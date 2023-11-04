package com.example.proyecto.daos;

import com.example.proyecto.beans.Evento;

import java.sql.*;

public class DelecActiDao extends DaoBase{

    public void crear(String eventoFoto, String eventoDescripcion, String eventoFecha, String eventoHora, String eventoLugar){

        String sql = "insert into evento (foto, descripcion, fechaIn, hora, lugar) values (?,?,?,?,?)";

        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1,eventoFoto);
            pstmt.setString(2,eventoDescripcion);
            pstmt.setString(3,eventoFecha);
            pstmt.setString(4,eventoHora);
            pstmt.setString(5,eventoLugar);

            pstmt.executeUpdate();

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
    public Evento buscarPorDescripcion(String eventoDescripcion){
        Evento evento = null;

        String sql = "select * from evento where descripcion = ?";


        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1,eventoDescripcion);

            try(ResultSet rs = pstmt.executeQuery()){
                while (rs.next()) {
                    evento = new Evento();
                    evento.setFoto(rs.getString(6));
                    evento.setDescripcion(rs.getString(2));
                    evento.setFechaIn(rs.getString(3));
                    evento.setHora(rs.getString(10));
                    evento.setLugar(rs.getString(9));
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        return evento;
    }
}
