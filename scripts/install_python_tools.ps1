# Define Python versions to install
$PythonVersions = @(
    "3.13",
    "3.12",
    "3.11",
    "3.10",
    "3.9",
    "3.8"
)

# Install/Update uv
Write-Host "Installing/updating uv..."
if (Get-Command uv -ErrorAction SilentlyContinue) {
    uv self update
} else {
    powershell -ExecutionPolicy ByPass -c "irm https://astral.sh/uv/install.ps1 | iex"
    foreach ($version in $PythonVersions) {
        uv python install $version
    }

    # Setup uv config
    $UvConfigDir = Join-Path $env:APPDATA "uv"
    New-Item -ItemType Directory -Force -Path $UvConfigDir | Out-Null
    Copy-Item "uv.toml" -Destination (Join-Path $UvConfigDir "uv.toml") -Force
}

# Install/Update poetry
Write-Host "Installing/updating poetry..."
if (Get-Command poetry -ErrorAction SilentlyContinue) {
    poetry self update
} else {
    (Invoke-WebRequest -Uri https://install.python-poetry.org -UseBasicParsing).Content | py -
    poetry config virtualenvs.create false
    poetry self add "poetry-plugin-use-pip-global-index-url@latest"
    poetry self add "poetry-plugin-export@latest"
}

# Install CLI tools
Write-Host "Installing/updating CLI tools..."
Get-Content "scripts/deps/py-tools.txt" | ForEach-Object {
    uv tool install $_
}
uv tool upgrade --all
