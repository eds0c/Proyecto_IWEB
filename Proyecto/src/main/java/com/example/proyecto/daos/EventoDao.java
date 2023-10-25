package com.example.proyecto.daos;

import com.example.proyecto.beans.AlumnoEvento;
import com.example.proyecto.beans.Evento;

import java.sql.*;
import java.util.ArrayList;

public class EventoDao {

    public ArrayList<Evento> listarPorActividad(String idActividad){

        ArrayList<Evento> lista = new ArrayList<>();

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            throw new RuntimeException(e);
        }

        String url = "jdbc:mysql://localhost:3306/basedatos";
        String username = "root";
        String password = "root";

        String sql = "select * from evento where Actividad_idActividad = ?";


        try (Connection conn = DriverManager.getConnection(url, username, password);
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
                    e.setIdActividad(rs.getInt(8));
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

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            throw new RuntimeException(e);
        }

        String url = "jdbc:mysql://localhost:3306/basedatos";
        String username = "root";
        String password = "root";

        String sql = "select a.idAlumno, e.descripcion, i.descripcion, e.fechaIn \n" +
                "from alumno a INNER JOIN alumno_evento ae ON (a.idAlumno = ae.Alumno_idAlumno)\n" +
                "INNER JOIN integrante i ON (ae.Integrante_idIntegrante = i.idIntegrante)\n" +
                "INNER JOIN evento e ON (ae.Evento_idEvento = e.idEvento)\n" +
                "WHERE a.idAlumno = ?;";

        try (Connection conn = DriverManager.getConnection(url, username, password);
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
