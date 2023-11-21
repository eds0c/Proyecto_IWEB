package com.example.proyecto.beans;

public class Donacion {

    private int idDonacion;
    private String monto;
    private byte[] captura;
    private String estado;
    private String fecha;
    private String motivo;
    private Alumno alumno;
    private TipoDonacion tipoDonacion;
    private DelegadoGeneral delegadoGeneral;

    public int getIdDonacion() {
        return idDonacion;
    }

    public void setIdDonacion(int idDonacion) {
        this.idDonacion = idDonacion;
    }

    public String getMonto() {
        return monto;
    }

    public void setMonto(String monto) {
        this.monto = monto;
    }

    public byte[] getCaptura() {
        return captura;
    }

    public void setCaptura(byte[] captura) {
        this.captura = captura;
    }

    public String getEstado() {
        return estado;
    }

    public void setEstado(String estado) {
        this.estado = estado;
    }

    public String getFecha() {
        return fecha;
    }

    public void setFecha(String fecha) {
        this.fecha = fecha;
    }

    public String getMotivo() {
        return motivo;
    }

    public void setMotivo(String motivo) {
        this.motivo = motivo;
    }

    public Alumno getAlumno() {
        return alumno;
    }

    public void setAlumno(Alumno alumno) {
        this.alumno = alumno;
    }

    public TipoDonacion getTipoDonacion() {
        return tipoDonacion;
    }

    public void setTipoDonacion(TipoDonacion tipoDonacion) {
        this.tipoDonacion = tipoDonacion;
    }

    public DelegadoGeneral getDelegadoGeneral() {
        return delegadoGeneral;
    }

    public void setDelegadoGeneral(DelegadoGeneral delegadoGeneral) {
        this.delegadoGeneral = delegadoGeneral;
    }
}
