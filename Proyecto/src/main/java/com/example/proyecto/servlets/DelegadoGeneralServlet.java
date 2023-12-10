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
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.SimpleTimeZone;
@MultipartConfig

@WebServlet(name = "DelegadoGeneralServlet", value = "/DelegadoGeneralServlet")
public class DelegadoGeneralServlet extends HttpServlet {


    //Daos
    EventoDao eventoDao= new EventoDao();
    ActividadDao actividadDao= new ActividadDao();
    DelegadoActividadDao delegadoActividadDao = new DelegadoActividadDao();
    AlumnoDao alumnoDao = new AlumnoDao();
    DonacionDao donacionDao = new DonacionDao();
    EnvioCorreosDaos envioCorreosDaos = new EnvioCorreosDaos();
    AlumnoEventoDao alumnoEventoDao = new AlumnoEventoDao();
    CredentialsDao credentialsDao = new CredentialsDao();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        response.setContentType("text/html");



        //Datos de sesión:
        DelegadoGeneral delegadoGeneral = (DelegadoGeneral) request.getSession().getAttribute("usuariologueado");

        String action = request.getParameter("action") == null ? "main_page" : request.getParameter("action");



        switch (action){
            case "main_page":
                request.getRequestDispatcher("delegGen/MainPage.jsp").forward(request,response);
                break;

            case "perfil":
                request.getRequestDispatcher("delegGen/Perfil.jsp").forward(request,response);
                break;

            case "editar_contra":
                request.getRequestDispatcher("delegGen/EditarContra.jsp").forward(request,response);
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

                request.setAttribute("lista2",donacionDao.listarDonacionesporEstado("pendiente") );
                request.getRequestDispatcher("delegGen/ValidarDonaciones.jsp").forward(request,response);
                break;

            case "lista_donaciones":
                request.setAttribute("lista1",donacionDao.listarDonacionesporEstado("aprobado"));
                request.getRequestDispatcher("delegGen/ListaDonaciones.jsp").forward(request,response);
                break;

            case "donaciones_rechazadas":
                request.setAttribute("lista3",donacionDao.listarDonacionesporEstado("rechazado"));
                request.getRequestDispatcher("delegGen/DonacionesRechazadas.jsp").forward(request,response);
                break;

            case "validar_registro":
                request.setAttribute("listaAlumnosPendientes",alumnoDao.listarAlumnosSegunEstado(3));
                request.getRequestDispatcher("delegGen/ValidarRegistro.jsp").forward(request,response);
                break;

            case "lista_usuarios":
                request.setAttribute("listaAlumnosActivos",alumnoDao.listarAlumnosSegunEstado(1));
                request.getRequestDispatcher("delegGen/ListaUsuarios.jsp").forward(request,response);
                break;

            case "usuarios_rechazados":
                request.setAttribute("listaUsuariosRechazados",alumnoDao.listarAlumnosSegunEstado(4));
                request.getRequestDispatcher("delegGen/UsuariosRechazados.jsp").forward(request,response);

                break;

            case "usuarios_baneados":
                request.setAttribute("listaUsuariosBaneados",alumnoDao.listarAlumnosSegunEstado(2));
                request.getRequestDispatcher("delegGen/UsuariosBaneados.jsp").forward(request,response);
                break;

            case "cerrar_sesion":
                response.sendRedirect(request.getContextPath() + "/SesionServlet?action=cerrar_sesion");
                break;

            default:
                request.getRequestDispatcher("/error404.jsp").forward(request, response);
                break;
        }

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {


        //Datos de sesión:
        DelegadoGeneral delegadoGeneral = (DelegadoGeneral) request.getSession().getAttribute("usuariologueado");


        //Valida rcorrectos parámetros: (Aún no implementado)


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
                    request.getSession().setAttribute("msg", "Actividad creada exitosamente.");
                    response.sendRedirect(request.getContextPath() + "/DelegadoGeneralServlet?action=editar_actividades");
                } else {
                    request.getSession().setAttribute("err", "Error al actualizar la actividad.");
                    request.getSession().setAttribute("errDesc", "Asegúrese de que no ha dejado campos vacíos o haya excedido los 45 caracteres.");
                    response.sendRedirect(request.getContextPath() + "/DelegadoGeneralServlet?action=editar_actividades");
                }
                break;


            case "editar"://voy a editar una actividad


                actividad.setTitulo(request.getParameter("tituloActividad"));
                actividad.setDescripcion(request.getParameter("descripcionActividad"));
                if(request.getPart("fotoActividad")!=null){
                    actividad.setFoto(request.getPart("fotoActividad").getInputStream());
                }

                Alumno alumnoDelegadoActividadActual = alumnoDao.obtenerAlumno(request.getParameter("idAlumnoDelegadoActividadActual"));
                actividad.setIdActividad(alumnoDelegadoActividadActual.getDelegadoActividad().getActividad().getIdActividad());


                boolean isAllValid2 = actividad.getDescripcion().length() <= 45 && actividad.getTitulo().length() <= 35 && !actividad.getDescripcion().isEmpty() && !actividad.getTitulo().isEmpty();

                if (isAllValid2) {

                    if (request.getParameter("idAlumnoDelegadoActividad").equalsIgnoreCase("0")) {  //Caso de mantener Delegado de Actividad

                        actividadDao.actualizar(actividad);
                        request.getSession().setAttribute("msg", "Actividad actualizada exitosamente.");
                        response.sendRedirect(request.getContextPath() + "/DelegadoGeneralServlet?action=editar_actividades");
                    } else {
                        actividadDao.actualizar(actividad);
                        alumnoDao.actualizarIdDelegadoActividad("eliminar",String.valueOf(alumnoDelegadoActividadActual.getIdAlumno()));
                        alumnoDao.actualizarIdDelegadoActividad(String.valueOf(alumnoDelegadoActividadActual.getDelegadoActividad().getIdDelegadoActividad()),request.getParameter("idAlumnoDelegadoActividad"));
                        request.getSession().setAttribute("msg", "Actividad actualizada exitosamente.");
                        response.sendRedirect(request.getContextPath() + "/DelegadoGeneralServlet?action=editar_actividades");
                    }

                } else {
                    request.getSession().setAttribute("err", "Error al actualizar la actividad.");
                    request.getSession().setAttribute("errDesc", "Asegúrese de que no ha dejado campos vacíos o haya excedido los 45 caracteres.");
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
                request.getSession().setAttribute("msg", "Actividad eliminada exitosamente.");
                response.sendRedirect(request.getContextPath() + "/DelegadoGeneralServlet?action=editar_actividades");
                break;


            case "acepto_registro":

                String id1 = request.getParameter("idAlumnoAceptado");
                alumnoDao.actualizarEstado("1",id1);
                request.getSession().setAttribute("info","Usuario Aceptado");
                request.getSession().setAttribute("msg", "Usuario Aceptado exitosamente");
                response.sendRedirect(request.getContextPath() + "/DelegadoGeneralServlet?action=lista_usuarios");
                // envio de correo
                Alumno alumno1 = alumnoDao.correo(id1);
                String asunto = "Has sido aceptado a TeleWeek ";
                String contenido = "Hola, " + alumno1.getNombre() + " " + alumno1.getApellido() + ", has sido aceptado en TeleWeek, para que puedas participar y donar a la Aitel en esta semana de Ingeniería.";
                String correo = alumno1.getCorreo();
                envioCorreosDaos.createEmail(correo,asunto,contenido);
                envioCorreosDaos.sendEmail();
                break;

            case "rechazo_registro":

                String id2 = request.getParameter("idAlumnoRechazado");
                alumnoDao.actualizarEstado("4",id2);
                request.getSession().setAttribute("info","Usuario Rechazado");
                request.getSession().setAttribute("msg", "Usuario Rechazado exitosamente");
                response.sendRedirect(request.getContextPath() + "/DelegadoGeneralServlet?action=lista_usuarios");
                // envio de correo
                Alumno alumno2 = alumnoDao.correo(id2);
                asunto = "Has sido rechazdo";
                contenido = "Hola, " + alumno2.getNombre() + " " + alumno2.getApellido() + ", has sido rechazado de participar de la semana de Ingeniería.";
                correo = alumno2.getCorreo();
                envioCorreosDaos.createEmail(correo,asunto,contenido);
                envioCorreosDaos.sendEmail();
                break;

            case "baneo_alumno":

                String id3 = request.getParameter("idAlumnoBaneado");

                if(alumnoDao.obtenerAlumno(id3).getDelegadoActividad().getActividad() != null){
                    Alumno preBan = alumnoDao.obtenerAlumno(id3);
                    request.getSession().setAttribute("err", "No se pudo banear al usuario.");
                    request.getSession().setAttribute("errDesc", "El usuario es un delegado de actividad. Primero asegúrese de seleccionar a un nuevo delegado de la actividad: " + preBan.getDelegadoActividad().getActividad().getTitulo()+".");
                    response.sendRedirect(request.getContextPath() + "/DelegadoGeneralServlet?action=lista_usuarios");
                }
                else{
                    alumnoDao.actualizarEstado("2",id3);
                    request.getSession().setAttribute("info","Usuario Baneado");
                    response.sendRedirect(request.getContextPath() + "/DelegadoGeneralServlet?action=lista_usuarios");
                    // envio de correo
                    Alumno alumno3 = alumnoDao.correo(id3);
                    asunto = "Has sido baneado";
                    contenido = "Hola, " + alumno3.getNombre() + " " + alumno3.getApellido() + ", has sido baneadoo de participar de la semana de Ingeniería.";
                    request.getSession().setAttribute("msg", "Usuario baneado exitosamente");
                    correo = alumno3.getCorreo();
                    envioCorreosDaos.createEmail(correo,asunto,contenido);
                    envioCorreosDaos.sendEmail();

                }

                break;

            case"validar-donacion":

                donacionDao.actualizarEstadoDonacion(request.getParameter("idDonacionValida"),"aprobado");
                request.getSession().setAttribute("msg", "Donación aprobada exitosamente");
                response.sendRedirect(request.getContextPath() + "/DelegadoGeneralServlet?action=validar_donaciones");
                String idAlumnoDonaValido = request.getParameter("idAlumnoDonacionValida");

                // envio de correo
                Alumno alumno4 = alumnoDao.correo(idAlumnoDonaValido);
                if(alumno4.getEgresado().equals("Estudiante")){
                    asunto = "Donación Validada";
                    contenido = "Hola, " + alumno4.getNombre() + " " + alumno4.getApellido() + ", tu donación ha sido validada. Muchas gracias por donar y apoyar a tu facultad. Saludos.";
                    correo = alumno4.getCorreo();
                    envioCorreosDaos.createEmail(correo,asunto,contenido);
                    envioCorreosDaos.sendEmail();
                }

                if (alumno4.getEgresado().equals("Egresado")){
                    asunto = "Donación Validada";
                    contenido = "Hola, " + alumno4.getNombre() + " " + alumno4.getApellido() + ", tu donación ha sido validada. Ya que usted es un egresado, se le entregará un kit teleco por parte de la Aitel. El lugar donde recogerá este kit será en el pabellón V, en el laboratorio V307. Puede ir a recogerlo desde el día de hoy " + DateTimeFormatter.ofPattern("yyyy/MM/dd").format(LocalDateTime.now(ZoneId.of("America/New_York"))) + ", recuerde que el horario de atención es de las 9 am hasta las 9 pm. Muchas gracias por donar y apoyar a tu facultad. Saludos.";
                    correo = alumno4.getCorreo();
                    envioCorreosDaos.createEmail(correo,asunto,contenido);
                    envioCorreosDaos.sendEmail();
                }


                break;

            case"rechazar-donacion":

                donacionDao.actualizarEstadoDonacion(request.getParameter("idDonacionRechazada"),"rechazado");
                request.getSession().setAttribute("msg", "Donación rechazada exitosamente");
                response.sendRedirect(request.getContextPath() + "/DelegadoGeneralServlet?action=validar_donaciones");

                String idAlumnoDonaInvalido = request.getParameter("idAlumnoDonacionInvalida");
                // envio de correo
                Alumno alumno5 = alumnoDao.correo(idAlumnoDonaInvalido);

                if(alumno5.getEgresado().equals("Estudiante")){
                    asunto = "Donación invalidada";
                    contenido = "Hola, " + alumno5.getNombre() + " " + alumno5.getApellido() + ", tu donación ha sido invalidada porque no cumple con el monto requerido o ha adjuntado un comprobante inválido. Saludos. ";
                    correo = alumno5.getCorreo();
                    envioCorreosDaos.createEmail(correo,asunto,contenido);
                    envioCorreosDaos.sendEmail();
                }

                if (alumno5.getEgresado().equals("Egresado")){
                    asunto = "Donación revisada";
                    contenido = "Hola, " + alumno5.getNombre() + " " + alumno5.getApellido() + ", tu donación ha sido revisada. Muchas gracias por donar; sin embargo, ya que usted es un egresado, el monto a donar no tiene que ser menor a 100 nuevos soles. Por este motivo, no se le entregará el kit teleco. Saludos y tenga buen día.";
                    correo = alumno5.getCorreo();
                    envioCorreosDaos.createEmail(correo,asunto,contenido);
                    envioCorreosDaos.sendEmail();
                }
                break;

            case "cambiar_contra":

                String contra1 = request.getParameter("contra1");
                String contra2 = request.getParameter("contra2");

                boolean isAllValid6 = true;

                if(!credentialsDao.validarContrasenaDelegadoGeneral(String.valueOf(delegadoGeneral.getIdDelegadoGeneral()), request.getParameter("contraActual"))){
                    request.getSession().setAttribute("err", "No se pudo cambiar la contraseña.");
                    request.getSession().setAttribute("errDesc", "Las contraseña actual no es correcta");
                    isAllValid6 = false;
                }


                if(contra1.length() < 8 || contra2.length() < 8){
                    isAllValid6 = false;
                    request.getSession().setAttribute("errDesc", "Las contraseñas deben tener al menos 8 caracteres");
                }

                if(!contra1.equals(contra2)){
                    isAllValid6 = false;
                    request.getSession().setAttribute("errDesc", "Las contraseñas deben ser iguales");
                }

                if (isAllValid6) {
                    credentialsDao.actualizarContrasenaDelegadoGeneral(String.valueOf(delegadoGeneral.getIdDelegadoGeneral()),contra1);
                    request.getSession().setAttribute("msg", "Se actualizó la contraseña correctamente");
                    response.sendRedirect(request.getContextPath() + "/DelegadoGeneralServlet?action=editar_contra");

                } else {
                    request.getSession().setAttribute("err", "No se pudo cambiar la contraseña.");
                    response.sendRedirect(request.getContextPath() + "/DelegadoGeneralServlet?action=editar_contra");
                }


                break;

        }





    }


}

