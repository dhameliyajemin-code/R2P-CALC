@echo off
cd /d "%~dp0"
set FILE=index.html
set REMOTE_URL=https://github.com/dhameliyajemin-code/R2P-CALC.git

if not exist "%FILE%" (
    echo ERROR: %FILE% not found.
    pause
    exit /b 1
)

if not exist ".git" (
    echo Initializing git repository...
    git init
)

git add "%FILE%"
git commit -m "Update %DATE% %TIME%"

git remote -v >nul 2>&1
if errorlevel 1 (
    echo Adding remote origin...
    git remote add origin %REMOTE_URL%
)

git push origin main
if errorlevel 1 (
    echo.
    echo ========================================
    echo First push may need the branch flag.
    echo Trying: git push -u origin main
    echo ========================================
    git push -u origin main
    if errorlevel 1 (
        echo Push failed. Check remote URL or network.
        pause
        exit /b 1
    )
)

echo Done - pushed successfully.
timeout /t 2 /nobreak >nul
