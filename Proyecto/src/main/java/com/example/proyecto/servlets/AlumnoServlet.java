package com.example.proyecto.servlets;

import com.example.proyecto.beans.Alumno;
import com.example.proyecto.beans.AlumnoEvento;
import com.example.proyecto.beans.DelegadoActividad;
import com.example.proyecto.beans.Evento;
import com.example.proyecto.daos.AlumnoEventoDao;
import com.example.proyecto.daos.DelegadoActividadDao;
import com.example.proyecto.daos.EventoDao;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.util.ArrayList;


@WebServlet(name = "AlumnoServlet", value = "/AlumnoServlet")
public class AlumnoServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        //Sesion datos:
        //Alumno alumno = (Alumno) request.getAttribute("usuariologueado");
        Alumno alumno = (Alumno) request.getSession().getAttribute("usuariologueado");
        String IdAlumno = String.valueOf(alumno.getIdAlumno());
        System.out.println("Id Alumno: " + IdAlumno);
        String idAlumno = "1";


       response.setContentType("text/html");

       String action = request.getParameter("action") == null ? "main_page" : request.getParameter("action");

       EventoDao eDao = new EventoDao();
       AlumnoEventoDao alumnoEventoDao = new AlumnoEventoDao();
        DelegadoActividadDao delegadoActividadDao = new DelegadoActividadDao();


       switch (action){
          case "main_page":
             //saca la lista de eventos según actividad
              String idAct = request.getParameter("idAct") == null ? "1" : request.getParameter("idAct"); //click
             ArrayList<Evento> list = eDao.listarPorActividad(idAct,"a",100,0);
              //saca la lista de actividades
              ArrayList<DelegadoActividad> listDelegadoActividad = delegadoActividadDao.listarActividades(100,0);


             //mandar las listas a la vista -> /MainPage.jsp
             request.setAttribute("lista",list);
             request.setAttribute("listaActividades", listDelegadoActividad);
             RequestDispatcher rd = request.getRequestDispatcher("/MainPage.jsp");
             rd.forward(request,response);
             break;

          case "mis_eventos":
              //saca del modelo"

              ArrayList<AlumnoEvento> list_mis_eventos = eDao.listarPorAlumno(String.valueOf(alumno.getIdAlumno()),"a",100,0); //

              //mandar la lista a la vista -> /MisEventos.jsp
              request.setAttribute("lista_mis_eventos",list_mis_eventos);
              request.getRequestDispatcher("/MisEventos.jsp").forward(request,response);
              break;
          case "eventos_finalizados":
              //saca la lista de eventos finalizados

              ArrayList<AlumnoEvento> listaEventosFinalizados = eDao.listarPorAlumno("1","f",100,0); //

              //mandar la lista a la vista -> /MainPage.jsp
              request.setAttribute("lista_eventos_finalizados",listaEventosFinalizados);
              request.getRequestDispatcher("/EventosFinalizados.jsp").forward(request,response);
              break;
          case "donaciones":
              request.getRequestDispatcher("/Donaciones.jsp").forward(request,response);
              break;

           case "info_eventos":

               String idEvento = request.getParameter("idEvento") == null ? "1" : request.getParameter("idEvento");

               Evento evento = eDao.buscarEvento(idEvento);
               ArrayList<Evento> lista2 = eDao.listarEventos(idEvento,4,0);

               //mandar la lista a la vista -> /InfoEventos.jsp
               request.setAttribute("evento",evento);
               request.setAttribute("lista2",lista2);
               request.setAttribute("participando",alumnoEventoDao.comprobarParticipacionEvento(idAlumno,idEvento));

               request.getRequestDispatcher("/InfoEventos.jsp").forward(request,response);
               break;

           case "cerrar_sesion":
               response.sendRedirect(request.getContextPath() + "/SesionServlet");
               break;
       }



    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        //Daos

        AlumnoEventoDao alumnoEventoDao = new AlumnoEventoDao();


        String action = request.getParameter("action") == null ? "" : request.getParameter("action");

        switch (action){
            case "apoyar_evento":
                //saca el id del evento a apoyar
                String idEventoApoyar = request.getParameter("idEventoApoyar") == null ? "" : request.getParameter("idEventoApoyar");
                String idAlumno = "2";
                alumnoEventoDao.apoyarEvento(idAlumno,idEventoApoyar);

                response.sendRedirect(request.getContextPath() + "/AlumnoServlet?action=info_eventos");
                break;

        }


    }
}

