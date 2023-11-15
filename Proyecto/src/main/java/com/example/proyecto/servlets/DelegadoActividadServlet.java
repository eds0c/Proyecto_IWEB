package com.example.proyecto.servlets;

import com.example.proyecto.beans.Alumno;
import com.example.proyecto.beans.AlumnoEvento;
import com.example.proyecto.beans.DelegadoActividad;
import com.example.proyecto.beans.Evento;
import com.example.proyecto.daos.*;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.io.InputStream;
import java.sql.Date;
import java.sql.SQLException;
import java.sql.Time;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.SimpleTimeZone;

@WebServlet(name = "DelegadoActividadServlet", value = "/DelegadoActividadServlet")
public class DelegadoActividadServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        //VALIDAR SESIÓN
        if (request.getSession().getAttribute("tipoUsuario")==null || (Integer) request.getSession().getAttribute("tipoUsuario")!=2){
            response.sendRedirect(request.getContextPath() + "/SesionServlet?action=cerrar_sesion");
        }



        response.setContentType("text/html");
        String action = request.getParameter("action") == null ? "main_page" : request.getParameter("action");

        //Daos:
        EventoDao eDao = new EventoDao();
        DelecActiDao delecActiDao = new DelecActiDao();
        AlumnoEventoDao alumnoEventoDao = new AlumnoEventoDao();
        DelegadoActividadDao delegadoActividadDao = new DelegadoActividadDao();

        //Datos de sesión:
        Alumno alumno = (Alumno) request.getSession().getAttribute("usuariologueado");


        switch (action) {
            case "main_page":
                //saca la lista de eventos según actividad
                String idAct = request.getParameter("idAct") == null ? "1" : request.getParameter("idAct"); //click
                ArrayList<Evento> list = eDao.listarPorActividad(idAct, "a",100,0);

                //saca la lista de actividades
                ArrayList<DelegadoActividad> listDelegadoActividad = delegadoActividadDao.listarActividades(100,0);

                //mandar la lista a la vista -> /MainPage.jsp
                request.setAttribute("lista", list);
                request.setAttribute("listaActividades", listDelegadoActividad);
                RequestDispatcher rd = request.getRequestDispatcher("delegAct/MainPage.jsp");
                rd.forward(request, response);
                break;

            case "mis_eventos":

                //saca del modelo
                ArrayList<AlumnoEvento> list_mis_eventos = eDao.listarPorAlumno(String.valueOf(alumno.getIdAlumno()),"a",100,0); //

                //mandar la lista a la vista -> /MisEventos.jsp
                request.setAttribute("lista_mis_eventos", list_mis_eventos);
                request.getRequestDispatcher("delegAct/MisEventos.jsp").forward(request, response);
                break;
            case "eventos_finalizados":

                //saca la lista de eventos finalizados

                ArrayList<AlumnoEvento> listaEventosFinalizados = eDao.listarPorAlumno(String.valueOf(alumno.getIdAlumno()),"f",100,0); //

                //mandar la lista a la vista -> /MainPage.jsp
                request.setAttribute("lista_eventos_finalizados",listaEventosFinalizados);
                request.getRequestDispatcher("delegAct/EventFinalizados.jsp").forward(request,response);
                break;
            case "donaciones":
                request.getRequestDispatcher("delegAct/Donaciones.jsp").forward(request, response);
                break;
            case "info_eventos":

                String idEvento = request.getParameter("idEvento") == null ? "1" : request.getParameter("idEvento");

                Evento evento = eDao.buscarEvento(idEvento);
                ArrayList<Evento> lista2 = eDao.listarEventos(idEvento,4,0);

                //mandar la lista a la vista -> /InfoEventos.jsp
                request.setAttribute("evento",evento);
                request.setAttribute("lista2",lista2);
                request.setAttribute("participando",alumnoEventoDao.comprobarParticipacionEvento(String.valueOf(alumno.getIdAlumno()),idEvento));

                request.getRequestDispatcher("delegAct/InfoEvento.jsp").forward(request,response);
                break;
            case "mi_actividad":
                String idEvento2 = request.getParameter("idEvento") == null ? "1" : request.getParameter("idEvento");

                Evento evento2 = eDao.buscarEvento(idEvento2);
                String idAct2 = String.valueOf(alumno.getDelegadoActividad().getActividad().getIdActividad());
                ArrayList<Evento> lista3 = eDao.listarPorActividad(idAct2,"a",100,0);

                //mandar la lista a la vista -> /InfoEventos.jsp
                request.setAttribute("evento2",evento2);
                request.setAttribute("lista3",lista3);
                request.getRequestDispatcher("delegAct/MiActividad.jsp").forward(request, response);
                break;
            case "participantes":

                String offsetParticipantesPendientes =  request.getParameter("offset_pendientes") == null ? "0" : request.getParameter("offset_pendientes");
                String idEvento3 = request.getParameter("idEventoParticipantes") == null ? "1" : request.getParameter("idEventoParticipantes");

                ArrayList<AlumnoEvento> listaParticipantesPendientes = eDao.listarAlumnosPendientesPorEvento(idEvento3,"a",5,Integer.parseInt(offsetParticipantesPendientes)*3);
                ArrayList<AlumnoEvento> listaParticipantes = eDao.listarAlumnosPorEvento(idEvento3,"a",100,0);

                //mandar la lista a la vista -> /InfoEventos.jsp
                request.setAttribute("idE",idEvento3);
                request.setAttribute("lista_participantes",listaParticipantes);
                request.setAttribute("lista_participantes_pendientes",listaParticipantesPendientes);

                request.getRequestDispatcher("delegAct/Participantes.jsp").forward(request, response);
                break;


            case "cerrar_sesion":
                response.sendRedirect(request.getContextPath() + "/SesionServlet?action=cerrar_sesion");
                break;

        }

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html");

        //VALIDAR SESIÓN
        if (request.getSession().getAttribute("tipoUsuario")==null || (Integer) request.getSession().getAttribute("tipoUsuario")!=2){
            response.sendRedirect(request.getContextPath() + "/SesionServlet?action=cerrar_sesion");
        }


        //Datos de sesión:
        Alumno alumno = (Alumno) request.getSession().getAttribute("usuariologueado");

        DelecActiDao delecActiDao = new DelecActiDao();
        AlumnoEventoDao aEDao = new AlumnoEventoDao();
        IntegranteDao iDao = new IntegranteDao();
        ActividadDao aDao = new ActividadDao();
        EventoDao eDao = new EventoDao();

        String action = request.getParameter("action") == null ? "crear" : request.getParameter("action");

        switch (action) {
            case "crear"://voy a crear un nuevo evento

                String eventoFotoStr = request.getParameter("eventoFoto");
                String eventoDescripcion = request.getParameter("eventoDescripcion");
                String eventoFecha = request.getParameter("eventoFecha");
                String eventoTitulo = request.getParameter("titulo");
                String eventoHora = request.getParameter("eventoHora");
                String eventoLugar = request.getParameter("eventoLugar");




                boolean isAllValid = true;

                if (eventoDescripcion.length() > 45) {
                    isAllValid = false;
                }

                if (isAllValid) {

                    Evento evento = delecActiDao.buscarPorDescripcion(eventoDescripcion); //Busca si hay un evento con el mismo nombre
                    //Creamos Evento
                    if (evento == null) {  //Se verifica que no se repita el evento

                        // Parsear la Foto a Byte
                        byte[] eventoFoto = eventoFotoStr.getBytes();
                        int IdActividad = alumno.getDelegadoActividad().getActividad().getIdActividad();

                        delecActiDao.crear(eventoFoto, eventoDescripcion, eventoFecha, eventoHora, eventoLugar, eventoTitulo, IdActividad);
                        response.sendRedirect(request.getContextPath() + "/DelegadoActividadServlet?action=mi_actividad"); //Una vez creado y dado click a submit se devuelve a la página donde está la lista
                    } else {
                        request.getRequestDispatcher("delegAct/MiActividad.jsp").forward(request, response);
                    }
                } else {
                    request.getRequestDispatcher("delegAct/MiActividad.jsp").forward(request, response);
                }
                break;

            case "editar"://voy a editar un evento

                String eventoFotoStr2 = request.getParameter("eventoFoto");
                String eventoDescripcion2 = request.getParameter("eventoDescripcion");
                String eventoFecha2 = request.getParameter("eventoFecha");
                String eventoID2 = request.getParameter("eventoID");
                String eventoHora2 = request.getParameter("eventoHora");
                String eventoLugar2 = request.getParameter("eventoLugar");




                boolean isAllValid2 = true;

                if (eventoDescripcion2.length() > 45) {
                    isAllValid2 = false;
                }

                if (isAllValid2) {

                    Evento evento = delecActiDao.buscarPorDescripcion(eventoDescripcion2); //Busca si hay un evento con el mismo nombre
                    //Creamos Trabajador
                    if (evento == null) {  //Se verifica que no se repita el evento

                        // Parsear la Foto a Byte
                        byte[] eventoFoto = eventoFotoStr2.getBytes();
                        String IdActividad = String.valueOf(alumno.getDelegadoActividad().getActividad().getIdActividad());

                        Evento e2 = new Evento();
                        e2.setFoto(eventoFoto);
                        e2.setActividad(aDao.obtenerActividad(IdActividad));
                        e2.setDescripcion(eventoDescripcion2);
                        e2.setLugar(eventoLugar2);
                        e2.setFechaIn(eventoFecha2);
                        e2.setHora(eventoHora2);
                        e2.setIdEvento(Integer.parseInt(eventoID2));

                        delecActiDao.actualizar(e2);
                        response.sendRedirect(request.getContextPath() + "/DelegadoActividadServlet?action=mi_actividad"); //Una vez actualizado y dado click a submit se devuelve a la página donde está la lista
                    } else {
                        request.getRequestDispatcher("delegAct/MiActividad.jsp").forward(request, response);
                    }
                } else {
                    request.getRequestDispatcher("delegAct/MiActividad.jsp").forward(request, response);
                }
                break;

            case "cambiar_rol":


                String idAE = request.getParameter("idAE") == null ? "1" : request.getParameter("idAE");
                AlumnoEvento aE = aEDao.obtenerAlumnoEvento(idAE);
                iDao.cambiarRol(aE);
                response.sendRedirect(request.getContextPath() + "/DelegadoActividadServlet?action=participantes&idEventoParticipantes="+ aE.getEvento().getIdEvento());

                break;


            case "eliminar_evento":
                String idEventoStr = request.getParameter("idEventoEliminar");
                Evento evento3 = eDao.buscarEvento(idEventoStr);

                if(evento3 != null){
                    try {
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
                    AlumnoEvento alumnoN = aEDao.obtenerAlumnoEvento(idPendienteN);
                    iDao.asignarRol(alumnoN,rolAsignarN);
                }
                response.sendRedirect(request.getContextPath() + "/DelegadoActividadServlet?action=participantes&idEventoParticipantes="+ idEvento);
                break;
            case "apoyar_evento":
                //saca el id del evento a apoyar
                String idEventoApoyar = request.getParameter("idEventoApoyar") == null ? "" : request.getParameter("idEventoApoyar");
                String idAlumno = String.valueOf(alumno.getIdAlumno());
                aEDao.apoyarEvento(idAlumno,idEventoApoyar);
                response.sendRedirect(request.getContextPath() + "/AlumnoServlet?action=info_eventos");
                break;

        }





        }



}

