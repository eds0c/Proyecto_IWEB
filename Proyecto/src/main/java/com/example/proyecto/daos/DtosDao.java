package com.example.proyecto.daos;

import com.example.proyecto.Dtos.DonacionesPorFecha;
import com.example.proyecto.Dtos.IntegrantesPorActividad;
import com.example.proyecto.beans.Actividad;
import com.example.proyecto.beans.Evento;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Optional;

public class DtosDao extends DaoBase{

    public ArrayList<IntegrantesPorActividad> estadisticasIntegrantesPorActividad(){ //evento de segundo plano

        ArrayList<IntegrantesPorActividad> lista = new ArrayList<>();
        ActividadDao aDao = new ActividadDao();
        AlumnoEventoDao alumnoEventoDao = new AlumnoEventoDao();
        EventoDao eventoDao = new EventoDao();


        String sql = "select idActividad from actividad";

        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            try(ResultSet rs = pstmt.executeQuery()) {

                while (rs.next()) {
                    String idActividad = String.valueOf(rs.getInt(1));
                    IntegrantesPorActividad integrantesPorActividad = new IntegrantesPorActividad();
                    integrantesPorActividad.setActividad(aDao.obtenerActividad(idActividad));
                    int cantEquipo = 0, cantBarra = 0, cantPendiente = 0;

                    for(int idEvento: eventoDao.listarIdsPorActividad(idActividad)){
                        cantEquipo += alumnoEventoDao.obtenerCantidadDeIntegrantesPorEvento(idEvento,1);
                        cantBarra += alumnoEventoDao.obtenerCantidadDeIntegrantesPorEvento(idEvento,2);
                        cantPendiente += alumnoEventoDao.obtenerCantidadDeIntegrantesPorEvento(idEvento,3);
                    }
                    integrantesPorActividad.setCantidadIntegrantesBarra(cantBarra);
                    integrantesPorActividad.setCantidadIntegrantesEquipo(cantEquipo);
                    integrantesPorActividad.setCantidadIntegrantesPendientes(cantPendiente);
                    lista.add(integrantesPorActividad);
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return lista;
    }


    public ArrayList<DonacionesPorFecha> estadisticasDonacionesPorFecha(String fechaActual, int cantidadDias){

        ArrayList<DonacionesPorFecha> lista = new ArrayList<>();
        DonacionDao donacionDao = new DonacionDao();

        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy/MM/dd");
        LocalDate fechaActualLocalDate = LocalDate.parse(fechaActual, formatter);

        for(int i=0;i<cantidadDias;i++){
            LocalDate localDateAux = fechaActualLocalDate.minusDays(i);
            DonacionesPorFecha donacionesPorFecha = new DonacionesPorFecha();
            String fechaAux = formatter.format(localDateAux);
            donacionesPorFecha.setFecha(fechaAux);
            donacionesPorFecha.setSumaDonaciones(donacionDao.sumaDeDonacion(fechaAux));
            lista.add(donacionesPorFecha);
        }
        Collections.reverse(lista);
        return lista;
    }








}
