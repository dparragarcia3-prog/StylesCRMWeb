package modelo;


/*
 * Clase modelo Cliente.
 * 
 * Representa la información de los clientes
 * registrados dentro del sistema Styles CRM.
 *
 * Esta clase almacena los datos que serán
 * enviados y recuperados desde la base de datos.
 */

public class Cliente {


    // Identificador único del cliente
    private int id;


    // Nombre del cliente
    private String nombre;


    // Apellido del cliente
    private String apellido;


    // Número telefónico del cliente
    private String telefono;


    // Correo electrónico del cliente
    private String email;



    /*
     * Constructor vacío utilizado
     * para crear objetos Cliente sin información inicial.
     */
    public Cliente(){

    }



    /*
     * Constructor utilizado para crear
     * un cliente con sus datos básicos.
     */
    public Cliente(String nombre, String apellido,
                   String telefono, String email){

        this.nombre = nombre;
        this.apellido = apellido;
        this.telefono = telefono;
        this.email = email;

    }



    // Obtiene el identificador del cliente
    public int getId() {

        return id;

    }


    // Asigna un identificador al cliente
    public void setId(int id) {

        this.id = id;

    }



    // Obtiene el nombre del cliente
    public String getNombre() {

        return nombre;

    }


    // Modifica el nombre del cliente
    public void setNombre(String nombre) {

        this.nombre = nombre;

    }



    // Obtiene el apellido del cliente
    public String getApellido() {

        return apellido;

    }


    // Modifica el apellido del cliente
    public void setApellido(String apellido) {

        this.apellido = apellido;

    }



    // Obtiene el teléfono del cliente
    public String getTelefono() {

        return telefono;

    }


    // Modifica el teléfono del cliente
    public void setTelefono(String telefono) {

        this.telefono = telefono;

    }



    // Obtiene el correo electrónico
    public String getEmail() {

        return email;

    }


    // Modifica el correo electrónico
    public void setEmail(String email) {

        this.email = email;

    }

}