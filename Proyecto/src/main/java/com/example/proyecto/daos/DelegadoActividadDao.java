package com.example.proyecto.daos;

import com.example.proyecto.beans.Actividad;
import com.example.proyecto.beans.DelegadoActividad;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class DelegadoActividadDao extends DaoBase {
    public ArrayList<DelegadoActividad> listarActividades(String idActividadNoMostrada, int limit, int offset){ //actividades de segundo plano

        ArrayList<DelegadoActividad> lista = new ArrayList<>();
        DelegadoGeneralDao delGenDao = new DelegadoGeneralDao();
        ActividadDao aDao = new ActividadDao();


        String sql = "select * from delegado_actividad da where Actividad_idActividad != ? limit = ? offset = ?";


        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1,idActividadNoMostrada); // actividad no mostrada
            pstmt.setInt(2,limit);
            pstmt.setInt(3,offset);


            try(ResultSet rs = pstmt.executeQuery()) {

                while (rs.next()) {


                    DelegadoActividad delegadoActividad = new DelegadoActividad();
                    delegadoActividad.setActividad(aDao.obtenerActividad(rs.getString("Actividad_idActividad")));
                    delegadoActividad.setDelegadoGeneral(delGenDao.obtenerDelegadoGeneral(rs.getString("da.Delegado_General_idDelegado_General")));
                    delegadoActividad.setIdDelegadoActividad(rs.getInt("idDelegado_Actividad"));
                    delegadoActividad.setDescripcion(rs.getString("descripcion"));
                    delegadoActividad.setFechaAprobacion(rs.getString("fecha_aprob"));

                    lista.add(delegadoActividad);
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return lista;
    }

}
