package com.example.proyecto.beans;

import java.io.InputStream;

public class Alumno {

    private int idAlumno;
    private String nombre;
    private String apellido;
    private String codigo;
    private String correo;
    private String contrasena;
    private String egresado;
    private InputStream foto;
    private String motivo;
    private String fechaAprobacion;
    private DelegadoActividad delegadoActividad;
    private EstadoAlumno estadoAlumno;
    private DelegadoGeneral delegadoGeneral;


    public int getIdAlumno() {
        return idAlumno;
    }

    public void setIdAlumno(int idAlumno) {
        this.idAlumno = idAlumno;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getApellido() {
        return apellido;
    }

    public void setApellido(String apellido) {
        this.apellido = apellido;
    }

    public String getCodigo() {
        return codigo;
    }

    public void setCodigo(String codigo) {
        this.codigo = codigo;
    }

    public String getCorreo() {
        return correo;
    }

    public void setCorreo(String correo) {
        this.correo = correo;
    }

    public String getContrasena() {
        return contrasena;
    }

    public void setContrasena(String contrasena) {
        this.contrasena = contrasena;
    }

    public String getEgresado() {
        return egresado;
    }

    public void setEgresado(String egresado) {
        this.egresado = egresado;
    }

    public InputStream getFoto() {
        return foto;
    }

    public void setFoto(InputStream foto) {
        this.foto = foto;
    }

    public String getMotivo() {
        return motivo;
    }

    public void setMotivo(String motivo) {
        this.motivo = motivo;
    }

    public String getFechaAprobacion() {
        return fechaAprobacion;
    }

    public void setFechaAprobacion(String fechaAprobacion) {
        this.fechaAprobacion = fechaAprobacion;
    }

    public DelegadoActividad getDelegadoActividad() {
        return delegadoActividad;
    }

    public void setDelegadoActividad(DelegadoActividad delegadoActividad) {
        this.delegadoActividad = delegadoActividad;
    }

    public EstadoAlumno getEstadoAlumno() {
        return estadoAlumno;
    }

    public void setEstadoAlumno(EstadoAlumno estadoAlumno) {
        this.estadoAlumno = estadoAlumno;
    }

    public DelegadoGeneral getDelegadoGeneral() {
        return delegadoGeneral;
    }

    public void setDelegadoGeneral(DelegadoGeneral delegadoGeneral) {
        this.delegadoGeneral = delegadoGeneral;
    }
}
