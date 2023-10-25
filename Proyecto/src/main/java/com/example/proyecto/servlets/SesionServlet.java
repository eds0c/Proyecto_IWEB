package com.example.proyecto.servlets;

import com.example.proyecto.beans.AlumnoEvento;
import com.example.proyecto.beans.Evento;
import com.example.proyecto.daos.EventoDao;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.util.ArrayList;

@WebServlet(name = "SesionServlet", value = "/SesionServlet")
public class SesionServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html");

        String action = request.getParameter("action") == null ? "inicio_sesion" : request.getParameter("action");


        switch (action){
            case "inicio_sesion":

                request.getRequestDispatcher("/InicioSesion.jsp").forward(request,response);
                break;

            case "olvido_contra":
                request.getRequestDispatcher("/OlvidoContra.jsp").forward(request,response);
                break;
            case "registro_usuario":
                request.getRequestDispatcher("/RegistroUsuario.jsp").forward(request,response);
                break;
            case "cambio_contra":
                request.getRequestDispatcher("/CambiarContra.jsp").forward(request,response);
                break;

        }

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}

