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
             //saca del modelo
             ArrayList<Evento> list = eDao.listarPorActividad("1");

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
              request.getRequestDispatcher("/EventosFinalizados.jsp").forward(request,response);
              break;
          case "donaciones":
              request.getRequestDispatcher("/Donaciones.jsp").forward(request,response);
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

