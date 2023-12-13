package com.example.proyecto.Dtos;

import com.example.proyecto.beans.Donacion;

public class DonacionesPorFecha {

    private String fecha;
    private int sumaDonaciones;

    public String getFecha() {
        return fecha;
    }

    public void setFecha(String fecha) {
        this.fecha = fecha;
    }

    public int getSumaDonaciones() {
        return sumaDonaciones;
    }

    public void setSumaDonaciones(int sumaDonaciones) {
        this.sumaDonaciones = sumaDonaciones;
    }
}
