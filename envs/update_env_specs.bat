@echo off
REM =============================================================
REM  update_env_specs.bat
REM  Refresh Conda-environment spec files in one shot
REM  (no hard-coded paths – script uses its own folder).
REM =============================================================

:: --------------------------------------------------------------
:: 1) Resolve the folder this script lives in (= envs\)
:: --------------------------------------------------------------
set "PROJECT_ENV_DIR=%~dp0"
pushd "%PROJECT_ENV_DIR%" >nul

:: --------------------------------------------------------------
:: 2) Determine which Conda env to export
::    • If you pass a name as the first argument, use that
::    • Otherwise fall back to a default (edit if you like)
:: --------------------------------------------------------------
if "%~1"=="" (
    set "CONDA_ENV_NAME=digital_tmp_base"
) else (
    set "CONDA_ENV_NAME=%~1"
)

echo [INFO] Working directory : %CD%
echo [INFO] Target Conda env  : %CONDA_ENV_NAME%
echo.

:: --------------------------------------------------------------
:: 3) Activate the environment
:: --------------------------------------------------------------
call conda activate "%CONDA_ENV_NAME%"
if errorlevel 1 (
    echo [ERROR] Conda activation failed — aborting.
    popd & pause & exit /b 1
)

:: --------------------------------------------------------------
:: 4) Export specs (overwrite existing files)
:: --------------------------------------------------------------
echo [INFO] Exporting specifications...
conda env export                    > digital_tmp_base_env.yml
conda env export --no-builds        > environment.yml
conda env export --from-history     > digital_tmp_base_env_minimal.yml
conda list --explicit               > digital_tmp_base_env.txt

echo.
echo [SUCCESS] Spec files refreshed in: %PROJECT_ENV_DIR%
popd
pause
