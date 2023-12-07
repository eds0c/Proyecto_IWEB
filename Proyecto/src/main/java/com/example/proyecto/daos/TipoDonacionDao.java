package com.example.proyecto.daos;

import com.example.proyecto.beans.EstadoAlumno;
import com.example.proyecto.beans.TipoDonacion;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class TipoDonacionDao extends DaoBase{
    public TipoDonacion obtenerTipoDonacion(String idTipoDonacion){

        TipoDonacion tipoDonacion = new TipoDonacion();


        String sql = "select * from tipo_donacion  where idTipo_Donacion = ?;";

        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1,idTipoDonacion);

            try(ResultSet rs = pstmt.executeQuery()) {

                if (rs.next()) {
                    tipoDonacion.setIdTipoDonacion(Integer.parseInt(rs.getString(("idTipo_Donacion"))));
                    tipoDonacion.setDescripcion(rs.getString("descripcion"));
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return tipoDonacion;
    }
}
