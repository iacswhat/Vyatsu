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



        //Обновляет данные в dataGridView1
        void UpdateGrid(string sql)
        {
            string str = @"Data Source=DESKTOP-PVL4P4H;Initial Catalog=Ustanovki;Integrated Security=True";
            SqlConnection con;
            con = new SqlConnection(str);
            con.Open();

            SqlCommand s_cmd = con.CreateCommand();
            s_cmd.CommandText = sql;
            SqlDataAdapter adapter = new SqlDataAdapter(s_cmd);
            DataSet n_set = new DataSet();
            adapter.Fill(n_set);

            dataGridView1.DataSource = n_set.Tables[0];
        }

        // Выполняет запрос не возвращающий данные
        void ExecSQL(string sql)
        {
            string str = @"Data Source=DESKTOP-PVL4P4H;Initial Catalog=Ustanovki;Integrated Security=True";
            SqlConnection con;
            con = new SqlConnection(str);
            con.Open();

            SqlCommand s_cmd = con.CreateCommand();
            s_cmd.CommandText = sql;
            s_cmd.ExecuteNonQuery();

        }

        private void Form1_Load(object sender, EventArgs e)
        {
            // TODO: данная строка кода позволяет загрузить данные в таблицу "ustanovkiDataSet9.ust1". При необходимости она может быть перемещена или удалена.
            this.ust1TableAdapter8.Fill(this.ustanovkiDataSet9.ust1);
            // TODO: данная строка кода позволяет загрузить данные в таблицу "ustanovkiDataSet8.ust1". При необходимости она может быть перемещена или удалена.
            //this.ust1TableAdapter7.Fill(this.ustanovkiDataSet8.ust1);


        }

        //Добавление
        private void button1_Click(object sender, EventArgs e)
        {
            //Data Source=DESKTOP-AMJ0FVH\SQLEXPRESS;Initial Catalog=Ustanovki;Integrated Security=True
            string ConnectionString = @"Data Source=DESKTOP-PVL4P4H;Initial Catalog=Ustanovki;Integrated Security=True";
            using (SqlConnection conn = new SqlConnection(ConnectionString))
            {
                conn.Open();
                SqlCommand command = new SqlCommand("INSERT INTO ust1 (Установка,Тип_комплектующего,Обозначение,Наименование,Серийный_номер,Поставщик,Изготовитель,Дата_изготовления,Срок_хранения,Страна_изготовления) values (@Установка,@Тип_комплектующего,@Обозначение,@Наименование,@Серийный_номер,@Поставщик,@Изготовитель,@Дата_изготовления,@Срок_хранения,@Страна_изготовления)");
                command.Connection = conn;
                command.Parameters.AddWithValue("Установка", comboBox4.Text);
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

            //Обновляем
            string sql = "select * from ust1";
            UpdateGrid(sql);

            //Отображаем данные установки выбранной в comboBox2
            string ust;
            ust = comboBox2.Text;
            sql = "SELECT id,Установка,Тип_комплектующего,Обозначение,Наименование,Серийный_номер,Поставщик,Изготовитель,Дата_изготовления,Срок_хранения,Страна_изготовления FROM ust1 WHERE Установка =" + "'" + ust + "'";
            UpdateGrid(sql);

        } 
        

        //Удаление строки
        private void button4_Click(object sender, EventArgs e)
        {
            string Message;
            Message = "Вы действительно хотите удалить выделенную запись?";

            if (MessageBox.Show(Message, "Удаление", MessageBoxButtons.YesNo, MessageBoxIcon.Warning, MessageBoxDefaultButton.Button2) == DialogResult.No) 
                {
                    return;
                }

            string id;
            id= dataGridView1.SelectedRows[0].Cells["id"].Value.ToString();

            //string sql = "delete from ust1 where Установка ="+ id;

            string sql = "delete from ust1 where id =" + "'" + id + "'";

            ExecSQL(sql);//Выполняем запрос

            //Обновляем
           // sql = "select * from ust1";
           // UpdateGrid(sql);

            //Отображаем данные установки выбранной в comboBox2
            string ust;
            ust = comboBox2.Text;
            sql = "SELECT id,Установка,Тип_комплектующего,Обозначение,Наименование,Серийный_номер,Поставщик,Изготовитель,Дата_изготовления,Срок_хранения,Страна_изготовления FROM ust1 WHERE Установка =" + "'" + ust + "'";
            UpdateGrid(sql);

        }

        //OK
        private void button3_Click(object sender, EventArgs e)
        {
            //Подключение 
            string str = @"Data Source=DESKTOP-PVL4P4H;Initial Catalog=Ustanovki;Integrated Security=True";
            SqlConnection con;
            con = new SqlConnection(str);
            con.Open();

            //Отображаем данные
          // string sql = "select * from ust1";
          //  UpdateGrid(sql);

            //Отображаем данные установки выбранной в comboBox2
            string ust;
            ust = comboBox2.Text;
            string sql = "SELECT id,Установка,Тип_комплектующего,Обозначение,Наименование,Серийный_номер,Поставщик,Изготовитель,Дата_изготовления,Срок_хранения,Страна_изготовления FROM ust1 WHERE Установка =" + "'" + ust + "'";
            UpdateGrid(sql);

            //Вывод названия установки textBox7
             textBox7.Text = ust.ToString();

        }


        //Удаление установки
        private void button6_Click(object sender, EventArgs e)
        {
            string Message;
            Message = "Вы действительно хотите удалить выделенную установку?";

            if (MessageBox.Show(Message, "Удаление", MessageBoxButtons.YesNo, MessageBoxIcon.Warning, MessageBoxDefaultButton.Button2) == DialogResult.No)
            {
                return;
            }

            string delust;
            delust = comboBox3.Text;

            string sql = "delete from ust1 where Установка =" + "'" + delust + "'" ;
                   ExecSQL(sql);//Выполняем запрос

            //Обновляем
             sql = "select * from ust1";
             UpdateGrid(sql);

            //Отображаем данные установки выбранной в comboBox2
            string ust;
            ust = comboBox2.Text;
            sql = "SELECT id,Установка,Тип_комплектующего,Обозначение,Наименование,Серийный_номер,Поставщик,Изготовитель,Дата_изготовления,Срок_хранения,Страна_изготовления FROM ust1 WHERE Установка =" + "'" + ust + "'";
            UpdateGrid(sql);

        }

        //редатировать
        private void button2_Click(object sender, EventArgs e)
        {
            label30.Text = dataGridView1.SelectedRows[0].Cells["id"].Value.ToString();
            comboBox5.Text = dataGridView1.SelectedRows[0].Cells["Установка"].Value.ToString();
            comboBox6.Text = dataGridView1.SelectedRows[0].Cells["Тип_комплектующего"].Value.ToString();
            textBox10.Text = dataGridView1.SelectedRows[0].Cells["Обозначение"].Value.ToString();
            textBox11.Text = dataGridView1.SelectedRows[0].Cells["Наименование"].Value.ToString();
            textBox12.Text = dataGridView1.SelectedRows[0].Cells["Серийный_номер"].Value.ToString();
            textBox13.Text = dataGridView1.SelectedRows[0].Cells["Поставщик"].Value.ToString();
            textBox14.Text = dataGridView1.SelectedRows[0].Cells["Изготовитель"].Value.ToString();
            dateTimePicker2.Text = dataGridView1.SelectedRows[0].Cells["Дата_изготовления"].Value.ToString();
            textBox16.Text = dataGridView1.SelectedRows[0].Cells["Срок_хранения"].Value.ToString();
            textBox17.Text = dataGridView1.SelectedRows[0].Cells["Страна_изготовления"].Value.ToString();


        }

        //сохранить редактирование
        private void button5_Click(object sender, EventArgs e)
        {

        //Подключение 
            string str = @"Data Source=DESKTOP-PVL4P4H;Initial Catalog=Ustanovki;Integrated Security=True";
            SqlConnection con;
            con = new SqlConnection(str);
            con.Open();


            SqlCommand command = new SqlCommand("Update ust1 set Установка=@Установка,Тип_комплектующего=@Тип_комплектующего,Обозначение=@Обозначение,Наименование=@Наименование,Серийный_номер=@Серийный_номер,Поставщик=@Поставщик,Изготовитель=@Изготовитель,Дата_изготовления=@Дата_изготовления,Срок_хранения=@Срок_хранения,Страна_изготовления=@Страна_изготовления where id=@id", con);
            command.Parameters.AddWithValue("@id", int.Parse(label30.Text));
            command.Parameters.AddWithValue("@Установка", comboBox5.Text);
            command.Parameters.AddWithValue("@Тип_комплектующего", comboBox6.Text);
            command.Parameters.AddWithValue("@Обозначение", textBox10.Text);
            command.Parameters.AddWithValue("@Наименование", textBox11.Text);
            command.Parameters.AddWithValue("@Серийный_номер", textBox12.Text);
            command.Parameters.AddWithValue("@Поставщик", textBox13.Text);
            command.Parameters.AddWithValue("@Изготовитель", textBox14.Text);
            command.Parameters.AddWithValue("@Дата_изготовления", dateTimePicker2.Text);
            command.Parameters.AddWithValue("@Срок_хранения", textBox16.Text);
            command.Parameters.AddWithValue("@Страна_изготовления", textBox17.Text);
            command.ExecuteNonQuery();


            //Отображаем данные установки выбранной в comboBox2
            string ust;
            ust = comboBox2.Text;
            string sql = "SELECT id,Установка,Тип_комплектующего,Обозначение,Наименование,Серийный_номер,Поставщик,Изготовитель,Дата_изготовления,Срок_хранения,Страна_изготовления FROM ust1 WHERE Установка =" + "'" + ust + "'";
            UpdateGrid(sql);
        }


    }
}
