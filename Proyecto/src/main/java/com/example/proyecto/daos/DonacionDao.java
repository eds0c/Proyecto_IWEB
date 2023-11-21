package com.example.proyecto.daos;

import com.example.proyecto.beans.*;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class DonacionDao extends DaoBase{

    public Donacion buscarDonacionxUsuario(String idDonacion){ //devuelve el evento grande

        Donacion d = new Donacion();
        AlumnoDao aDao = new AlumnoDao();

        String sql = "select * from donacion d where d.idDonacion = ? ;";


        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1,idDonacion);

            try(ResultSet rs = pstmt.executeQuery()) {

                if (rs.next()) {

                    Alumno a = aDao.obtenerAlumno(rs.getString("Alumno_idAlumno"));

                    d.setIdDonacion(rs.getInt("d.idDonacion"));
                    d.setMonto(rs.getString("d.monto"));
                    d.setCaptura(rs.getBytes("d.captura"));
                    d.setEstado(rs.getString("d.estado"));
                    d.setFecha(rs.getString("d.fecha"));
                    d.setMotivo(rs.getString("d.motivo"));
                    d.setAlumno(a);

                }
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return d;
    }



    public ArrayList<Donacion> listarDonacionPorUsuario(String idDonacion, String estado, int limit, int offset){


        ArrayList<Donacion> lista = new ArrayList<>();

        String sql = "select * \n" +
                "from donacion d INNER JOIN alumno a ON (d.Alumno_idAlumno = a.idAlumno)\n" +
                "WHERE a.idAlumno = ?  order by a.idAlumno limit ? offset ?;";

        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1,idDonacion);
            pstmt.setString(2,estado);
            pstmt.setInt(3,limit);
            pstmt.setInt(4,offset);

            try(ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    Donacion d = new Donacion();

                    Alumno a = new Alumno();
                    a.setIdAlumno(rs.getInt("a.idAlumno"));
                    a.setNombre(rs.getString("a.nombre"));
                    a.setApellido(rs.getString("a.apellido"));
                    a.setCodigo(rs.getString("a.codigo"));
                    a.setCorreo(rs.getString("a.correo"));
                    a.setContrasena(rs.getString("a.contrasena"));
                    a.setEgresado(rs.getString("a.egresado"));
                    a.setFoto(rs.getBytes("a.foto"));
                    a.setMotivo(rs.getString("a.motivo"));
                    a.setFechaAprobacion(rs.getString("a.fecha_aprob"));

                    TipoDonacion tD = new TipoDonacion();
                    tD.setIdTipoDonacion(rs.getInt("tD.idTipoDonacion"));
                    tD.setDescripcion(rs.getString("tD.descripcion"));

                    DelegadoGeneral dG = new DelegadoGeneral();
                    dG.setIdDelegadoGeneral(rs.getInt("idDelegado_General"));
                    dG.setFoto(rs.getBytes("foto"));
                    dG.setNombre(rs.getString("nombre"));
                    dG.setApellido(rs.getString("apellido"));
                    dG.setCodigo(rs.getString("codigo"));
                    dG.setCorreo(rs.getString("correo"));
                    dG.setContrasena(rs.getString("contrasena"));


                    d.setTipoDonacion(tD);
                    d.setDelegadoGeneral(dG);
                    d.setAlumno(a);
                    d.setIdDonacion(rs.getInt("d.idDonacion"));

                    lista.add(d);
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return lista;
    }

    public ArrayList<Donacion> listarDonacionesPendientesporUsuario(String idDonacion, String estado, int limit, int offset){


        ArrayList<Donacion> lista = new ArrayList<>();


        String sql = "select * \n" +
                "from alumno a INNER JOIN alumno_evento ae ON (a.idAlumno = ae.Alumno_idAlumno)\n" +
                "INNER JOIN integrante i ON (ae.Integrante_idIntegrante = i.idIntegrante)\n" +
                "INNER JOIN evento e ON (ae.Evento_idEvento = e.idEvento)\n" +
                "WHERE e.idEvento = ? and e.estado = ? and i.idIntegrante = 3 order by a.idAlumno limit ? offset ?;";

        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1,idDonacion);
            pstmt.setString(2,estado);
            pstmt.setInt(3,limit);
            pstmt.setInt(4,offset);

            try(ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    Donacion d = new Donacion();

                    Alumno a = new Alumno();
                    a.setIdAlumno(rs.getInt("a.idAlumno"));
                    a.setNombre(rs.getString("a.nombre"));
                    a.setApellido(rs.getString("a.apellido"));
                    a.setCodigo(rs.getString("a.codigo"));
                    a.setCorreo(rs.getString("a.correo"));
                    a.setContrasena(rs.getString("a.contrasena"));
                    a.setEgresado(rs.getString("a.egresado"));
                    a.setFoto(rs.getBytes("a.foto"));
                    a.setMotivo(rs.getString("a.motivo"));
                    a.setFechaAprobacion(rs.getString("a.fecha_aprob"));

                    TipoDonacion tD = new TipoDonacion();
                    tD.setIdTipoDonacion(rs.getInt("tD.idTipoDonacion"));
                    tD.setDescripcion(rs.getString("tD.descripcion"));

                    DelegadoGeneral dG = new DelegadoGeneral();
                    dG.setIdDelegadoGeneral(rs.getInt("idDelegado_General"));
                    dG.setFoto(rs.getBytes("foto"));
                    dG.setNombre(rs.getString("nombre"));
                    dG.setApellido(rs.getString("apellido"));
                    dG.setCodigo(rs.getString("codigo"));
                    dG.setCorreo(rs.getString("correo"));
                    dG.setContrasena(rs.getString("contrasena"));


                    d.setTipoDonacion(tD);
                    d.setDelegadoGeneral(dG);
                    d.setAlumno(a);
                    d.setIdDonacion(rs.getInt("d.idDonacion"));

                    lista.add(d);
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return lista;
    }



}
