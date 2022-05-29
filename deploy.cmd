@echo off
REM Deploys the compiled project

REM Run deploy powershell script
powershell -ExecutionPolicy ByPass -NoProfile -Command "& '%~dp0scripts\deploy_zip.ps1'" %_args%
