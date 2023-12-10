package com.example.proyecto.daos;
import com.example.proyecto.beans.*;

import java.io.InputStream;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;



public class FotosActividadDao extends DaoBase{

    public FotosActividad obtenerFotosActividad(String idFotosActividad) {

        ActividadDao actividadDao = new ActividadDao();
        FotosActividad fotosActividad = new FotosActividad();

        String sql = "select * from fotos_actividad where idFotos_Actividad = ?;";

        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, idFotosActividad);

            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    fotosActividad.setIdFotosActividad(rs.getInt("idFotos_Actividad"));
                    fotosActividad.setDescripcion(rs.getString("descripcion"));
                    fotosActividad.setActividad(actividadDao.obtenerActividad(String.valueOf(rs.getInt("Actividad_idActividad"))));
                    fotosActividad.setFoto(rs.getBinaryStream("foto"));
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return fotosActividad;
    }

    public void subirFotoDeActividadFinalizada(String idActividad, InputStream foto){

        String sql = "insert into fotos_actividad (foto, Actividad_idActividad) values (?,?)";

        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setBlob(1,foto);
            pstmt.setString(2,idActividad);
            pstmt.executeUpdate();

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }




}
