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
    DelegadoGeneralDao delegadoGeneralDao = new DelegadoGeneralDao();
    DtosDao dtosDao = new DtosDao();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        response.setContentType("text/html");



        //Datos de sesión:
        DelegadoGeneral delegadoGeneral = (DelegadoGeneral) request.getSession().getAttribute("usuariologueado");

        String action = request.getParameter("action") == null ? "main_page" : request.getParameter("action");

        int currentPage=Integer.parseInt(request.getParameter("currentPage")==null?"1":request.getParameter("currentPage"));
        request.setAttribute("currentPageJsp",currentPage);
        int cantidadPaginas;
        int limit;
        int cantidadEgresados;
        int cantidadEstudiantes;


        switch (action){
            case "main_page":
                ArrayList<Alumno> list10 = alumnoDao.listarAlumnoEstado("Egresado", 10000, 0);
                cantidadEgresados=list10.size();
                ArrayList<Alumno> list20 = alumnoDao.listarAlumnoEstado("Estudiante", 10000, 0);
                cantidadEstudiantes=list20.size();
                request.setAttribute("cantidadEgresados", cantidadEgresados);
                request.setAttribute("cantidadEstudiantes", cantidadEstudiantes);
                request.setAttribute("integrantesPorActividadLista", dtosDao.estadisticasIntegrantesPorActividad());
                request.setAttribute("donacionesPorFechaLista", dtosDao.estadisticasDonacionesPorFecha(DateTimeFormatter.ofPattern("yyyy/MM/dd").format(LocalDateTime.now(ZoneId.of("America/New_York"))),10));
                request.setAttribute("sumaDonacionesPorFechaLista", dtosDao.estadisticasDonacionesPorFechaSuma(DateTimeFormatter.ofPattern("yyyy/MM/dd").format(LocalDateTime.now(ZoneId.of("America/New_York"))),10));
                request.getRequestDispatcher("delegGen/MainPage.jsp").forward(request,response);
                break;

            case "perfil":
                request.getRequestDispatcher("delegGen/Perfil.jsp").forward(request,response);
                break;

            case "editar_contra":
                request.getRequestDispatcher("delegGen/EditarContra.jsp").forward(request,response);
                break;

            case "editar_actividades":
                limit = 10;
                ArrayList<DelegadoActividad> list = delegadoActividadDao.listarActividades(limit,(currentPage-1)*limit);
                ArrayList<DelegadoActividad> list2 = delegadoActividadDao.listarActividades(1000,0);
                ArrayList<Alumno> listaAlumnosCandidatos = alumnoDao.listarAlumnosQueNoSonDelegadosDeActividad();
                cantidadPaginas=(list2.size()/limit) +1;
                request.setAttribute("cantidadPaginas", cantidadPaginas);
                //mandar las lista a la vista -> /MainPage.jsp
                request.setAttribute("listaAlumnos_DelegadosActividad",alumnoDao.listarDelegadosDeActividad());
                request.setAttribute("listaActividades",list);
                request.setAttribute("listaAlumnosCandidatos",listaAlumnosCandidatos);
                request.getRequestDispatcher("delegGen/EditarActividades.jsp").forward(request,response);
                break;
            case "validar_donaciones":
                limit = 10;
                ArrayList<Donacion> lista1 = donacionDao.listarDonacionesporEstado("pendiente", limit, (currentPage-1)*limit);
                cantidadPaginas=(donacionDao.cantidadDonacionesPorEstado("pendiente")/limit) +1;
                request.setAttribute("cantidadPaginas", cantidadPaginas);
                request.setAttribute("lista1",lista1);
                request.getRequestDispatcher("delegGen/ValidarDonaciones.jsp").forward(request,response);
                break;

            case "lista_donaciones":
                limit = 10;
                ArrayList<Donacion> lista3 = donacionDao.listarDonacionesporEstado("aprobado", limit, (currentPage-1)*limit);
                cantidadPaginas=(donacionDao.cantidadDonacionesPorEstado("aprobado")/limit) +1;
                request.setAttribute("cantidadPaginas", cantidadPaginas);
                request.setAttribute("lista3",lista3);
                request.getRequestDispatcher("delegGen/ListaDonaciones.jsp").forward(request,response);
                break;

            case "donaciones_rechazadas":
                limit = 10;
                ArrayList<Donacion> lista5 = donacionDao.listarDonacionesporEstado("rechazado", limit, (currentPage-1)*limit);
                cantidadPaginas=(donacionDao.cantidadDonacionesPorEstado("rechazado")/limit) +1;
                request.setAttribute("cantidadPaginas", cantidadPaginas);
                request.setAttribute("lista5",lista5);
                request.getRequestDispatcher("delegGen/DonacionesRechazadas.jsp").forward(request,response);
                break;

            case "validar_registro":
                limit = 10;
                ArrayList<Alumno> listaAlumnosPendientes = alumnoDao.listarAlumnosSegunEstado(3,limit,(currentPage-1)*limit);
                cantidadPaginas=(alumnoDao.cantidadAlumnosPorEstado(3)/limit) +1;
                request.setAttribute("cantidadPaginas", cantidadPaginas);
                request.setAttribute("listaAlumnosPendientes",listaAlumnosPendientes);
                request.getRequestDispatcher("delegGen/ValidarRegistro.jsp").forward(request,response);
                break;

            case "lista_usuarios":
                limit = 10;
                ArrayList<Alumno> listaAlumnosActivos = alumnoDao.listarAlumnosSegunEstado(1,limit,(currentPage-1)*limit);
                cantidadPaginas=(alumnoDao.cantidadAlumnosPorEstado(1)/limit) +1;
                request.setAttribute("cantidadPaginas", cantidadPaginas);
                request.setAttribute("listaAlumnosActivos",listaAlumnosActivos);
                request.getRequestDispatcher("delegGen/ListaUsuarios.jsp").forward(request,response);
                break;

            case "usuarios_rechazados":
                limit = 10;
                ArrayList<Alumno> listaUsuariosRechazados = alumnoDao.listarAlumnosSegunEstado(4,limit,(currentPage-1)*limit);
                cantidadPaginas=(alumnoDao.cantidadAlumnosPorEstado(4)/limit) +1;
                request.setAttribute("cantidadPaginas", cantidadPaginas);
                request.setAttribute("listaUsuariosRechazados",listaUsuariosRechazados);
                request.getRequestDispatcher("delegGen/UsuariosRechazados.jsp").forward(request,response);
                break;

            case "usuarios_baneados":
                limit = 10;
                ArrayList<Alumno> listaUsuariosBaneados = alumnoDao.listarAlumnosSegunEstado(2,limit,(currentPage-1)*limit);
                cantidadPaginas=(alumnoDao.cantidadAlumnosPorEstado(2)/limit) +1;
                request.setAttribute("cantidadPaginas", cantidadPaginas);
                request.setAttribute("listaUsuariosBaneados",listaUsuariosBaneados);
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
                if(actividad.getTitulo().isEmpty() || actividad.getTitulo().length() > 100){
                    request.getSession().setAttribute("errDesc", "El título no cumple con la longitud adecuada. ");
                }

                boolean isAllValid = actividad.getDescripcion().length() <= 200 && actividad.getTitulo().length() <= 100;

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
                InputStream fotoActividadEditada = request.getPart("fotoActividadEditada").getInputStream();
                actividad.setFoto(fotoActividadEditada);
                if(request.getPart("fotoActividad")!=null){
                    actividad.setFoto(request.getPart("fotoActividad").getInputStream());
                }

                Alumno alumnoDelegadoActividadActual = alumnoDao.obtenerAlumno(request.getParameter("idAlumnoDelegadoActividadActual"));
                actividad.setIdActividad(alumnoDelegadoActividadActual.getDelegadoActividad().getActividad().getIdActividad());


                boolean isAllValid2 = actividad.getDescripcion().length() <= 200 && actividad.getTitulo().length() <= 100 && !actividad.getDescripcion().isEmpty() && !actividad.getTitulo().isEmpty();

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
                String motivoAcepto = request.getParameter("motivo");
                // envio de correo
                Alumno alumno1 = alumnoDao.correo(id1);
                alumnoDao.actualizarMotivo(id1,motivoAcepto);
                String asunto = "Has sido aceptado a TeleWeek ";
                String contenido = "Hola, " + alumno1.getNombre() + " " + alumno1.getApellido() + ", has sido aceptado en TeleWeek porque " + motivoAcepto + ", para que puedas participar y donar a la Aitel en esta semana de Ingeniería.";
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
                String motivoRechazo1 = request.getParameter("motivo");
                // envio de correo
                Alumno alumno2 = alumnoDao.correo(id2);
                alumnoDao.actualizarMotivo(id2,motivoRechazo1);
                asunto = "Has sido rechazdo";
                contenido = "Hola, " + alumno2.getNombre() + " " + alumno2.getApellido() + ", has sido rechazado de participar de la semana de Ingeniería porque " + motivoRechazo1 + ".";
                correo = alumno2.getCorreo();
                envioCorreosDaos.createEmail(correo,asunto,contenido);
                envioCorreosDaos.sendEmail();
                break;

            case "revocar_rechazo":

                String id7 = request.getParameter("idAlumnoRevocado");
                alumnoDao.actualizarEstado("1",id7);
                request.getSession().setAttribute("info","Usuario Revocado de Rechazo");
                request.getSession().setAttribute("msg", "Usuario revocado exitosamente");
                response.sendRedirect(request.getContextPath() + "/DelegadoGeneralServlet?action=lista_usuarios");
                String motivoRechazo7 = request.getParameter("motivo");
                // envio de correo
                Alumno alumno7 = alumnoDao.correo(id7);
                alumnoDao.actualizarMotivo(id7,motivoRechazo7);
                asunto = "Has sido revocado";
                contenido = "Hola, " + alumno7.getNombre() + " " + alumno7.getApellido() + ", se te ha revocado el rechazo de participar de la semana de Ingeniería porque " + motivoRechazo7 + ". Podras participar nuevamente...";
                correo = alumno7.getCorreo();
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
                    String motivoBaneo = request.getParameter("motivo");
                    // envio de correo
                    Alumno alumno3 = alumnoDao.correo(id3);
                    alumnoDao.actualizarMotivo(id3,motivoBaneo);
                    asunto = "Has sido baneado";
                    contenido = "Hola, " + alumno3.getNombre() + " " + alumno3.getApellido() + ", has sido baneadoo de participar de la semana de Ingeniería porque " + motivoBaneo + ".";
                    request.getSession().setAttribute("msg", "Usuario baneado exitosamente");
                    correo = alumno3.getCorreo();
                    envioCorreosDaos.createEmail(correo,asunto,contenido);
                    envioCorreosDaos.sendEmail();

                }

                break;

            case "desbaneo_alumno":

                String id10 = request.getParameter("idAlumnoDesbaneado");
                alumnoDao.actualizarEstado("1",id10);
                request.getSession().setAttribute("info","Usuario Desbaneado");
                response.sendRedirect(request.getContextPath() + "/DelegadoGeneralServlet?action=lista_usuarios");
                String motivoDesbaneo = request.getParameter("motivo");
                // envio de correo
                Alumno alumno10 = alumnoDao.correo(id10);
                alumnoDao.actualizarMotivo(id10,motivoDesbaneo);
                asunto = "Has sido desbaneado";
                contenido = "Hola, " + alumno10.getNombre() + " " + alumno10.getApellido() + ", has sido desbaneado de participar de la semana de Ingeniería porque " + motivoDesbaneo + ".";
                request.getSession().setAttribute("msg", "Usuario desbaneado exitosamente");
                correo = alumno10.getCorreo();
                envioCorreosDaos.createEmail(correo,asunto,contenido);
                envioCorreosDaos.sendEmail();

                break;

            case"validar-donacion":

                donacionDao.actualizarEstadoDonacion(request.getParameter("idDonacionValida"),"aprobado");
                request.getSession().setAttribute("msg", "Donación aprobada exitosamente");
                response.sendRedirect(request.getContextPath() + "/DelegadoGeneralServlet?action=validar_donaciones");
                String idAlumnoDonaValido = request.getParameter("idAlumnoDonacionValida");
                String idDonacionValida1 = request.getParameter("idDonacionValida1");
                String motivoValido = request.getParameter("motivo");

                // envio de correo
                Alumno alumno4 = alumnoDao.correo(idAlumnoDonaValido);
                donacionDao.crearMotivo(idDonacionValida1,motivoValido);
                if(alumno4.getEgresado().equals("Estudiante")){
                    asunto = "Donación Validada";
                    contenido = "Hola, " + alumno4.getNombre() + " " + alumno4.getApellido() + ", tu donación ha sido validada, porque " + motivoValido + ". Muchas gracias por donar y apoyar a tu facultad. Saludos.";
                    correo = alumno4.getCorreo();
                    envioCorreosDaos.createEmail(correo,asunto,contenido);
                    envioCorreosDaos.sendEmail();
                }

                if (alumno4.getEgresado().equals("Egresado")){
                    asunto = "Donación Validada";
                    contenido = "Hola, " + alumno4.getNombre() + " " + alumno4.getApellido() + ", tu donación ha sido validada, porque " + motivoValido + ". Ya que usted es un egresado, se le entregará un kit teleco por parte de la Aitel. El lugar donde recogerá este kit será en el pabellón V, en el laboratorio V307. Puede ir a recogerlo desde el día de hoy " + DateTimeFormatter.ofPattern("yyyy/MM/dd").format(LocalDateTime.now(ZoneId.of("America/New_York"))) + ", recuerde que el horario de atención es de las 9 am hasta las 9 pm. Muchas gracias por donar y apoyar a tu facultad. Saludos.";
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
                String idDonacionValida2 = request.getParameter("idDonacionValida2");
                String motivoRechazo = request.getParameter("motivo");

                // envio de correo
                Alumno alumno5 = alumnoDao.correo(idAlumnoDonaInvalido);
                donacionDao.crearMotivo(idDonacionValida2,motivoRechazo);

                if(alumno5.getEgresado().equals("Estudiante")){
                    asunto = "Donación invalidada";
                    contenido = "Hola, " + alumno5.getNombre() + " " + alumno5.getApellido() + ", tu donación ha sido invalidada porque " + motivoRechazo + ". Saludos. ";
                    correo = alumno5.getCorreo();
                    envioCorreosDaos.createEmail(correo,asunto,contenido);
                    envioCorreosDaos.sendEmail();
                }

                if (alumno5.getEgresado().equals("Egresado")){
                    asunto = "Donación revisada";
                    contenido = "Hola, " + alumno5.getNombre() + " " + alumno5.getApellido() + ", tu donación ha sido revisada. Muchas gracias por donar; sin embargo, ya que usted es un egresado, " + motivoRechazo + ". Por este motivo, no se le entregará el kit teleco. Saludos y tenga buen día.";
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


            case "editar_perfil":

                //String emailEditado = request.getParameter("emailEditado");
                String usuarioIdStr = request.getParameter("usuarioId");

                boolean isAllValidEditarPerfil = true;

                if(request.getPart("usuarioFoto") == null){
                    isAllValidEditarPerfil = false;
                    request.getSession().setAttribute("errDesc", "Debe subir una foto. ");
                }

                if(isAllValidEditarPerfil){
                    InputStream usuarioFoto = request.getPart("usuarioFoto").getInputStream();
                    delegadoGeneralDao.actualizarFotoDePerfil(usuarioFoto,usuarioIdStr);
                    request.getSession().setAttribute("msg", "Foto de perfil actualizada exitosamente.");
                    response.sendRedirect(request.getContextPath() + "/DelegadoGeneralServlet?action=perfil");
                }
                else{
                    request.getSession().setAttribute("errDesc", "Debe subir una foto.");
                    response.sendRedirect(request.getContextPath() + "/DelegadoGeneralServlet?action=perfil");
                }
                break;
        }





    }


}

