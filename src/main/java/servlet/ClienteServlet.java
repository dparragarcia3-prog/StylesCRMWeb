package servlet;


import dao.ClienteDAO;
import modelo.Cliente;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;



/*
 * Servlet encargado de gestionar
 * las solicitudes del módulo clientes
 * del sistema Styles CRM.
 *
 * Recibe la información enviada desde
 * el formulario registrarCliente.html
 * y la envía al DAO para almacenarla.
 */


@WebServlet("/ClienteServlet")
public class ClienteServlet extends HttpServlet {



@Override
protected void doPost(HttpServletRequest request,
                      HttpServletResponse response)
throws ServletException, IOException {



    // Obtención de datos enviados desde el formulario

    String nombre = request.getParameter("nombre");

    String apellido = request.getParameter("apellido");

    String telefono = request.getParameter("telefono");

    String email = request.getParameter("email");



    // Creación del objeto cliente

    Cliente cliente = new Cliente(
            nombre,
            apellido,
            telefono,
            email
    );



    // Comunicación con la capa DAO

    ClienteDAO dao = new ClienteDAO();



    boolean guardado = dao.insertar(cliente);



    System.out.println(
        "Resultado del guardado: " + guardado
    );



    // Redirecciona a la lista de clientes para confirmar el registro

    response.sendRedirect(
        "clientes.jsp"
    );


}

// Método GET

@Override
protected void doGet(HttpServletRequest request,
                     HttpServletResponse response)
throws ServletException, IOException {


    // Método GET encargado de mostrar
    // el formulario de registro de clientes

    response.sendRedirect(
            "registrarCliente.html"
    );


}


}