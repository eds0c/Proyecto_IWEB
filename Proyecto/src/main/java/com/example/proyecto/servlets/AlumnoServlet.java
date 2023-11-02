package com.example.proyecto.servlets;

import com.example.proyecto.beans.AlumnoEvento;
import com.example.proyecto.beans.Evento;
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


       response.setContentType("text/html");

       String action = request.getParameter("action") == null ? "main_page" : request.getParameter("action");

       EventoDao eDao = new EventoDao();

       switch (action){
          case "main_page":
             //saca la lista de eventos según actividad
              String idAct = request.getParameter("idAct") == null ? "1" : request.getParameter("idAct");
             ArrayList<Evento> list = eDao.listarPorActividad(idAct);

             //mandar la lista a la vista -> /MainPage.jsp
             request.setAttribute("lista",list);
             RequestDispatcher rd = request.getRequestDispatcher("/MainPage.jsp");
             rd.forward(request,response);
             break;

          case "mis_eventos":
              //saca del modelo
              ArrayList<AlumnoEvento> list_mis_eventos = eDao.listarPorAlumno("1");

              //mandar la lista a la vista -> /MisEventos.jsp
              request.setAttribute("lista_mis_eventos",list_mis_eventos);
              request.getRequestDispatcher("/MisEventos.jsp").forward(request,response);
              break;
          case "eventos_finalizados":
              //saca la lista de eventos finalizados

              ArrayList<Evento> listaEventosFinalizados = eDao.listarEventosSegunEstado("f",100,0);

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

               request.getRequestDispatcher("/InfoEventos.jsp").forward(request,response);
               break;

           case "cerrar_sesion":
               response.sendRedirect(request.getContextPath() + "/SesionServlet");
               break;
       }



    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}

