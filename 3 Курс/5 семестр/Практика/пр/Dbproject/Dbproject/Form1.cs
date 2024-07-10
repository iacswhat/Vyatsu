using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using System.Data.SqlClient;
using System.Configuration;


namespace Dbproject
{
    public partial class Form1 : Form
    {
        public Form1()
        {
            InitializeComponent();
        }

        private void tableNameBindingNavigatorSaveItem_Click(object sender, EventArgs e)
        {
            this.Validate();
            this.tableNameBindingSource.EndEdit();
            this.tableAdapterManager.UpdateAll(this.ustanovkiDataSet);

        }

        private void Form1_Load(object sender, EventArgs e)
        {
            // TODO: данная строка кода позволяет загрузить данные в таблицу "ustanovkiDataSet11.ust1". При необходимости она может быть перемещена или удалена.
            this.ust1TableAdapter.Fill(this.ustanovkiDataSet11.ust1);
  
        }

        private void button1_Click(object sender, EventArgs e)
        {

            //Data Source=DESKTOP-AMJ0FVH\SQLEXPRESS;Initial Catalog=Ustanovki;Integrated Security=True
            string ConnectionString = @"Data Source=DESKTOP-PVL4P4H;Initial Catalog=Ustanovki;Integrated Security=True";
            using (SqlConnection conn = new SqlConnection(ConnectionString))
            {
                conn.Open();
                SqlCommand command = new SqlCommand("INSERT INTO ust1 (Тип_комплектующего,Обозначение,Наименование,Серийный_номер,Поставщик,Изготовитель,Дата_изготовления,Срок_хранения,Страна_изготовления) values (@Тип_комплектующего,@Обозначение,@Наименование,@Серийный_номер,@Поставщик,@Изготовитель,@Дата_изготовления,@Срок_хранения,@Страна_изготовления)");
                command.Connection = conn;
                command.Parameters.AddWithValue("Тип_комплектующего", comboBox1.Text);
                command.Parameters.AddWithValue("Обозначение", textBox2.Text);
                command.Parameters.AddWithValue("Наименование", textBox3.Text);
                command.Parameters.AddWithValue("Серийный_номер", textBox4.Text);
                command.Parameters.AddWithValue("Поставщик", textBox5.Text);
                command.Parameters.AddWithValue("Изготовитель", textBox6.Text);
                command.Parameters.AddWithValue("Дата_изготовления", dateTimePicker1.Text);
                command.Parameters.AddWithValue("Срок_хранения", textBox8.Text);
                command.Parameters.AddWithValue("Страна_изготовления", textBox9.Text);
                command.ExecuteNonQuery();
            }

        }

        private void button2_Click(object sender, EventArgs e)
        {
            this.Hide();
            Form main = new Form1();
            main.Show();
        }

       
    }
}
