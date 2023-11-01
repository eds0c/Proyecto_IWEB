package com.example.proyecto.beans;

public class DelegadoActividad {

    private int idDelegadoActividad;
    private String descripcion;
    private String fechaAprobacion;
    private Actividad actividad;
    private DelegadoGeneral delegadoGeneral;

    public int getIdDelegadoActividad() {
        return idDelegadoActividad;
    }

    public void setIdDelegadoActividad(int idDelegadoActividad) {
        this.idDelegadoActividad = idDelegadoActividad;
    }

    public String getDescripcion() {
        return descripcion;
    }

    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }

    public String getFechaAprobacion() {
        return fechaAprobacion;
    }

    public void setFechaAprobacion(String fechaAprobacion) {
        this.fechaAprobacion = fechaAprobacion;
    }

    public Actividad getActividad() {
        return actividad;
    }

    public void setActividad(Actividad actividad) {
        this.actividad = actividad;
    }

    public DelegadoGeneral getDelegadoGeneral() {
        return delegadoGeneral;
    }

    public void setDelegadoGeneral(DelegadoGeneral delegadoGeneral) {
        this.delegadoGeneral = delegadoGeneral;
    }
}
