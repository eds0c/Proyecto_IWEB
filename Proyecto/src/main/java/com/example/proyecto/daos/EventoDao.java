package com.example.proyecto.daos;

import com.example.proyecto.beans.*;

import javax.swing.*;
import java.sql.*;
import java.util.ArrayList;

public class EventoDao extends DaoBase{

    public ArrayList<Evento> listarPorActividad(String idActividad, String estado, int limit, int offset){

        ArrayList<Evento> lista = new ArrayList<>();
        ActividadDao aDao = new ActividadDao();


        String sql = "select * from evento e where Actividad_idActividad = ? and e.estado = ? limit ? offset ?;";


        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1,idActividad);
            pstmt.setString(2,estado);
            pstmt.setInt(3,limit);
            pstmt.setInt(4,offset);

            try(ResultSet rs = pstmt.executeQuery()) {

                while (rs.next()) {
                    Actividad a = aDao.obtenerActividad(rs.getString("Actividad_idActividad"));

                    Evento e = new Evento();
                    e.setIdEvento(rs.getInt("e.idEvento"));
                    e.setDescripcion(rs.getString("e.descripcion"));
                    e.setFechaIn(rs.getString("e.fechaIn"));
                    e.setParticipantes(rs.getString("e.participantes"));
                    e.setEstado(rs.getString("e.estado"));
                    e.setFoto(rs.getBytes("e.foto"));
                    e.setFechaFin(rs.getString("e.fechaFin"));
                    e.setLugar(rs.getString("e.lugar"));
                    e.setHora(rs.getString("e.hora"));
                    e.setTitulo(rs.getString("e.titulo"));

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
        ActividadDao aDao = new ActividadDao();


        String sql = "select * from evento e where e.idEvento != ? and e.estado = ? limit ? offset ?";


        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1,idEventoNoMostrado); // evento principal
            pstmt.setString(2,"a");
            pstmt.setInt(3,limit);
            pstmt.setInt(4,offset);


            try(ResultSet rs = pstmt.executeQuery()) {

                while (rs.next()) {
                    Actividad a = aDao.obtenerActividad(rs.getString("Actividad_idActividad"));

                    Evento e = new Evento();
                    e.setIdEvento(rs.getInt("idEvento"));
                    e.setDescripcion(rs.getString("descripcion"));
                    e.setFechaIn(rs.getString("fechaIn"));
                    e.setParticipantes(rs.getString("participantes"));
                    e.setEstado(rs.getString("estado"));
                    e.setFoto(rs.getBytes("foto"));
                    e.setFechaFin(rs.getString("fechaFin"));
                    e.setLugar(rs.getString("lugar"));
                    e.setHora(rs.getString("hora"));
                    e.setTitulo(rs.getString("titulo"));

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
        ActividadDao aDao = new ActividadDao();

        String sql = "select * from evento e where e.idEvento = ? ;";


        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1,idEvento);

            try(ResultSet rs = pstmt.executeQuery()) {

                if (rs.next()) {

                    Actividad a = aDao.obtenerActividad(rs.getString("Actividad_idActividad"));

                    evento.setIdEvento(rs.getInt("idEvento"));
                    evento.setDescripcion(rs.getString("descripcion"));
                    evento.setFechaIn(rs.getString("fechaIn"));
                    evento.setParticipantes(rs.getString("participantes"));
                    evento.setEstado(rs.getString("estado"));
                    evento.setFoto(rs.getBytes("foto"));
                    evento.setFechaFin(rs.getString("fechaFin"));
                    evento.setLugar(rs.getString("lugar"));
                    evento.setHora(rs.getString("hora"));
                    evento.setTitulo(rs.getString("titulo"));
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
        AlumnoDao alumnoDao = new AlumnoDao();
        IntegranteDao iDao = new IntegranteDao();


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
                "WHERE e.idEvento = ? and e.estado = ? and i.idIntegrante != 3 order by a.idAlumno limit ? offset ?;";

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


    public ArrayList<AlumnoEvento> listarAlumnosPendientesPorEvento(String idEvento, String estado, int limit, int offset){


        ArrayList<AlumnoEvento> lista = new ArrayList<>();


        String sql = "select * \n" +
                "from alumno a INNER JOIN alumno_evento ae ON (a.idAlumno = ae.Alumno_idAlumno)\n" +
                "INNER JOIN integrante i ON (ae.Integrante_idIntegrante = i.idIntegrante)\n" +
                "INNER JOIN evento e ON (ae.Evento_idEvento = e.idEvento)\n" +
                "WHERE e.idEvento = ? and e.estado = ? and i.idIntegrante = 3 order by a.idAlumno limit ? offset ?;";

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
