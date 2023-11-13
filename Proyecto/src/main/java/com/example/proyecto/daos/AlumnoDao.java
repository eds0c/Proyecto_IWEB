package com.example.proyecto.daos;

import com.example.proyecto.beans.Actividad;
import com.example.proyecto.beans.Alumno;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class AlumnoDao extends DaoBase{

    public Alumno obtenerAlumno(String idAlumno){

        Alumno a = new Alumno();
        EstadoAlumnoDao estadoAlumnoDao = new EstadoAlumnoDao();
        DelegadoGeneralDao delegadoGeneralDao = new DelegadoGeneralDao();
        DelegadoActividadDao delegadoActividadDao = new DelegadoActividadDao();



        String sql = "select * from alumno a where a.idAlumno = ?;";

        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1,idAlumno);

            try(ResultSet rs = pstmt.executeQuery()) {

                if (rs.next()) {
                    a.setIdAlumno(rs.getInt("a.idAlumno"));
                    a.setNombre(rs.getString("a.nombre"));
                    a.setApellido(rs.getString("a.apellido"));
                    a.setCodigo(rs.getString("a.codigo"));
                    a.setCorreo(rs.getString("a.correo"));
                    a.setContrasena(rs.getString("a.contrasena"));
                    a.setEgresado(rs.getString("a.egresado"));
                    a.setFoto(rs.getBytes("a.foto"));
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

    public Alumno obtenerDelegadoDeActividad(String idDelegadoDeActividad){

        Alumno a = new Alumno();
        EstadoAlumnoDao estadoAlumnoDao = new EstadoAlumnoDao();
        DelegadoGeneralDao delegadoGeneralDao = new DelegadoGeneralDao();
        DelegadoActividadDao delegadoActividadDao = new DelegadoActividadDao();



        String sql = "select * from alumno a where a.Delegado_Actividad_idDelegado_Actividad = ?;";

        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1,idDelegadoDeActividad);

            try(ResultSet rs = pstmt.executeQuery()) {

                if (rs.next()) {
                    a.setIdAlumno(rs.getInt("a.idAlumno"));
                    a.setNombre(rs.getString("a.nombre"));
                    a.setApellido(rs.getString("a.apellido"));
                    a.setCodigo(rs.getString("a.codigo"));
                    a.setCorreo(rs.getString("a.correo"));
                    a.setContrasena(rs.getString("a.contrasena"));
                    a.setEgresado(rs.getString("a.egresado"));
                    a.setFoto(rs.getBytes("a.foto"));
                    a.setMotivo(rs.getString("a.motivo"));
                    a.setFechaAprobacion(rs.getString("a.fecha_aprob"));
                    a.setDelegadoGeneral(delegadoGeneralDao.obtenerDelegadoGeneral(rs.getString("a.Delegado_General_idDelegado_General")));
                    a.setEstadoAlumno(estadoAlumnoDao.obtenerEstadoAlumno(rs.getString("a.Estado_Alumno_idEstado_Alumno")));
                    a.setDelegadoActividad(delegadoActividadDao.obtenerDelegadoActividad(rs.getString("a.Delegado_Actividad_idDelegado_Actividad")));

                }
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return a;
    }

    public ArrayList<Alumno> listarDelegadosDeActividad(){

        ArrayList<Alumno> lista = new ArrayList<>();
        EstadoAlumnoDao estadoAlumnoDao = new EstadoAlumnoDao();
        DelegadoGeneralDao delegadoGeneralDao = new DelegadoGeneralDao();
        DelegadoActividadDao delegadoActividadDao = new DelegadoActividadDao();



        String sql = "select * from alumno a where a.Delegado_Actividad_idDelegado_Actividad is not null order by a.Delegado_Actividad_idDelegado_Actividad;";

        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {


            try(ResultSet rs = pstmt.executeQuery()) {

                while (rs.next()) {
                    Alumno a = new Alumno();
                    a.setIdAlumno(rs.getInt("a.idAlumno"));
                    a.setNombre(rs.getString("a.nombre"));
                    a.setApellido(rs.getString("a.apellido"));
                    a.setCodigo(rs.getString("a.codigo"));
                    a.setCorreo(rs.getString("a.correo"));
                    a.setContrasena(rs.getString("a.contrasena"));
                    a.setEgresado(rs.getString("a.egresado"));
                    a.setFoto(rs.getBytes("a.foto"));
                    a.setMotivo(rs.getString("a.motivo"));
                    a.setFechaAprobacion(rs.getString("a.fecha_aprob"));
                    a.setDelegadoGeneral(delegadoGeneralDao.obtenerDelegadoGeneral(rs.getString("a.Delegado_General_idDelegado_General")));
                    a.setEstadoAlumno(estadoAlumnoDao.obtenerEstadoAlumno(rs.getString("a.Estado_Alumno_idEstado_Alumno")));
                    a.setDelegadoActividad(delegadoActividadDao.obtenerDelegadoActividad(rs.getString("a.Delegado_Actividad_idDelegado_Actividad")));

                    lista.add(a);

                }
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return lista;
    }



}
