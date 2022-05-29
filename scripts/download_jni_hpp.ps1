# Script for downloading the JNI.hpp extensions
Write-Host "Downloading jni-hpp..."

$jni_hpp = "https://github.com/Ohjurot/jni-hpp/releases/download/version_0_1/jni.hpp"
$jni_hpp_jar = "https://github.com/Ohjurot/jni-hpp/releases/download/version_0_1/jni.hpp.jar"
$jdk_folder = "./jdk/"
$jar_folder = "./app/java/"

# Download ini-hpp header and jar (java 17)
Invoke-WebRequest $jni_hpp -OutFile "$($jdk_folder)include/jni.hpp" | Out-Null
Invoke-WebRequest $jni_hpp_jar -OutFile "$($jar_folder)jni.hpp.jar" | Out-Null
