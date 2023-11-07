package com.example.proyecto.daos;

import com.example.proyecto.beans.Actividad;
import com.example.proyecto.beans.AlumnoEvento;
import com.example.proyecto.beans.Evento;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class AlumnoEventoDao extends DaoBase{


    public AlumnoEvento obtenerAlumnoEvento(String idAE){

        AlumnoEvento aE = new AlumnoEvento();


        String sql = "select * from alumno_evento where idAlumno_Evento = ?;";

        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1,idAE);

            try(ResultSet rs = pstmt.executeQuery()) {

                if (rs.next()) {
                    aE.setIdAlumnoEvento(Integer.parseInt(idAE));
                    IntegranteDao iDao = new IntegranteDao();
                    aE.setIntegrante(iDao.otenerIntegrante(String.valueOf(rs.getInt("Integrante_idIntegrante"))));
                    EventoDao eDao = new EventoDao();
                    aE.setEvento(eDao.buscarEvento(String.valueOf(rs.getInt("Evento_idEvento"))));
                    AlumnoDao alumnoDao = new AlumnoDao();
                    aE.setAlumno(alumnoDao.obtenerAlumno(String.valueOf(rs.getInt("Alumno_idAlumno"))));
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return aE;
    }
}
