# LoopMotion Build Script
# Usage: .\build.ps1

$ErrorActionPreference = "Stop"

$ArmToolchainPath = "C:\ProgramData\chocolatey\lib\gcc-arm-embedded\tools\gcc-arm-none-eabi-10.3-2021.10\bin"

# Set PATH to include ARM toolchain
$env:PATH = "$ArmToolchainPath;$env:PATH"

Write-Host "Building LoopMotion..." -ForegroundColor Cyan

# Clean and configure
Write-Host "Configuring..." -ForegroundColor Yellow
cmake -S . -B build -G Ninja

if ($LASTEXITCODE -ne 0) {
    Write-Host "Configure failed!" -ForegroundColor Red
    exit 1
}

# Build
Write-Host "Building..." -ForegroundColor Yellow
cmake --build build

if ($LASTEXITCODE -ne 0) {
    Write-Host "Build failed!" -ForegroundColor Red
    exit 1
}

Write-Host "Build complete!" -ForegroundColor Green
Write-Host "Output: build\loopmotion.uf2" -ForegroundColor Cyan
