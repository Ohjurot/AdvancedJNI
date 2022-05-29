# Script for downloading the JDK
Write-Host "Deploying to zip..."

# VARS
$AppName = "JavaTest"
$TempFolderName = "./temp/"
$ZipFileName = "./$($AppName).zip"

# Create empty temp folder
if (Test-Path $TempFolderName) 
{
    Remove-Item $TempFolderName -Force -Recurse | Out-Null
} 
New-Item $TempFolderName -itemType Directory | Out-Null

# Create JavaTest subfolder
New-Item "$($TempFolderName)$($AppName)" -itemType Directory | Out-Null

# Copy the content of app
Copy-Item -Path "./app/*" -Destination "$($TempFolderName)$($AppName)/" -Recurse | Out-Null
Remove-Item "$($TempFolderName)$($AppName)/.gitignore" -Force | Out-Null

# Copy c++ excecutables and libs
Copy-Item -Path "./bin/Release/JavaHost.exe" -Destination "$($TempFolderName)$($AppName)" | Out-Null
# TODO: Add your own binaries by copying the line above

# Zip the file
if (Test-Path $ZipFileName) 
{
    Remove-Item $ZipFileName -Force | Out-Null
} 
Compress-Archive -Path "$($TempFolderName)$($AppName)" -DestinationPath $ZipFileName | Out-Null

# Cleanup
Remove-Item $TempFolderName -Force -Recurse | Out-Null
