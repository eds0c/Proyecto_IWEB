package com.example.proyecto.daos;

import com.example.proyecto.beans.Actividad;
import com.example.proyecto.beans.Alumno;
import com.example.proyecto.beans.DelegadoGeneral;
import com.mysql.cj.util.DataTypeUtil;
import org.apache.commons.codec.digest.DigestUtils;

import javax.xml.datatype.DatatypeConstants;
import java.nio.charset.StandardCharsets;
import java.security.DigestException;
import java.security.MessageDigest;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.concurrent.ThreadLocalRandom;

public class CredentialsDao extends DaoBase{
    public int validarUsuarioPassword(String correo, String password){

        int tipoUsuario = 0;//1: alumno | 2: delegado de actividad | 3: delegado general | 0:no encontrado


        String sql = "SELECT * FROM alumno where correo= ? and contrasena= SHA2(?,256) and Delegado_Actividad_idDelegado_Actividad is null and Estado_Alumno_idEstado_Alumno = 1";
        try(Connection connection = getConnection();
            PreparedStatement pstmt = connection.prepareStatement(sql)){
                pstmt.setString(1,correo);
                pstmt.setString(2,password);
                try(ResultSet rs = pstmt.executeQuery()){
                    if (rs.next()){ //sí encuentra el usuario con la contraseña y no es delegado de actividad hacer lo siguiente
                        tipoUsuario = 1; //es un alumno
                    }
                }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        String sql2 = "SELECT * FROM alumno where correo= ? and contrasena= SHA2(?,256) and Delegado_Actividad_idDelegado_Actividad is not null and Estado_Alumno_idEstado_Alumno = 1";
        try(Connection connection = getConnection();
            PreparedStatement pstmt = connection.prepareStatement(sql2)){
            pstmt.setString(1,correo);
            pstmt.setString(2,password);
            try(ResultSet rs = pstmt.executeQuery()){
                if (rs.next()){ //sí encuentra el usuario con la contraseña hacer lo siguiente
                    tipoUsuario = 2; //es un delegado de actividad
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);

        }

        String sql3 = "SELECT * FROM delegado_general where correo= ? and contrasena= SHA2(?,256)";
        try(Connection connection = getConnection();
            PreparedStatement pstmt = connection.prepareStatement(sql3)){
            pstmt.setString(1,correo);
            pstmt.setString(2,password);
            try(ResultSet rs = pstmt.executeQuery()){
                if (rs.next()){ //sí encuentra el usuario con la contraseña hacer lo siguiente
                    tipoUsuario = 3; // es un delegado general
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);

        }


        return tipoUsuario;
    }
    public Alumno obtenerAlumno(String correo){
        Alumno a = new Alumno();
        EstadoAlumnoDao estadoAlumnoDao = new EstadoAlumnoDao();
        DelegadoGeneralDao delegadoGeneralDao = new DelegadoGeneralDao();
        DelegadoActividadDao delegadoActividadDao = new DelegadoActividadDao();

        String sql = "select * from alumno a where a.correo = ?;";

        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1,correo);

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

    public DelegadoGeneral obtenerDelegadoGeneral(String correo) {

        DelegadoGeneral delegadoGeneral = new DelegadoGeneral();


        String sql = "select * from delegado_general where correo = ?;";

        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, correo);

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

    public void actualizarContrasenaAlumno(String idAlumno, String nuevaContrasena){ //para actualizar la contraseña

        String sql = "update alumno set contrasena = SHA2(?,256) where idAlumno = ?;";

        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1,nuevaContrasena);
            pstmt.setInt(2, Integer.parseInt(idAlumno));

            pstmt.executeUpdate();

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public void actualizarContrasenaDelegadoGeneral(String idDelegadoGeneral, String nuevaContrasena){ //para actualizar la contraseña

        String sql = "update delegado_general set contrasena = SHA2(?,256) where idDelegado_General = ?;";

        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1,nuevaContrasena);
            pstmt.setInt(2, Integer.parseInt(idDelegadoGeneral));

            pstmt.executeUpdate();

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public boolean validarContrasenaDelegadoGeneral(String idDelegadoGeneral, String nuevaContrasena){ //para actualizar la contraseña

        boolean isValid = false;

        String sql = "select * from delegado_general where idDelegado_General = ?;";

        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, idDelegadoGeneral);
            try (ResultSet rs = pstmt.executeQuery()) {

                if (rs.next()) {


                    String sha256NuevaContrasena = DigestUtils.sha256Hex(nuevaContrasena);

                    if(rs.getString("contrasena").equalsIgnoreCase(sha256NuevaContrasena)){
                        isValid = true;
                    }

                }
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return isValid;
    }

    public boolean validarContrasenaAlumno(String idAlumno, String nuevaContrasena){ //para actualizar la contraseña

        boolean isValid = false;

        String sql = "select * from alumno where idAlumno = ?;";

        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, idAlumno);
            try (ResultSet rs = pstmt.executeQuery()) {

                if (rs.next()) {


                    String sha256NuevaContrasena = DigestUtils.sha256Hex(nuevaContrasena);

                    if(rs.getString("contrasena").equalsIgnoreCase(sha256NuevaContrasena)){
                        isValid = true;
                    }

                }
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return isValid;
    }


    public boolean validarCorreoAlumno(String correo){

        boolean isValid = false;

        String sql = "select * from alumno a where a.correo = ?;";

        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1,correo);

            try(ResultSet rs = pstmt.executeQuery()) {

                if (rs.next()) {
                    isValid = true;
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return isValid;

    }

    public boolean validarCorreoDelegadoGeneral(String correo) {

        boolean isValid = false;

        String sql = "select * from delegado_general where correo = ?;";

        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, correo);

            try (ResultSet rs = pstmt.executeQuery()) {

                if (rs.next()) {
                    isValid = true;
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return isValid;
    }


    public void actualizarTokenAlumno(int idAlumno, String token){

        String sql = "update alumno set token = ? where idAlumno = ?;";

        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1,token);
            pstmt.setInt(2,idAlumno);

            pstmt.executeUpdate();

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public void actualizarTokenDelegadoGeneral(int idDelegadoGeneral, String token){

        String sql = "update delegado_general set token = ? where idDelegado_General = ?;";

        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1,token);
            pstmt.setInt(2,idDelegadoGeneral);

            pstmt.executeUpdate();

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }


    public void borrarTokenDelegadoGeneral(String idDelegadoGeneral){

        String sql = "update delegado_general set token = NULL where idDelegado_General = ?;";

        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1,idDelegadoGeneral);

            pstmt.executeUpdate();

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public void borrarTokenAlumno(String idAlumno){

        String sql = "update alumno set token = NULL where idAlumno = ?;";

        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1,idAlumno);

            pstmt.executeUpdate();

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }


    public String obtenerTokenDelegadoGeneral(String idDelegadoGeneral) {

        String token = "";
        String sql = "select * from delegado_general where idDelegado_General = ?;";

        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, idDelegadoGeneral);

            try (ResultSet rs = pstmt.executeQuery()) {

                if (rs.next()) {
                    token = rs.getString("token");
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return token;
    }

    public String obtenerTokenAlumno(String idAlumno) {

        String token = "";
        String sql = "select * from alumno where idAlumno = ?;";

        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, idAlumno);

            try (ResultSet rs = pstmt.executeQuery()) {

                if (rs.next()) {
                    token = rs.getString("token");
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return token;
    }









    public  int numeroAleatorioEnRango(int minimo, int maximo) {
        // nextInt regresa en rango pero con límite superior exclusivo, por eso sumamos 1
        return ThreadLocalRandom.current().nextInt(minimo, maximo + 1);
    }

    public String cadenaAleatoria(int longitud) {
        // El banco de caracteres
        String banco = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890";
        // La cadena en donde iremos agregando un carácter aleatorio
        String cadena = "";
        for (int x = 0; x < longitud; x++) {
            int indiceAleatorio = numeroAleatorioEnRango(0, banco.length() - 1);
            char caracterAleatorio = banco.charAt(indiceAleatorio);
            cadena += caracterAleatorio;
        }
        return cadena;
    }

}
