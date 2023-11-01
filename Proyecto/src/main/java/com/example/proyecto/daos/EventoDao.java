package com.example.proyecto.daos;

import com.example.proyecto.beans.Actividad;
import com.example.proyecto.beans.AlumnoEvento;
import com.example.proyecto.beans.Evento;

import java.sql.*;
import java.util.ArrayList;

public class EventoDao extends DaoBase{

    public ArrayList<Evento> listarPorActividad(String idActividad){

        ArrayList<Evento> lista = new ArrayList<>();


        String sql = "select * from evento e inner join actividad a on e.Actividad_idActividad = a.idActividad where Actividad_idActividad = ?;";


        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1,idActividad);

            try(ResultSet rs = pstmt.executeQuery()) {

                while (rs.next()) {
                    Evento e = new Evento();
                    e.setIdEvento(rs.getInt(1));
                    e.setDescripcion(rs.getString(2));
                    e.setFechaIn(rs.getString(3));
                    e.setParticipantes(rs.getString(4));
                    e.setEstado(rs.getString(5));
                    e.setFoto(rs.getString(6));
                    e.setFechaFin(rs.getString(7));
                    e.setLugar(rs.getString(9));
                    e.setHora(rs.getString(10));

                    Actividad a = new Actividad();
                    a.setDescripcion(rs.getString("a.descripcion"));
                    a.setFoto(rs.getString("a.foto"));
                    a.setFoto(rs.getString("a.estado"));

                    e.setActividad(a);

                    lista.add(e);
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return lista;
    }


    public ArrayList<AlumnoEvento> listarPorAlumno(String idAlumno){


        ArrayList<AlumnoEvento> lista = new ArrayList<>();


        String sql = "select a.idAlumno, e.descripcion, i.descripcion, e.fechaIn \n" +
                "from alumno a INNER JOIN alumno_evento ae ON (a.idAlumno = ae.Alumno_idAlumno)\n" +
                "INNER JOIN integrante i ON (ae.Integrante_idIntegrante = i.idIntegrante)\n" +
                "INNER JOIN evento e ON (ae.Evento_idEvento = e.idEvento)\n" +
                "WHERE a.idAlumno = ?;";

        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1,idAlumno);

            try(ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    AlumnoEvento aE = new AlumnoEvento();
                    aE.setIdAlumno(rs.getInt(1));
                    aE.setDescripcionIntegrante(rs.getString(2));
                    aE.setDescripcionEvento(rs.getString(3));
                    aE.setFechaEvento(rs.getString(4));
                    lista.add(aE);
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }



        return lista;
    }


}
