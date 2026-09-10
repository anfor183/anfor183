<#
.SYNOPSIS
    One-Click Setup and Push Script for Fortune Anukposi's GitHub Profile README (@anfor183)

.DESCRIPTION
    Initializes git in this repository, configures the default branch to 'main',
    stages all profile assets and workflows, commits them, sets the remote origin to
    https://github.com/anfor183/anfor183.git, and pushes to GitHub.
#>

[CmdletBinding()]
param(
    [string]$RemoteUrl = "https://github.com/anfor183/anfor183.git"
)

Write-Host "==========================================================" -ForegroundColor Cyan
Write-Host "  Fortune Anukposi (@anfor183) - GitHub Profile Deployment" -ForegroundColor Green
Write-Host "==========================================================" -ForegroundColor Cyan

# 1. Initialize Git if not already initialized
if (-not (Test-Path ".git")) {
    Write-Host "[1/4] Initializing Git repository with default branch 'main'..." -ForegroundColor Yellow
    git init -b main
} else {
    Write-Host "[1/4] Git repository already initialized." -ForegroundColor Green
}

# 2. Stage all files
Write-Host "[2/4] Staging all files..." -ForegroundColor Yellow
git add -A

# 3. Create commit
$status = git status --porcelain
if ($status) {
    Write-Host "[3/4] Committing files..." -ForegroundColor Yellow
    git commit -m "feat: launch institutional quantitative systems & algorithmic trading profile landing page"
} else {
    Write-Host "[3/4] Working tree clean, no new changes to commit." -ForegroundColor Green
}

# 4. Configure Remote
Write-Host "[4/4] Configuring remote origin to $RemoteUrl..." -ForegroundColor Yellow
$currentRemote = git remote get-url origin 2>$null
if (-not $currentRemote) {
    git remote add origin $RemoteUrl
    Write-Host "      Added remote origin: $RemoteUrl" -ForegroundColor Green
} elseif ($currentRemote -ne $RemoteUrl) {
    git remote set-url origin $RemoteUrl
    Write-Host "      Updated remote origin to: $RemoteUrl" -ForegroundColor Green
} else {
    Write-Host "      Remote origin is correctly configured." -ForegroundColor Green
}

Write-Host ""
Write-Host "==========================================================" -ForegroundColor Cyan
Write-Host "  READY TO PUSH TO GITHUB!" -ForegroundColor Green
Write-Host "==========================================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "IMPORTANT: Make sure you have created the repository 'anfor183' on GitHub:" -ForegroundColor Yellow
Write-Host "  --> Direct URL: https://github.com/new" -ForegroundColor White
Write-Host "      Repository name: anfor183" -ForegroundColor White
Write-Host "      Visibility: Public (Must be Public to show on your profile)" -ForegroundColor White
Write-Host "      Do NOT check 'Add a README file' (we already created an elite one!)" -ForegroundColor White
Write-Host ""

$response = Read-Host "Would you like to run 'git push -u origin main' now? (y/n)"
if ($response -match "^[Yy]") {
    Write-Host "Pushing to GitHub..." -ForegroundColor Cyan
    git push -u origin main
} else {
    Write-Host "To push manually anytime, run:" -ForegroundColor Cyan
    Write-Host "   git push -u origin main" -ForegroundColor White
}
