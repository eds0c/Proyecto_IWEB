package com.example.proyecto.servlets;

import com.example.proyecto.beans.Alumno;
import com.example.proyecto.beans.AlumnoEvento;
import com.example.proyecto.beans.Evento;
import com.example.proyecto.daos.CredentialsDao;
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

                request.getRequestDispatcher("login/InicioSesion.jsp").forward(request,response);
                break;

            case "olvido_contra":
                request.getRequestDispatcher("login/OlvidoContra.jsp").forward(request,response);
                break;
            case "registro_usuario":
                request.getRequestDispatcher("login/RegistroUsuario.jsp").forward(request,response);
                break;
            case "cambio_contra":
                request.getRequestDispatcher("login/CambiarContra.jsp").forward(request,response);
                break;
            case "cerrar_sesion":
                HttpSession httpSession = request.getSession();
                httpSession.invalidate(); //Lo que hace invalidate es borrar todos los atributos y la sesion la deja en blanco
                request.getRequestDispatcher("login/InicioSesion.jsp").forward(request,response);
                response.sendRedirect(request.getContextPath() + "/SesionServlet");
                break;


        }

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String correo = request.getParameter("username");
        String password = request.getParameter("password");
        System.out.println("username: " + correo + "| password: " + password );

        CredentialsDao credentialsDao = new CredentialsDao();
        if(credentialsDao.validarUsusarioPassword(correo,password)){
            Alumno alumno = credentialsDao.obtenerAlumno(correo); //Obtener al alumno por el correo. Este es el alumno logueado
            HttpSession httpSession = request.getSession();
            httpSession.setAttribute("usuariologueado",alumno); //Guardo el alumno que acaba de iniciar sesion
            System.out.println("usuario y password válidos");
            response.sendRedirect(request.getContextPath() + "/AlumnoServlet");
        }else{
            System.out.println("usuario o password incorrectos");
            request.setAttribute("err","Usuario o password incorrectos "); //Va a mandar este mensaje a login/InicioSesion.jsp
            request.getRequestDispatcher("login/InicioSesion.jsp").forward(request,response);
        }
    }
}

