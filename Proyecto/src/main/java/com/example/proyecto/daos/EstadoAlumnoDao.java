package com.example.proyecto.daos;

import com.example.proyecto.beans.Alumno;
import com.example.proyecto.beans.EstadoAlumno;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class EstadoAlumnoDao extends DaoBase {

    public EstadoAlumno obtenerEstadoAlumno(String idEstadoAlumno){

        EstadoAlumno estadoAlumno = new EstadoAlumno();


        String sql = "select * from estado_alumno  where idEstado_Alumno = ?;";

        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1,idEstadoAlumno);

            try(ResultSet rs = pstmt.executeQuery()) {

                if (rs.next()) {
                    estadoAlumno.setIdEstadoAlumno(Integer.parseInt(rs.getString(("idEstado_Alumno"))));
                    estadoAlumno.setDescripcion(rs.getString("descripcion"));
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return estadoAlumno;
    }


}
