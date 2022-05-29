@echo off
REM Builds the solution

REM Setup project for a release build
autogen

REM Run MsBuild (This will only work from a developers cmd line)
MsBuild JavaTest.sln /property:Configuration=Release
