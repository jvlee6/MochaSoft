package cl.mochasoft.model;

/**
 *
 * @author Jorge A
 */
public class Staff {

    private String id;
    private String nombre;

    public Staff(String id, String nombre) {
        this.id = id;
        this.nombre = nombre;
    }

    public Staff() {
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    @Override
    public String toString() {
        return "Staff{" + "id=" + id + ", nombre=" + nombre + '}';
    }

}
