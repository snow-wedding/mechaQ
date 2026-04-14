@echo off
echo -----------------------------------------------
echo  MB Match Notifier
echo -----------------------------------------------
echo.

:: ── Check if Python is already installed ─────────────────────────────────────
call :check_python
if %errorlevel% == 0 goto :start

echo Python not found. Installing now...
echo.

:: ── Try winget first (built into Windows 10 20H1 and later) ──────────────────
where winget >nul 2>&1
if %errorlevel% == 0 (
    echo Using Windows Package Manager...
    winget install Python.Python.3.12 --silent --accept-package-agreements --accept-source-agreements
    if %errorlevel% == 0 (
        call :refresh_path
        call :check_python
        if !errorlevel! == 0 goto :start
    )
    echo winget install failed, falling back to direct download...
    echo.
)

:: ── Fallback: download Python installer directly ──────────────────────────────
echo Downloading Python 3.12 installer...
powershell -NoProfile -Command "Invoke-WebRequest -Uri 'https://www.python.org/ftp/python/3.12.7/python-3.12.7-amd64.exe' -OutFile '%TEMP%\python_installer.exe'"
if %errorlevel% neq 0 (
    echo.
    echo Download failed. Please install Python manually from https://python.org
    pause
    exit /b 1
)

echo Installing Python...
"%TEMP%\python_installer.exe" /quiet InstallAllUsers=0 PrependPath=1 Include_launcher=0
del "%TEMP%\python_installer.exe" >nul 2>&1

call :refresh_path

call :check_python
if %errorlevel% neq 0 (
    echo.
    echo Python was installed but could not be found in this session.
    echo Please close this window and run launch.bat again.
    pause
    exit /b 1
)

echo Python installed successfully.
echo.

:: ── Launch the notifier ───────────────────────────────────────────────────────
:start
echo Starting MB Match Notifier...
echo Keep this window open while using the notifier.
echo Close this window to stop.
echo.

start /b cmd /c "timeout /t 2 /nobreak >nul && start "" http://localhost:8080/mechabreak_notifier.html"
%PYTHON_CMD% -m http.server 8080
pause
exit /b 0

:: ── Subroutine: check for python or py command ───────────────────────────────
:check_python
python --version >nul 2>&1
if %errorlevel% == 0 (
    set "PYTHON_CMD=python"
    exit /b 0
)
py --version >nul 2>&1
if %errorlevel% == 0 (
    set "PYTHON_CMD=py"
    exit /b 0
)
exit /b 1

:: ── Subroutine: refresh PATH from registry via temp file ─────────────────────
:refresh_path
powershell -NoProfile -Command "$m=[Environment]::GetEnvironmentVariable('PATH','Machine'); $u=[Environment]::GetEnvironmentVariable('PATH','User'); ($m+';'+$u) | Out-File '%TEMP%\mb_envpath.txt' -Encoding ASCII -NoNewline"
set /p REFRESHED_PATH= < "%TEMP%\mb_envpath.txt"
set "PATH=%REFRESHED_PATH%"
del "%TEMP%\mb_envpath.txt" >nul 2>&1
exit /b 0
