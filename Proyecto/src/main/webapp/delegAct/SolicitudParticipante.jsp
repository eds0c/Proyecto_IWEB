<%@ page import="java.util.ArrayList" %>
<%@ page import="com.example.proyecto.beans.AlumnoEvento" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.example.proyecto.beans.Alumno" %>
<jsp:useBean id="lista_participantes_pendientes" scope="request" type="ArrayList<AlumnoEvento>" />
<%int idEvento = Integer.parseInt((String) request.getAttribute("idE"));%>
<jsp:useBean id="usuariologueado" scope="session" type="com.example.proyecto.beans.Alumno" class="com.example.proyecto.beans.Alumno"/>
<jsp:useBean id="textoBusqueda" scope="request" type="java.lang.String" class="java.lang.String"/>
<%boolean actividadIsFinalizada = (Boolean) request.getAttribute("actividadIsFinalizada");%>

<html lang="en">

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0">
    <title>Act: Solicitud</title>
    <link rel="shortcut icon" type="image/x-icon" href="assets/img/IconoBat.png">

    <link rel="stylesheet" href="assets/css/bootstrap.min.css">
    <link rel="stylesheet" href="assets/plugins/fontawesome/css/all.min.css">
    <link rel="stylesheet" href="assets/css/feathericon.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.0/font/bootstrap-icons.css">
    <%-- BOOTSTRAP 5--%>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
    <link rel="stylesheet" href="assets/css/style.css">
</head>

<body>
<div class="main-wrapper">
    <!-- CABECERA -->
    <div class="header">
        <!-- CABECERA DE LA BARRA LATERAL LISTOOOOO -->
        <div class="header-left">
            <a href="<%=request.getContextPath() %>/DelegadoActividadServlet?action=main_page"
               class="logo text-decoration-none"> <img
                    src="assets/img/IconoBat.png" width="30" height="50" alt="logo"> <span
                    class="logoclass">TELEWEEK</span> </a>
        </div>
        <!-- LAS RAYITAS Q ABREN A LA BARRA LISTOOO-->
        <a class="text-decoration-none" href="javascript:void(0);" id="toggle_btn"> <i
                class="fe fe-text-align-left"></i> </a>
        <a class="mobile_btn text-decoration-none" id="mobile_btn"> <i class="fas fa-bars"></i> </a>
        <!-- NAVBAR -->
        <ul class="nav user-menu">
            <!-- FOTO DE PERFIL CON LAS OPCIONES DE EDITAR PERFIL Y DEMAS -->
            <li class="nav-item dropdown has-arrow">
                <a href="#" class="dropdown-toggle nav-link text-decoration-none" data-bs-toggle="dropdown"> <span
                        class="user-img"><%Alumno alumnologueado = (Alumno) session.getAttribute("usuariologueado");%>
                    <img
                            class="rounded-circle" src="<%=request.getContextPath()%>/ImgServlet?action=fotoPerfilDeleAct&idd=<%=alumnologueado.getIdAlumno()%>" width="50" height="50"></span>
                </a>
                <!-- MENU DESPLEGABLE DE LA FLECHITA DE LA FOTO DE PERFIL -->
                <div class="dropdown-menu">
                    <div class="user-header">
                        <!-- nombre y rol del usuario -->
                        <div class="user-text">
                            <%if (session.getAttribute("usuariologueado") == null) {%>
                            <span class="email">codigo@pucp.edu.com</span>
                            <%} else {%>
                            <%Alumno alumnologueado1 = (Alumno) session.getAttribute("usuariologueado");%>
                            <span class="email"><%=alumnologueado1.getNombre() + " " + alumnologueado1.getApellido()%></span>
                            <%}%>
                            <p class="text-muted mb-0">Delegado Actividad</p>
                        </div>
                    </div>
                    <a class="dropdown-item text-decoration-none"
                       href="<%=request.getContextPath() %>/DelegadoActividadServlet?action=perfil">Mi
                        Perfil</a>
                    <a class="dropdown-item text-decoration-none"
                       href="<%=request.getContextPath() %>/DelegadoActividadServlet?action=cerrar_sesion">Cerrar
                        Sesión</a>
                </div>
            </li>
        </ul>
    </div>

    <!-- BARRA LATERAL -->
    <div class="sidebar" id="sidebar">
        <div class="sidebar-inner slimscroll">
            <div id="sidebar-menu" class="sidebar-menu">
                <ul>
                    <li><a class="text-decoration-none"
                           href="<%=request.getContextPath() %>/DelegadoActividadServlet?action=main_page"><i
                            class="bi bi-house-fill"></i>
                        <span>Inicio</span></a></li>
                    <li class="list-divider"></li>

                    <li class="menu-title mt-3"><span>PARTICIPACION</span></li>
                    <!-- EVENTOS INSCRITOS -->
                    <li><a class="text-decoration-none"
                           href="<%=request.getContextPath() %>/DelegadoActividadServlet?action=mis_eventos"><i
                            class="bi bi-calendar-event-fill"></i><span>Mis eventos</span></a>
                    </li>

                    <!-- DONACION -->
                    <li><a class="text-decoration-none"
                           href="<%=request.getContextPath() %>/DelegadoActividadServlet?action=donaciones"><i
                            class="bi bi-heart-fill"></i><span>Donaciones</span></a>
                    </li>

                    <!-- MI ACTIVIDAD -->
                    <li class="list-divider"></li>
                    <li class="menu-title mt-3"><span>ACCIONES</span></li>
                    <li class="submenu"><a class="text-decoration-none" href="#"><i
                            class="bi bi-file-earmark-text-fill"></i> <span>Mi Actividad</span> <span
                            class="menu-arrow"></span></a>
                        <ul class="submenu_class" style="display: none;">

                            <%if(!actividadIsFinalizada){%>
                            <li><a class="text-decoration-none" href="<%=request.getContextPath() %>/DelegadoActividadServlet?action=mi_actividad">Eventos activos</a></li>
                            <li><a class="text-decoration-none" href="<%=request.getContextPath() %>/DelegadoActividadServlet?action=estado_finalizado">Eventos finalizados </a></li>
                            <%}%>
                            <%if(actividadIsFinalizada){%>
                            <li><a class="text-decoration-none" href="<%=request.getContextPath() %>/DelegadoActividadServlet?action=actividad_finalizada">Subir fotos</a></li>
                            <%}%>
                        </ul>
                    </li>

                    <!-- NOVEDADES - ACT FINALIZADAS -->
                    <li class="list-divider"></li>
                    <li class="menu-title mt-3"><span>EXPLORA</span></li>
                    <li><a class="text-decoration-none" href="<%=request.getContextPath() %>/DelegadoActividadServlet?action=actividades_finalizadas"><i class="bi bi-calendar2-check-fill"></i><span>Act finalizadas</span></a>
                    </li>


                    <!-- CONTACTOS -->
                    <li class="list-divider"></li>
                    <li class="menu-title mt-3"><span>CONTACTOS</span></li>
                    <li><a class="text-decoration-none" href="https://www.instagram.com/aitel.pucp/" target="_blank"><i
                            class="bi bi-instagram"></i>
                        <span>Instagram</span></a></li>
                    <li><a class="text-decoration-none" href="mailto:aitel@pucp.pe" target="_blank"><i
                            class="fas fa-envelope"></i>
                        <span>Gmail</span></a></li>

                </ul>
            </div>
        </div>
    </div>

    <!-- TODO LO Q ESTA EN LA PAGINA SIN BARRA LATERAL -->
    <div class="page-wrapper">
        <div class="content container-fluid">
            <div class="page-header">
                <div class="row align-items-center">
                    <div class="col">
                        <div class="mt-5">
                            <h4 class="card-title float-left mt-2">Solicitud de participantes</h4>
                        </div>
                    </div>
                </div>
            </div>
            <div class="text-center justify-content-center mb-3 col" style="font-size: 14px">
                <!-- MENSAJES DE ERROR O CONFIRMACION -->
                <% if (session.getAttribute("msg") != null) { %>
                <span class="alert-message success" style="color:green">
                                    <i class="bi bi-check-circle"></i>
                                    <%= session.getAttribute("msg") %></span>
                <% session.removeAttribute("msg"); } %>
                <% if (session.getAttribute("err") != null) { %>
                <span class="alert-message danger" style="color:red">
                                    <i class="bi bi-exclamation-circle"></i>
                                    <%= session.getAttribute("err") %></span>
                <% session.removeAttribute("err"); } %>
                <% if (session.getAttribute("errDesc") != null) { %>
                <span class="alert-message danger" style="color:red"><%= session.getAttribute("errDesc") %></span>
                <% session.removeAttribute("errDesc"); } %>
            </div>

            <!-- LISTA DE PARTICIPANTES -->
            <div class="row">
                <div class="col-sm-12">
                    <div class="card">
                        <div class="card-body">
                            <div class="table-responsive">
                                <!-- TABLA EVENTOS -->
                                <table class="table table-hover mt-1 mb-1">
                                    <thead>
                                    <tr>
                                        <th>#</th>
                                        <th>Nombre</th>
                                        <th>Correo</th>
                                        <th>Equipo</th>
                                        <th>Barra</th>
                                    </tr>
                                    </thead>
                                    <%if (lista_participantes_pendientes.isEmpty()){%>
                                    <p class="lead">No existen nuevas solicitudes</p>
                                    <%}%>
                                    <tbody>
                                    <%int p = 1;%>
                                    <%for (AlumnoEvento aE: lista_participantes_pendientes){%>
                                    <tr>
                                        <th><%=p%></th>
                                        <td><%=aE.getAlumno().getNombre() + " " +aE.getAlumno().getApellido()%></td>
                                        <td><%=aE.getAlumno().getCorreo()%></td>

                                        <!-- EQUIPO -->
                                        <td>
                                            <button class="btn btn-secondary" data-bs-toggle="modal"
                                                    data-bs-target="#equipo<%=p%>">
                                                <i class="bi bi-dribbble"></i>
                                            </button>
                                        </td>

                                        <%-- BARRA--%>
                                        <td>
                                            <button class="btn btn-primary" data-bs-toggle="modal"
                                                    data-bs-target="#barra<%=p%>">
                                                <i class="bi bi-emoji-laughing"></i>
                                            </button>
                                        </td>
                                        <!-- MODAL EQUIPO -->
                                        <form method="post"
                                              action="<%=request.getContextPath()%>/DelegadoActividadServlet?action=asignar_rol">
                                        <div class="modal fade" id="equipo<%=p%>" aria-hidden="true">
                                            <div class="modal-dialog modal-dialog-centered">
                                                <div class="modal-content">
                                                    <div class="modal-header">
                                                        <h5 class="modal-title">Equipo
                                                        </h5>
                                                        <button type="button" class="btn-close" data-bs-dismiss="modal"
                                                                aria-label="Close"></button>
                                                    </div>
                                                    <div class="modal-body text-justify">
                                                        Has seleccionado "Equipo". <br>
                                                        Si esta es la acción que deseas realizar, por favor confirma tu
                                                        elección,
                                                        de lo contrario, selecciona cancelar.
                                                    </div>
                                                    <div class="modal-footer">
                                                        <button type="button" class="btn btn-light active"
                                                                data-bs-dismiss="modal">Cancelar
                                                        </button>
                                                            <input type="hidden" class="form-control" name="idAlumnoAsignarRol" value=<%=aE.getAlumno().getIdAlumno()%>>
                                                            <input type="hidden" class="form-control" name="rolAsignar" value="equipo">
                                                            <input type="hidden" class="form-control" name="idEvento" value="<%=aE.getEvento().getIdEvento()%>">
                                                            <input type="hidden" class="form-control" name="idAlumnoEvento" value="<%=aE.getIdAlumnoEvento()%>">
                                                            <button type="submit" class="btn btn-primary" id="Equipo">Asignar Rol
                                                            </button>

                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        </form>
                                        <!-- FIN MODAL EQUIPO -->


                                        <!-- MODAL BARRA -->
                                        <form method="post"
                                              action="<%=request.getContextPath()%>/DelegadoActividadServlet?action=asignar_rol">
                                        <div class="modal fade" id="barra<%=p%>" aria-hidden="true">
                                            <div class="modal-dialog modal-dialog-centered">
                                                <div class="modal-content">
                                                    <div class="modal-header">
                                                        <h5 class="modal-title">Barra
                                                        </h5>
                                                        <button type="button" class="btn-close" data-bs-dismiss="modal"
                                                                aria-label="Close"></button>
                                                    </div>
                                                    <div class="modal-body text-justify">
                                                        Has seleccionado "Barra". <br>
                                                        Si esta es la acción que deseas realizar, por favor confirma tu
                                                        elección,
                                                        de lo contrario, selecciona cancelar.
                                                    </div>
                                                    <div class="modal-footer">
                                                        <button type="button" class="btn btn-light active"
                                                                data-bs-dismiss="modal">Cancelar
                                                        </button>
                                                            <input type="hidden" class="form-control" name="idAlumnoAsignarRol" value=<%=aE.getAlumno().getIdAlumno()%>>
                                                            <input type="hidden" class="form-control" name="rolAsignar" value="barra">
                                                            <input type="hidden" class="form-control" name="idEvento" value="<%=aE.getEvento().getIdEvento()%>">
                                                            <input type="hidden" class="form-control" name="idAlumnoEvento" value="<%=aE.getIdAlumnoEvento()%>">
                                                            <button type="submit" class="btn btn-primary" id="Barra">Asignar Rol
                                                            </button>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        </form>
                                        <!-- FIN MODAL BARRA -->





                                    </tr>
                                    <%
                                            p++;
                                        }
                                    %>

                                    </tbody>
                                </table>

                                <!-- PAGINACION -->
                                <nav aria-label="Page navigation example">
                                    <ul class="pagination justify-content-center">
                                        <li class="page-item">
                                            <a class="page-link" href="#" aria-label="Previous">
                                                <span aria-hidden="true">&laquo;</span>
                                            </a>
                                        </li>
                                        <li class="page-item"><a class="page-link" href="#">1</a></li>
                                        <li class="page-item"><a class="page-link" href="#">2</a></li>
                                        <li class="page-item"><a class="page-link" href="#">3</a></li>
                                        <li class="page-item">
                                            <a class="page-link" href="#" aria-label="Next">
                                                <span aria-hidden="true">&raquo;</span>
                                            </a>
                                        </li>
                                    </ul>
                                </nav>

                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="assets/js/jquery-3.5.1.min.js"></script>
<script src="assets/js/popper.min.js"></script>
<script src="assets/js/bootstrap.min.js"></script>
<script src="assets/plugins/slimscroll/jquery.slimscroll.min.js"></script>
<script src="assets/js/script.js"></script>
<!--Script de bootstrap  -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL"
        crossorigin="anonymous"></script>
</body>

</html>
