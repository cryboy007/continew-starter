<#
.SYNOPSIS
  修复 Maven 编译失败的 Java 文件（处理编码问题）
#>

# 配置参数
$projectRoot = "D:\project\znsd-starter"
$sourceRoot = "D:\project\continew-starter"
$logFile = "$projectRoot\build.log"
$mavenSettings = "D:\data\conf\settings_goldlion.xml"
$mavenRepo = "D:\tools\maven_repository"
$encoding = "UTF-8"


# 进入项目目录
Set-Location $projectRoot

# 清空旧日志
if (Test-Path $logFile) {
    Remove-Item $logFile -Force
}

# 构建 Maven 命令参数数组
$mvnArgs = @(
    "clean", "install", "-fn",
    "-s", $mavenSettings,
    "-Dmaven.repo.local=$mavenRepo",
    "-Dfile.encoding=$encoding",
    "-P", "!e3plus,!jdk-1.8"
)

Write-Host "🔧 正在执行 mvn clean install -fn (--fail-never)..." -ForegroundColor Cyan

# 使用 & 执行带参数的命令
& mvn @mvnArgs | Tee-Object -FilePath $logFile

# 2. 分析编译错误（改进的错误匹配）
Write-Host "`n🔍 正在分析编译失败的 Java 文件..." -ForegroundColor Cyan

# 匹配多种错误格式
$errorPatterns = @(
    '\[ERROR\]\s+([\/\\]?[a-zA-Z]:[\\/].+?\.java):'
)


[System.Collections.ArrayList]$errors = @()

foreach ($pattern in $errorPatterns) {
    $matches = Select-String -Path $logFile -Pattern $pattern -AllMatches
    foreach ($match in $matches) {
        $filePath = $match.Matches.Groups[1].Value -replace '/', '\'
        # 如果是相对路径，转换为绝对路径
        if (-not $filePath.StartsWith($projectRoot)) {
            $filePath = Join-Path $projectRoot $filePath
        }
        if (-not $errors.Contains($filePath)) {
            $errors.Add($filePath) | Out-Null
        }
    }
}

# 3. 处理错误文件（带编码转换）
if ($errors.Count -eq 0) {
    Write-Host "`n✅ 没有发现 Java 编译错误。" -ForegroundColor Green
    exit 0
}

Write-Host "`n⚠️ 发现 $($errors.Count) 个编译失败的 Java 文件：" -ForegroundColor Yellow
$errors | ForEach-Object { Write-Host " - $_" }

Write-Host "`n🔄 开始从 '$sourceRoot' 替换文件（使用 $encoding 编码）..." -ForegroundColor Cyan

$successCount = 0
$failCount = 0

foreach ($errorPath in $errors) {
    $relativePath = $errorPath.Replace($projectRoot, '').TrimStart('\')
   # 替换 znsd 为 continew

    $originalPath = $relativePath

    $relativePath = $relativePath -replace 'znsd', 'continew'

    $sourceFile = Join-Path $sourceRoot $relativePath

    # ✅ 修复 targetFile 拼接逻辑
    if (-not (Split-Path -IsAbsolute $relativePath)) {
        $targetFile = Join-Path $projectRoot $originalPath
    } else {
        $targetFile = $originalPath
    }

    if (Test-Path $sourceFile) {
        try {
            # 确保目标目录存在
            $targetDir = [System.IO.Path]::GetDirectoryName($targetFile)
            if (-not (Test-Path $targetDir)) {
                New-Item -ItemType Directory -Path $targetDir -Force | Out-Null
            }
            # 如果目标文件存在则先删除
            if (Test-Path $targetFile) {
                Remove-Item $targetFile -Force
                Write-Host "🗑️ 已删除旧文件: $relativePath"
            }
            # 复制文件（保留原编码或指定编码）
            Copy-Item $sourceFile -Destination $targetFile -Force
            Write-Host "✅ 复制成功: $relativePath" -ForegroundColor Green
            $successCount++
        } catch {
            Write-Host "❌ 替换失败：$relativePath (错误: $_)" -ForegroundColor Red
            $failCount++
        }
    } else {
        Write-Host "❌ 源文件不存在：$sourceFile" -ForegroundColor Red
        $failCount++
    }
}

# 4. 输出结果
Write-Host "`n🎉 替换完成：" -ForegroundColor Cyan
Write-Host "  成功替换: $successCount 个文件" -ForegroundColor Green
Write-Host "  失败处理: $failCount 个文件" -ForegroundColor ($failCount -eq 0 ? "Green" : "Red")

if ($successCount -gt 0) {
    Write-Host "`n建议执行以下命令验证修复结果："
    Write-Host "mvn clean install -s `"$mavenSettings`" -Dmaven.repo.local=`"$mavenRepo`" -Dfile.encoding=$encoding" -ForegroundColor Cyan
}