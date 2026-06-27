package conexion;


import java.sql.Connection;
import java.sql.DriverManager;



/*
 * Clase encargada de gestionar la conexión
 * entre la aplicación Styles CRM y la base
 * de datos MySQL.
 */

public class ConexionBD {



    // Dirección de conexión a la base de datos

    private static final String URL =
            "jdbc:mysql://localhost:3306/stylescrm";



    // Usuario de la base de datos

    private static final String USER = "root";



    // Contraseña de la base de datos

    private static final String PASSWORD = "";




    /*
     * Método encargado de establecer conexión
     * con MySQL.
     *
     * @return objeto Connection activo
     */

    public static Connection conectar() {



        Connection conexion = null;



        try {



            // Cargar controlador JDBC de MySQL

            Class.forName(
              "com.mysql.cj.jdbc.Driver"
            );



            // Crear conexión con la base de datos

            conexion = DriverManager.getConnection(
                    URL,
                    USER,
                    PASSWORD
            );



            System.out.println(
              "Conexión exitosa a Styles CRM"
            );



        } catch (Exception e) {



            System.out.println(
              "Error de conexión: " + e.getMessage()
            );



        }



        return conexion;


    }


}