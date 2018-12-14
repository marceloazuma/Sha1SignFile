set BuildPublishLocation="bin\Debug\app.publish"
set CertificateThumbprint=09c4b9b38fad53f0add279b624e876597c519e0a
set DotfuscatorCLI="C:\Program Files (x86)\Microsoft Visual Studio\2017\Professional\Common7\IDE\Extensions\PreEmptiveSolutions\DotfuscatorCE\dotfuscatorCLI.exe"
set PublishBaseTarget="C:\inetpub\wwwroot\COnceLab"
set Sha1SignFile="..\Sha1SignFile\bin\Release\Sha1SignFile.exe"
set TimeStampServer="http://timestamp.verisign.com/scripts/timstamp.dll"

@echo off

if [%1]==[] goto usage

msbuild.exe COnceLab.csproj /target:publish /p:DeployOnBuild=true

%DotfuscatorCLI% COnceLab-Dotfuscator.xml

copy /y Dotfuscated\COnceLab.exe "%BuildPublishLocation%\Application Files\%1\COnceLab.exe.deploy"

ren "%BuildPublishLocation%\Application Files\%1\COnceLab.exe.deploy" COnceLab.exe

signtool sign /sha1 %CertificateThumbprint% /fd sha1 /t %TimeStampServer% "%BuildPublishLocation%\Application Files\%1\COnceLab.exe"

mage.exe -Update "%BuildPublishLocation%\Application Files\%1\COnceLab.exe.manifest" -Algorithm sha1RSA -CertHash %CertificateThumbprint% -TimeStampUri %TimeStampServer%

%Sha1SignFile% -certThumbprint %CertificateThumbprint% -timestampUrl %TimeStampServer% -filePath "%BuildPublishLocation%\Application Files\%1\COnceLab.exe.manifest"

mage.exe -Update "%BuildPublishLocation%\COnceLab.application" -AppManifest "%BuildPublishLocation%\Application Files\%1\COnceLab.exe.manifest" -Algorithm sha1RSA -CertHash %CertificateThumbprint% -TimeStampUri %TimeStampServer%

%Sha1SignFile% -certThumbprint %CertificateThumbprint% -timestampUrl %TimeStampServer% -filePath "%BuildPublishLocation%\COnceLab.application"

ren "%BuildPublishLocation%\Application Files\%1\COnceLab.exe" COnceLab.exe.deploy

copy /y %BuildPublishLocation%\COnceLab.application %PublishBaseTarget%

mkdir "%PublishBaseTarget%\Application Files\%1"

copy /y %BuildPublishLocation%\COnceLab.application "%PublishBaseTarget%\Application Files\%1"

copy /y "%BuildPublishLocation%\Application Files\%1\COnceLab.exe.deploy" "%PublishBaseTarget%\Application Files\%1"

copy /y "%BuildPublishLocation%\Application Files\%1\COnceLab.exe.manifest" "%PublishBaseTarget%\Application Files\%1"

goto :eof

:usage

echo Usage: %0 "Version folder name, like COnceLab_1_0_0_0"

exit /B 1