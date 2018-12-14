using System.Linq;

namespace Sha1SignFile
{
    public class Arguments
    {
        public string CertThumbprint { get; set; }

        public string FilePath { get; set; }

        public string TimestampUrl { get; set; }

        public bool Parse(string[] args)
        {
            CertThumbprint = null;
            TimestampUrl = null;
            FilePath = null;

            for (int i = 0; i < args.Length; i++)
            {
                if (args[i].First() == '-')
                {
                    switch (args[i].ToLower())
                    {
                        case "-certthumbprint":
                            CertThumbprint = args[++i];
                            break;
                        case "-filepath":
                            FilePath = args[++i];
                            break;
                        case "-timestampurl":
                            TimestampUrl = args[++i];
                            break;
                        default:
                            return false;
                    }
                }
            }

            return CertThumbprint != null && FilePath != null && TimestampUrl != null;
        }
    }
}
