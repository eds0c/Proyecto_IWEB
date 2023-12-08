<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.example.proyecto.beans.Alumno" %>
<%@ page import="com.example.proyecto.beans.DelegadoGeneral" %>
<html lang="en">

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0">
    <title>TELEWEEK</title>
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
            <a href="<%=request.getContextPath() %>/DelegadoGeneralServlet?action=main_page" class="logo text-decoration-none"> <img
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
                            <%if (session.getAttribute("usuariologueado") == null) {%>
                            <span class="email">codigo@pucp.edu.com</span>
                            <%} else {%>
                            <%DelegadoGeneral delegadoGenerallogueado = (DelegadoGeneral) session.getAttribute("usuariologueado");%>
                            <h6><%=delegadoGenerallogueado.getNombre() + " " + delegadoGenerallogueado.getApellido()%>
                            </h6>
                            <%}%>
                            <p class="text-muted mb-0">Delegado General</p>
                        </div>
                    </div>
                    <a class="dropdown-item text-decoration-none" href="<%=request.getContextPath() %>/DelegadoGeneralServlet?action=perfil">Mi
                        Perfil</a>
                    <a class="dropdown-item text-decoration-none"
                       href="<%=request.getContextPath() %>/DelegadoGeneralServlet?action=cerrar_sesion">Cerrar
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
                    <li class="active"><a class="text-decoration-none" href="<%=request.getContextPath() %>/DelegadoGeneralServlet?action=main_page"><i
                            class="fas fa-tachometer-alt"></i> <span>Dashboard</span></a></li>
                    <li class="list-divider"></li>

                    <li class="menu-title mt-3"><span>ACCIONES</span></li>
                    <!-- USUARIOS -->
                    <li class="submenu"><a class="text-decoration-none" href="#"><i class="fas fa-user"></i> <span> Usuarios </span> <span
                            class="menu-arrow"></span></a>
                        <ul class="submenu_class" style="display: none;">
                            <li><a class="text-decoration-none" href="<%=request.getContextPath() %>/DelegadoGeneralServlet?action=validar_registro"> Solicitudes </a></li>
                            <li><a class="text-decoration-none" href="<%=request.getContextPath() %>/DelegadoGeneralServlet?action=lista_usuarios"> Registrados </a></li>
                        </ul>
                    </li>

                    <!-- DONACIONES -->
                    <li class="submenu"><a class="text-decoration-none" href="#"><i class="bi bi-heart-fill"></i> <span> Donaciones </span> <span
                            class="menu-arrow"></span></a>
                        <ul class="submenu_class" style="display: none;">
                            <li><a class="text-decoration-none" href="<%=request.getContextPath() %>/DelegadoGeneralServlet?action=validar_donaciones">Por verificar</a></li>
                            <li><a class="text-decoration-none" href="<%=request.getContextPath() %>/DelegadoGeneralServlet?action=lista_donaciones">Verificadas</a></li>
                            <li><a class="text-decoration-none" href="<%=request.getContextPath() %>/DelegadoGeneralServlet?action=donaciones_rechazadas">No validadas</a></li>
                        </ul>
                    </li>

                    <!-- ACTIVIDADES -->
                    <li><a class="text-decoration-none" href="<%=request.getContextPath() %>/DelegadoGeneralServlet?action=editar_actividades"><i class="bi bi-calendar-fill"></i><span>Actividades</span></a>
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
