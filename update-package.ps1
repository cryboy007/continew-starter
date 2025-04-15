# replace-package.ps1

# 1. 替换所有 .java 文件中的包名引用
Get-ChildItem -Recurse -Filter *.java | ForEach-Object {
   $file = $_.FullName
   (Get-Content $file -Raw) -replace 'top\.continew', 'top.znsd' | Set-Content -Encoding UTF8 $file
}

# 2. 自动遍历所有模块，查找 src\main\java\top\continew，移动到 top\znsd
$sourceDirs = Get-ChildItem -Recurse -Directory -Filter continew | Where-Object {
    $_.FullName -match "src\\main\\java\\top\\continew$"
}

foreach ($continewDir in $sourceDirs) {
    $topDir = Split-Path $continewDir.Parent.FullName -Parent
    $znsdDir = Join-Path $topDir "top\znsd"

    # 创建目标目录
    New-Item -ItemType Directory -Path $znsdDir -Force | Out-Null

    # 移动 continew 下的所有内容到 znsd
    Get-ChildItem $continewDir.FullName | Move-Item -Destination $znsdDir

    # 删除 continew 文件夹
    Remove-Item $continewDir.FullName -Recurse -Force
}
