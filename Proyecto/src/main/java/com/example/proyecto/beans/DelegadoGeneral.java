package com.example.proyecto.beans;

public class DelegadoGeneral {

    private int idDelegadoGeneral;
    private String nombre;
    private String apellido;
    private String codigo;
    private String correo;
    private String contrasena;
    private byte[] foto;

    public int getIdDelegadoGeneral() {
        return idDelegadoGeneral;
    }

    public void setIdDelegadoGeneral(int idDelegadoGeneral) {
        this.idDelegadoGeneral = idDelegadoGeneral;
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

    public byte[] getFoto() {
        return foto;
    }

    public void setFoto(byte[] foto) {
        this.foto = foto;
    }
}
