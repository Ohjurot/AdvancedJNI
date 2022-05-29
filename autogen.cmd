@echo off
REM Preparese the C++ projects

REM Setup argument
IF "%1"=="" SET bt="Release"
IF NOT "%1"=="" SET bt=%1

REM Run conan
conan install . --build missing -s build_type=%bt%

REM Premake
".\scripts\premake5" vs2022