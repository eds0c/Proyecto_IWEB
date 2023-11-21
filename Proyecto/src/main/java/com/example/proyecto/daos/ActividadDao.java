package com.example.proyecto.daos;

import com.example.proyecto.beans.Actividad;
import com.example.proyecto.beans.DelegadoActividad;
import com.example.proyecto.beans.Evento;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class ActividadDao extends DaoBase {


    public Actividad obtenerActividad(String idActividad) {

        Actividad actividad = new Actividad();


        String sql = "select * from actividad where idActividad = ?;";

        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, idActividad);

            try (ResultSet rs = pstmt.executeQuery()) {

                if (rs.next()) {
                    actividad.setIdActividad(Integer.parseInt(idActividad));
                    actividad.setDescripcion(rs.getString("descripcion"));
                    actividad.setFoto(rs.getBinaryStream("foto"));
                    actividad.setEstado(rs.getString("estado"));
                    actividad.setTitulo(rs.getString("titulo"));

                }
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return actividad;
    }


    public void crearActividad(Actividad actividad){

        String sql = "insert into actividad (foto, descripcion, estado, titulo) values (?,?,?,?)";

        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setBlob(1,actividad.getFoto());
            pstmt.setString(2,actividad.getDescripcion());
            pstmt.setString(3,actividad.getEstado());
            pstmt.setString(4,actividad.getTitulo());


            pstmt.executeUpdate();

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }


    public int obtenerUltimoId(){

        int ultimoId = 0;

        String sql = "select max(idActividad) from actividad";

        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    ultimoId = rs.getInt(1);
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        return ultimoId;
    }

    public void eliminar(String idActividad){


        String sql = "delete from actividad where idActividad = ?";

        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1,Integer.parseInt(idActividad));
            pstmt.executeUpdate();

        }
        catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }


}
