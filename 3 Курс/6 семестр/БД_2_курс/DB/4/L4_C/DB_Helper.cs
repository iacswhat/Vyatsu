using System.Data;
using Npgsql;
using System.Numerics;

namespace L4_C;

public class DB
{
	private NpgsqlConnection connection = new NpgsqlConnection("Server=localhost;Port=5432;Database=lab;User Id=postgres;Password=iacswhat789");

	public DB()
	{
		try
        {
            connection.Open();

		} 
        catch (Exception e) { }
	}

	public void CloseConnection()
    {
        try
        {
            if (connection != null)
            {
                connection.Close();
            }
        }
        catch (Exception e) { }
    }

    public void Read(DataGridView dgv)
    {
        NpgsqlCommand command = new NpgsqlCommand();
        command.Connection = connection;
        command.CommandType = CommandType.Text;
        command.CommandText = "" +
                "SELECT p.name, p.age, p.position, te.name " +
                "FROM team te " +
                "JOIN player p " +
                "ON te.id = p.id_team";

        NpgsqlDataReader dr = command.ExecuteReader();
        if (dr.HasRows)
        {
            DataTable dt = new DataTable();
            dt.Load(dr);
            dgv.DataSource = dt;
            dgv.Columns[0].HeaderText = "Имя";
            dgv.Columns[1].HeaderText = "Возраст";
            dgv.Columns[2].HeaderText = "Позиция";
            dgv.Columns[3].HeaderText = "Команда";
        }
        command.Dispose();

    }

    public void Add(TextBox name, TextBox age, string pos, ComboBox team)
    {
        NpgsqlCommand command = new NpgsqlCommand("insert into player(id_team, name, age, position) values (@p1, @p2, @p3, CAST(@p4 as position_type_enum))", connection);


        //string str = name.Text;

        //NpgsqlCommand command = new NpgsqlCommand("do language plpgsql $$\n" +
        //    "begin\n" +
        //    "if not exists (select * from player where name = '" + str + "') then insert into player(id_team, name, age, position) values (@p1, @p2, @p3, CAST(@p4 as position_type_enum));\n" +
        //    "end if;\n" +
        //    "end;\n" +
        //    "$$;", connection);

        command.Parameters.Add("@p1", NpgsqlTypes.NpgsqlDbType.Bigint).Value = team.SelectedValue;
        command.Parameters.Add("@p2", NpgsqlTypes.NpgsqlDbType.Varchar).Value = name.Text;
        command.Parameters.Add("@p3", NpgsqlTypes.NpgsqlDbType.Integer).Value = Convert.ToInt64(age.Text);
        command.Parameters.Add("@p4", NpgsqlTypes.NpgsqlDbType.Varchar).Value = pos;

        //var a = new NpgsqlParameter("@p1", NpgsqlTypes.NpgsqlDbType.Bigint);
        //var b = new NpgsqlParameter("@p2", NpgsqlTypes.NpgsqlDbType.Varchar);
        //var c = new NpgsqlParameter("@p3", NpgsqlTypes.NpgsqlDbType.Integer);
        //var d = new NpgsqlParameter("@p4", NpgsqlTypes.NpgsqlDbType.Varchar);

        //a.Value = team.SelectedValue;
        //b.Value = name.Text;
        //c.Value = Convert.ToInt64(age.Text);
        //d.Value = pos;

        //command.Parameters.Add(a);
        //command.Parameters.Add(b);
        //command.Parameters.Add(c);
        //command.Parameters.Add(d);




        command.ExecuteNonQuery();
        command.Dispose();

    }


    public void Del(TextBox name)
    {
        NpgsqlCommand command = new NpgsqlCommand("delete from player where name = @p1", connection);

        var a = new NpgsqlParameter("@p1", NpgsqlTypes.NpgsqlDbType.Varchar);

        a.Value = name.Text;

        command.Parameters.Add(a);

        command.ExecuteNonQuery();
        command.Dispose();

    }

    public void Sort(DataGridView dgv, TextBox age)
    {
        NpgsqlCommand command = new NpgsqlCommand();
        command.Connection = connection;
        command.CommandType = CommandType.Text;
        command.CommandText = "" +
                "SELECT p.name, p.age, p.position, te.name " +
                "FROM team te " +
                "JOIN player p " +
                "ON te.id = p.id_team where p.age <= @p1";

        var a = new NpgsqlParameter("@p1", NpgsqlTypes.NpgsqlDbType.Integer);

        a.Value = Convert.ToInt64(age.Text);
        command.Parameters.Add(a);

        NpgsqlDataReader dr = command.ExecuteReader();
        if (dr.HasRows)
        {
            DataTable dt = new DataTable();
            dt.Load(dr);
            dgv.DataSource = dt;
            dgv.Columns[0].HeaderText = "Имя";
            dgv.Columns[1].HeaderText = "Возраст";
            dgv.Columns[2].HeaderText = "Позиция";
            dgv.Columns[3].HeaderText = "Команда";
        }
        command.Dispose();
    }


    public void cbTeam(ComboBox team)
    {
        //string sql = "select name from team where id in (select id_team from player)";
        string sql1 = "select id, name from team";

        using (NpgsqlCommand cmd = new NpgsqlCommand(sql1, connection))
        {
            cmd.CommandType = CommandType.Text;
            DataTable table = new DataTable();
            NpgsqlDataAdapter adapter = new NpgsqlDataAdapter(cmd);
            adapter.Fill(table);
            team.DisplayMember = "name";
            team.ValueMember = "id";
            team.DataSource = table;
        }

    }

}
