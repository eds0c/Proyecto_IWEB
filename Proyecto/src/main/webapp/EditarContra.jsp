<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.example.proyecto.beans.Alumno" %>
<html lang="en">

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0">
    <title>Perfil</title>
    <link rel="shortcut icon" type="image/x-icon" href="assets/img/IconoBat.png">
    <link rel="stylesheet" href="assets/css/bootstrap.min.css">
    <link rel="stylesheet" href="assets/plugins/fontawesome/css/all.min.css">
    <link rel="stylesheet" href="assets/css/feathericon.min.css">
    <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.0/font/bootstrap-icons.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
    <link rel="stylesheet" href="assets/css/style.css">
    <link rel="stylesheet" href="css/styleContra.css"/>
</head>

<body>
<div class="main-wrapper">
    <!-- CABECERA -->
    <div class="header">
        <!-- CABECERA DE LA BARRA LATERAL -->
        <div class="header-left">
            <a href="<%=request.getContextPath() %>/AlumnoServlet?action=main_page" class="logo text-decoration-none"> <img
                    src="assets/img/IconoBat.png" width="30" height="50" alt="logo"> <span
                    class="logoclass">TELEWEEK</span> </a>
        </div>
        <a class="text-decoration-none" href="javascript:void(0);" id="toggle_btn"> <i class="fe fe-text-align-left"></i> </a>
        <a class="mobile_btn text-decoration-none" id="mobile_btn"> <i class="fas fa-bars"></i> </a>
        <!-- NAVBAR -->
        <ul class="nav user-menu">
            <!-- FOTO DE PERFIL CON LAS OPCIONES DE EDITAR PERFIL Y DEMAS -->
            <li class="nav-item dropdown has-arrow">
                <a href="#" class="dropdown-toggle nav-link text-decoration-none" data-bs-toggle="dropdown"> <span class="user-img"><%Alumno alumnologueado = (Alumno) session.getAttribute("usuariologueado");%>
                    <img
                            class="rounded-circle" src="<%=request.getContextPath()%>/ImgServlet?action=fotoPerfilAlumno&idAlumno=<%=alumnologueado.getIdAlumno()%>" width="50" height="50"></span> </a>
                <!-- MENU DESPLEGABLE DE LA FLECHITA DE LA FOTO DE PERFIL -->
                <div class="dropdown-menu">
                    <div class="user-header">
                        <!-- nombre y rol del usuario -->
                        <div class="user-text">
                            <%if(session.getAttribute("usuariologueado")==null) {%>
                            <span class="email">codigo@pucp.edu.com</span>
                            <%}else{%>
                            <%Alumno alumnologueado1 = (Alumno) session.getAttribute("usuariologueado");%>
                            <span class="email"><%=alumnologueado1.getNombre() + " " + alumnologueado1.getApellido()%></span>
                            <%}%>
                            <p class="text-muted mb-0">Alumno</p>
                        </div>
                    </div>
                    <a class="dropdown-item text-decoration-none" href="<%=request.getContextPath() %>/AlumnoServlet?action=perfil">Mi
                        Perfil</a>
                    <a class="dropdown-item text-decoration-none"
                       href="<%=request.getContextPath() %>/AlumnoServlet?action=cerrar_sesion">Cerrar
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
                    <li><a class="text-decoration-none" href="<%=request.getContextPath() %>/AlumnoServlet?action=main_page"><i class="bi bi-house-fill"></i>
                        <span>Inicio</span></a></li>
                    <li class="list-divider"></li>

                    <li class="menu-title mt-3"><span>PARTICIPACION</span></li>
                    <!-- EVENTOS INSCRITOS -->
                    <li><a class="text-decoration-none" href="<%=request.getContextPath() %>/AlumnoServlet?action=mis_eventos"><i class="bi bi-calendar-event-fill"></i><span>Mis eventos</span></a>
                    </li>

                    <!-- DONACION -->
                    <li><a class="text-decoration-none" href="<%=request.getContextPath() %>/AlumnoServlet?action=donaciones"><i class="bi bi-heart-fill"></i><span>Donaciones</span></a>
                    </li>

                    <li class="list-divider"></li>
                    <li class="menu-title mt-3"><span>EXPLORA</span></li>

                    <!-- NOVEDADES - ACT FINALIZADAS -->
                    <li class="list-divider"></li>
                    <li class="menu-title mt-3"><span>EXPLORA</span></li>
                    <li><a class="text-decoration-none" href="<%=request.getContextPath() %>/AlumnoServlet?action=actividades_finalizadas"><i class="bi bi-calendar2-check-fill"></i><span>Act finalizadas</span></a>
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
    <div class="main-wrapper login-body login_class">
        <div class="login-wrapper">
            <div class="container">
                <div class="loginbox login_pswd" style="min-height: 650px">
                    <div class="login-right">
                        <div class="text-center login-right-wrap mb-5 mt-5">
                            <div class="mb-3">
                                <img src="images/candado.png" width="80px">
                            </div>
                            <h2>Cambiar Contraseña</h2>
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
                            <form method="POST" action="<%=request.getContextPath()%>/AlumnoServlet?action=cambiar_contra">
                                <div class="field valid-password mt-3">
                                    <div class="input-field">
                                        <input type="password" placeholder="Contraseña actual" class="password" name="contraActual" required>
                                        <i class="bx bx-hide show-hide"></i>
                                    </div>
                                    <span class="error password-error">
                                        <i class="bx bx-error-circle error-icon"></i>
                                        <p class="error-text">
                                            Por favor, ingrese al menos 8 carácteres entre ellos un número,
                                            símbolo, letra minúscula y mayúscula.
                                        </p>
                                    </span>
                                </div>
                                <div class="field create-password mt-3">
                                    <div class="input-field">
                                        <input type="password" placeholder="Nueva contraseña" class="password" name="contra1" required>
                                        <i class="bx bx-hide show-hide"></i>
                                    </div>
                                    <span class="error password-error">
                                        <i class="bx bx-error-circle error-icon"></i>
                                        <p class="error-text">
                                            Por favor, ingrese al menos 8 carácteres entre ellos un número,
                                            símbolo, letra minúscula y mayúscula.
                                        </p>
                                    </span>
                                </div>
                                <div class="field confirm-password">
                                    <div class="input-field">
                                        <input type="password" placeholder="Confirme contraseña" class="cPassword" name="contra2" required>
                                        <i class="bx bx-hide show-hide"></i>
                                    </div>
                                    <span class="error cPassword-error">
                                        <i class="bx bx-error-circle error-icon"></i>
                                        <p class="error-text">Las contraseñas no coinciden</p>
                                    </span>
                                </div>
                                <div class="text-center">
                                    <button type="submit" class="btn btn-primary">Guardar cambios</button>
                                </div>
                            </form>
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
<script src="js/contrasena.js"></script>
</body>

</html>
