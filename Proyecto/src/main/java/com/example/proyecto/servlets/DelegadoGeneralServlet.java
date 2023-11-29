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

        EventoDao eventoDao= new EventoDao();
        ActividadDao actividadDao= new ActividadDao();
        DelegadoActividadDao delegadoActividadDao = new DelegadoActividadDao();
        AlumnoDao alumnoDao = new AlumnoDao();
        DonacionDao donacionDao = new DonacionDao();
        EnvioCorreosDaos envioCorreosDaos = new EnvioCorreosDaos();

        switch (action){
            case "main_page":
                request.getRequestDispatcher("delegGen/MainPage.jsp").forward(request,response);
                break;

            case "editar_actividades":


                ArrayList<DelegadoActividad> list = delegadoActividadDao.listarActividades(100,0);
                ArrayList<Alumno> listaAlumnosCandidatos = alumnoDao.listarAlumnosQueNoSonDelegadosDeActividad();
                //mandar las lista a la vista -> /MainPage.jsp
                request.setAttribute("listaAlumnos_DelegadosActividad",alumnoDao.listarDelegadosDeActividad());
                request.setAttribute("listaActividades",list);
                request.setAttribute("listaAlumnosCandidatos",listaAlumnosCandidatos);
                request.getRequestDispatcher("delegGen/EditarActividades.jsp").forward(request,response);
                break;
            case "validar_donaciones":

                request.setAttribute("lista2",new ArrayList<Donacion>() );
                request.getRequestDispatcher("delegGen/ValidarDonaciones.jsp").forward(request,response);
                break;
            case "validar_registro":

                request.setAttribute("listaAlumnosPendientes",alumnoDao.listarAlumnosSegunEstado(3));
                request.setAttribute("listaAlumnosActivos",alumnoDao.listarAlumnosSegunEstado(1));
                request.getRequestDispatcher("delegGen/ValidarRegistro.jsp").forward(request,response);
                break;

            case "acepto-registro":

                String id1 = request.getParameter("id1");
                alumnoDao.habilitarCuenta(id1);
                request.getSession().setAttribute("info","Usuario Aceptado");
                // envio de correo
                Alumno alumno1 = alumnoDao.correo(id1);
                String asunto = "Has sido aceptado a TeleWeek ";
                String contenido = "Hola," + alumno1.getNombre() + " " + alumno1.getApellido() + ", has sido aceptado en TeleWeek, para que puedas participar y donar a la Aitel en esta semana de Ingeniería.";
                String correo = alumno1.getCorreo();
                envioCorreosDaos.createEmail(correo,asunto,contenido);
                response.sendRedirect(request.getContextPath() + "/DelegadoGeneralServlet?action=main_page");
                envioCorreosDaos.sendEmail();
                break;

            case "rechazo-registro":

                String id2 = request.getParameter("id2");
                alumnoDao.deshabilitarCuenta(id2);
                request.getSession().setAttribute("info","Usuario Rechazado");
                // envio de correo
                Alumno alumno2 = alumnoDao.correo(id2);
                asunto = "Has sido rechazdo";
                contenido = "Hola," + alumno2.getNombre() + " " + alumno2.getApellido() + ", has sido rechazado de participar de la semana de Ingeniería.";
                correo = alumno2.getCorreo();
                envioCorreosDaos.createEmail(correo,asunto,contenido);
                response.sendRedirect(request.getContextPath() + "/DelegadoGeneralServlet?action=main_page");
                envioCorreosDaos.sendEmail();
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
        Actividad actividad = new Actividad();


        switch (action) {
            case "crear"://voy a crear una nueva Actividad

                //creamos la actividad (tabla actividad)

                actividad.setTitulo(request.getParameter("tituloActividad"));
                actividad.setEstado("activa");
                actividad.setDescripcion(request.getParameter("descripcionActividad"));
                if(request.getPart("fotoActividad")!=null){
                    actividad.setFoto(request.getPart("fotoActividad").getInputStream());
                }

                boolean isAllValid = actividad.getDescripcion().length() <= 45 && actividad.getTitulo().length() <= 35;

                if (isAllValid) {
                    actividadDao.crearActividad(actividad);
                    //vinculamos al delegado_actividad(tabla) con la actividad
                    delegadoActividadDao.crearDelegadoActividad(String.valueOf(actividadDao.obtenerUltimoId()));
                    alumnoDao.actualizarIdDelegadoActividad(String.valueOf(delegadoActividadDao.obtenerUltimoId()),request.getParameter("idAlumnoDelegadoActividad"));
                    response.sendRedirect(request.getContextPath() + "/DelegadoGeneralServlet?action=editar_actividades");
                } else {
                    response.sendRedirect(request.getContextPath() + "/DelegadoGeneralServlet?action=editar_actividades");
                }
                break;


            case "editar"://voy a editar una actividad


                actividad.setTitulo(request.getParameter("tituloActividad"));
                if(request.getParameter("estadoActividad")!=null){
                    actividad.setEstado(request.getParameter("estadoActividad"));
                }
                actividad.setDescripcion(request.getParameter("descripcionActividad"));
                if(request.getPart("fotoActividad")!=null){
                    actividad.setFoto(request.getPart("fotoActividad").getInputStream());
                }

                Alumno alumnoDelegadoActividadActual = alumnoDao.obtenerAlumno(request.getParameter("idAlumnoDelegadoActividadActual"));
                actividad.setIdActividad(alumnoDelegadoActividadActual.getDelegadoActividad().getActividad().getIdActividad());


                boolean isAllValid2 = actividad.getDescripcion().length() <= 45 && actividad.getTitulo().length() <= 35;

                if (isAllValid2) {

                    if (request.getParameter("idAlumnoDelegadoActividad").equalsIgnoreCase("0")) {  //Caso de mantener Delegado de Actividad

                        actividadDao.actualizar(actividad);
                        response.sendRedirect(request.getContextPath() + "/DelegadoGeneralServlet?action=editar_actividades");
                    } else {
                        actividadDao.actualizar(actividad);
                        alumnoDao.actualizarIdDelegadoActividad("eliminar",String.valueOf(alumnoDelegadoActividadActual.getIdAlumno()));
                        alumnoDao.actualizarIdDelegadoActividad(String.valueOf(alumnoDelegadoActividadActual.getDelegadoActividad().getIdDelegadoActividad()),request.getParameter("idAlumnoDelegadoActividad"));
                        response.sendRedirect(request.getContextPath() + "/DelegadoGeneralServlet?action=editar_actividades");
                    }
                } else {
                    response.sendRedirect(request.getContextPath() + "/DelegadoGeneralServlet?action=editar_actividades");
                }
                break;



            case "eliminar_actividad":

                //Parámetros:
                String idAlumnoDelegadoActividadEliminar = request.getParameter("idAlumnoDelegadoActividadEliminar");
                String idDelegadoActividadEliminar = request.getParameter("idDelegadoActividadEliminar");
                String idActividadEliminar = request.getParameter("idActividadEliminar");

                alumnoDao.actualizarIdDelegadoActividad("eliminar",idAlumnoDelegadoActividadEliminar);
                delegadoActividadDao.eliminar(idDelegadoActividadEliminar);
                eventoDao.eliminarPorActividad(idActividadEliminar);
                actividadDao.eliminar(idActividadEliminar);
                response.sendRedirect(request.getContextPath() + "/DelegadoGeneralServlet?action=editar_actividades");
                break;

            case "validar_registro":

                int cantidadAlumnosPendientes = Integer.parseInt(request.getParameter("cantidad"));

                for(int i = 1; i<=cantidadAlumnosPendientes;i++){

                    String idPendiente = request.getParameter("idPendiente"+i) == null ? "0" : request.getParameter("idPendiente"+i);
                    String estadoAsignar = request.getParameter("estadoAsignar"+i);
                    alumnoDao.actualizarEstado(estadoAsignar,idPendiente);
                }
                response.sendRedirect(request.getContextPath() + "/DelegadoActividadServlet?action=validar_registro");
                break;


        }





    }


}

