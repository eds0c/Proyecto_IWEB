package com.example.proyecto.servlets;

import com.example.proyecto.beans.*;
import com.example.proyecto.daos.*;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import jakarta.servlet.annotation.MultipartConfig;

import java.io.IOException;
import java.io.InputStream;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.SimpleTimeZone;
@MultipartConfig

@WebServlet(name = "DelegadoGeneralServlet", value = "/DelegadoGeneralServlet")
public class DelegadoGeneralServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        response.setContentType("text/html");

        //VALIDAR SESIÓN
        if (request.getSession().getAttribute("tipoUsuario")==null || (Integer) request.getSession().getAttribute("tipoUsuario")!=3){
            response.sendRedirect(request.getContextPath() + "/SesionServlet?action=cerrar_sesion");
        }

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
                response.sendRedirect(request.getContextPath() + "/SesionServlet?action=cerrar_sesion");
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


        String action = request.getParameter("action");



        switch (action) {
            case "crear"://voy a crear una nueva Actividad

                //creamos la actividad (tabla actividad)
                Actividad actividad = new Actividad();
                actividad.setTitulo(request.getParameter("tituloActividad"));
                actividad.setEstado("activa");
                actividad.setDescripcion(request.getParameter("descripcionActividad"));
                actividad.setFoto(request.getPart("fotoActividad").getInputStream());


                actividadDao.crearActividad(actividad);
                //vinculamos al delegado_actividad(tabla) con la actividad
                delegadoActividadDao.crearDelegadoActividad(String.valueOf(actividadDao.obtenerUltimoId()));
                alumnoDao.actualizarIdDelegadoActividad(String.valueOf(delegadoActividadDao.obtenerUltimoId()),request.getParameter("idAlumnoDelegadoActividad"));
                response.sendRedirect(request.getContextPath() + "/DelegadoGeneralServlet?action=editar_actividades");
            case "editar"://voy a editar una actividad


                break;
            case "eliminar_actividad":

                //Parámetros:
                String idAlumnoDelegadoActividadEliminar = request.getParameter("idAlumnoDelegadoActividadEliminar");
                String idDelegadoActividadEliminar = request.getParameter("idDelegadoActividadEliminar");
                String idActividadEliminar = request.getParameter("idActividadEliminar");

                alumnoDao.actualizarIdDelegadoActividad("eliminar",idAlumnoDelegadoActividadEliminar);
                delegadoActividadDao.eliminar(idDelegadoActividadEliminar);
                actividadDao.eliminar(idActividadEliminar);
                response.sendRedirect(request.getContextPath() + "/DelegadoGeneralServlet?action=editar_actividades");
                break;


        }





    }


}

