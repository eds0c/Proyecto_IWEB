package com.example.proyecto.beans;

public class AlumnoEvento {

    private int idAlumno;
    private String descripcionIntegrante;
    private String descripcionEvento;
    private String fechaEvento;



    public int getIdAlumno() {
        return idAlumno;
    }

    public void setIdAlumno(int idAlumno) {
        this.idAlumno = idAlumno;
    }

    public String getDescripcionIntegrante() {
        return descripcionIntegrante;
    }

    public void setDescripcionIntegrante(String descripcionIntegrante) {
        this.descripcionIntegrante = descripcionIntegrante;
    }

    public String getDescripcionEvento() {
        return descripcionEvento;
    }

    public void setDescripcionEvento(String descripcionEvento) {
        this.descripcionEvento = descripcionEvento;
    }

    public String getFechaEvento() {
        return fechaEvento;
    }

    public void setFechaEvento(String fechaEvento) {
        this.fechaEvento = fechaEvento;
    }
}
