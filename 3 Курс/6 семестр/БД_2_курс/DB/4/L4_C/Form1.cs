using Npgsql;
using System.Data;
using System.Windows.Forms;

namespace L4_C

{
    public partial class Form1 : Form
    {
        private DB DB;
        private string possition;

        public Form1()
        {
            InitializeComponent();
            cbPos.SelectedIndex = 0;
            
            
            DB = new DB();

            DB.Read(dataGridView1);
            DB.cbTeam(cbTeam);



            //DB.CloseConnection();
        }

        private void addBtn_Click(object sender, EventArgs e)
        {
            DB.Add(tbName, tbAge, possition, cbTeam);
            DB.Read(dataGridView1);
        }

        private void cbPos_SelectionChangeCommitted(object sender, EventArgs e)
        {
            possition = cbPos.GetItemText(cbPos.SelectedItem);
        }

        private void Form1_FormClosing(object sender, FormClosingEventArgs e)
        {
            DB.CloseConnection();
        }

        private void delBtn_Click(object sender, EventArgs e)
        {
            DialogResult result = MessageBox.Show(
                "Вы дейсвительно хотите удалить запись с именем " + tbNameDel.Text + "?",
                "Внимание",
                MessageBoxButtons.YesNo,
                MessageBoxIcon.Question,
                MessageBoxDefaultButton.Button1,
                MessageBoxOptions.DefaultDesktopOnly);

            if (result == DialogResult.Yes)
            {
                DB.Del(tbNameDel);
                DB.Read(dataGridView1);
            }

            this.TopMost = true;
        }

        private void button1_Click(object sender, EventArgs e)
        {
            DB.Sort(dataGridView1, tbSort);
        }

        private void button2_Click(object sender, EventArgs e)
        {
            DB.Read(dataGridView1);
        }
    }
}