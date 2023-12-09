package com.example.proyecto.servlets;

import com.example.proyecto.beans.Alumno;
import com.example.proyecto.beans.AlumnoEvento;
import com.example.proyecto.beans.DelegadoActividad;
import com.example.proyecto.beans.Evento;
import com.example.proyecto.daos.*;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import jakarta.servlet.annotation.MultipartConfig;

import java.io.IOException;
import java.util.ArrayList;

@MultipartConfig

@WebServlet(name = "AlumnoServlet", value = "/AlumnoServlet")
public class AlumnoServlet extends HttpServlet {

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



        //Sesion datos:
        Alumno alumno = (Alumno) request.getSession().getAttribute("usuariologueado");

        response.setContentType("text/html");

        String action = request.getParameter("action") == null ? "main_page" : request.getParameter("action");


        switch (action) {
            case "main_page":
                //saca la lista de eventos según actividad
                String idAct = request.getParameter("idAct") == null ? "1" : request.getParameter("idAct"); //click
                ArrayList<Evento> list = eventoDao.listarPorActividad(idAct, "a", 100, 0);
                //saca la lista de actividades
                ArrayList<DelegadoActividad> listDelegadoActividad = delegadoActividadDao.listarActividades(100, 0);


                //mandar las listas a la vista -> /MainPage.jsp
                request.setAttribute("lista", list);
                request.setAttribute("listaActividades", listDelegadoActividad);
                RequestDispatcher rd = request.getRequestDispatcher("/MainPage.jsp");
                rd.forward(request, response);
                break;

            case "perfil":
                request.getRequestDispatcher("/Perfil.jsp").forward(request, response);
                break;

            case "mis_eventos":
                //saca del modelo"

                ArrayList<AlumnoEvento> list_mis_eventos = eventoDao.listarPorAlumno(String.valueOf(alumno.getIdAlumno()), "a", 100, 0); //

                //mandar la lista a la vista -> /MisEventos.jsp
                request.setAttribute("lista_mis_eventos", list_mis_eventos);
                request.getRequestDispatcher("/MisEventos.jsp").forward(request, response);
                break;
            case "eventos_finalizados":
                //saca la lista de eventos finalizados

                ArrayList<AlumnoEvento> listaEventosFinalizados = eventoDao.listarPorAlumno(String.valueOf(alumno.getIdAlumno()), "f", 100, 0); //

                //mandar la lista a la vista -> /MainPage.jsp
                request.setAttribute("lista_eventos_finalizados", listaEventosFinalizados);
                request.getRequestDispatcher("/EventosFinalizados.jsp").forward(request, response);
                break;

            case "donaciones":
                request.getRequestDispatcher("/Donaciones.jsp").forward(request, response);
                break;

            case "info_eventos":

                String idEvento = request.getParameter("idEvento") == null ? "1" : request.getParameter("idEvento");

                Evento evento = eventoDao.buscarEvento(idEvento);
                ArrayList<Evento> lista2 = eventoDao.listarEventos(idEvento, 4, 0);

                //mandar la lista a la vista -> /InfoEventos.jsp
                request.setAttribute("evento", evento);
                request.setAttribute("lista2", lista2);
                request.setAttribute("participando", alumnoEventoDao.comprobarParticipacionEvento(String.valueOf(alumno.getIdAlumno()), idEvento));

                request.getRequestDispatcher("/InfoEventos.jsp").forward(request, response);
                break;

            case "cerrar_sesion":
                response.sendRedirect(request.getContextPath() + "/SesionServlet?action=cerrar_sesion");
                break;
        }


    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html");

        //Sesion datos:
        Alumno alumno = (Alumno) request.getSession().getAttribute("usuariologueado");

        String action = request.getParameter("action") == null ? "" : request.getParameter("action");

        switch (action) {
            case "apoyar_evento":
                //saca el id del evento a apoyar
                String idEventoApoyar = request.getParameter("idEventoApoyar") == null ? "" : request.getParameter("idEventoApoyar");
                String idAlumno = String.valueOf(alumno.getIdAlumno());
                alumnoEventoDao.apoyarEvento(idAlumno, idEventoApoyar);

                response.sendRedirect(request.getContextPath() + "/AlumnoServlet?action=mis_eventos");
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
                    response.sendRedirect(request.getContextPath() + "/AlumnoServlet?action=donaciones");
                } else {
                    request.getSession().setAttribute("err", "Tu donación no fue enviada correctamente.");
                    response.sendRedirect(request.getContextPath() + "/AlumnoServlet?action=donaciones");
                }
                break;


        }


    }
}

