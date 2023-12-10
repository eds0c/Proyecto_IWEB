package com.example.proyecto.daos;

import com.example.proyecto.beans.Actividad;
import com.example.proyecto.beans.DelegadoActividad;
import com.example.proyecto.beans.DelegadoGeneral;
import com.example.proyecto.beans.Evento;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class DelegadoActividadDao extends DaoBase {
    public ArrayList<DelegadoActividad> listarActividades(int limit, int offset){

        ArrayList<DelegadoActividad> lista = new ArrayList<>();
        DelegadoGeneralDao delGenDao = new DelegadoGeneralDao();
        ActividadDao aDao = new ActividadDao();


        String sql = "select * from delegado_actividad da limit ? offset ?";


        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1,limit);
            pstmt.setInt(2,offset);


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

    public DelegadoActividad obtenerDelegadoActividad(String idDelegadoActividad){ //devuelve el Delegado Actividad

        DelegadoActividad delegadoActividad = new DelegadoActividad();
        ActividadDao aDao = new ActividadDao();
        DelegadoGeneralDao delGenDao = new DelegadoGeneralDao();

        String sql = "select * from delegado_actividad where idDelegado_Actividad = ? ;";


        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1,idDelegadoActividad);

            try(ResultSet rs = pstmt.executeQuery()) {

                if (rs.next()) {

                    Actividad a = aDao.obtenerActividad(rs.getString("Actividad_idActividad"));
                    DelegadoGeneral dG = delGenDao.obtenerDelegadoGeneral(rs.getString("Delegado_General_idDelegado_General"));

                    delegadoActividad.setActividad(a);
                    delegadoActividad.setDelegadoGeneral(dG);
                    delegadoActividad.setIdDelegadoActividad(rs.getInt("idDelegado_Actividad"));
                    delegadoActividad.setDescripcion(rs.getString("descripcion"));
                    delegadoActividad.setFechaAprobacion(rs.getString("fecha_aprob"));

                }

            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return delegadoActividad;
    }

    public void crearDelegadoActividad(String idActividad){

        String sql = "insert into delegado_actividad (Actividad_idActividad) values (?)";

        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1,Integer.parseInt(idActividad));
            pstmt.executeUpdate();

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public int obtenerUltimoId(){

        int ultimoId = 0;

        String sql = "select max(idDelegado_Actividad) from delegado_actividad";

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

    public void eliminar(String idDelegadoActividad) {

        String sql = "delete from delegado_actividad where idDelegado_Actividad = ?";

        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1,Integer.parseInt(idDelegadoActividad));
            pstmt.executeUpdate();
        }
        catch (SQLException e) {
            throw new RuntimeException(e);
        }


    }




}
