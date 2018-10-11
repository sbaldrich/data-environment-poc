import com.facebook.presto.jdbc.internal.guava.base.Charsets;
import com.google.common.io.Resources;

import java.io.IOException;
import java.sql.*;
import java.util.ResourceBundle;

public class ExamplePrestoConsumer {
    public static void main(String[] args) throws IOException {
        try (Connection connection = DriverManager.getConnection(args.length == 0 ? prestoUrl() : args[0], "test", null)) {
            final PreparedStatement statement = connection.prepareStatement(prestoQuery());
            final ResultSet resultSet = statement.executeQuery();
            while (resultSet.next()) {
                System.out.println(teamStringFromRow(resultSet));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    private static String prestoUrl(){
        return ResourceBundle.getBundle("consumer").getString("presto.url");
    }

    private static String prestoQuery() throws IOException {
        return Resources.toString(Resources.getResource("query.sql"), Charsets.UTF_8);
    }

    private static String teamStringFromRow(ResultSet rs) throws SQLException {
        return String.format("Team {id: %d, name: %s, points: %d}\n",
                rs.getInt("team_id"),
                rs.getString("team_name"),
                rs.getInt("points")
        );
    }
}

