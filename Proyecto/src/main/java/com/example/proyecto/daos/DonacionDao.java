package com.example.proyecto.daos;

import com.example.proyecto.beans.*;

import java.io.InputStream;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
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
                    d.setCaptura(rs.getBinaryStream("d.captura"));
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

    public void crearDonacion(Donacion donacion){

        String sql = "insert into donacion (monto, captura, estado, fecha, motivo, Alumno_idAlumno, Tipo_Donacion_idTipo_Donacion, Delegado_General_idDelegado_General) values (?,?,?,?,?,?,?,?)";

        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1,donacion.getMonto());
            pstmt.setBlob(2,donacion.getCaptura());
            pstmt.setString(3,donacion.getEstado());
            pstmt.setString(4,donacion.getFecha());
            pstmt.setString(5,donacion.getMotivo());
            pstmt.setInt(6,donacion.getAlumno().getIdAlumno());
            pstmt.setInt(7,donacion.getTipoDonacion().getIdTipoDonacion());
            pstmt.setInt(8,donacion.getDelegadoGeneral().getIdDelegadoGeneral());

            pstmt.executeUpdate();

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public void crear(InputStream donacionCaptura, String donacionTipo, int donacionMonto, String idAlumno){

        String sql = "insert into donacion (captura,monto, Tipo_Donacion_idTipo_Donacion,estado,fecha,Alumno_idAlumno) values (?,?,?,?,?,?)";

        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setBlob(1,donacionCaptura);
            pstmt.setInt(2,donacionMonto);
            pstmt.setString(3,donacionTipo);
            pstmt.setString(4,"pendiente");
            pstmt.setString(5,DateTimeFormatter.ofPattern("yyyy/MM/dd").format(LocalDateTime.now()));
            pstmt.setString(6,idAlumno);

            pstmt.executeUpdate();

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public ArrayList<Donacion> listarDonacionPorAlumno(String estado){


        ArrayList<Donacion> lista = new ArrayList<>();

        String sql = "select * from donacion d where d.estado = ?;";

        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1,estado);

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
                    a.setFoto(rs.getBinaryStream("a.foto"));
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

    public ArrayList<Donacion> listarDonacionesporEstado(String estado){


        ArrayList<Donacion> lista = new ArrayList<>();
        AlumnoDao alumnoDao = new AlumnoDao();
        TipoDonacionDao tipoDonacionDao = new TipoDonacionDao();
        DelegadoGeneralDao delegadoGeneralDao = new DelegadoGeneralDao();


        String sql = "select * from donacion d where d.estado = ?;";

        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1,estado);

            try(ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    Donacion d = new Donacion();

                    d.setIdDonacion(rs.getInt("d.idDonacion"));
                    d.setMonto(rs.getString("d.monto"));
                    d.setCaptura(rs.getBinaryStream("d.captura"));
                    d.setEstado(rs.getString("d.estado"));
                    d.setFecha(rs.getString("d.fecha"));
                    d.setMotivo(rs.getString("d.motivo"));
                    d.setAlumno(alumnoDao.obtenerAlumno(rs.getString("d.Alumno_idAlumno")));
                    d.setTipoDonacion(tipoDonacionDao.obtenerTipoDonacion(rs.getString("d.Tipo_Donacion_idTipo_Donacion")));
                    d.setDelegadoGeneral(delegadoGeneralDao.obtenerDelegadoGeneral(rs.getString("d.Delegado_General_idDelegado_General")));

                    lista.add(d);
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return lista;
    }



}
