package com.example.proyecto.daos;

import com.example.proyecto.beans.Actividad;
import com.example.proyecto.beans.DelegadoActividad;
import com.example.proyecto.beans.Evento;
import jakarta.servlet.http.HttpServletResponse;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.InputStream;
import java.io.OutputStream;
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

    public void actualizar(Actividad actividad){

        String sql = "update actividad set descripcion = ?,  foto = ?, estado = ?, titulo = ? where idActividad = ?;";

        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1,actividad.getDescripcion());
            pstmt.setBlob(2,actividad.getFoto());
            if(actividad.getEstado()!=null){
                pstmt.setString(3,actividad.getEstado());
            }
            else{
                pstmt.setString(3,obtenerActividad(String.valueOf(actividad.getIdActividad())).getEstado());
            }
            pstmt.setString(4,actividad.getTitulo());
            pstmt.setInt(5,actividad.getIdActividad());


            pstmt.executeUpdate();

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public void finalizarActividad(String idActividad){


        String sql = "update actividad set estado = ? where idActividad = ?";

        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1,"finalizada");
            pstmt.setInt(2,Integer.parseInt(idActividad));
            pstmt.executeUpdate();

        }
        catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public void fotoActividad(int idActividad, HttpServletResponse response){
        String sql = "Select foto from actividad where idActividad=?";
        InputStream inputStream = null;
        OutputStream outputStream = null;
        BufferedInputStream bufferedInputStream = null;
        BufferedOutputStream bufferedOutputStream = null;
        response.setContentType("image/*");
        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            outputStream = response.getOutputStream();
            pstmt.setInt(1,idActividad);
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

    public ArrayList<Actividad> listarActividadesSegunEstado(String estado) {


        ArrayList<Actividad> lista = new ArrayList<>();

        String sql = "select * from actividad where estado = ?;";

        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, estado);

            try (ResultSet rs = pstmt.executeQuery()) {

                while (rs.next()) {
                    Actividad actividad = new Actividad();
                    actividad.setIdActividad(rs.getInt("idActividad"));
                    actividad.setDescripcion(rs.getString("descripcion"));
                    actividad.setFoto(rs.getBinaryStream("foto"));
                    actividad.setEstado(rs.getString("estado"));
                    actividad.setTitulo(rs.getString("titulo"));
                    lista.add(actividad);

                }
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return lista;
    }


}
