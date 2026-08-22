@echo off
setlocal EnableExtensions

echo ========================================
echo       Python Web Application
echo ========================================
echo.

rem Resolve the directory containing this script, regardless of the launch directory.
set "PROJECT_DIR=%~dp0"
if "%PROJECT_DIR:~-1%"=="\" set "PROJECT_DIR=%PROJECT_DIR:~0,-1%"
cd /d "%PROJECT_DIR%"
if errorlevel 1 goto :error_directory

echo Project directory:
echo %PROJECT_DIR%
echo.

set "PYTHON="
if exist "%PROJECT_DIR%\.venv\Scripts\python.exe" set "PYTHON=%PROJECT_DIR%\.venv\Scripts\python.exe"
if not defined PYTHON if exist "%PROJECT_DIR%\venv\Scripts\python.exe" set "PYTHON=%PROJECT_DIR%\venv\Scripts\python.exe"
if not defined PYTHON (
    where python >nul 2>&1
    if errorlevel 1 goto :error_python
    set "PYTHON=python"
)

echo Python:
echo %PYTHON%
echo.

if not exist "%PROJECT_DIR%\app\main.py" goto :error_app

"%PYTHON%" -c "import fastapi, uvicorn" >nul 2>&1
if errorlevel 1 goto :error_dependencies

"%PYTHON%" -c "import app.main" >nul 2>&1
if errorlevel 1 goto :error_import

echo Starting application...
echo.
echo URL:
echo http://127.0.0.1:8000
echo.

"%PYTHON%" -m uvicorn app.main:app --host 127.0.0.1 --port 8000 --reload
set "EXIT_CODE=%ERRORLEVEL%"
if "%EXIT_CODE%"=="0" goto :end

echo.
echo Application failed to start.
echo Exit code: %EXIT_CODE%
goto :pause_exit

:error_directory
echo.
echo Could not change to the project directory.
goto :pause_exit

:error_python
echo.
echo Python was not found.
echo Please install Python 3.12 or newer and ensure it is on PATH.
goto :pause_exit

:error_app
echo.
echo Application package not found: app\main.py
goto :pause_exit

:error_dependencies
echo.
echo FastAPI/Uvicorn is not installed.
echo Please run:
echo pip install -r requirements.txt
goto :pause_exit

:error_import
echo.
echo The app package could not be imported from the project root.
echo Check the Python package files and imports.
goto :pause_exit

:pause_exit
echo.
pause

:end
endlocal
