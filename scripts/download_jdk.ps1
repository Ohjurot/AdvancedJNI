# Script for downloading the JDK
Write-Host "Downloading JDK..."

# Vars
$JdkDownloadUrl = "https://aka.ms/download-jdk/microsoft-jdk-17.0.3-windows-x64.zip"
$JdkZipFolderName = "jdk-17.0.3+7"
$DestiantionFolderName = "./jdk/"
$TempFolderName = "./temp/"

# Delete old JDK Version
if (Test-Path $DestiantionFolderName) 
{
    Remove-Item $DestiantionFolderName -Force -Recurse | Out-Null
}

# Create empty temp folder
if (Test-Path $TempFolderName) 
{
    Remove-Item $TempFolderName -Force -Recurse | Out-Null
} 
New-Item $TempFolderName -itemType Directory | Out-Null

# Download and extract jdk
Invoke-WebRequest $JdkDownloadUrl -OutFile "$($TempFolderName)jdk.zip" | Out-Null
Expand-Archive "$($TempFolderName)jdk.zip" -DestinationPath $DestiantionFolderName | Out-Null

# Fix directory setup
Move-Item -Path ".\jdk\$($JdkZipFolderName)\*" -Destination ".\jdk\" -Force | Out-Null
Remove-Item ".\jdk\$($JdkZipFolderName)\" -Force | Out-Null

# Delete temps
Remove-Item $TempFolderName -Force -Recurse | Out-Null
