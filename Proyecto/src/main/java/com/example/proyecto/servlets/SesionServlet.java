package com.example.proyecto.servlets;

import com.example.proyecto.beans.*;
import com.example.proyecto.daos.*;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import jakarta.servlet.annotation.MultipartConfig;

import java.io.InputStream;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.time.LocalDateTime;

import java.io.IOException;
import java.util.ArrayList;

@MultipartConfig

@WebServlet(name = "SesionServlet", value = {"/SesionServlet",""})
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
                response.sendRedirect(request.getContextPath() + "/SesionServlet");
                break;


        }

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String correo = request.getParameter("username");
        String password = request.getParameter("password");
        System.out.println("username: " + correo + "| password: " + password );

        //Herramientas:
        CredentialsDao credentialsDao = new CredentialsDao();
        DelegadoActividadDao delegadoActividadDao = new DelegadoActividadDao();
        DelegadoGeneralDao delegadoGeneralDao = new DelegadoGeneralDao();
        EstadoAlumnoDao estadoAlumnoDao = new EstadoAlumnoDao();
        AlumnoDao alumnoDao = new AlumnoDao();



        String action = request.getParameter("action");


        switch (action){
            case "inicio_sesion":
                HttpSession httpSession = request.getSession();

                int tipoUsuario=credentialsDao.validarUsuarioPassword(correo,password);//1: alumno | 2: delegado de actividad | 3: delegado general | 0:no encontrado

                switch (tipoUsuario){
                    case 0:
                        request.setAttribute("err","Usuario o password incorrectos "); //Va a mandar este mensaje a login/InicioSesion.jsp
                        request.getRequestDispatcher("login/InicioSesion.jsp").forward(request,response);
                        break;
                    case 1:
                        Alumno alumno = credentialsDao.obtenerAlumno(correo); //Obtener al alumno por el correo. Este es el alumno logueado
                        httpSession.setAttribute("usuariologueado",alumno); //Guardo el alumno que acaba de iniciar sesion
                        httpSession.setAttribute("tipoUsuario",1); //Para validar después en los servlets (anti copiar urls)
                        response.sendRedirect(request.getContextPath() + "/AlumnoServlet");
                        break;
                    case 2:
                        Alumno alumno2 = credentialsDao.obtenerAlumno(correo); //Obtener al alumno por el correo. Este es el alumno logueado
                        DelegadoActividad delegadoActividad = alumno2.getDelegadoActividad();
                        httpSession.setAttribute("usuariologueado",alumno2); //Guardo el alumno que acaba de iniciar sesion
                        httpSession.setAttribute("DelegadoActividad",delegadoActividad); //Guardo la tabla que relaciona al alumno con la actividad
                        httpSession.setAttribute("tipoUsuario",2); //Para validar después en los servlets (anti copiar urls)
                        response.sendRedirect(request.getContextPath() + "/DelegadoActividadServlet");
                        break;
                    case 3:

                        DelegadoGeneral delegadoGeneral = credentialsDao.obtenerDelegadoGeneral(correo);
                        httpSession.setAttribute("usuariologueado",delegadoGeneral); //Guardo el alumno que acaba de iniciar sesion
                        httpSession.setAttribute("tipoUsuario",3); //Para validar después en los servlets (anti copiar urls)
                        response.sendRedirect(request.getContextPath() + "/DelegadoGeneralServlet");
                        break;

                }
                break;

            case "olvido_contra":
                request.getRequestDispatcher("login/OlvidoContra.jsp").forward(request,response);
                break;
            case "registro_usuario":

                Alumno alumnoRegistrar = new Alumno();

                alumnoRegistrar.setNombre(request.getParameter("nombre"));
                alumnoRegistrar.setApellido(request.getParameter("apellido"));
                alumnoRegistrar.setCodigo(request.getParameter("codigo"));
                alumnoRegistrar.setCorreo(request.getParameter("correo"));
                alumnoRegistrar.setContrasena(request.getParameter("password"));
                alumnoRegistrar.setEgresado(request.getParameter("estadoAcademico"));
                alumnoRegistrar.setFoto(request.getPart("foto").getInputStream());
                alumnoRegistrar.setEstadoAlumno(estadoAlumnoDao.obtenerEstadoAlumno("3")); // se le asigna el estado de pendiente (luego será revisado por el delegado general)

                alumnoDao.crearAlumno(alumnoRegistrar); //crear el alumno en la base de datos

                response.sendRedirect(request.getContextPath() + "/SesionServlet");
                break;


        }
    }
}

