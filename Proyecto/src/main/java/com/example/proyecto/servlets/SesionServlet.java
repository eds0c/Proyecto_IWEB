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

    //Herramientas:
    CredentialsDao credentialsDao = new CredentialsDao();
    DelegadoActividadDao delegadoActividadDao = new DelegadoActividadDao();
    DelegadoGeneralDao delegadoGeneralDao = new DelegadoGeneralDao();
    EstadoAlumnoDao estadoAlumnoDao = new EstadoAlumnoDao();
    AlumnoDao alumnoDao = new AlumnoDao();
    EnvioCorreosDaos envioCorreosDaos = new EnvioCorreosDaos();

    String urlProyecto = "http://35.209.249.189:8080";

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
                String caseUsuario = request.getParameter("case");

                if(caseUsuario.equals("del_gen")){
                    String idDelGenCambiarContra = request.getParameter("idCambiar");
                    String tokenBaseDatos = credentialsDao.obtenerTokenDelegadoGeneral(idDelGenCambiarContra);
                    if(tokenBaseDatos.equals(request.getParameter("token"))){
                        request.setAttribute("idParaCambiar",idDelGenCambiarContra);
                        request.setAttribute("casoC","delG");
                        request.setAttribute("tokenEnvio",tokenBaseDatos);
                        request.getRequestDispatcher("login/CambiarContra.jsp").forward(request,response);
                    }
                    else{
                        response.sendRedirect(request.getContextPath() + "/SesionServlet");
                    }

                }
                else if(caseUsuario.equals("alum")){
                    String idAlumnoCambiarContra = request.getParameter("idCambiar");
                    String tokenBaseDatos = credentialsDao.obtenerTokenAlumno(idAlumnoCambiarContra);
                    if(tokenBaseDatos.equals(request.getParameter("token"))){
                        request.setAttribute("idParaCambiar",idAlumnoCambiarContra);
                        request.setAttribute("casoC","alum");
                        request.setAttribute("tokenEnvio",tokenBaseDatos);
                        request.getRequestDispatcher("login/CambiarContra.jsp").forward(request,response);
                    }
                    else{
                        response.sendRedirect(request.getContextPath() + "/SesionServlet");
                    }
                }
                else{
                    response.sendRedirect(request.getContextPath() + "/SesionServlet");
                }

                break;
            case "cerrar_sesion":
                HttpSession httpSession = request.getSession();
                httpSession.invalidate(); //Lo que hace invalidate es borrar todos los atributos y la sesion la deja en blanco
                response.sendRedirect(request.getContextPath() + "/SesionServlet");
                break;

            default:
                request.getRequestDispatcher("/error404.jsp").forward(request, response);
                break;


        }

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String correo = request.getParameter("username");
        String password = request.getParameter("password");
        System.out.println("username: " + correo + "| password: " + password );





        String action = request.getParameter("action");


        switch (action){
            case "inicio_sesion":
                HttpSession httpSession = request.getSession();

                int tipoUsuario=credentialsDao.validarUsuarioPassword(correo,password);//1: alumno | 2: delegado de actividad | 3: delegado general | 0:no encontrado

                switch (tipoUsuario){
                    case 0:
                        request.getSession().setAttribute("errDesc", "Usuario o contraseña incorrectos.");; //Va a mandar este mensaje a login/InicioSesion.jsp
                        response.sendRedirect(request.getContextPath() + "/SesionServlet");
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
            case "registro_usuario":

                Alumno alumnoRegistrar = new Alumno();

                String correoR = request.getParameter("correo");
                String password1 = request.getParameter("password1");
                String password2 = request.getParameter("password2");
                String nombre = request.getParameter("nombre");
                String apellido = request.getParameter("apellido");
                String codigo = request.getParameter("codigo");


                if(request.getPart("foto").getInputStream()!=null){
                    alumnoRegistrar.setFoto(request.getPart("foto").getInputStream());
                }
                else {
                    request.getSession().setAttribute("errDesc", "Tiene que subir una foto de perfil.");
                    response.sendRedirect(request.getContextPath() + "/SesionServlet?action=registro_usuario");
                }


                boolean isAllValidRegistro = true;
                if(credentialsDao.validarCorreoDelegadoGeneral(correoR)){
                    request.getSession().setAttribute("errDesc", "El correo ya está vinculado a otra cuenta.");
                    isAllValidRegistro = false;

                } else if (credentialsDao.validarCorreoAlumno(correoR)) {
                    request.getSession().setAttribute("errDesc", "El correo ya está vinculado a otra cuenta.");
                    isAllValidRegistro = false;
                }


                if(password1.length() < 8 || password2.length() < 8){
                    isAllValidRegistro = false;
                    request.getSession().setAttribute("errDesc", "Las contraseñas deben tener al menos 8 caracteres");
                }

                if(!password1.equals(password2)){
                    isAllValidRegistro = false;
                    request.getSession().setAttribute("errDesc", "Las contraseñas deben ser iguales");
                }

                if(nombre.isEmpty() || apellido.isEmpty() || codigo.isEmpty()){
                    isAllValidRegistro = false;
                    request.getSession().setAttribute("errDesc", "Tiene que llenar los parámetros requeridos.");
                }


                try {
                    int codigoInt = Integer.parseInt(codigo);
                } catch (NumberFormatException n) {
                    isAllValidRegistro = false;
                    request.getSession().setAttribute("errDesc", "El código PUCP es un número.");
                }
                if(request.getParameter("estadoAcademico")==null){
                    isAllValidRegistro = false;
                    request.getSession().setAttribute("errDesc", "Seleccione un estado.");
                }

                if (isAllValidRegistro) {
                    alumnoRegistrar.setNombre(request.getParameter("nombre"));
                    alumnoRegistrar.setApellido(request.getParameter("apellido"));
                    alumnoRegistrar.setCodigo(request.getParameter("codigo"));
                    alumnoRegistrar.setCorreo(request.getParameter("correo"));
                    alumnoRegistrar.setContrasena(password1);
                    alumnoRegistrar.setEgresado(request.getParameter("estadoAcademico"));
                    alumnoRegistrar.setEstadoAlumno(estadoAlumnoDao.obtenerEstadoAlumno("3")); // se le asigna el estado de pendiente (luego será revisado por el delegado general)
                    alumnoDao.crearAlumno(alumnoRegistrar); //crear el alumno en la base de datos
                    request.getSession().setAttribute("msg", "Se registro correctamente. Espere a que el delegado general valide su registro.");
                    response.sendRedirect(request.getContextPath() + "/SesionServlet");

                } else {
                    request.getSession().setAttribute("err", "Hubo un error al registrar sus datos.");
                    response.sendRedirect(request.getContextPath() + "/SesionServlet?action=registro_usuario");
                }


                break;

            case "olvido_contra":
                request.getRequestDispatcher("login/OlvidoContra.jsp").forward(request,response);
                break;

            case "generar_token":

                String correoRecibido = request.getParameter("correoOlvidoContra");

                if(credentialsDao.validarCorreoDelegadoGeneral(correoRecibido)){
                    //Generar token:
                    DelegadoGeneral delegadoGeneralOlvidoContra = credentialsDao.obtenerDelegadoGeneral(correoRecibido);
                    String token = credentialsDao.cadenaAleatoria(25);
                    credentialsDao.actualizarTokenDelegadoGeneral(delegadoGeneralOlvidoContra.getIdDelegadoGeneral(),token);
                    // envio de correo

                    String asunto = "Enlace para reestablecer tu contraseña.";
                    String contenido = "Hola, " + delegadoGeneralOlvidoContra.getNombre() + " " + delegadoGeneralOlvidoContra.getApellido() + ", entra al siguiente link para reestablecer tu contraseña: \n" +
                             urlProyecto + request.getContextPath() + "/SesionServlet?action=cambio_contra&token=" + token + "&idCambiar=" + delegadoGeneralOlvidoContra.getIdDelegadoGeneral() + "&case=del_gen";

                    envioCorreosDaos.createEmail(correoRecibido,asunto,contenido);
                    envioCorreosDaos.sendEmail();
                    response.sendRedirect(request.getContextPath() + "/SesionServlet");

                } else if (credentialsDao.validarCorreoAlumno(correoRecibido)) {

                    //Generar token:
                    Alumno alumnoOlvidoContra = credentialsDao.obtenerAlumno(correoRecibido);
                    String token = credentialsDao.cadenaAleatoria(25);
                    credentialsDao.actualizarTokenAlumno(alumnoOlvidoContra.getIdAlumno(),token);

                    // envio de correo

                    String asunto = "Enlace para reestablecer tu contraseña.";
                    String contenido = "Hola, " + alumnoOlvidoContra.getNombre() + " " + alumnoOlvidoContra.getApellido() + ", entra al siguiente link para reestablecer tu contraseña: \n" +
                            urlProyecto + request.getContextPath() + "/SesionServlet?action=cambio_contra&token=" + token + "&idCambiar=" + alumnoOlvidoContra.getIdAlumno() + "&case=alum";

                    envioCorreosDaos.createEmail(correoRecibido,asunto,contenido);
                    envioCorreosDaos.sendEmail();
                    response.sendRedirect(request.getContextPath() + "/SesionServlet");

                }
                else {
                    request.getSession().setAttribute("errDesc", "No existe ningún usuario registrado con el correo ingresado.");
                    response.sendRedirect(request.getContextPath() + "/SesionServlet?action=olvido_contra");
                }


                break;


            case "reestablecer_contra":

                String caseC = request.getParameter("caseC");

                if(caseC.equals("delG")){

                    String contra1 = request.getParameter("contra1");
                    String contra2 = request.getParameter("contra2");
                    String idDelGenString = request.getParameter("idUsuarioCambiar");
                    String token = request.getParameter("tokenPost");


                    boolean isAllValid6 = true;



                    if(contra1.length() < 8 || contra2.length() < 8){
                        isAllValid6 = false;
                        request.getSession().setAttribute("errDesc", "Las contraseñas deben tener al menos 8 caracteres");
                    }

                    if(!contra1.equals(contra2)){
                        isAllValid6 = false;
                        request.getSession().setAttribute("errDesc", "Las contraseñas deben ser iguales");
                    }

                    if (isAllValid6) {
                        credentialsDao.actualizarContrasenaDelegadoGeneral(idDelGenString,contra1);
                        request.getSession().setAttribute("msg", "Se actualizó la contraseña correctamente");
                        credentialsDao.borrarTokenDelegadoGeneral(idDelGenString);
                        response.sendRedirect(request.getContextPath() + "/SesionServlet");

                    } else {
                        request.getSession().setAttribute("err", "No se pudo cambiar la contraseña.");
                        response.sendRedirect(request.getContextPath() + "/SesionServlet?action=cambio_contra&token=" + token + "&idCambiar=" + idDelGenString + "&case=del_gen");
                    }

                }
                else if(caseC.equals("alum")){
                    String contra1 = request.getParameter("contra1");
                    String contra2 = request.getParameter("contra2");
                    String idAlumString = request.getParameter("idUsuarioCambiar");
                    String token = request.getParameter("tokenPost");

                    boolean isAllValid7 = true;


                    if(contra1.length() < 8 || contra2.length() < 8){
                        isAllValid7 = false;
                        request.getSession().setAttribute("errDesc", "Las contraseñas deben tener al menos 8 caracteres");
                    }

                    if(!contra1.equals(contra2)){
                        isAllValid7 = false;
                        request.getSession().setAttribute("errDesc", "Las contraseñas deben ser iguales");
                    }

                    if (isAllValid7) {
                        credentialsDao.actualizarContrasenaAlumno(idAlumString,contra1);
                        request.getSession().setAttribute("msg", "Se actualizó la contraseña correctamente");
                        credentialsDao.borrarTokenAlumno(idAlumString);
                        response.sendRedirect(request.getContextPath() + "/SesionServlet");

                    } else {
                        request.getSession().setAttribute("err", "No se pudo cambiar la contraseña.");
                        response.sendRedirect(request.getContextPath() + "/SesionServlet?action=cambio_contra&token=" + token + "&idCambiar=" + idAlumString + "&case=alum");
                    }
                }
                else{
                response.sendRedirect(request.getContextPath() + "/SesionServlet");
                }


                break;
        }
    }
}

