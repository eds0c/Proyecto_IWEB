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
                    actividad.setFoto(rs.getBytes("foto"));
                    actividad.setEstado(rs.getString("estado"));
                    actividad.setTitulo(rs.getString("titulo"));

                }
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return actividad;
    }


    public void crearActividad(byte[] actividadFoto, String actividadDescripcion, String estado, String titulo){

        String sql = "insert into actividad (foto, descripcion, estado, titulo) values (?,?,?,?)";

        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setBytes(1,actividadFoto );
            pstmt.setString(2,actividadDescripcion);
            pstmt.setString(3,estado);
            pstmt.setString(4,titulo);

            pstmt.executeUpdate();

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }


}
