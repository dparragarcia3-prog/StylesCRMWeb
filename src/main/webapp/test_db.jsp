<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Diagnostico de Base de Datos</title>
    <style>
        body { font-family: sans-serif; margin: 20px; line-height: 1.6; }
        .success { color: green; font-weight: bold; }
        .error { color: red; font-weight: bold; }
        pre { background: #f4f4f4; padding: 10px; border: 1px solid #ddd; overflow: auto; }
        table { border-collapse: collapse; width: 100%; margin-top: 10px; }
        th, td { border: 1px solid #ddd; padding: 8px; text-align: left; }
        th { background-color: #f2f2f2; }
    </style>
</head>
<body>
    <h2>Diagnostico de Base de Datos - Styles CRM</h2>

    <h3>1. Verificacion del Driver JDBC</h3>
    <%
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            out.println("<p class='success'>Driver MySQL cargado correctamente.</p>");
        } catch (ClassNotFoundException e) {
            out.println("<p class='error'>Error al cargar el driver MySQL: " + e.getMessage() + "</p>");
            out.println("<pre>");
            e.printStackTrace(new java.io.PrintWriter(out));
            out.println("</pre>");
        }
    %>

    <h3>2. Intento de Conexion a la Base de Datos</h3>
    <%
        Connection conn = null;
        try {
            String url = "jdbc:mysql://localhost:3306/stylescrm";
            String user = "root";
            String password = "";
            conn = DriverManager.getConnection(url, user, password);
            out.println("<p class='success'>Conexion establecida con exito a: " + url + "</p>");
            
            DatabaseMetaData dbmd = conn.getMetaData();
            
            out.println("<h3>3. Tablas en la base de datos</h3>");
            ResultSet tables = dbmd.getTables("stylescrm", null, "%", new String[]{"TABLE"});
            out.println("<ul>");
            boolean tieneClientes = false;
            while(tables.next()) {
                String tableName = tables.getString("TABLE_NAME");
                out.println("<li>" + tableName + "</li>");
                if ("clientes".equalsIgnoreCase(tableName)) {
                    tieneClientes = true;
                }
            }
            out.println("</ul>");
            
            if (tieneClientes) {
                out.println("<h3>4. Estructura de la tabla 'clientes'</h3>");
                out.println("<table><tr><th>Columna</th><th>Tipo</th><th>Nulo</th><th>Clave</th></tr>");
                ResultSet columns = dbmd.getColumns("stylescrm", null, "clientes", "%");
                while(columns.next()) {
                    out.println("<tr>");
                    out.println("<td>" + columns.getString("COLUMN_NAME") + "</td>");
                    out.println("<td>" + columns.getString("TYPE_NAME") + "(" + columns.getInt("COLUMN_SIZE") + ")</td>");
                    out.println("<td>" + columns.getString("IS_NULLABLE") + "</td>");
                    out.println("<td>" + (columns.getInt("ORDINAL_POSITION") == 1 ? "PK" : "") + "</td>");
                    out.println("</tr>");
                }
                out.println("</table>");
                
                out.println("<h3>5. Ultimos registros en 'clientes'</h3>");
                Statement stmt = conn.createStatement();
                try {
                    ResultSet rs = stmt.executeQuery("SELECT * FROM clientes LIMIT 5");
                    ResultSetMetaData rsmd = rs.getMetaData();
                    int colCount = rsmd.getColumnCount();
                    out.println("<table><tr>");
                    for (int i = 1; i <= colCount; i++) {
                        out.println("<th>" + rsmd.getColumnName(i) + "</th>");
                    }
                    out.println("</tr>");
                    while(rs.next()) {
                        out.println("<tr>");
                        for (int i = 1; i <= colCount; i++) {
                            out.println("<td>" + rs.getString(i) + "</td>");
                        }
                        out.println("</tr>");
                    }
                    out.println("</table>");
                } catch (Exception ex) {
                    out.println("<p class='error'>Error al consultar clientes: " + ex.getMessage() + "</p>");
                }
            } else {
                out.println("<p class='error'>La tabla 'clientes' no existe en la base de datos 'stylescrm'.</p>");
            }
            
        } catch (SQLException e) {
            out.println("<p class='error'>Error de conexion a la base de datos:</p>");
            out.println("<pre>Codigo de error SQL: " + e.getErrorCode() + "\nEstado SQL: " + e.getSQLState() + "\nMensaje: " + e.getMessage() + "</pre>");
            out.println("<pre>");
            e.printStackTrace(new java.io.PrintWriter(out));
            out.println("</pre>");
        } finally {
            if (conn != null) {
                try { conn.close(); } catch (SQLException e) {}
            }
        }
    %>
</body>
</html>
