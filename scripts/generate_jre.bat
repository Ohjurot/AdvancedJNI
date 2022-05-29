@echo off

REM Info
echo Creating JRE...

REM Delete old JRE
if exist app/jre (
    rmdir /s /q "app/jre"
)

REM Invoke jlink
REM TODO: Add all the module that you need by dublicating the line "--add-modules java.base ^" and replacing the module name
"jdk/bin/jlink" ^
    --add-modules java.base ^
    --strip-debug ^
    --no-man-pages ^
    --no-header-files ^
    --compress=1 ^
    --output ./app/jre
