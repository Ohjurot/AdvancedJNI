@echo off
REM Prepares the development enviroment

REM Download JDK
powershell -ExecutionPolicy ByPass -NoProfile -Command "& '%~dp0scripts\download_jdk.ps1'" %_args%

REM Download jni.hpp
powershell -ExecutionPolicy ByPass -NoProfile -Command "& '%~dp0scripts\download_jni_hpp.ps1'" %_args%

REM Create matching JRE
"scripts/generate_jre"
