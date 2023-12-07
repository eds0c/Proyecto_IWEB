<%@ page import="java.util.ArrayList" %>
<%@ page import="com.example.proyecto.beans.Evento" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.example.proyecto.beans.Alumno" %>
<jsp:useBean id="evento" scope="request" type="Evento"/>
<jsp:useBean id="lista2" scope="request" type="ArrayList<Evento>" />
<%boolean participando = (Boolean) request.getAttribute("participando");%>
<html lang="en">

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0">
    <title>Evento</title>
    <link rel="shortcut icon" type="image/x-icon" href="assets/img/IconoBat.png">
    <link rel="stylesheet" href="assets/css/bootstrap.min.css">
    <link rel="stylesheet" href="assets/plugins/fontawesome/css/all.min.css">
    <link rel="stylesheet" href="assets/css/feathericon.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.0/font/bootstrap-icons.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
    <link rel="stylesheet" href="assets/css/style.css">
</head>

<body>
<div class="main-wrapper">
    <!-- CABECERA -->
    <div class="header">
        <!-- CABECERA DE LA BARRA LATERAL -->
        <div class="header-left">
            <a href="<%=request.getContextPath() %>/DelegadoActividadServlet?action=main_page" class="logo text-decoration-none">
                <img
                        src="assets/img/IconoBat.png" width="30" height="50" alt="logo"> <span
                    class="logoclass">TELEWEEK</span> </a>
        </div>
        <a class="text-decoration-none" href="javascript:void(0);" id="toggle_btn"> <i
                class="fe fe-text-align-left"></i> </a>
        <a class="mobile_btn text-decoration-none" id="mobile_btn"> <i class="fas fa-bars"></i> </a>
        <!-- NAVBAR -->
        <ul class="nav user-menu">
            <!-- FOTO DE PERFIL CON LAS OPCIONES DE EDITAR PERFIL Y DEMAS -->
            <li class="nav-item dropdown has-arrow">
                <a href="#" class="dropdown-toggle nav-link text-decoration-none" data-bs-toggle="dropdown"> <span
                        class="user-img"><img
                        class="rounded-circle" src="assets/img/profiles/usuario.jpg" width="50"></span> </a>
                <!-- MENU DESPLEGABLE DE LA FLECHITA DE LA FOTO DE PERFIL -->
                <div class="dropdown-menu">
                    <div class="user-header">
                        <!-- nombre y rol del usuario -->
                        <div class="user-text">
                            <%if (session.getAttribute("usuariologueado") == null) {%>
                            <span class="email">codigo@pucp.edu.com</span>
                            <%} else {%>
                            <%Alumno alumnologueado = (Alumno) session.getAttribute("usuariologueado");%>
                            <span class="email"><%=alumnologueado.getNombre() + " " + alumnologueado.getApellido()%></span>
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
                    <li><a class="text-decoration-none" href="<%=request.getContextPath() %>/DelegadoActividadServlet?action=mi_actividad"><i class="bi bi-file-earmark-text-fill"></i><span>Mi Actividad</span></a>
                    </li>

                    <!-- NOVEDADES - ACT FINALIZADAS -->
                    <li class="list-divider"></li>
                    <li class="menu-title mt-3"><span>EXPLORA</span></li>
                    <li><a class="text-decoration-none"
                           href="<%=request.getContextPath() %>/DelegadoActividadServlet?action=eventos_finalizados"><i
                            class="bi bi-calendar2-check-fill"></i><span>Act finalizadas</span></a>
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
        <div class="content mt-5">
            <div class="row">
                <div class="col-sm-12">
                    <h4 class="page-title">Actividad: <%=evento.getActividad().getTitulo()%>
                    </h4></div>
            </div>
            <div class="row mt-3">
                <div class="col-md-10 mx-auto">
                    <div class="blog-view">
                        <article class="blog blog-single-post">
                            <h3 class="blog-title"><%=evento.getTitulo()%>
                            </h3>
                            <!-- imagen del evento -->
                            <div class="blog-image">
                                <div class="col-md-10 mx-auto">
                                    <img alt="" src="<%=request.getContextPath()%>/ImgServlet?id=<%=evento.getIdEvento()%>" class="img-fluid mt-4">
                                </div>
                            </div>

                            <div class="blog-content mt-4">
                                <div class="col-md-10 mx-auto">
                                    <div class="row">
                                        <div class="col md-10 mx-auto">
                                            <!-- descripción del evento -->
                                            <p class="text-justify"><%=evento.getDescripcion()%></p>
                                        </div>
                                    </div>
                                    <div class="row mt-3">
                                        <div class="col md-10 mx-auto">
                                            <div class="row">
                                                <!-- fecha del evento -->
                                                <div class="col md-4">
                                                    <h5>Fecha:</h5>
                                                    <div class="d-flex align-items-center ">
                                                        <i class="bi bi-calendar"></i>
                                                        <p class="mb-0 ml-2"><%=evento.getFechaIn()%>
                                                        </p>
                                                    </div>

                                                </div>
                                                <!-- hora del evento -->
                                                <div class="col md-4">
                                                    <h5>Hora:</h5>
                                                    <div class="d-flex align-items-center">
                                                        <i class="bi bi-clock"></i>
                                                        <p class="mb-0 ml-2"><%=evento.getHora()%>
                                                        </p>
                                                    </div>

                                                </div>

                                                <!-- lugar del evento -->
                                                <div class="col md-4">
                                                    <h5>Lugar:</h5>
                                                    <div class="d-flex align-items-center">
                                                        <i class="bi bi-geo-alt"></i>
                                                        <p class="mb-0 ml-2"><%=evento.getLugar()%>
                                                        </p>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <!-- boton para inscribirse evento -->
                                    <div class="row mt-4 text-center">
                                        <%if (!participando) {%>
                                        <button type="button" id="button-help" class="btn btn-dark mx-auto"
                                                data-bs-toggle="modal" data-bs-target="#exampleModal">Apoyar al evento
                                        </button>
                                        <%}%>

                                        <%if (participando) {%>
                                        <button type="button" aria-label="Close" id="button-help"
                                                class="btn btn-dark mx-auto disabled"
                                                data-bs-toggle="modal" data-bs-target="#exampleModal">Inscrito
                                        </button>
                                        <%
                                            }
                                            ;
                                        %>

                                    </div>
                                    <!-- Modal de apoyar evento  -->
                                    <div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
                                        <div class="modal-dialog">
                                            <div class="modal-content">
                                                <div class="modal-header">
                                                    <h1 class="modal-title fs-5" id="exampleModalLabel">Solicitud enviada</h1>
                                                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                                </div>
                                                <div class="modal-body">
                                                    <p>Espere a que el delegado confirme su solicitud de registro</p>
                                                </div>
                                                <form method="post" action="<%=request.getContextPath()%>/DelegadoActividadServlet?action=apoyar_evento">
                                                    <input type="hidden" class="form-control" name="idEventoApoyar" value=<%=evento.getIdEvento()%>>
                                                    <div class="modal-footer">
                                                        <button type="submit" class="btn btn-primary"  data-bs-dismiss="modal">Ok</button>
                                                    </div>
                                                </form>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                            </div>
                        </article>

                        <!-- INFO DEL DELEGADO Q CREO LA ACTIVIDAD ? -->
                        <div class="widget author-widget clearfix">
                            <h3>Delegado de actividad</h3>
                            <div class="about-author">
                                <div class="about-author-img">
                                    <div class="author-img-wrap"><img class="img-fluid rounded-circle" alt=""
                                                                      src="assets/img/profiles/avatar-15.jpg"></div>
                                </div>
                                <div class="author-details"><span class="blog-author-name">Linda Barrett</span>
                                    <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor
                                        incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis
                                        nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo
                                        consequat.</p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<!-- Para deshabilitar el boton -->
<script>
    document.getElementById("button-help").addEventListener("click", function () {
        var button = this;
        button.innerHTML = "Solicitud enviada";
        button.style.backgroundColor = "rgba(0, 0, 0, 0.7)";
        button.disabled = true;
    });
</script>
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
