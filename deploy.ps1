# Get the current directory
$project_dir = $PSScriptRoot

# Navigate to the project directory
Set-Location -Path $project_dir

# Check if Python is installed
if (-not (Get-Command python -ErrorAction SilentlyContinue)) {
    Write-Host "Python is not installed. Please install Python first."
    exit
}

# Create a virtual environment
$venv_dir = "$project_dir\venv"
if (-Not (Test-Path -Path $venv_dir)) {
    python -m venv $venv_dir
}

# Activate the virtual environment
& "$venv_dir\Scripts\Activate.ps1"

# Install dependencies
if (Test-Path -Path "$project_dir\requirements.txt") {
    python -m pip install -r "$project_dir\requirements.txt"
} else {
    Write-Host "requirements.txt not found in $project_dir"
    exit
}

