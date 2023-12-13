package com.example.proyecto.Dtos;

import com.example.proyecto.beans.Actividad;

public class IntegrantesPorActividad {

    private Actividad actividad;
    private int cantidadIntegrantesBarra;
    private int cantidadIntegrantesEquipo;
    private int cantidadIntegrantesPendientes;

    public Actividad getActividad() {
        return actividad;
    }

    public void setActividad(Actividad actividad) {
        this.actividad = actividad;
    }

    public int getCantidadIntegrantesBarra() {
        return cantidadIntegrantesBarra;
    }

    public void setCantidadIntegrantesBarra(int cantidadIntegrantesBarra) {
        this.cantidadIntegrantesBarra = cantidadIntegrantesBarra;
    }

    public int getCantidadIntegrantesEquipo() {
        return cantidadIntegrantesEquipo;
    }

    public void setCantidadIntegrantesEquipo(int cantidadIntegrantesEquipo) {
        this.cantidadIntegrantesEquipo = cantidadIntegrantesEquipo;
    }

    public int getCantidadIntegrantesPendientes() {
        return cantidadIntegrantesPendientes;
    }

    public void setCantidadIntegrantesPendientes(int cantidadIntegrantesPendientes) {
        this.cantidadIntegrantesPendientes = cantidadIntegrantesPendientes;
    }
}
