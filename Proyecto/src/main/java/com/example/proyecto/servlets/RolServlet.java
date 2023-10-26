package com.example.proyecto.servlets;

import com.example.proyecto.beans.AlumnoEvento;
import com.example.proyecto.beans.Evento;
import com.example.proyecto.daos.EventoDao;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.util.ArrayList;

@WebServlet(name = "RolServlet", value = "/RolServlet")
public class RolServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String action = request.getParameter("action") == null ? "default" : request.getParameter("action");

        switch (action){
            case "default":
                request.getRequestDispatcher("/EscogerRol.jsp").forward(request,response);
                break;

            case "alumno":
                response.sendRedirect(request.getContextPath() + "/AlumnoServlet");
                break;
            case "delegado_actividad":
                response.sendRedirect(request.getContextPath() + "/DelegadoActividadServlet");
                break;
            case "delegado_general":
                response.sendRedirect(request.getContextPath() + "/DelegadoGeneralServlet");
                break;


        }

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}

