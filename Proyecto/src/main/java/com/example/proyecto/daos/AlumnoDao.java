package com.example.proyecto.daos;

import com.example.proyecto.beans.Actividad;
import com.example.proyecto.beans.Alumno;
import com.example.proyecto.beans.Evento;

import java.io.InputStream;
import java.sql.*;
import java.util.ArrayList;

public class AlumnoDao extends DaoBase{

    public Alumno obtenerAlumno(String idAlumno){

        Alumno a = new Alumno();
        EstadoAlumnoDao estadoAlumnoDao = new EstadoAlumnoDao();
        DelegadoGeneralDao delegadoGeneralDao = new DelegadoGeneralDao();
        DelegadoActividadDao delegadoActividadDao = new DelegadoActividadDao();



        String sql = "select * from alumno a where a.idAlumno = ?;";

        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1,idAlumno);

            try(ResultSet rs = pstmt.executeQuery()) {

                if (rs.next()) {
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
                    a.setDelegadoGeneral(delegadoGeneralDao.obtenerDelegadoGeneral(rs.getString("a.Delegado_General_idDelegado_General")));
                    a.setEstadoAlumno(estadoAlumnoDao.obtenerEstadoAlumno(rs.getString("Estado_Alumno_idEstado_Alumno")));
                    a.setDelegadoActividad(delegadoActividadDao.obtenerDelegadoActividad(rs.getString("Delegado_Actividad_idDelegado_Actividad")));

                }
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return a;
    }

    public Alumno obtenerDelegadoDeActividad(String idDelegadoDeActividad){

        Alumno a = new Alumno();
        EstadoAlumnoDao estadoAlumnoDao = new EstadoAlumnoDao();
        DelegadoGeneralDao delegadoGeneralDao = new DelegadoGeneralDao();
        DelegadoActividadDao delegadoActividadDao = new DelegadoActividadDao();



        String sql = "select * from alumno a where a.Delegado_Actividad_idDelegado_Actividad = ?;";

        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1,idDelegadoDeActividad);

            try(ResultSet rs = pstmt.executeQuery()) {

                if (rs.next()) {
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
                    a.setDelegadoGeneral(delegadoGeneralDao.obtenerDelegadoGeneral(rs.getString("a.Delegado_General_idDelegado_General")));
                    a.setEstadoAlumno(estadoAlumnoDao.obtenerEstadoAlumno(rs.getString("a.Estado_Alumno_idEstado_Alumno")));
                    a.setDelegadoActividad(delegadoActividadDao.obtenerDelegadoActividad(rs.getString("a.Delegado_Actividad_idDelegado_Actividad")));

                }
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return a;
    }

    public ArrayList<Alumno> listarDelegadosDeActividad(){

        ArrayList<Alumno> lista = new ArrayList<>();
        EstadoAlumnoDao estadoAlumnoDao = new EstadoAlumnoDao();
        DelegadoGeneralDao delegadoGeneralDao = new DelegadoGeneralDao();
        DelegadoActividadDao delegadoActividadDao = new DelegadoActividadDao();



        String sql = "select * from alumno a where a.Delegado_Actividad_idDelegado_Actividad is not null and a.Estado_Alumno_idEstado_Alumno = 1 order by a.Delegado_Actividad_idDelegado_Actividad;";

        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {


            try(ResultSet rs = pstmt.executeQuery()) {

                while (rs.next()) {
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
                    a.setDelegadoGeneral(delegadoGeneralDao.obtenerDelegadoGeneral(rs.getString("a.Delegado_General_idDelegado_General")));
                    a.setEstadoAlumno(estadoAlumnoDao.obtenerEstadoAlumno(rs.getString("a.Estado_Alumno_idEstado_Alumno")));
                    a.setDelegadoActividad(delegadoActividadDao.obtenerDelegadoActividad(rs.getString("a.Delegado_Actividad_idDelegado_Actividad")));

                    lista.add(a);

                }
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return lista;
    }


    public ArrayList<Alumno> listarAlumnosQueNoSonDelegadosDeActividad(){   //Lo utilizamos para mandar una lista de alumnos que son candidatos para ser un delegado de actividad

        ArrayList<Alumno> lista = new ArrayList<>();
        EstadoAlumnoDao estadoAlumnoDao = new EstadoAlumnoDao();
        DelegadoGeneralDao delegadoGeneralDao = new DelegadoGeneralDao();
        DelegadoActividadDao delegadoActividadDao = new DelegadoActividadDao();



        String sql = "select * from alumno a where a.Delegado_Actividad_idDelegado_Actividad is null and a.Estado_Alumno_idEstado_Alumno = 1 order by a.idAlumno;";

        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {


            try(ResultSet rs = pstmt.executeQuery()) {

                while (rs.next()) {
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
                    a.setDelegadoGeneral(delegadoGeneralDao.obtenerDelegadoGeneral(rs.getString("a.Delegado_General_idDelegado_General")));
                    a.setEstadoAlumno(estadoAlumnoDao.obtenerEstadoAlumno(rs.getString("a.Estado_Alumno_idEstado_Alumno")));
                    a.setDelegadoActividad(delegadoActividadDao.obtenerDelegadoActividad(rs.getString("a.Delegado_Actividad_idDelegado_Actividad")));

                    lista.add(a);

                }
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return lista;
    }

    public void actualizarIdDelegadoActividad(String idDelegadoActividad, String idAlumno){ //para convertirlo en un delegado de actividad

        String sql = "update alumno set Delegado_Actividad_idDelegado_Actividad = ? where idAlumno = ?;";

        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            if(idDelegadoActividad.equalsIgnoreCase("eliminar")){
                pstmt.setNull(1,Types.INTEGER);
                //pstmt.setString(1, "NULL");
            }
            else{
                pstmt.setInt(1,Integer.parseInt(idDelegadoActividad));
            }
            pstmt.setInt(2, Integer.parseInt(idAlumno));

            System.out.println("idDeleg Act: " + idDelegadoActividad);
            System.out.println("idAlumno Act: " + idAlumno);

            pstmt.executeUpdate();

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }


    public void crearAlumno(Alumno alumno){

        String sql = "insert into alumno (nombre, apellido, codigo, correo, contrasena, egresado, foto, Estado_Alumno_idEstado_Alumno) values (?,?,?,?,SHA2(?,256),?,?,?)";

        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1,alumno.getNombre());
            pstmt.setString(2,alumno.getApellido());
            pstmt.setString(3,alumno.getCodigo());
            pstmt.setString(4,alumno.getCorreo());
            pstmt.setString(5,alumno.getContrasena());
            pstmt.setString(6,alumno.getEgresado());
            pstmt.setBlob(7,alumno.getFoto());
            pstmt.setInt(8,alumno.getEstadoAlumno().getIdEstadoAlumno());

            pstmt.executeUpdate();

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public ArrayList<Alumno> listarAlumnosSegunEstado(int estado){   //Para validar registros

        ArrayList<Alumno> lista = new ArrayList<>();
        EstadoAlumnoDao estadoAlumnoDao = new EstadoAlumnoDao();
        DelegadoGeneralDao delegadoGeneralDao = new DelegadoGeneralDao();
        DelegadoActividadDao delegadoActividadDao = new DelegadoActividadDao();



        String sql = "select * from alumno a where a.Estado_Alumno_idEstado_Alumno = ?;";

        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1,estado);
            try(ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
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
                    a.setDelegadoGeneral(delegadoGeneralDao.obtenerDelegadoGeneral(rs.getString("a.Delegado_General_idDelegado_General")));
                    a.setEstadoAlumno(estadoAlumnoDao.obtenerEstadoAlumno(rs.getString("a.Estado_Alumno_idEstado_Alumno")));
                    a.setDelegadoActividad(delegadoActividadDao.obtenerDelegadoActividad(rs.getString("a.Delegado_Actividad_idDelegado_Actividad")));
                    lista.add(a);
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return lista;
    }


    public void actualizarEstado(String estado, String idAlumno){ //para banear, rechazar o aceptar registro

        String sql = "update alumno set Estado_Alumno_idEstado_Alumno = ? where idAlumno = ?;";

        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, Integer.parseInt(estado));
            switch (estado){
                case "Activo":
                    pstmt.setInt(1, 1);
                    break;
                case "Baneado":
                    pstmt.setInt(1, 2);
                    break;
                case "Pendiente":
                    pstmt.setInt(1, 3);
                    break;
                case "Rechazado":
                    pstmt.setInt(1, 4);
                    break;
            }
            pstmt.setInt(2, Integer.parseInt(idAlumno));

            pstmt.executeUpdate();

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public void deshabilitarCuenta(String id) {

        String sql = "UPDATE alumno SET Estado_Alumno_idEstado_Alumno = 2 WHERE idCuenta = ?";
        try (Connection connection = this.getConnection();
             PreparedStatement pstmt = connection.prepareStatement(sql)) {

            pstmt.setString(1, id);
            pstmt.executeUpdate();

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public void habilitarCuenta(String id) {

        String sql = "UPDATE alumno SET Estado_Alumno_idEstado_Alumno = 1 WHERE idCuenta = ?";
        try (Connection connection = this.getConnection();
             PreparedStatement pstmt = connection.prepareStatement(sql)) {

            pstmt.setString(1, id);

            pstmt.executeUpdate();

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public Alumno correo(String id) {
        Alumno alumno = null;


        String sql = "select correo , nombre, apellido, egresado from alumno \n" +
                "where idAlumno= ?";

        try (Connection conn = this.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, id);

            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    alumno = new Alumno();
                    alumno.setCorreo(rs.getString(1));
                    alumno.setNombre(rs.getString(2));
                    alumno.setApellido(rs.getString(3));
                    alumno.setEgresado(rs.getString(4));
                }
            }

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        return alumno;
    }

    public boolean alumnoEsDelegadoActividad(String idAlumno){


        boolean esDelegadoDeActividad = false;

        String sql = "select * from alumno a where a.idAlumno = ?;";

        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1,idAlumno);

            try(ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {

                    if(!rs.getString("Delegado_Actividad_idDelegado_Actividad").equals("null")){
                        esDelegadoDeActividad = true;
                    }

                }
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return esDelegadoDeActividad;
    }


    public void actualizarFotoDePerfil(InputStream fotoPerfil, String idAlumno){ //para banear, rechazar o aceptar registro

        String sql = "update alumno set foto = ? where idAlumno = ?;";

        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setBlob(1,fotoPerfil);
            pstmt.setInt(2, Integer.parseInt(idAlumno));

            pstmt.executeUpdate();

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }



}
