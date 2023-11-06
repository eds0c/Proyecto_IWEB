package com.example.proyecto.servlets;

import com.example.proyecto.beans.AlumnoEvento;
import com.example.proyecto.beans.Evento;
import com.example.proyecto.daos.DelecActiDao;
import com.example.proyecto.daos.EventoDao;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.io.InputStream;
import java.sql.Date;
import java.sql.Time;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;

@WebServlet(name = "DelegadoActividadServlet", value = "/DelegadoActividadServlet")
public class DelegadoActividadServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        response.setContentType("text/html");
        String action = request.getParameter("action") == null ? "main_page" : request.getParameter("action");
        EventoDao eDao = new EventoDao();
        switch (action) {
            case "main_page":
                //saca la lista de eventos según actividad
                String idAct = request.getParameter("idAct") == null ? "1" : request.getParameter("idAct"); //click
                ArrayList<Evento> list = eDao.listarPorActividad(idAct, "a");

                //mandar la lista a la vista -> /MainPage.jsp
                request.setAttribute("lista", list);
                RequestDispatcher rd = request.getRequestDispatcher("delegAct/MainPage.jsp");
                rd.forward(request, response);
                break;

            case "mis_eventos":
                //saca del modelo
                ArrayList<AlumnoEvento> list_mis_eventos = eDao.listarPorAlumno("1"); //

                //mandar la lista a la vista -> /MisEventos.jsp
                request.setAttribute("lista_mis_eventos", list_mis_eventos);
                request.getRequestDispatcher("delegAct/MisEventos.jsp").forward(request, response);
                break;
            case "eventos_finalizados":
                //saca la lista de eventos finalizados

                ArrayList<Evento> listaEventosFinalizados = eDao.listarEventosSegunEstado("f", 100, 0); //

                //mandar la lista a la vista -> /MainPage.jsp
                request.setAttribute("lista_eventos_finalizados", listaEventosFinalizados);
                request.getRequestDispatcher("delegAct/EventFinalizados.jsp").forward(request, response);
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

                request.getRequestDispatcher("delegAct/InfoEvento.jsp").forward(request,response);
                break;
            case "mi_actividad":
                String iddEvento = request.getParameter("idEvento") == null ? "1" : request.getParameter("idEvento");

                Evento eevento = eDao.buscarEvento(iddEvento);
                ArrayList<Evento> lista3 = eDao.listarEventos(iddEvento,4,0);

                //mandar la lista a la vista -> /InfoEventos.jsp
                request.setAttribute("eevento",eevento);
                request.setAttribute("lista3",lista3);
                request.getRequestDispatcher("delegAct/MiActividad.jsp").forward(request, response);
                break;
            case "participantes":

                request.getRequestDispatcher("delegAct/Participantes.jsp").forward(request, response);
                break;
            case "cerrar_sesion":
                response.sendRedirect(request.getContextPath() + "/SesionServlet");
                break;

        }

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html");
        // Request es una solicitud y response es para generar una respuesta

        DelecActiDao delecActiDao = new DelecActiDao();

        String action = request.getParameter("action") == null ? "crear" : request.getParameter("action");

        switch (action) {
            case "crear"://voy a crear un nuevo evento

                String eventoFotoStr = request.getParameter("eventoFoto");
                String eventoDescripcion = request.getParameter("eventoDescripcion");
                String eventoFecha = request.getParameter("eventoFecha");

                String eventoHora = request.getParameter("eventoHora");
                String eventoLugar = request.getParameter("eventoLugar");




                boolean isAllValid = true;

                if (eventoDescripcion.length() > 45) {
                    isAllValid = false;
                }

                if (isAllValid) {

                    Evento evento = delecActiDao.buscarPorDescripcion(eventoDescripcion); //Busca si hay un evento con el mismo nombre
                    //Creamos Trabajador
                    if (evento == null) {  //Se verifica que no se repita el evento

                        // Parsear la Foto a Byte
                        byte[] eventoFoto = eventoFotoStr.getBytes();
                        int IdActividad = 1;
                        delecActiDao.crear(eventoFoto, eventoDescripcion, eventoFecha, eventoHora, eventoLugar,IdActividad);
                        response.sendRedirect(request.getContextPath() + "/DelegadoActividadServlet?action=mi_actividad"); //Una vez creado y dado click a submit se devuelve a la página donde está la lista
                    } else {
                        request.getRequestDispatcher("delegAct/MiActividad.jsp").forward(request, response);
                    }
                } else {
                    request.getRequestDispatcher("delegAct/MiActividad.jsp").forward(request, response);
                }
                break;
        }

    }
}

