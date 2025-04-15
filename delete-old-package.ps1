# 1. 自动遍历所有模块，查找 src\main\java\top\continew，移动到 top\znsd
$sourceDirs = Get-ChildItem -Recurse -Directory -Filter znsd | Where-Object {
    $_.FullName -match "src\\main\\java\\znsd$"
}

foreach ($continewDir in $sourceDirs) {
      # 输出找到的目录路径
     #Write-Host "Found directory: $($continewDir.FullName)"
     #删除目录（你可以取消注释来执行删除操作）
     Remove-Item $continewDir.FullName -Recurse -Force
}
