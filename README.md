# Sha1SignFile
Utility to run after Mage.exe to create a SHA1 signature using a SHA256 certificate.

This utility was created to correct the known problem of signing manifest files with mage.exe for .Net Framework 2.0, 3.5 and 4.0, using SHA256 certificate.

Visual Studio 2013 Service Pack 3 and above where updated to generate manifests with SHA1 signatures, but mage.exe, was not.

This utility uses the updated `Microsoft.Build.Tasks.Deployment.ManifestUtilities.SecurityUtilities.SignFile` method to create SHA1 signatures.

Since you will probably be using this tool to build from command line, you will still need to call mage.exe to update the Size and Hash Digest in the manifest files, specially if you are obfuscating your build.

In this repository you will find these folders:

    * Sha1SignFile - The Sha1SignFile utility source code
    
    * COnceLab - A sample application deployed with a custom ClickOnce setup, using .Net Framework 2.0. In this sample will find:
    
        * Obfuscation with PreEmptive Dotfuscator CE

        * Build.bat - A batch file that uses:
        
            * msbuild.exe to build and publish the sample application

            * dotfuscatorCLI.exe to obfuscate

            * signtool.exe to sign the obfuscated file

            * mage.exe to update the manifests

            * Sha1SignFile.exe to update the manifest signatures

To build the sample, you will need to generate a certificate and update Signing page, in Project Properties window, and the CertificateThumbprint in build.bat.