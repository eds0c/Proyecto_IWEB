<%@ page import="java.util.ArrayList" %>
<%@ page import="com.example.proyecto.beans.AlumnoEvento" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.example.proyecto.beans.Alumno" %>
<%int cantidadPaginas = (int) request.getAttribute("cantidadPaginas");%>
<%int currentPageJsp = (int) request.getAttribute("currentPageJsp");%>
<jsp:useBean id="lista_mis_eventos" scope="request" type="ArrayList<AlumnoEvento>"/>
<html lang="en">

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0">
    <title>Mis Eventos</title>
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
            <a href="<%=request.getContextPath() %>/AlumnoServlet?action=main_page" class="logo text-decoration-none">
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
                        class="user-img"><%Alumno alumnologueado = (Alumno) session.getAttribute("usuariologueado");%>
                    <img
                            class="rounded-circle" src="<%=request.getContextPath()%>/ImgServlet?action=fotoPerfilAlumno&idAlumno=<%=alumnologueado.getIdAlumno()%>" width="50" height="50"></span> </a>
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
                            <p class="text-muted mb-0">Alumno</p>
                        </div>
                    </div>
                    <a class="dropdown-item text-decoration-none"
                       href="<%=request.getContextPath() %>/AlumnoServlet?action=perfil">Mi
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
                    <li><a class="text-decoration-none"
                           href="<%=request.getContextPath() %>/AlumnoServlet?action=main_page"><i
                            class="bi bi-house-fill"></i>
                        <span>Inicio</span></a></li>
                    <li class="list-divider"></li>

                    <li class="menu-title mt-3"><span>PARTICIPACION</span></li>
                    <!-- EVENTOS INSCRITOS -->
                    <li class="active"><a class="text-decoration-none"
                                          href="<%=request.getContextPath() %>/AlumnoServlet?action=mis_eventos"><i
                            class="bi bi-calendar-event-fill"></i><span>Mis eventos</span></a>
                    </li>

                    <!-- DONACION -->
                    <li><a class="text-decoration-none"
                           href="<%=request.getContextPath() %>/AlumnoServlet?action=donaciones"><i
                            class="bi bi-heart-fill"></i><span>Donaciones</span></a>
                    </li>

                    <!-- NOVEDADES - ACT FINALIZADAS -->
                    <li class="list-divider"></li>
                    <li class="menu-title mt-3"><span>EXPLORA</span></li>
                    <li><a class="text-decoration-none" href="<%=request.getContextPath() %>/AlumnoServlet?action=actividades_finalizadas"><i class="bi bi-calendar2-check-fill"></i><span>Act finalizadas</span></a>
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
                            <h4 class="card-title float-left mt-2">Mis eventos</h4>
                        </div>
                    </div>
                </div>
            </div>
            <%if (lista_mis_eventos.isEmpty()) {%>
            <p class="lead">Aún no te has incrito en ningún evento.</p>
            <%}%>


            <%--            poner aqui lo q quiera                  --%>
            <%for (AlumnoEvento aE : lista_mis_eventos) {%>
            <div class="card mb-5">
                <div class="card-header text-center" style="background-color: #dae0e5">
                    <strong><%=aE.getEvento().getActividad().getTitulo() + ": " + aE.getEvento().getTitulo()%>
                    </strong>
                </div>
                <div class="row">
                    <div class="col-md-4 ">
                        <img src="<%=request.getContextPath()%>/ImgServlet?action=fotoEvento&id=<%=aE.getEvento().getIdEvento()%>" class="w-100 h-100">
                    </div>
                    <div class="col-md-8">
                        <div class="card-body">
                            <p class="card-text"><%=aE.getEvento().getDescripcion()%>
                            </p>
                            <p class="card-text">Rol asignado para el evento: <strong><%= aE.getIntegrante().getDescripcion() %></strong>
                            </p>

                            <div class="row mt-3">
                                <!-- fecha del evento -->
                                <div class="col md-4">
                                    <h6>Fecha:</h6>
                                    <div class="d-flex align-items-center ">
                                        <i class="bi bi-calendar"></i>
                                        <p class="mb-0 ml-2"><%=aE.getEvento().getFechaIn()%>
                                        </p>
                                    </div>

                                </div>
                                <!-- hora del evento -->
                                <div class="col md-4">
                                    <h6>Hora:</h6>
                                    <div class="d-flex align-items-center">
                                        <i class="bi bi-clock"></i>
                                        <p class="mb-0 ml-2"><%=aE.getEvento().getHora()%>
                                        </p>
                                    </div>

                                </div>

                                <!-- lugar del evento -->
                                <div class="col md-4">
                                    <h6>Lugar:</h6>
                                    <div class="d-flex align-items-center">
                                        <i class="bi bi-geo-alt"></i>
                                        <p class="mb-0 ml-2"><%=aE.getEvento().getLugar()%>
                                        </p>
                                    </div>
                                </div>
                            </div>

                        </div>
                    </div>
                </div>
            </div>
            <%}%>

            <!-- Paginacion -->
            <div class="row footer">
                <div class="col">
                    <nav aria-label="Page navigation example">
                        <ul class="pagination justify-content-center">
                            <%int auxStart, auxEnd;%>
                            <%if(currentPageJsp == 1){%>
                            <%auxStart=1;} else {%>
                            <%auxStart=currentPageJsp-1;}%>

                            <%if(currentPageJsp == cantidadPaginas){%>
                            <%auxEnd=cantidadPaginas;} else {%>
                            <%auxEnd=currentPageJsp+1;}%>
                            <li class="page-item">
                                <a class="page-link" href="<%=request.getContextPath() %>/AlumnoServlet?action=mis_eventos&currentPage=<%=auxStart%>" aria-label="Previous">
                                    <span aria-hidden="true">&laquo;</span>
                                </a>
                            </li>
                            <%for (int j=1;j<=cantidadPaginas;j++){%>
                            <%if(currentPageJsp == j){%>
                            <li class="page-item active"><a class="page-link" href="<%=request.getContextPath() %>/AlumnoServlet?action=mis_eventos&currentPage=<%=j%>"><%=j%></a></li>
                            <%} else {%>
                            <li class="page-item"><a class="page-link" href="<%=request.getContextPath() %>/AlumnoServlet?action=mis_eventos&currentPage=<%=j%>"><%=j%></a></li>
                            <%}%>

                            <%}%>
                            <li class="page-item">
                                <a class="page-link" href="<%=request.getContextPath() %>/AlumnoServlet?action=mis_eventos&currentPage=<%=auxEnd%>" aria-label="Next">
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
