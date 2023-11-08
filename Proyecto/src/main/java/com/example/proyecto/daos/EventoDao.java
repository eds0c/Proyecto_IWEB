package com.example.proyecto.daos;

import com.example.proyecto.beans.*;

import javax.swing.*;
import java.sql.*;
import java.util.ArrayList;

public class EventoDao extends DaoBase{

    public ArrayList<Evento> listarPorActividad(String idActividad, String estado, int limit, int offset){

        ArrayList<Evento> lista = new ArrayList<>();


        String sql = "select * from evento e inner join actividad a on e.Actividad_idActividad = a.idActividad where Actividad_idActividad = ? and e.estado = ? limit ? offset ?;";


        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1,idActividad);
            pstmt.setString(2,estado);
            pstmt.setInt(3,limit);
            pstmt.setInt(4,offset);

            try(ResultSet rs = pstmt.executeQuery()) {

                while (rs.next()) {
                    Evento e = new Evento();
                    e.setIdEvento(rs.getInt(1));
                    e.setDescripcion(rs.getString(2));
                    e.setFechaIn(rs.getString(3));
                    e.setParticipantes(rs.getString(4));
                    e.setEstado(rs.getString(5));
                    e.setFoto(rs.getBytes(6));
                    e.setFechaFin(rs.getString(7));
                    e.setLugar(rs.getString(9));
                    e.setHora(rs.getString(10));

                    Actividad a = new Actividad();
                    a.setDescripcion(rs.getString("a.descripcion"));
                    a.setFoto(rs.getBytes("a.foto"));
                    a.setFoto(rs.getBytes("a.estado"));

                    e.setActividad(a);

                    lista.add(e);
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return lista;
    }

    public ArrayList<Evento> listarEventos(String idEventoNoMostrado, int limit, int offset){ //evento de segundo plano

        ArrayList<Evento> lista = new ArrayList<>();


        String sql = "select * from evento e inner join actividad a on e.Actividad_idActividad = a.idActividad where e.idEvento != ? and e.estado = ? limit ? offset ?";


        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1,idEventoNoMostrado); // evento principal
            pstmt.setString(2,"a");
            pstmt.setInt(3,limit);
            pstmt.setInt(4,offset);


            try(ResultSet rs = pstmt.executeQuery()) {

                while (rs.next()) {
                    Evento e = new Evento();
                    e.setIdEvento(rs.getInt(1));
                    e.setDescripcion(rs.getString(2));
                    e.setFechaIn(rs.getString(3));
                    e.setParticipantes(rs.getString(4));
                    e.setEstado(rs.getString(5));
                    e.setFoto(rs.getBytes(6));
                    e.setFechaFin(rs.getString(7));
                    e.setLugar(rs.getString(9));
                    e.setHora(rs.getString(10));

                    Actividad a = new Actividad();
                    a.setDescripcion(rs.getString("a.descripcion"));
                    a.setFoto(rs.getBytes("a.foto"));
                    a.setFoto(rs.getBytes("a.estado"));

                    e.setActividad(a);

                    lista.add(e);
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return lista;
    }

    public Evento buscarEvento(String idEvento){ //devuelve el evento grande

        Evento evento = new Evento();

        String sql = "select * from evento e inner join actividad a on e.Actividad_idActividad = a.idActividad where e.idEvento = ? ;";


        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1,idEvento);

            try(ResultSet rs = pstmt.executeQuery()) {

                if (rs.next()) {

                    evento.setIdEvento(rs.getInt(1));
                    evento.setDescripcion(rs.getString(2));
                    evento.setFechaIn(rs.getString(3));
                    evento.setParticipantes(rs.getString(4));
                    evento.setEstado(rs.getString(5));
                    evento.setFoto(rs.getBytes(6));
                    evento.setFechaFin(rs.getString(7));
                    evento.setLugar(rs.getString(9));
                    evento.setHora(rs.getString(10));

                    Actividad a = new Actividad();
                    a.setDescripcion(rs.getString("a.descripcion"));
                    a.setFoto(rs.getBytes("a.foto"));
                    a.setFoto(rs.getBytes("a.estado"));

                    evento.setActividad(a);

                }
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return evento;
    }



    public ArrayList<AlumnoEvento> listarPorAlumno(String idAlumno, String estado, int limit, int offset){


        ArrayList<AlumnoEvento> lista = new ArrayList<>();


        String sql = "select * \n" +
                "from alumno a INNER JOIN alumno_evento ae ON (a.idAlumno = ae.Alumno_idAlumno)\n" +
                "INNER JOIN integrante i ON (ae.Integrante_idIntegrante = i.idIntegrante)\n" +
                "INNER JOIN evento e ON (ae.Evento_idEvento = e.idEvento)\n" +
                "WHERE a.idAlumno = ? and e.estado = ? limit ? offset ?;";

        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1,idAlumno);
            pstmt.setString(2,estado);
            pstmt.setInt(3,limit);
            pstmt.setInt(4,offset);

            try(ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    AlumnoEvento aE = new AlumnoEvento();

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

                    Integrante i = new Integrante();
                    i.setIdIntegrante(rs.getInt("i.idIntegrante"));
                    i.setDescripcion(rs.getString("i.descripcion"));

                    Evento e = new Evento();
                    e.setIdEvento(rs.getInt("e.idEvento"));
                    e.setDescripcion(rs.getString("e.descripcion"));
                    e.setFechaIn(rs.getString("e.fechaIn"));
                    e.setParticipantes(rs.getString("e.participantes"));
                    e.setEstado(rs.getString("e.estado"));
                    e.setFoto(rs.getBytes("e.foto"));
                    e.setFechaFin(rs.getString("e.fechaFin"));

                    ActividadDao aDao = new ActividadDao();
                    e.setActividad(aDao.obtenerActividad(String.valueOf(rs.getInt("e.Actividad_idActividad"))));
                    e.setLugar(rs.getString("e.lugar"));
                    e.setHora(rs.getString("e.hora"));

                    aE.setAlumno(a);
                    aE.setEvento(e);
                    aE.setIntegrante(i);
                    aE.setIdAlumnoEvento(rs.getInt("aE.idAlumno_Evento"));

                    lista.add(aE);
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return lista;
    }


    public ArrayList<AlumnoEvento> listarAlumnosPorEvento(String idEvento, String estado, int limit, int offset){


        ArrayList<AlumnoEvento> lista = new ArrayList<>();


        String sql = "select * \n" +
                "from alumno a INNER JOIN alumno_evento ae ON (a.idAlumno = ae.Alumno_idAlumno)\n" +
                "INNER JOIN integrante i ON (ae.Integrante_idIntegrante = i.idIntegrante)\n" +
                "INNER JOIN evento e ON (ae.Evento_idEvento = e.idEvento)\n" +
                "WHERE e.idEvento = ? and e.estado = ? order by a.idAlumno limit ? offset ?;";

        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1,idEvento);
            pstmt.setString(2,estado);
            pstmt.setInt(3,limit);
            pstmt.setInt(4,offset);

            try(ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    AlumnoEvento aE = new AlumnoEvento();

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

                    Integrante i = new Integrante();
                    i.setIdIntegrante(rs.getInt("i.idIntegrante"));
                    i.setDescripcion(rs.getString("i.descripcion"));

                    Evento e = new Evento();
                    e.setIdEvento(rs.getInt("e.idEvento"));
                    e.setDescripcion(rs.getString("e.descripcion"));
                    e.setFechaIn(rs.getString("e.fechaIn"));
                    e.setParticipantes(rs.getString("e.participantes"));
                    e.setEstado(rs.getString("e.estado"));
                    e.setFoto(rs.getBytes("e.foto"));
                    e.setFechaFin(rs.getString("e.fechaFin"));

                    ActividadDao aDao = new ActividadDao();
                    e.setActividad(aDao.obtenerActividad(String.valueOf(rs.getInt("e.Actividad_idActividad"))));
                    e.setLugar(rs.getString("e.lugar"));
                    e.setHora(rs.getString("e.hora"));

                    aE.setAlumno(a);
                    aE.setEvento(e);
                    aE.setIntegrante(i);
                    aE.setIdAlumnoEvento(rs.getInt("aE.idAlumno_Evento"));

                    lista.add(aE);
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return lista;
    }




}
