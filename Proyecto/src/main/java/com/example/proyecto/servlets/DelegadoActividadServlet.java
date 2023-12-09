package com.example.proyecto.servlets;

import com.example.proyecto.beans.*;
import com.example.proyecto.daos.*;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import jakarta.servlet.annotation.MultipartConfig;

import javax.sound.midi.Soundbank;
import java.io.IOException;
import java.io.InputStream;
import java.sql.*;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.time.format.DateTimeFormatter;
import java.time.format.DateTimeFormatterBuilder;
import java.util.ArrayList;
import java.util.SimpleTimeZone;
@MultipartConfig
@WebServlet(name = "DelegadoActividadServlet", value = "/DelegadoActividadServlet")
public class DelegadoActividadServlet extends HttpServlet {

    //Daos
    DelecActiDao delecActiDao = new DelecActiDao();
    AlumnoEventoDao alumnoEventoDao = new AlumnoEventoDao();
    IntegranteDao integranteDao = new IntegranteDao();
    ActividadDao actividadDao = new ActividadDao();
    EventoDao eventoDao = new EventoDao();
    DelegadoActividadDao delegadoActividadDao = new DelegadoActividadDao();

    DonacionDao donacionDao = new DonacionDao();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        //VALIDAR SESIÓN
        if (request.getSession().getAttribute("tipoUsuario")==null || (Integer) request.getSession().getAttribute("tipoUsuario")!=2){
            response.sendRedirect(request.getContextPath() + "/SesionServlet?action=cerrar_sesion");
        }



        response.setContentType("text/html");
        String action = request.getParameter("action") == null ? "main_page" : request.getParameter("action");



        //Datos de sesión:
        Alumno alumno = (Alumno) request.getSession().getAttribute("usuariologueado");


        switch (action) {
            case "main_page":
                //saca la lista de eventos según actividad
                String idAct = request.getParameter("idAct") == null ? "1" : request.getParameter("idAct"); //click
                ArrayList<Evento> list = eventoDao.listarPorActividad(idAct, "a",100,0);

                //saca la lista de actividades
                ArrayList<DelegadoActividad> listDelegadoActividad = delegadoActividadDao.listarActividades(100,0);

                //mandar la lista a la vista -> /MainPage.jsp
                request.setAttribute("lista", list);
                request.setAttribute("listaActividades", listDelegadoActividad);
                RequestDispatcher rd = request.getRequestDispatcher("delegAct/MainPage.jsp");
                rd.forward(request, response);
                break;

            case "perfil":
                request.getRequestDispatcher("delegAct/Perfil.jsp").forward(request, response);
                break;

            case "mis_eventos":

                //saca del modelo
                ArrayList<AlumnoEvento> list_mis_eventos = eventoDao.listarPorAlumno(String.valueOf(alumno.getIdAlumno()),"a",100,0); //

                //mandar la lista a la vista -> /MisEventos.jsp
                request.setAttribute("lista_mis_eventos", list_mis_eventos);
                request.getRequestDispatcher("delegAct/MisEventos.jsp").forward(request, response);
                break;
            case "eventos_finalizados":

                //saca la lista de eventos finalizados

                ArrayList<AlumnoEvento> listaEventosFinalizados = eventoDao.listarPorAlumno(String.valueOf(alumno.getIdAlumno()),"f",100,0); //

                //mandar la lista a la vista -> /MainPage.jsp
                request.setAttribute("lista_eventos_finalizados",listaEventosFinalizados);
                request.getRequestDispatcher("delegAct/EventFinalizados.jsp").forward(request,response);
                break;
            case "donaciones":
                request.getRequestDispatcher("delegAct/Donaciones.jsp").forward(request, response);
                break;
            case "info_eventos":

                String idEvento = request.getParameter("idEvento") == null ? "1" : request.getParameter("idEvento");

                Evento evento = eventoDao.buscarEvento(idEvento);
                ArrayList<Evento> lista2 = eventoDao.listarEventos(idEvento,4,0);

                //mandar la lista a la vista -> /InfoEventos.jsp
                request.setAttribute("evento",evento);
                request.setAttribute("lista2",lista2);
                request.setAttribute("participando",alumnoEventoDao.comprobarParticipacionEvento(String.valueOf(alumno.getIdAlumno()),idEvento));

                request.getRequestDispatcher("delegAct/InfoEvento.jsp").forward(request,response);
                break;
            case "mi_actividad":
                String idEvento2 = request.getParameter("idEvento") == null ? "1" : request.getParameter("idEvento");

                Evento evento2 = eventoDao.buscarEvento(idEvento2);
                String idAct2 = String.valueOf(alumno.getDelegadoActividad().getActividad().getIdActividad());
                ArrayList<Evento> lista3 = eventoDao.listarPorActividad(idAct2,"a",100,0);

                //mandar la lista a la vista -> /InfoEventos.jsp
                request.setAttribute("evento2",evento2);
                request.setAttribute("lista3",lista3);
                request.getRequestDispatcher("delegAct/MiActividad.jsp").forward(request, response);
                break;
            case "participantes":

                String idEvento3 = request.getParameter("idEventoParticipantes") == null ? "1" : request.getParameter("idEventoParticipantes");

                ArrayList<AlumnoEvento> listaParticipantes = eventoDao.listarAlumnosPorEvento(idEvento3,"a",100,0);

                //mandar la lista a la vista -> /InfoEventos.jsp
                request.setAttribute("idE",idEvento3);
                request.setAttribute("lista_participantes",listaParticipantes);

                request.getRequestDispatcher("delegAct/Participantes.jsp").forward(request, response);
                break;

            case "solicitud_participante":
                String offsetParticipantesPendientes =  request.getParameter("offset_pendientes") == null ? "0" : request.getParameter("offset_pendientes");
                String idEvento4 = request.getParameter("idEventoParticipantes") == null ? "1" : request.getParameter("idEventoParticipantes");

                ArrayList<AlumnoEvento> listaParticipantesPendientes = eventoDao.listarAlumnosPendientesPorEvento(idEvento4,"a",5,Integer.parseInt(offsetParticipantesPendientes)*3);

                //mandar la lista a la vista -> /InfoEventos.jsp
                request.setAttribute("idE",idEvento4);
                request.setAttribute("lista_participantes_pendientes",listaParticipantesPendientes);

                request.getRequestDispatcher("delegAct/SolicitudParticipante.jsp").forward(request, response);
                break;


            case "cerrar_sesion":
                response.sendRedirect(request.getContextPath() + "/SesionServlet?action=cerrar_sesion");
                break;

        }

    }



    @Override

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html");



        //Datos de sesión:
        Alumno alumno = (Alumno) request.getSession().getAttribute("usuariologueado");

        Donacion donacion = new Donacion();

        String action = request.getParameter("action") == null ? "crear" : request.getParameter("action");

        switch (action) {
            case "crear"://voy a crear un nuevo evento

                Part part = request.getPart("eventoFoto");
                InputStream eventoFoto = part.getInputStream();
                String eventoDescripcion = request.getParameter("eventoDescripcion");
                String eventoFecha = request.getParameter("eventoFecha");
                String eventoTitulo = request.getParameter("titulo");
                String eventoHora = request.getParameter("eventoHora");
                String eventoLugar = request.getParameter("eventoLugar");


                //Formatea String a Date
                DateTimeFormatter formatStringToDate = new DateTimeFormatterBuilder().append(DateTimeFormatter.ofPattern("yyyy-MM-dd")).toFormatter();

                boolean isAllValid = true;

                if (eventoDescripcion.length() > 45 || eventoDescripcion.length()<5) {
                    isAllValid = false;
                    request.getSession().setAttribute("errDesc", "La descripción no es del tamaño adecuado");
                }
                if (LocalDate.parse(eventoFecha, formatStringToDate).isBefore(LocalDateTime.now(ZoneId.of("America/New_York")).toLocalDate())) {
                    isAllValid = false;
                    request.getSession().setAttribute("errDesc", "La fecha del evento debe ser posterior a la fecha actual");
                }

                if (isAllValid) {

                    Evento evento = delecActiDao.buscarPorDescripcion(eventoDescripcion); //Busca si hay un evento con el mismo nombre
                    //Creamos Evento
                    if (evento == null) {  //Se verifica que no se repita el evento

                        // Parsear la Foto a Byte

                        int IdActividad = alumno.getDelegadoActividad().getActividad().getIdActividad();
                        delecActiDao.crear(eventoFoto, eventoDescripcion, eventoFecha, eventoHora, eventoLugar, eventoTitulo, IdActividad);
                        request.getSession().setAttribute("msg", "Evento creado exitosamente");
                        response.sendRedirect(request.getContextPath() + "/DelegadoActividadServlet?action=mi_actividad"); //Una vez creado y dado click a submit se devuelve a la página donde está la lista
                    } else {
                        request.getRequestDispatcher("delegAct/MiActividad.jsp").forward(request, response);
                        request.getSession().setAttribute("errDesc", "El evento ya existe");
                    }
                } else {
                    request.getSession().setAttribute("err", "Error al crear el evento");
                    response.sendRedirect(request.getContextPath() + "/DelegadoActividadServlet?action=mi_actividad");
                }
                break;

            case "editar"://voy a editar un evento

                Part part1 = request.getPart("eventoFoto");
                InputStream eventoFoto2 = part1.getInputStream();
                String eventoDescripcion2 = request.getParameter("eventoDescripcion");
                String eventoFecha2 = request.getParameter("eventoFecha");
                String eventoTitulo2 = request.getParameter("titulo");
                String eventoID2 = request.getParameter("eventoID");
                String eventoHora2 = request.getParameter("eventoHora");
                String eventoLugar2 = request.getParameter("eventoLugar");




                //Formatea String a Date
                DateTimeFormatter formatStringToDate2 = new DateTimeFormatterBuilder().append(DateTimeFormatter.ofPattern("yyyy-MM-dd")).toFormatter();

                boolean isAllValid2 = true;

                if (eventoDescripcion2.length() > 45 || eventoDescripcion2.length()<5 || eventoLugar2.isEmpty() || eventoLugar2.length() > 20 || eventoTitulo2.isEmpty() || eventoTitulo2.length() > 20) {
                    isAllValid2 = false;
                    request.getSession().setAttribute("errDesc", "La descripción, el título o el lugar no cumplen con el tamaño adecuado.");
                }
                if (LocalDate.parse(eventoFecha2, formatStringToDate2).isBefore(LocalDateTime.now(ZoneId.of("America/New_York")).toLocalDate())) {
                    isAllValid2 = false;
                    request.getSession().setAttribute("errDesc", "La fecha del evento debe ser posterior a la fecha actual");
                }

                if (isAllValid2) {

                    Evento evento = delecActiDao.buscarPorDescripcion(eventoDescripcion2); //Busca si hay un evento con el mismo nombre
                    //Creamos Trabajador
                    if (evento == null) {  //Se verifica que no se repita el evento

                        // Parsear la Foto a Byte

                        String IdActividad = String.valueOf(alumno.getDelegadoActividad().getActividad().getIdActividad());

                        Evento e2 = new Evento();
                        e2.setFoto(eventoFoto2);
                        e2.setActividad(actividadDao.obtenerActividad(IdActividad));
                        e2.setDescripcion(eventoDescripcion2);
                        e2.setLugar(eventoLugar2);
                        e2.setFechaIn(eventoFecha2);
                        e2.setHora(eventoHora2);
                        e2.setIdEvento(Integer.parseInt(eventoID2));

                        delecActiDao.actualizar(e2);
                        request.getSession().setAttribute("msg", "Evento actualizado exitosamente");
                        response.sendRedirect(request.getContextPath() + "/DelegadoActividadServlet?action=mi_actividad"); //Una vez actualizado y dado click a submit se devuelve a la página donde está la lista
                    } else {
                        request.getSession().setAttribute("err", "Error al actualizar el evento");
                        request.getRequestDispatcher("delegAct/MiActividad.jsp").forward(request, response);
                    }
                } else {
                    request.getSession().setAttribute("err", "Error al actualizar el evento");
                    request.getRequestDispatcher("delegAct/MiActividad.jsp").forward(request, response);
                }
                break;

            case "cambiar_rol":

                if(request.getParameter("idAE") != null){
                    String idAE = request.getParameter("idAE");
                    AlumnoEvento aE = alumnoEventoDao.obtenerAlumnoEvento(idAE);
                    integranteDao.cambiarRol(aE);
                    request.getSession().setAttribute("msg", "Rol cambiado exitosamente.");
                    response.sendRedirect(request.getContextPath() + "/DelegadoActividadServlet?action=participantes&idEventoParticipantes="+ aE.getEvento().getIdEvento());
                }
                else{
                    request.getSession().setAttribute("err", "Error al cambiar rol.");
                    response.sendRedirect(request.getContextPath() + "/DelegadoActividadServlet?action=participantes");
                }

                break;


            case "eliminar_evento":
                String idEventoStr = request.getParameter("idEventoEliminar");
                Evento evento3 = eventoDao.buscarEvento(idEventoStr);

                if(evento3 != null){
                    try {
                        alumnoEventoDao.eliminar(idEventoStr);
                        request.getSession().setAttribute("msg", "Evento eliminado exitosamente");
                        delecActiDao.borrar(Integer.parseInt(idEventoStr));
                    } catch (SQLException e) {
                        System.out.println("Log: excepcion: " + e.getMessage());
                    }
                }
                response.sendRedirect(request.getContextPath() + "/DelegadoActividadServlet?action=mi_actividad");
                break;

            case "asignar_rol":

                String idEvento = request.getParameter("idE") == null ? "1" : request.getParameter("idE");
                int cantidadAlumnosPendientes = Integer.parseInt(request.getParameter("cantidad"));

                for(int i = 1; i<=cantidadAlumnosPendientes;i++){

                    String idPendienteN = request.getParameter("idPendiente"+ i) == null ? "0" : request.getParameter("idPendiente"+i);
                    String rolAsignarN = request.getParameter("rolAsignar"+i);
                    AlumnoEvento alumnoN = alumnoEventoDao.obtenerAlumnoEvento(idPendienteN);
                    integranteDao.asignarRol(alumnoN,rolAsignarN);
                }
                response.sendRedirect(request.getContextPath() + "/DelegadoActividadServlet?action=participantes&idEventoParticipantes="+ idEvento);
                break;
            case "apoyar_evento":
                //saca el id del evento a apoyar
                String idEventoApoyar = request.getParameter("idEventoApoyar") == null ? "" : request.getParameter("idEventoApoyar");
                String idAlumno = String.valueOf(alumno.getIdAlumno());
                alumnoEventoDao.apoyarEvento(idAlumno,idEventoApoyar);
                response.sendRedirect(request.getContextPath() + "/DelegadoActividadServlet?action=main_page");
                break;

            case "donar":

                String donacionTipo = request.getParameter("donacionTipo");
                String donacionMonto = request.getParameter("donacionMonto");


                boolean isAllValid1 = true;

                if (donacionMonto.isEmpty()) {
                    isAllValid1 = false;
                    request.getSession().setAttribute("errDesc", "Coloca un monto a donar.");
                }

                double donacionMontoDouble = 0;
                try {
                    donacionMontoDouble = Double.parseDouble(donacionMonto);
                } catch (NumberFormatException n) {
                    isAllValid1 = false;
                    request.getSession().setAttribute("errDesc", "El monto tiene que ser un número (Puede usar decimales).");
                }


                if(request.getPart("donacionFoto") == null){
                    isAllValid1 = false;
                    request.getSession().setAttribute("errDesc", "Coloca la captura de tu donación.");
                }

                if(request.getParameter("donacionTipo") == null){
                    isAllValid1 = false;
                    request.getSession().setAttribute("errDesc", "Selecciona la billeta electrónica que desees.");
                }


                if (isAllValid1) {
                    //guardamos Donacion
                    donacionDao.crear(request.getPart("donacionFoto").getInputStream(), donacionTipo, donacionMontoDouble, request.getParameter("alumnoIDdonador"));
                    request.getSession().setAttribute("msg", "Tu donación fue enviada correctamente.");
                    response.sendRedirect(request.getContextPath() + "/DelegadoActividadServlet?action=donaciones");
                } else {
                    request.getRequestDispatcher("delegAct/Donaciones.jsp").forward(request, response);
                    request.getSession().setAttribute("err", "Tu donación no fue enviada correctamente.");
                }
                break;


        }



    }



}

