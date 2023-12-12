package com.example.proyecto.servlets;

import com.example.proyecto.beans.*;
import com.example.proyecto.daos.*;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import jakarta.servlet.annotation.MultipartConfig;

import javax.sound.midi.Soundbank;
import java.io.IOException;
import java.io.InputStream;
import java.sql.*;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.time.format.DateTimeFormatter;
import java.time.format.DateTimeFormatterBuilder;
import java.util.ArrayList;
import java.util.SimpleTimeZone;
@MultipartConfig
@WebServlet(name = "DelegadoActividadServlet", value = "/DelegadoActividadServlet")
public class DelegadoActividadServlet extends HttpServlet {

    //Daos
    DelecActiDao delecActiDao = new DelecActiDao();
    AlumnoEventoDao alumnoEventoDao = new AlumnoEventoDao();
    IntegranteDao integranteDao = new IntegranteDao();
    ActividadDao actividadDao = new ActividadDao();
    EventoDao eventoDao = new EventoDao();
    DelegadoActividadDao delegadoActividadDao = new DelegadoActividadDao();
    CredentialsDao credentialsDao = new CredentialsDao();
    AlumnoDao alumnoDao = new AlumnoDao();
    EnvioCorreosDaos envioCorreosDaos = new EnvioCorreosDaos();
    DonacionDao donacionDao = new DonacionDao();
    FotosActividadDao fotosActividadDao = new FotosActividadDao();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {


        response.setContentType("text/html");
        String action = request.getParameter("action") == null ? "main_page" : request.getParameter("action");



        //Datos de sesión:
        Alumno alumno = (Alumno) request.getSession().getAttribute("usuariologueado");

        boolean actividadIsFinalizada= !actividadDao.obtenerActividad(String.valueOf(alumno.getDelegadoActividad().getActividad().getIdActividad())).getEstado().equalsIgnoreCase("activa");
        if(alumno.getDelegadoActividad().getActividad().getEstado().equalsIgnoreCase("finalizada")){
            actividadIsFinalizada = true;
        }
        //enviar parámetro si la actividad está finalizada
        request.setAttribute("actividadIsFinalizada",actividadIsFinalizada);



        switch (action) {
            case "main_page":
                //saca la lista de eventos según actividad
                String idAct = request.getParameter("idAct") == null ? "1" : request.getParameter("idAct"); //click
                ArrayList<Evento> list = eventoDao.listarPorActividad(idAct, "a",100,0);

                //saca la lista de actividades
                ArrayList<DelegadoActividad> listDelegadoActividad = delegadoActividadDao.listarActividades(100,0);

                //mandar la lista a la vista -> /MainPage.jsp
                request.setAttribute("lista", list);
                request.setAttribute("listaActividades", listDelegadoActividad);
                RequestDispatcher rd = request.getRequestDispatcher("delegAct/MainPage.jsp");
                rd.forward(request, response);
                break;

            case "perfil":
                request.getRequestDispatcher("delegAct/Perfil.jsp").forward(request, response);
                break;

            case "editar_contra":
                request.getRequestDispatcher("delegAct/EditarContra.jsp").forward(request,response);
                break;

            case "mis_eventos":

                //saca del modelo
                ArrayList<AlumnoEvento> list_mis_eventos = eventoDao.listarPorAlumno(String.valueOf(alumno.getIdAlumno()),"a",100,0); //

                //mandar la lista a la vista -> /MisEventos.jsp
                request.setAttribute("lista_mis_eventos", list_mis_eventos);
                request.getRequestDispatcher("delegAct/MisEventos.jsp").forward(request, response);
                break;

            // ESTE CASO SE REFIERE A LA ACTIVIDAD FINALIZADA
            case "actividad_finalizada":

                if(actividadIsFinalizada){
                    //saca la lista de eventos finalizados
                    request.getRequestDispatcher("delegAct/ActFinalizada.jsp").forward(request,response);
                }
                else {
                    response.sendRedirect(request.getContextPath() + "/DelegadoActividadServlet?action=mi_actividad");
                }
                break;

            case "actividades_finalizadas":
                //saca la lista de eventos según actividad
                String idAct1 = request.getParameter("idAct") == null ? "1" : request.getParameter("idAct"); //click
                ArrayList<Evento> list1 = eventoDao.listarPorActividad(idAct1, "f",100,0);

                //saca la lista de actividades
                ArrayList<DelegadoActividad> listDelegadoActividad1 = delegadoActividadDao.listarActividades(100,0);

                //mandar la lista a la vista -> /MainPage.jsp
                request.setAttribute("lista", list1);
                request.setAttribute("listaActividades", listDelegadoActividad1);
                request.getRequestDispatcher("delegAct/ActividadesFinalizadas.jsp").forward(request,response);
                break;

            case "donaciones":

                request.getRequestDispatcher("delegAct/Donaciones.jsp").forward(request, response);
                break;

            case "info_eventos":
                String idEvento = request.getParameter("idEvento") == null ? "1" : request.getParameter("idEvento");

                Evento evento = eventoDao.buscarEvento(idEvento);
                Alumno delegadoDelEvento = alumnoDao.obtenerDelegadoDeActividad(String.valueOf(delegadoActividadDao.obtenerDelegadoActividadPorIdActividad(String.valueOf(evento.getActividad().getIdActividad())).getIdDelegadoActividad()));
                ArrayList<Evento> lista2 = eventoDao.listarEventos(idEvento,4,0);


                //mandar la lista a la vista -> /InfoEventos.jsp
                request.setAttribute("delegadoEvento",delegadoDelEvento);
                request.setAttribute("evento",evento);
                request.setAttribute("lista2",lista2);
                request.setAttribute("participando",alumnoEventoDao.comprobarParticipacionEvento(String.valueOf(alumno.getIdAlumno()),idEvento));

                request.getRequestDispatcher("delegAct/InfoEvento.jsp").forward(request,response);
                break;

            //EVENTOS CON ESTADO ACTIVO
            case "mi_actividad":
                if(actividadIsFinalizada){
                    response.sendRedirect(request.getContextPath() + "/DelegadoActividadServlet?action=actividad_finalizada");
                }
                else {
                    String idEvento2 = request.getParameter("idEvento") == null ? "1" : request.getParameter("idEvento");
                    Evento evento2 = eventoDao.buscarEvento(idEvento2);
                    String idAct2 = String.valueOf(alumno.getDelegadoActividad().getActividad().getIdActividad());
                    String estadoAct2 = String.valueOf(alumno.getDelegadoActividad().getActividad().getEstado());

                    ArrayList<Evento> lista3 = eventoDao.listarPorActividad(idAct2,"a",100,0);
                    request.setAttribute("evento2",evento2);
                    request.setAttribute("lista3",lista3);
                    request.getRequestDispatcher("delegAct/MiActividad.jsp").forward(request, response);

                }

                break;

            //EVENTOS CON ESTADO FINALIZADO
            case "estado_finalizado":

                if(actividadIsFinalizada){
                    response.sendRedirect(request.getContextPath() + "/DelegadoActividadServlet?action=actividad_finalizada");
                }
                else {
                    request.setAttribute("lista_eventos_finalizados",eventoDao.listarEventosSegunEstadoYActividad("f",alumno.getDelegadoActividad().getActividad().getIdActividad(),100,0));
                    request.getRequestDispatcher("delegAct/EstadoFinalizado.jsp").forward(request, response);;
                }

                break;


            case "participantes":

                String idEvento3 = request.getParameter("idEventoParticipantes") == null ? "1" : request.getParameter("idEventoParticipantes");

                ArrayList<AlumnoEvento> listaParticipantes = eventoDao.listarAlumnosPorEvento(idEvento3,"a",100,0);

                //enviar parámetro si el evento está finalizado
                boolean eventoIsFinalizado = !eventoDao.buscarEvento(idEvento3).getEstado().equalsIgnoreCase("a");
                if(eventoDao.buscarEvento(idEvento3).getEstado().equalsIgnoreCase("f")){
                    eventoIsFinalizado = true;
                }
                request.setAttribute("eventoIsFinalizada",eventoIsFinalizado);

                //mandar la lista a la vista -> /InfoEventos.jsp
                request.setAttribute("idE",idEvento3);
                request.setAttribute("lista_participantes",listaParticipantes);


                request.getRequestDispatcher("delegAct/Participantes.jsp").forward(request, response);
                break;

            case "solicitud_participante":
                String offsetParticipantesPendientes =  request.getParameter("offset_pendientes") == null ? "0" : request.getParameter("offset_pendientes");
                String idEvento4 = request.getParameter("idEventoParticipantes");

                ArrayList<AlumnoEvento> listaParticipantesPendientes = eventoDao.listarAlumnosPendientesPorEvento(idEvento4,"a",5,Integer.parseInt(offsetParticipantesPendientes)*3);

                //mandar la lista a la vista -> /InfoEventos.jsp
                request.setAttribute("idE",idEvento4);
                request.setAttribute("lista_participantes_pendientes",listaParticipantesPendientes);


                request.getRequestDispatcher("delegAct/SolicitudParticipante.jsp").forward(request, response);
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
        response.setContentType("text/html");



        //Datos de sesión:
        Alumno alumno = (Alumno) request.getSession().getAttribute("usuariologueado");

        Donacion donacion = new Donacion();

        String action = request.getParameter("action") == null ? "crear" : request.getParameter("action");

        switch (action) {
            case "crear"://voy a crear un nuevo evento


                Part part = request.getPart("eventoFoto");
                InputStream eventoFoto = part.getInputStream();
                String eventoDescripcion = request.getParameter("eventoDescripcion");
                String eventoFecha = request.getParameter("eventoFecha");
                String eventoTitulo = request.getParameter("titulo");
                String eventoHora = request.getParameter("eventoHora");
                String eventoLugar = request.getParameter("eventoLugar");




                //Formatea String a Date
                DateTimeFormatter formatStringToDate = new DateTimeFormatterBuilder().append(DateTimeFormatter.ofPattern("yyyy-MM-dd")).toFormatter();

                boolean isAllValid = true;

                if(request.getPart("eventoFoto") == null){
                    isAllValid = false;
                    request.getSession().setAttribute("errDesc", "Debe subir una foto. ");
                }

                if (eventoDescripcion.length() > 200 || eventoDescripcion.length()<2) {
                    isAllValid = false;
                    request.getSession().setAttribute("errDesc", "La descripción no es de la longitud adecuada.");
                }
                if (eventoLugar.isEmpty() || eventoLugar.length() > 30 || eventoTitulo.isEmpty() || eventoTitulo.length() > 50) {
                    isAllValid = false;
                    request.getSession().setAttribute("errDesc", "El título o el lugar no cumplen con el tamaño adecuado.");
                }
                if (LocalDate.parse(eventoFecha, formatStringToDate).isBefore(LocalDateTime.now(ZoneId.of("America/New_York")).toLocalDate())) {
                    isAllValid = false;
                    request.getSession().setAttribute("errDesc", "La fecha del evento debe ser posterior a la fecha actual");
                }
                System.out.println("Estamos?");
                if (isAllValid) {
                    // Parsear la Foto a Byte
                    System.out.println("La foto es: " + eventoFoto);
                    System.out.println("llegamos");
                    int IdActividad = alumno.getDelegadoActividad().getActividad().getIdActividad();
                    delecActiDao.crear(eventoFoto, eventoDescripcion, eventoFecha, eventoHora, eventoLugar, eventoTitulo, IdActividad);
                    request.getSession().setAttribute("msg", "Evento creado exitosamente");
                    response.sendRedirect(request.getContextPath() + "/DelegadoActividadServlet?action=mi_actividad"); //Una vez creado y dado click a submit se devuelve a la página donde está la lista
                } else {
                    request.getSession().setAttribute("err", "Error al crear el evento. ");
                    response.sendRedirect(request.getContextPath() + "/DelegadoActividadServlet?action=mi_actividad");
                }
                break;

            case "editar"://voy a editar un evento

                Part part1 = request.getPart("eventoFoto");
                InputStream eventoFoto2 = part1.getInputStream();
                String eventoDescripcion2 = request.getParameter("eventoDescripcion");
                String eventoFecha2 = request.getParameter("eventoFecha");
                String eventoTitulo2 = request.getParameter("titulo");
                String eventoID2 = request.getParameter("eventoID");
                String eventoHora2 = request.getParameter("eventoHora");
                String eventoLugar2 = request.getParameter("eventoLugar");




                //Formatea String a Date
                DateTimeFormatter formatStringToDate2 = new DateTimeFormatterBuilder().append(DateTimeFormatter.ofPattern("yyyy-MM-dd")).toFormatter();

                boolean isAllValid2 = true;

                if (eventoDescripcion2.length() > 200 || eventoDescripcion2.length()<2 || eventoLugar2.isEmpty() || eventoLugar2.length() > 30 || eventoTitulo2.isEmpty() || eventoTitulo2.length() > 50) {
                    isAllValid2 = false;
                    request.getSession().setAttribute("errDesc", "La descripción, el título o el lugar no cumplen con el tamaño adecuado.");
                }
                if (LocalDate.parse(eventoFecha2, formatStringToDate2).isBefore(LocalDateTime.now(ZoneId.of("America/New_York")).toLocalDate())) {
                    isAllValid2 = false;
                    request.getSession().setAttribute("errDesc", "La fecha del evento debe ser posterior a la fecha actual");
                }

                if (isAllValid2) {

                    String IdActividad = String.valueOf(alumno.getDelegadoActividad().getActividad().getIdActividad());

                    Evento e2 = new Evento();
                    e2.setFoto(eventoFoto2);
                    e2.setActividad(actividadDao.obtenerActividad(IdActividad));
                    e2.setDescripcion(eventoDescripcion2);
                    e2.setLugar(eventoLugar2);
                    e2.setFechaIn(eventoFecha2);
                    e2.setHora(eventoHora2);
                    e2.setIdEvento(Integer.parseInt(eventoID2));

                    delecActiDao.actualizar(e2);
                    request.getSession().setAttribute("msg", "Evento actualizado exitosamente");
                    response.sendRedirect(request.getContextPath() + "/DelegadoActividadServlet?action=mi_actividad");

                } else {
                    request.getSession().setAttribute("err", "Error al actualizar el evento. ");
                    response.sendRedirect(request.getContextPath() + "/DelegadoActividadServlet?action=mi_actividad");
                }
                break;

            case "cambiar_rol":

                if(request.getParameter("idAE") != null){
                    String idAE = request.getParameter("idAE");
                    AlumnoEvento aE = alumnoEventoDao.obtenerAlumnoEvento(idAE);
                    integranteDao.cambiarRol(aE);
                    aE = alumnoEventoDao.obtenerAlumnoEvento(idAE);
                    request.getSession().setAttribute("msg", "Rol cambiado exitosamente.");
                    // envio de correo
                    Alumno alumno1 = aE.getAlumno();
                    String asunto = "Cambio de Rol";
                    String contenido = "Hola, " + alumno1.getNombre() + " " + alumno1.getApellido() + ", se te ha asignado el nuevo rol de " + aE.getIntegrante().getDescripcion() + ", en el evento '" + aE.getEvento().getTitulo() + "', cuya fecha es " + aE.getEvento().getFechaIn()+".";

                    String correo = alumno1.getCorreo();
                    envioCorreosDaos.createEmail(correo,asunto,contenido);
                    envioCorreosDaos.sendEmail();

                    response.sendRedirect(request.getContextPath() + "/DelegadoActividadServlet?action=participantes&idEventoParticipantes="+ aE.getEvento().getIdEvento());
                }
                else{
                    request.getSession().setAttribute("err", "Error al cambiar rol. ");
                    response.sendRedirect(request.getContextPath() + "/DelegadoActividadServlet?action=participantes");
                }

                break;


            case "eliminar_evento":
                String idEventoStr = request.getParameter("idEventoEliminar");
                Evento evento3 = eventoDao.buscarEvento(idEventoStr);

                if(evento3 != null){
                    try {
                        alumnoEventoDao.eliminar(idEventoStr);
                        request.getSession().setAttribute("msg", "Evento eliminado exitosamente");
                        delecActiDao.borrar(Integer.parseInt(idEventoStr));
                    } catch (SQLException e) {
                        System.out.println("Log: excepcion: " + e.getMessage());
                    }
                }
                response.sendRedirect(request.getContextPath() + "/DelegadoActividadServlet?action=mi_actividad");
                break;

            case "asignar_rol":

                String idEvento = request.getParameter("idEvento");
                String rolAsignar = request.getParameter("rolAsignar");
                String idAlumnoAsignarRol = request.getParameter("idAlumnoAsignarRol");
                String idAlumnoEventoRol = request.getParameter("idAlumnoEvento");

                if(rolAsignar.equals("equipo")){
                    AlumnoEvento alumnoN = alumnoEventoDao.obtenerAlumnoEvento(idAlumnoEventoRol);
                    integranteDao.asignarRol(alumnoN,"equipo");
                    request.getSession().setAttribute("msg", "Rol asignado correctamente.");

                    // envio de correo
                    Alumno alumno1 = alumnoN.getAlumno();
                    String asunto = "Asignación de Rol";
                    String contenido = "Hola, " + alumno1.getNombre() + " " + alumno1.getApellido() + ", se te ha asignado el rol de " + "EQUIPO" + ", en el evento: " + alumnoN.getEvento().getTitulo() + ", cuya fecha es: " + alumnoN.getEvento().getFechaIn();
                    String correo = alumno1.getCorreo();
                    envioCorreosDaos.createEmail(correo,asunto,contenido);
                    envioCorreosDaos.sendEmail();

                    response.sendRedirect(request.getContextPath() + "/DelegadoActividadServlet?action=participantes&idEventoParticipantes="+ idEvento);
                }
                if(rolAsignar.equals("barra")){
                    AlumnoEvento alumnoN = alumnoEventoDao.obtenerAlumnoEvento(idAlumnoEventoRol);
                    integranteDao.asignarRol(alumnoN,"barra");
                    request.getSession().setAttribute("msg", "Rol asignado correctamente. ");
                    // envio de correo
                    Alumno alumno1 = alumnoN.getAlumno();
                    String asunto = "Asignación de Rol";
                    String contenido = "Hola, " + alumno1.getNombre() + " " + alumno1.getApellido() + ", se te ha asignado el rol de " + "BARRA" + ", en el evento: " + alumnoN.getEvento().getTitulo() + ", cuya fecha es: " + alumnoN.getEvento().getFechaIn();
                    String correo = alumno1.getCorreo();
                    envioCorreosDaos.createEmail(correo,asunto,contenido);
                    envioCorreosDaos.sendEmail();

                    response.sendRedirect(request.getContextPath() + "/DelegadoActividadServlet?action=participantes&idEventoParticipantes="+ idEvento);
                }


                break;
            case "apoyar_evento":
                //saca el id del evento a apoyar
                String idEventoApoyar = request.getParameter("idEventoApoyar") == null ? "" : request.getParameter("idEventoApoyar");
                String idAlumno = String.valueOf(alumno.getIdAlumno());
                alumnoEventoDao.apoyarEvento(idAlumno,idEventoApoyar);
                response.sendRedirect(request.getContextPath() + "/DelegadoActividadServlet?action=mis_eventos");
                break;

            case "donar":

                String donacionTipo = request.getParameter("donacionTipo");
                String donacionMonto = request.getParameter("donacionMonto");
                Part part2 = request.getPart("donacionFoto");
                InputStream donacionFoto = part2.getInputStream();


                boolean isAllValid1 = true;

                if (donacionMonto.isEmpty()) {
                    isAllValid1 = false;
                    request.getSession().setAttribute("errDesc", "Coloca un monto a donar.");
                }

                double donacionMontoDouble = 0;
                try {
                    donacionMontoDouble = Double.parseDouble(donacionMonto);
                } catch (NumberFormatException n) {
                    isAllValid1 = false;
                    request.getSession().setAttribute("errDesc", "El monto tiene que ser un número (Puede usar decimales).");
                }


                if(request.getPart("donacionFoto") == null){
                    isAllValid1 = false;
                    request.getSession().setAttribute("errDesc", "Coloca la captura de tu donación.");
                }

                if(request.getParameter("donacionTipo") == null){
                    isAllValid1 = false;
                    request.getSession().setAttribute("errDesc", "Selecciona la billeta electrónica que desees.");
                }


                if (isAllValid1) {
                    //guardamos Donacion
                    donacionDao.crear(donacionFoto, donacionTipo, donacionMontoDouble, request.getParameter("alumnoIDdonador"));
                    request.getSession().setAttribute("msg", "Tu donación fue enviada correctamente.");
                    response.sendRedirect(request.getContextPath() + "/DelegadoActividadServlet?action=donaciones");
                } else {
                    request.getRequestDispatcher("delegAct/Donaciones.jsp").forward(request, response);
                    request.getSession().setAttribute("err", "Tu donación no fue enviada correctamente. ");
                }
                break;

            case "cambiar_contra":

                String contra1 = request.getParameter("contra1");
                String contra2 = request.getParameter("contra2");

                boolean isAllValid6 = true;

                if(!credentialsDao.validarContrasenaAlumno(String.valueOf(alumno.getIdAlumno()), request.getParameter("contraActual"))){
                    request.getSession().setAttribute("err", "No se pudo cambiar la contraseña.");
                    request.getSession().setAttribute("errDesc", "La contraseña actual no es correcta.");
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
                    credentialsDao.actualizarContrasenaAlumno(String.valueOf(alumno.getIdAlumno()),contra1);
                    request.getSession().setAttribute("msg", "Se actualizó la contraseña correctamente");
                    response.sendRedirect(request.getContextPath() + "/DelegadoActividadServlet?action=editar_contra");

                } else {
                    request.getSession().setAttribute("err", "No se pudo cambiar la contraseña.");
                    response.sendRedirect(request.getContextPath() + "/DelegadoActividadServlet?action=editar_contra");
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
                    alumnoDao.actualizarFotoDePerfil(usuarioFoto,usuarioIdStr);
                    request.getSession().setAttribute("msg", "Foto de perfil actualizada exitosamente.");
                    response.sendRedirect(request.getContextPath() + "/DelegadoActividadServlet?action=perfil");
                }
                else{
                    request.getSession().setAttribute("errDesc", "Debe subir una foto.");
                    response.sendRedirect(request.getContextPath() + "/DelegadoActividadServlet?action=perfil");
                }
                break;

            case "finalizar_evento":

                //Parámetros:
                String idEventoFinalizar = request.getParameter("idEventoFinalizar");
                eventoDao.finalizarEvento(idEventoFinalizar);
                request.getSession().setAttribute("msg", "Evento finalizado existosamente.");
                response.sendRedirect(request.getContextPath() + "/DelegadoActividadServlet?action=mi_actividad");
                break;

            case "finalizar_actividad":

                //Parámetros:
                String idActividadFinalizar = request.getParameter("idActividadFinalizar");
                eventoDao.finalizarEventosPorActividad(idActividadFinalizar);
                actividadDao.finalizarActividad(idActividadFinalizar);
                request.getSession().setAttribute("msg", "Actividad finalizada existosamente.");
                response.sendRedirect(request.getContextPath() + "/DelegadoActividadServlet?action=actividad_finalizada");
                break;


            case "subir_foto":

                //Parámetros:
                String idActividadFinalizadaFotos = request.getParameter("idActividadFinalizadaFotos");
                if(request.getParameter("fotoActividadFinalizada")!=null){
                    InputStream actividadFoto = request.getPart("fotoActividadFinalizada").getInputStream();
                    fotosActividadDao.subirFotoDeActividadFinalizada(idActividadFinalizadaFotos,actividadFoto);
                    request.getSession().setAttribute("msg", "Foto subida exitosamente.");
                    response.sendRedirect(request.getContextPath() + "/DelegadoActividadServlet?action=actividad_finalizada");
                }
                else{
                    request.getSession().setAttribute("errDesc", "Debe subir una foto.");
                    response.sendRedirect(request.getContextPath() + "/DelegadoActividadServlet?action=actividad_finalizada");
                }

                break;
        }



    }



}

