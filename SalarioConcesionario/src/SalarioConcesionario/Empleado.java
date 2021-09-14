package SalarioConcesionario; //Comentar para entregar

public class Empleado{
    
    private int id;
    private String nombre;
    private int salario;
        
    //Atributos necesarios aún no definidos en los diagramas UML de las guías
    /*
    private int comisiones;
    private int horasExtras;
    private int auxilioTransporte;
    */
        
    public Empleado() {
    }

    public Empleado(String name, int salary) {
        this.nombre = name.toLowerCase();
        this.salario = salary;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String name) {
        this.nombre = name.toLowerCase();
    }

    public int getSalario() {
        return salario;
    }

    public void setSalario(int salary) {
        this.salario = salary;
    }
    
    @Override
    public String toString() {
        String string = "";
        string += "EMPLEADO "   + 
                  "\nID: "      + this.getId() + 
                  "\nNombre: "  + this.getNombre() +
                  "\nSalario: " + String.format("$%,.2f", (this.getSalario()*1.0));
        return string;
    }
}
