<%@ page import="java.sql.*" %>
<%@ page import="conexion.ConexionBD" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Lista de Clientes - Styles CRM</title>
    <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <style>
        :root {
            --primary: #800020;
            --primary-hover: #5c0017;
            --background: #f8f3f4;
            --card-bg: #ffffff;
            --text-main: #2d3748;
            --text-muted: #718096;
            --border-color: #e2e8f0;
        }

        body {
            font-family: 'Outfit', sans-serif;
            background-color: var(--background);
            color: var(--text-main);
            margin: 0;
            padding: 40px 20px;
            display: flex;
            justify-content: center;
        }

        .container {
            width: 100%;
            max-width: 900px;
            background: var(--card-bg);
            padding: 40px;
            border-radius: 16px;
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.05);
        }

        h2 {
            color: var(--primary);
            margin-top: 0;
            margin-bottom: 24px;
            font-size: 28px;
            font-weight: 600;
            text-align: center;
        }

        .actions {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 24px;
        }

        .btn {
            background-color: var(--primary);
            color: white;
            text-decoration: none;
            padding: 10px 20px;
            border-radius: 8px;
            font-weight: 500;
            transition: all 0.2s ease;
            display: inline-flex;
            align-items: center;
            gap: 8px;
        }

        .btn:hover {
            background-color: var(--primary-hover);
            transform: translateY(-1px);
            box-shadow: 0 4px 12px rgba(128, 0, 32, 0.2);
        }

        .btn-secondary {
            background-color: transparent;
            color: var(--text-muted);
            border: 1px solid var(--border-color);
        }

        .btn-secondary:hover {
            background-color: #f7fafc;
            color: var(--text-main);
            box-shadow: none;
            transform: none;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 10px;
            text-align: left;
        }

        th {
            background-color: #f7fafc;
            color: var(--text-muted);
            font-weight: 600;
            text-transform: uppercase;
            font-size: 12px;
            letter-spacing: 0.05em;
            padding: 16px;
            border-bottom: 2px solid var(--border-color);
        }

        td {
            padding: 16px;
            border-bottom: 1px solid var(--border-color);
            font-size: 15px;
        }

        tr:last-child td {
            border-bottom: none;
        }

        tr:hover td {
            background-color: #fffafb;
        }

        .empty-state {
            text-align: center;
            padding: 40px;
            color: var(--text-muted);
            font-size: 16px;
        }
    </style>
</head>
<body>

<div class="container">
    <h2>Lista de Clientes Registrados</h2>
    
    <div class="actions">
        <a href="index.html" class="btn btn-secondary">
            ← Volver al Inicio
        </a>
        <a href="registrarCliente.html" class="btn">
            + Registrar Nuevo Cliente
        </a>
    </div>

    <table>
        <thead>
            <tr>
                <th>ID</th>
                <th>Nombre</th>
                <th>Apellido</th>
                <th>Teléfono</th>
                <th>Email</th>
            </tr>
        </thead>
        <tbody>
            <%
                Connection conn = null;
                Statement stmt = null;
                ResultSet rs = null;
                boolean tieneRegistros = false;
                try {
                    conn = ConexionBD.conectar();
                    if (conn != null) {
                        stmt = conn.createStatement();
                        rs = stmt.executeQuery("SELECT * FROM clientes ORDER BY id_cliente DESC");
                        while(rs.next()) {
                            tieneRegistros = true;
                            out.println("<tr>");
                            out.println("<td>" + rs.getInt("id_cliente") + "</td>");
                            out.println("<td>" + rs.getString("nombre") + "</td>");
                            out.println("<td>" + rs.getString("apellido") + "</td>");
                            out.println("<td>" + rs.getString("telefono") + "</td>");
                            out.println("<td>" + rs.getString("email") + "</td>");
                            out.println("</tr>");
                        }
                    }
                } catch (Exception e) {
                    out.println("<tr><td colspan='5' class='empty-state' style='color:red;'>Error al cargar los datos: " + e.getMessage() + "</td></tr>");
                } finally {
                    if (rs != null) try { rs.close(); } catch(Exception e) {}
                    if (stmt != null) try { stmt.close(); } catch(Exception e) {}
                    if (conn != null) try { conn.close(); } catch(Exception e) {}
                }

                if (!tieneRegistros) {
                    out.println("<tr><td colspan='5' class='empty-state'>No hay clientes registrados en el sistema.</td></tr>");
                }
            %>
        </tbody>
    </table>
</div>

</body>
</html>