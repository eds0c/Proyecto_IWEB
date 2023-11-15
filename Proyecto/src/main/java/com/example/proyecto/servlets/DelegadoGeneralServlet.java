package com.example.proyecto.servlets;

import com.example.proyecto.beans.*;
import com.example.proyecto.daos.*;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;

@WebServlet(name = "DelegadoGeneralServlet", value = "/DelegadoGeneralServlet")
public class DelegadoGeneralServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        response.setContentType("text/html");

        //Datos de sesión:
        DelegadoGeneral delegadoGeneral = (DelegadoGeneral) request.getSession().getAttribute("usuariologueado");

        String action = request.getParameter("action") == null ? "main_page" : request.getParameter("action");

        EventoDao eDao = new EventoDao();
        ActividadDao aDao= new ActividadDao();
        DelegadoActividadDao dADao = new DelegadoActividadDao();
        AlumnoDao alumnoDao = new AlumnoDao();

        switch (action){
            case "main_page":
                request.getRequestDispatcher("delegGen/MainPage.jsp").forward(request,response);
                break;

            case "editar_actividades":


                ArrayList<DelegadoActividad> list = dADao.listarActividades(100,0);
                ArrayList<Alumno> listaAlumnosCandidatos = alumnoDao.listarAlumnosQueNoSonDelegadosDeActividad();
                //mandar las lista a la vista -> /MainPage.jsp
                request.setAttribute("listaAlumnos_DelegadosActividad",alumnoDao.listarDelegadosDeActividad());
                request.setAttribute("listaActividades",list);
                request.setAttribute("listaAlumnosCandidatos",listaAlumnosCandidatos);
                request.getRequestDispatcher("delegGen/EditarActividades.jsp").forward(request,response);
                break;
            case "validar_donaciones":

                request.getRequestDispatcher("delegGen/ValidarDonaciones.jsp").forward(request,response);
                break;
            case "validar_registro":
                request.getRequestDispatcher("delegGen/ValidarRegistro.jsp").forward(request,response);
                break;

            case "cerrar_sesion":
                response.sendRedirect(request.getContextPath() + "/SesionServlet");
                break;
        }

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        //Datos de sesión:
        DelegadoGeneral delegadoGeneral = (DelegadoGeneral) request.getSession().getAttribute("usuariologueado");


        //Daos:
        DelecActiDao delecActiDao = new DelecActiDao();
        AlumnoDao alumnoDao = new AlumnoDao();
        AlumnoEventoDao alumnoEventoDao = new AlumnoEventoDao();
        IntegranteDao integranteDao = new IntegranteDao();
        ActividadDao actividadDao = new ActividadDao();
        EventoDao eventoDao = new EventoDao();
        DelegadoActividadDao delegadoActividadDao = new DelegadoActividadDao();

        //Validarcorrectos parámetros: (Aún no implementado)


        String action = request.getParameter("action") == null ? "crear" : request.getParameter("action");

        //creamos la actividad (tabla actividad)
        Actividad actividad = new Actividad();
        actividad.setTitulo(request.getParameter("tituloActividad"));
        actividad.setEstado("activa");
        actividad.setDescripcion(request.getParameter("descripcionActividad"));
        actividad.setFoto(request.getParameter("actividadFoto").getBytes());

        //vinculamos al delegado_actividad(tabla) con la actividad
        DelegadoActividad delegadoActividad = new DelegadoActividad();
        delegadoActividad.setIdDelegadoActividad(actividadDao.obtenerUltimoId());

        //vinculamos al alumno con el id de delegado_actividad(tabla)
        alumnoDao.actualizarIdDelegadoActividad(request.getParameter("idAlumnoDelegadoActividad"),String.valueOf(delegadoActividadDao.obtenerUltimoId()));

        switch (action) {
            case "crear"://voy a crear una nueva Actividad

                actividadDao.crearActividad(actividad);
                delegadoActividadDao.crearDelegadoActividad(String.valueOf(delegadoActividad.getIdDelegadoActividad()));
                alumnoDao.actualizarIdDelegadoActividad(request.getParameter("idAlumnoDelegadoActividad"),String.valueOf(delegadoActividadDao.obtenerUltimoId()));

            case "editar"://voy a editar una actividad


                break;



        }





    }


}

