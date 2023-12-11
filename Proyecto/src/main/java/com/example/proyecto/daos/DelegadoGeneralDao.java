package com.example.proyecto.daos;

import com.example.proyecto.beans.Actividad;
import com.example.proyecto.beans.DelegadoGeneral;
import jakarta.servlet.http.HttpServletResponse;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.InputStream;
import java.io.OutputStream;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class DelegadoGeneralDao extends DaoBase {

    public DelegadoGeneral obtenerDelegadoGeneral(String idDelegadoGeneral) {

        DelegadoGeneral delegadoGeneral = new DelegadoGeneral();


        String sql = "select * from delegado_general where idDelegado_General = ?;";

        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, idDelegadoGeneral);

            try (ResultSet rs = pstmt.executeQuery()) {

                if (rs.next()) {
                    delegadoGeneral.setIdDelegadoGeneral(rs.getInt("idDelegado_General"));
                    delegadoGeneral.setFoto(rs.getBytes("foto"));
                    delegadoGeneral.setNombre(rs.getString("nombre"));
                    delegadoGeneral.setApellido(rs.getString("apellido"));
                    delegadoGeneral.setCodigo(rs.getString("codigo"));
                    delegadoGeneral.setCorreo(rs.getString("correo"));
                    delegadoGeneral.setContrasena(rs.getString("contrasena"));
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return delegadoGeneral;
    }

    public void actualizarFotoDePerfil(InputStream fotoPerfil, String idDelegadoGeneral){

        String sql = "update delegado_general set foto = ? where idDelegado_General = ?;";

        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setBlob(1,fotoPerfil);
            pstmt.setInt(2, Integer.parseInt(idDelegadoGeneral));

            pstmt.executeUpdate();

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public void fotoPerfil(int idDelegado_General, HttpServletResponse response){
        String sql = "Select * from delegado_general where idDelegado_General=?";
        InputStream inputStream = null;
        OutputStream outputStream = null;
        BufferedInputStream bufferedInputStream = null;
        BufferedOutputStream bufferedOutputStream = null;
        response.setContentType("image/*");
        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            outputStream = response.getOutputStream();
            pstmt.setInt(1,idDelegado_General);
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

        }
    }

}
