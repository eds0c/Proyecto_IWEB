package com.example.proyecto.daos;

import com.example.proyecto.beans.Evento;

import java.sql.*;
import java.text.ParseException;
import java.text.SimpleDateFormat;

public class DelecActiDao extends DaoBase{

    public void crear(byte[] eventoFoto, String eventoDescripcion, String eventoFecha, String eventoHora, String eventoLugar, int IdActividad){

        String sql = "insert into evento (foto, descripcion, fechaIn, hora, lugar, Actividad_idActividad) values (?,?,?,?,?,?)";

        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setBytes(1,eventoFoto );
            pstmt.setString(2,eventoDescripcion);
            pstmt.setString(3,eventoFecha);
            pstmt.setString(4,eventoHora);
            pstmt.setString(5,eventoLugar);
            pstmt.setInt(6,IdActividad);

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
                    evento.setFoto(rs.getBytes(6));
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
    public Date parsearDate( String eventoFecha){
        SimpleDateFormat formatter = new SimpleDateFormat("yyyy/MM/dd");

        try {
            Date date = (Date) formatter.parse(eventoFecha);
            return date;
        } catch (ParseException e) {
            e.printStackTrace();
        }
        return null;
    }
    public Time parsearTime( String eventoTime){
        SimpleDateFormat formatter = new SimpleDateFormat("hh:mm");

        try {
            Time time = (Time) formatter.parse(eventoTime);
            return time;
        } catch (ParseException e) {
            e.printStackTrace();
        }
        return null;
    }

    public void actualizar(Evento evento){

        String sql = "update evento set foto = ?,  descripcion = ?, fechaIn = ?, hora = ?, lugar = ?, Actividad_idActividad = ? where idEvento = ?;";

        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setBytes(1,evento.getFoto());
            pstmt.setString(2, evento.getDescripcion());
            pstmt.setString(3, evento.getFechaIn());
            pstmt.setString(4, evento.getHora());
            pstmt.setString(5,evento.getLugar());
            pstmt.setInt(6,evento.getActividad().getIdActividad());
            pstmt.setInt(7,evento.getIdEvento());

            pstmt.executeUpdate();

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public void borrar(int idEventoo) throws SQLException {



        String sql = "delete from evento where idEvento = ?";

        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1,idEventoo);
            pstmt.executeUpdate();

        }
    }
}
