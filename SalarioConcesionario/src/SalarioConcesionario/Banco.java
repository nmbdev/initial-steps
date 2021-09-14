package SalarioConcesionario; //Comentar para entregar

import java.util.ArrayList;

public class Banco {
    private final static float PRIMA                        = 0.08330f;
    private final static float CESANTIA                     = 0.08330f;
    private final static float INTERESES_CESANTIA           = 0.12000f;
    private final static float VACACIONES                   = 0.04160f;
    private final static float SALUD_SEGURIDADSOCIAL        = 0.08500f;
    private final static float PENSION_SEGURIDADSOCIAL      = 0.12000f;
    private final static float ARL                          = 0.00520f; // Valor de la guia: 0.00522f (inconsistente con la calificación)
    private final static float SALUD_NOMINA                 = 0.04000f;
    private final static float PENSION_NOMINA               = 0.04000f;
    private final static float CAJA_COMPENSACION_FAMILIAR   = 0.04000f;
    private final static float ICBF                         = 0.03000f;
    private final static float SENA                         = 0.02000f;
    
    //Valores provisionales, deberían ser atributos de la clase empleado, aún no están definidos en el diagrama UML de la guía
    private final static int COMISIONES                     = 0;
    private final static int HORAS_EXTRA                    = 0;
    private final static int AUXILIO_TRANSPORTE             = 0;
    
    private ArrayList<Empleado> empleados;
    
    public Banco(){        
        this.empleados = new ArrayList</*Empleado*/>();
    }

    public ArrayList<Empleado> getEmpleados() {
        return empleados;
    }

    public void setEmpleados(ArrayList<Empleado> empleado) {
        this.empleados = empleado;
    }
    
    public Empleado getEmpleado(int id) {
        return empleados.get(id);
    }
    
    public void setEmpleado(Empleado empleado) {
        this.empleados.add(empleado);
    }
    
    public Empleado getEmpleado(String nombre) {
        Empleado empleado = null;
        try {
            for(Empleado e:this.empleados){
                if((e.getNombre().toLowerCase()).equals(nombre.toLowerCase())){
                    empleado = e;
                }
            }            
        } catch (Exception e) {
            System.out.println("Error: " + e);
        } 
        
        return empleado;
    }
        
    public static double liquidarPrestacionesEmp(Empleado empleado){
        double prestaciones = 0.0;
        
        try {
            prestaciones = empleado.getSalario() * (PRIMA + (CESANTIA*(1+INTERESES_CESANTIA)) + VACACIONES);
            prestaciones = Math.round(prestaciones);                        
        } catch (Exception e) {
            System.out.println("Error: "+e);
        }
        
        return prestaciones;
    }
    
    public static double liquidarSegSocialEmp(Empleado empleado){
        double seguridadSocial = 0.0;
        
        try {
            //int totalDevengado = empleado.getSalario() + empleado.getComisiones() + empleado.getHorasExtra() + empleado.getAuxilioTransporte(); 
            int totalDevengado = empleado.getSalario() + COMISIONES + HORAS_EXTRA + AUXILIO_TRANSPORTE; 
            
            seguridadSocial = (totalDevengado - AUXILIO_TRANSPORTE /*empleado.getAuxilioTransporte()*/) * (SALUD_SEGURIDADSOCIAL + PENSION_SEGURIDADSOCIAL + ARL);
            seguridadSocial = Math.round(seguridadSocial);            
        } catch (Exception e) {
            System.out.println("Error: "+e);
        }
        
        return seguridadSocial;
    }
    
    public static double liquidarNominaEmp(Empleado empleado){
        double nomina = 0.0;
        
        try {
            //int totalDevengado = empleado.getSalario() + empleado.getComisiones() + empleado.getHorasExtra() + empleado.getAuxilioTransporte(); 
            int totalDevengado = empleado.getSalario() + COMISIONES + HORAS_EXTRA + AUXILIO_TRANSPORTE; 
            
            nomina = totalDevengado - ( (totalDevengado - AUXILIO_TRANSPORTE /*empleado.getAuxilioTransporte()*/) * (SALUD_NOMINA + PENSION_NOMINA) );
            nomina = Math.round(nomina);                        
        } catch (Exception e) {
            System.out.println("Error: "+e);
        }
        
        return nomina;
    }
    
    public static double liquidarParafiscalesEmp(Empleado empleado){
        double parafiscales = 0.0;
        
        try {
            //int totalDevengado = empleado.getSalario() + empleado.getComisiones() + empleado.getHorasExtra() + empleado.getAuxilioTransporte(); 
            int totalDevengado = empleado.getSalario() + COMISIONES + HORAS_EXTRA + AUXILIO_TRANSPORTE; 
            
            parafiscales = (totalDevengado - AUXILIO_TRANSPORTE /*empleado.getAuxilioTransporte()*/) * (CAJA_COMPENSACION_FAMILIAR + ICBF + SENA) ;
            parafiscales = Math.round(parafiscales);                        
        } catch (Exception e) {
            System.out.println("Error: "+e);
        }
        
        return parafiscales;
    }

    @Override
    public String toString() {
        String string = "";
        for(Empleado e:this.empleados){
            string += "EMPLEADO "   + this.empleados.indexOf(e) +
                      "\nID: "      + e.getId() + 
                      "\nNombre: "  + e.getNombre() +
                      "\nSalario: " + String.format("$%,.2f", (e.getSalario()*1.0)) + 
                      "\n\n";
        }
        return string;
    }
}
