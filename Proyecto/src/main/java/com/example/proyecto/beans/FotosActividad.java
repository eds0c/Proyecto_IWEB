package com.example.proyecto.beans;

import java.io.InputStream;

public class FotosActividad {

    private int idFotosActividad;
    private String descripcion;
    private InputStream foto;
    private Actividad actividad;


    public int getIdFotosActividad() {
        return idFotosActividad;
    }

    public void setIdFotosActividad(int idFotosActividad) {
        this.idFotosActividad = idFotosActividad;
    }

    public String getDescripcion() {
        return descripcion;
    }

    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }

    public Actividad getActividad() {
        return actividad;
    }

    public void setActividad(Actividad actividad) {
        this.actividad = actividad;
    }

    public InputStream getFoto() {
        return foto;
    }

    public void setFoto(InputStream foto) {
        this.foto = foto;
    }
}
