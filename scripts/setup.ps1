# Papyrus 开发环境初始化脚本 (Windows)
$ErrorActionPreference = "Stop"

$FlutterRoot = if ($env:FLUTTER_ROOT) { $env:FLUTTER_ROOT } else { "C:\src\flutter" }
$FlutterBin = Join-Path $FlutterRoot "bin"

if (-not (Test-Path (Join-Path $FlutterBin "flutter.bat"))) {
    Write-Host "正在安装 Flutter SDK 到 $FlutterRoot ..."
    New-Item -ItemType Directory -Force -Path (Split-Path $FlutterRoot) | Out-Null
    git clone https://github.com/flutter/flutter.git -b stable --depth 1 $FlutterRoot
}

$userPath = [Environment]::GetEnvironmentVariable("Path", "User")
if ($userPath -notlike "*$FlutterBin*") {
    [Environment]::SetEnvironmentVariable("Path", "$FlutterBin;$userPath", "User")
    Write-Host "已将 Flutter 加入用户 PATH: $FlutterBin"
}

$env:PATH = "$FlutterBin;$env:PATH"

Push-Location (Split-Path $PSScriptRoot -Parent)
try {
    Write-Host "检查 Flutter 环境..."
    flutter doctor

    Write-Host "安装项目依赖..."
    flutter pub get

    Write-Host "生成 Drift 代码..."
    dart run build_runner build

    Write-Host "运行单元测试..."
    flutter test

    Write-Host ""
    Write-Host "开发环境配置完成。"
    Write-Host "  Web:     flutter run -d chrome"
    Write-Host "  Windows: 需安装 Visual Studio（Desktop development with C++）后执行 flutter run -d windows"
} finally {
    Pop-Location
}
