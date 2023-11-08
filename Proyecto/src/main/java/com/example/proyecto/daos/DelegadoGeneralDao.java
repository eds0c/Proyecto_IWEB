package com.example.proyecto.daos;

import com.example.proyecto.beans.Actividad;
import com.example.proyecto.beans.DelegadoGeneral;

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

}
