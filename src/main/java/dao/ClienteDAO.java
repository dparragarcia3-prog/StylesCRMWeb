package dao;


import conexion.ConexionBD;
import modelo.Cliente;

import java.sql.Connection;
import java.sql.PreparedStatement;


/*
 * Clase ClienteDAO
 *
 * Esta clase se encarga de realizar
 * las operaciones de acceso a datos
 * relacionadas con los clientes.
 *
 * Permite guardar la información del cliente
 * en la base de datos del sistema Styles CRM.
 */

public class ClienteDAO {



    /*
     * Método encargado de insertar un nuevo cliente
     * en la tabla clientes de la base de datos.
     *
     * @param cliente objeto con la información del cliente
     * @return true si el registro fue guardado correctamente
     */

    public boolean insertar(Cliente cliente) {


        boolean resultado = false;


        String sql = 
        "INSERT INTO clientes(nombre, apellido, telefono, email) VALUES (?, ?, ?, ?)";



        try (Connection conexion = ConexionBD.conectar();
             
             PreparedStatement ps = conexion.prepareStatement(sql)) {



            // Se envían los datos del cliente a la consulta SQL

            ps.setString(1, cliente.getNombre());

            ps.setString(2, cliente.getApellido());

            ps.setString(3, cliente.getTelefono());

            ps.setString(4, cliente.getEmail());



            // Ejecuta la inserción en la base de datos

            ps.executeUpdate();



            resultado = true;



            System.out.println("Cliente guardado correctamente");



        } catch(Exception e) {


            System.out.println(
                "Error al insertar cliente: " + e.getMessage()
            );


        }


        return resultado;


    }


}