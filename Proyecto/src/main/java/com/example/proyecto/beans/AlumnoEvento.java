package com.example.proyecto.beans;

public class AlumnoEvento {

    private Alumno alumno;
    private Integrante integrante;
    private Evento evento;
    private int idAlumnoEvento;

    public Alumno getAlumno() {
        return alumno;
    }

    public void setAlumno(Alumno alumno) {
        this.alumno = alumno;
    }

    public Integrante getIntegrante() {
        return integrante;
    }

    public void setIntegrante(Integrante integrante) {
        this.integrante = integrante;
    }

    public Evento getEvento() {
        return evento;
    }

    public void setEvento(Evento evento) {
        this.evento = evento;
    }

    public int getIdAlumnoEvento() {
        return idAlumnoEvento;
    }

    public void setIdAlumnoEvento(int idAlumnoEvento) {
        this.idAlumnoEvento = idAlumnoEvento;
    }
}
