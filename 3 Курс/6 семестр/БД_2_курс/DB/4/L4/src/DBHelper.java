import java.sql.*;


public class DBHelper {
    //Объект соединения с БД
    private final Connection connection;

    //строка подключения к БД
    private static String DB_URL = "jdbc:postgresql://localhost:5432/lab";

    //Имя пользователя и пароль
    private static String DB_USER = "postgres";
    private static String DB_PASSWORD = "iacswhat789";

    public DBHelper() {
        try {
            connection = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
            System.out.println("Successful!\n");
        } catch (SQLException e) {
            System.out.println("Not successful!\n");
            throw new RuntimeException(e);
        }
    }

    public void closeConnection() {
        try {
            if (connection != null && !connection.isClosed()) {
                connection.close();
                System.out.println("Connection is closed!\n");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void simpleSelect() {
        Statement statement;
        ResultSet result;
        try {
            statement = connection.createStatement();
            result = statement.executeQuery("SELECT * FROM public.player");

            while (result.next())
            {
                System.out.printf("Команда: %s\nИмя: %s\nВозраст: %d\nПозиция: %s\n\n",
                        result.getInt("id_team"),
                        result.getString("name"),
                        result.getInt("age"),
                        result.getString("position"));
            }

            statement.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void simplePreparedSelect() {
        PreparedStatement preparedStatement;
        ResultSet result;
        try {
            preparedStatement = connection.prepareStatement("SELECT * FROM public.player WHERE age <= ?");
            preparedStatement.setInt(1, 29);
            result = preparedStatement.executeQuery();
            while (result.next()) {
                System.out.printf("Команда: %s\nИмя: %s\nВозраст: %d\nПозиция: %s\n\n",
                        result.getInt("id_team"),
                        result.getString("name"),
                        result.getInt("age"),
                        result.getString("position"));
            }
            preparedStatement.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }


    public void simpleInsert() {
        PreparedStatement preparedStatement;
        try {
            preparedStatement = connection.prepareStatement("INSERT INTO team(name, place) values(?, ?)");
            preparedStatement.setString(1, "Houston Rockets");
            preparedStatement.setInt(2, 5);
            preparedStatement.execute();
            preparedStatement.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }


    public void simpleUpdate() {
        PreparedStatement preparedStatement;
        try {
            preparedStatement = connection.prepareStatement("UPDATE team SET name = ?, place = ? WHERE id = 8");
            preparedStatement.setString(1, "Chicago Bulls");
            preparedStatement.setInt(2, 5);
            preparedStatement.execute();
            preparedStatement.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void simpleDelete() {
        PreparedStatement preparedStatement;
        try {
            preparedStatement = connection.prepareStatement("DELETE FROM player WHERE id = ?");
            preparedStatement.setInt(1, 8);
            preparedStatement.execute();
            preparedStatement.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void simpleFunctionSelect() {
        CallableStatement callableStatement;
        try {
            callableStatement = connection.prepareCall("{call filter_player_by_age(?)}");
            callableStatement.setInt(1, 29);
            ResultSet resultSet = callableStatement.executeQuery();

            while (resultSet.next()) {
                System.out.printf("Имя: %s\nВозраст: %d\nПозиция: %s\n\n",
                        resultSet.getString("name"),
                        resultSet.getInt("age"),
                        resultSet.getString("position"));
            }
            callableStatement.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
