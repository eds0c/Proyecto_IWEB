<%@ page import="java.util.ArrayList" %>
<%@ page import="com.example.proyecto.beans.Evento" %>
<%@ page import="com.example.proyecto.beans.AlumnoEvento" %>
<%@ page import="com.example.proyecto.beans.Alumno" %>
<%@ page import="com.example.proyecto.beans.DelegadoActividad" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%boolean actividadIsFinalizada = (Boolean) request.getAttribute("actividadIsFinalizada");%>
<jsp:useBean id="lista" scope="request" type="ArrayList<Evento>" />
<jsp:useBean id="listaActividades" scope="request" type="ArrayList<com.example.proyecto.beans.DelegadoActividad>" />
<jsp:useBean id="usuariologueado" scope="session" type="com.example.proyecto.beans.Alumno" class="com.example.proyecto.beans.Alumno" />
<html lang="en">

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0">
    <title>Explora</title>
    <link rel="shortcut icon" type="image/x-icon" href="assets/img/IconoBat.png">
    <link rel="stylesheet" href="assets/css/bootstrap.min.css">
    <link rel="stylesheet" href="assets/plugins/fontawesome/css/all.min.css">
    <link rel="stylesheet" href="assets/css/feathericon.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.0/font/bootstrap-icons.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
    <link rel="stylesheet" href="assets/css/style.css">
    <link rel="stylesheet" href="css/styleFiltro.css">
</head>

<body>
<div class="main-wrapper">
    <!-- CABECERA -->
    <div class="header">
        <!-- CABECERA DE LA BARRA LATERAL -->
        <div class="header-left">
            <a href="<%=request.getContextPath() %>/DelegadoActividadServlet?action=main_page" class="logo text-decoration-none"> <img
                    src="assets/img/IconoBat.png" width="30" height="50" alt="logo"> <span
                    class="logoclass">TELEWEEK</span> </a>
        </div>
        <a class="text-decoration-none" href="javascript:void(0);" id="toggle_btn"> <i class="fe fe-text-align-left"></i> </a>
        <a class="mobile_btn text-decoration-none" id="mobile_btn"> <i class="fas fa-bars"></i> </a>
        <!-- NAVBAR -->
        <ul class="nav user-menu">
            <!-- FOTO DE PERFIL CON LAS OPCIONES DE EDITAR PERFIL Y DEMAS -->
            <li class="nav-item dropdown has-arrow">
                <a href="#" class="dropdown-toggle nav-link text-decoration-none" data-bs-toggle="dropdown"> <span class="user-img"><img
                        class="rounded-circle" src="assets/img/profiles/usuario.jpg" width="50"></span> </a>
                <!-- MENU DESPLEGABLE DE LA FLECHITA DE LA FOTO DE PERFIL -->
                <div class="dropdown-menu">
                    <div class="user-header">
                        <!-- nombre y rol del usuario -->
                        <div class="user-text">
                            <%if(session.getAttribute("usuariologueado")==null) {%>
                            <span class="email">codigo@pucp.edu.com</span>
                            <%}else{%>
                            <%Alumno alumnologueado = (Alumno) session.getAttribute("usuariologueado");%>
                            <span class="email"><%=alumnologueado.getNombre() + " " + alumnologueado.getApellido()%></span>
                            <%}%>
                            <p class="text-muted mb-0">Delegado Actividad</p>
                        </div>
                    </div>
                    <a class="dropdown-item text-decoration-none" href="<%=request.getContextPath() %>/DelegadoActividadServlet?action=perfil">Mi
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
                    <li><a class="text-decoration-none" href="<%=request.getContextPath() %>/DelegadoActividadServlet?action=main_page"><i class="bi bi-house-fill"></i>
                        <span>Inicio</span></a></li>
                    <li class="list-divider"></li>

                    <li class="menu-title mt-3"><span>PARTICIPACION</span></li>
                    <!-- EVENTOS INSCRITOS -->
                    <li><a class="text-decoration-none" href="<%=request.getContextPath() %>/DelegadoActividadServlet?action=mis_eventos"><i class="bi bi-calendar-event-fill"></i><span>Mis eventos</span></a>
                    </li>

                    <!-- DONACION -->
                    <li><a class="text-decoration-none" href="<%=request.getContextPath() %>/DelegadoActividadServlet?action=donaciones"><i class="bi bi-heart-fill"></i><span>Donaciones</span></a>
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
                    <li class="active"><a class="text-decoration-none" href="<%=request.getContextPath() %>/DelegadoActividadServlet?action=actividades_finalizadas"><i class="bi bi-calendar2-check-fill"></i><span>Act finalizadas</span></a>
                    </li>

                    <!-- CONTACTOS -->
                    <li class="list-divider"></li>
                    <li class="menu-title mt-3"><span>CONTACTOS</span></li>
                    <li><a class="text-decoration-none" href="https://www.instagram.com/aitel.pucp/" target="_blank"><i class="bi bi-instagram"></i>
                        <span>Instagram</span></a></li>
                    <li><a class="text-decoration-none" href="mailto:aitel@pucp.pe" target="_blank"><i class="fas fa-envelope"></i>
                        <span>Gmail</span></a></li>

                </ul>
            </div>
        </div>
    </div>

    <!-- TODO LO Q ESTA EN LA PAGINA SIN BARRA LATERAL -->
    <div class="page-wrapper">
        <div class="content container-fluid">
            <!-- FILTRO POR ACTIVIDADES -->
            <div class="row filter mt-5">
                <div class="col">
                    <div class="filter-buttons" id="buttons">
                        <i class="bi bi-arrow-left-circle-fill prev"></i>
                        <div class="slider">
                            <%for (DelegadoActividad dA : listaActividades){%>
                            <a class="button-value text-decoration-none" role="button" href="<%=request.getContextPath()%>/DelegadoActividadServlet?idAct=<%=dA.getActividad().getIdActividad()%>"><%=dA.getActividad().getTitulo()%></a>
                            <%};%>
                        </div>
                        <i class="bi bi-arrow-right-circle-fill next"></i>
                    </div>
                </div>
            </div>
            <!-- GALERÍA -->
            <section class="container mt-4">
                <h1 class="my-4 mt-4 text-sm-center text-lg-left image_title">Image Gallery</h1>
                <div class="row gallery">
                    <div class="col-lg-3 col-md-4 col-xs-6 thumb">
                        <a href="assets/img/product/product-01.jpg">
                            <figure><img class="img-fluid img-thumbnail" src="assets/img/product/product-01.jpg"
                                         alt="Random Image"></figure>
                        </a>
                    </div>
                    <div class="col-lg-3 col-md-4 col-xs-6 thumb">
                        <a href="assets/img/product/product-02.jpg">
                            <figure><img class="img-fluid img-thumbnail" src="assets/img/product/product-02.jpg"
                                         alt="Random Image"></figure>
                        </a>
                    </div>
                    <div class="col-lg-3 col-md-4 col-xs-6 thumb">
                        <a href="assets/img/product/product-03.jpg">
                            <figure><img class="img-fluid img-thumbnail" src="assets/img/product/product-03.jpg"
                                         alt="Random Image"></figure>
                        </a>
                    </div>


                </div>
            </section>
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
