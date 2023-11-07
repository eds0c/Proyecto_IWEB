package com.example.proyecto.daos;

import com.example.proyecto.beans.Actividad;
import com.example.proyecto.beans.AlumnoEvento;
import com.example.proyecto.beans.Integrante;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class IntegranteDao extends DaoBase {


    public void cambiarRol(AlumnoEvento aE){

        String sql = "update alumno_evento set Integrante_idIntegrante = ? where idAlumno_Evento = ?;";

        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            if(aE.getIntegrante().getIdIntegrante() == 1){
                pstmt.setInt(1,2);
            }
            else{
                pstmt.setInt(1,1);
            }
            pstmt.setInt(2,aE.getIdAlumnoEvento());


        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public Integrante otenerIntegrante(String idIntegrante){

        Integrante i = new Integrante();
        String sql = "select * from integrante where idIntegrante = ?;";

        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1,idIntegrante);

            try(ResultSet rs = pstmt.executeQuery()) {

                if (rs.next()) {
                    i.setIdIntegrante(Integer.parseInt(idIntegrante));
                    i.setDescripcion(rs.getString("descripcion"));
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        return i;
    }

}
