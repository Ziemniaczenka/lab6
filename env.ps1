# PowerShell environment setup script
# Usage: . .\env.ps1

$scriptPath = $PSScriptRoot

$env:ROOT_DIR = $scriptPath
$env:FPGA_DIR = Join-Path $scriptPath "fpga"
$env:FPGA_BUILD_DIR = Join-Path $scriptPath "build\fpga"
$env:SIM_BUILD_DIR = Join-Path $scriptPath "build\sim"
$env:RESULTS_DIR = Join-Path $scriptPath "results"
$env:PATH = "$(Join-Path $scriptPath 'tools');$env:PATH"

Write-Host "Environment variables set for Lab 5."
