package com.example.proyecto.daos;

import com.example.proyecto.beans.Alumno;
import com.example.proyecto.beans.DelegadoGeneral;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class CredentialsDao extends DaoBase{
    public int validarUsuarioPassword(String correo, String password){

        int tipoUsuario = 0;//1: alumno | 2: delegado de actividad | 3: delegado general | 0:no encontrado


//        String sql = "SELECT * FROM alumno where correo= ? and contrasena= SHA2(?,256) and Delegado_Actividad_idDelegado_Actividad is null and Estado_Alumno_idEstado_Alumno = 1";
        String sql = "SELECT * FROM alumno where correo= ? and contrasena= ? and Delegado_Actividad_idDelegado_Actividad is null and Estado_Alumno_idEstado_Alumno = 1";
        try(Connection connection = getConnection();
            PreparedStatement pstmt = connection.prepareStatement(sql)){
                pstmt.setString(1,correo);
                pstmt.setString(2,password);
                try(ResultSet rs = pstmt.executeQuery()){
                    if (rs.next()){ //sí encuentra el usuario con la contraseña y no es delegado de actividad hacer lo siguiente
                        tipoUsuario = 1; //es un alumno
                    }
                }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

//        String sql2 = "SELECT * FROM alumno where correo= ? and contrasena= SHA2(?,256) and Delegado_Actividad_idDelegado_Actividad is not null and Estado_Alumno_idEstado_Alumno = 1";
        String sql2 = "SELECT * FROM alumno where correo= ? and contrasena= ? and Delegado_Actividad_idDelegado_Actividad is not null and Estado_Alumno_idEstado_Alumno = 1";
        try(Connection connection = getConnection();
            PreparedStatement pstmt = connection.prepareStatement(sql2)){
            pstmt.setString(1,correo);
            pstmt.setString(2,password);
            try(ResultSet rs = pstmt.executeQuery()){
                if (rs.next()){ //sí encuentra el usuario con la contraseña hacer lo siguiente
                    tipoUsuario = 2; //es un delegado de actividad
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);

        }

//        String sql3 = "SELECT * FROM delegado_general where correo= ? and contrasena= SHA2(?,256)";
        String sql3 = "SELECT * FROM delegado_general where correo= ? and contrasena= ?";
        try(Connection connection = getConnection();
            PreparedStatement pstmt = connection.prepareStatement(sql3)){
            pstmt.setString(1,correo);
            pstmt.setString(2,password);
            try(ResultSet rs = pstmt.executeQuery()){
                if (rs.next()){ //sí encuentra el usuario con la contraseña hacer lo siguiente
                    tipoUsuario = 3; // es un delegado general
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);

        }


        return tipoUsuario;
    }
    public Alumno obtenerAlumno(String correo){
        Alumno a = new Alumno();
        EstadoAlumnoDao estadoAlumnoDao = new EstadoAlumnoDao();
        DelegadoGeneralDao delegadoGeneralDao = new DelegadoGeneralDao();
        DelegadoActividadDao delegadoActividadDao = new DelegadoActividadDao();

        String sql = "select * from alumno a where a.correo = ?;";

        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1,correo);

            try(ResultSet rs = pstmt.executeQuery()) {

                if (rs.next()) {
                    a.setIdAlumno(rs.getInt("a.idAlumno"));
                    a.setNombre(rs.getString("a.nombre"));
                    a.setApellido(rs.getString("a.apellido"));
                    a.setCodigo(rs.getString("a.codigo"));
                    a.setCorreo(rs.getString("a.correo"));
                    a.setContrasena(rs.getString("a.contrasena"));
                    a.setEgresado(rs.getString("a.egresado"));
                    a.setFoto(rs.getBinaryStream("a.foto"));
                    a.setMotivo(rs.getString("a.motivo"));
                    a.setFechaAprobacion(rs.getString("a.fecha_aprob"));
                    a.setDelegadoGeneral(delegadoGeneralDao.obtenerDelegadoGeneral(rs.getString("a.Delegado_General_idDelegado_General")));
                    a.setEstadoAlumno(estadoAlumnoDao.obtenerEstadoAlumno(rs.getString("Estado_Alumno_idEstado_Alumno")));
                    a.setDelegadoActividad(delegadoActividadDao.obtenerDelegadoActividad(rs.getString("Delegado_Actividad_idDelegado_Actividad")));
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return a;

    }

    public DelegadoGeneral obtenerDelegadoGeneral(String correo) {

        DelegadoGeneral delegadoGeneral = new DelegadoGeneral();


        String sql = "select * from delegado_general where correo = ?;";

        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, correo);

            try (ResultSet rs = pstmt.executeQuery()) {

                if (rs.next()) {
                    delegadoGeneral.setIdDelegadoGeneral(rs.getInt("idDelegado_General"));
                    delegadoGeneral.setFoto(rs.getBytes("foto"));
                    delegadoGeneral.setNombre(rs.getString("nombre"));
                    delegadoGeneral.setApellido(rs.getString("apellido"));
                    delegadoGeneral.setCodigo(rs.getString("codigo"));
                    delegadoGeneral.setCorreo(rs.getString("correo"));
                    delegadoGeneral.setContrasena(rs.getString("contrasena"));
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return delegadoGeneral;
    }

}
