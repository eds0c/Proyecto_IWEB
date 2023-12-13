package com.example.proyecto.daos;
import com.example.proyecto.beans.*;
import jakarta.servlet.http.HttpServletResponse;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.InputStream;
import java.io.OutputStream;
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

    public void fotoActividadFinalizada(int idFotosActividad, HttpServletResponse response){
        String sql = "Select foto from fotos_actividad where idFotos_Actividad=?";
        InputStream inputStream = null;
        OutputStream outputStream = null;
        BufferedInputStream bufferedInputStream = null;
        BufferedOutputStream bufferedOutputStream = null;
        response.setContentType("image/*");
        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            outputStream = response.getOutputStream();
            pstmt.setInt(1,idFotosActividad);
            try(ResultSet rs = pstmt.executeQuery()) {

                if (rs.next()) {
                    inputStream = rs.getBinaryStream("foto");
                }
                bufferedInputStream = new BufferedInputStream(inputStream);
                bufferedOutputStream = new BufferedOutputStream(outputStream);
                int i = 0;
                while ((i=bufferedInputStream.read())!=-1){
                    bufferedOutputStream.write(i);
                }
            }

        }catch (Exception e){
            throw new RuntimeException(e);
        }
    }


    public ArrayList<FotosActividad> listaFotosDeActividadFinalizada(String idActividad) {

        ActividadDao actividadDao = new ActividadDao();
        ArrayList<FotosActividad> lista = new ArrayList<>();

        String sql = "select * from fotos_actividad where Actividad_idActividad = ?;";

        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, idActividad);

            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    FotosActividad fotosActividad = new FotosActividad();
                    fotosActividad.setIdFotosActividad(rs.getInt("idFotos_Actividad"));
                    fotosActividad.setDescripcion(rs.getString("descripcion"));
                    fotosActividad.setActividad(actividadDao.obtenerActividad(String.valueOf(rs.getInt("Actividad_idActividad"))));
                    fotosActividad.setFoto(rs.getBinaryStream("foto"));
                    lista.add(fotosActividad);
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return lista;
    }



}
