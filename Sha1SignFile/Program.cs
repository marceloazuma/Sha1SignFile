using System;
using Microsoft.Build.Tasks.Deployment.ManifestUtilities;

namespace Sha1SignFile
{
    class Program
    {
        static void Main(string[] args)
        {
            Arguments arguments = new Arguments();
            if (!arguments.Parse(args))
            {
                Console.WriteLine("Sha1SignFile");
                Console.WriteLine();
                Console.WriteLine("Use after Mage.exe to create a SHA1 signature with a SHA256 certificate");
                Console.WriteLine();
                Console.WriteLine("Arguments:");
                Console.WriteLine("-certThumbprint - Certificate thumbprint");
                Console.WriteLine("-filePath - File to sign");
                Console.WriteLine("-timestampUrl - Timestamp server address");
            }
            else
            {
                SecurityUtilities.SignFile(arguments.CertThumbprint, new Uri(arguments.TimestampUrl), arguments.FilePath, "v4.0");

                Console.WriteLine("Sha1SignFile successfully signed: {0}", arguments.FilePath);
            }
        }
    }
}
