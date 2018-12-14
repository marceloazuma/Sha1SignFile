using System;
using System.Windows.Forms;

namespace COnceLab
{
    public partial class Main : Form
    {
        public Main()
        {
            InitializeComponent();
        }

        private void Main_Load(object sender, EventArgs e)
        {
            lblVersionNumber.Text = typeof(Main).Assembly.GetName().Version.ToString();
        }

        private void btnUpdate_Click(object sender, EventArgs e)
        {
            COnceLabInstaller installer = new COnceLabInstaller();
            installer.InstallApplication(@"http://localhost/COnceLab/COnceLab.application");
            MessageBox.Show("Installer object created.");
        }
    }
}
