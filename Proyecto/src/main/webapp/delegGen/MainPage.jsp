<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.example.proyecto.beans.Alumno" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.example.proyecto.beans.DelegadoGeneral" %>
<%@ page import="com.example.proyecto.Dtos.IntegrantesPorActividad" %>
<%@ page import="com.example.proyecto.Dtos.DonacionesPorFecha" %>
<%int cantidadEgresados = (int) request.getAttribute("cantidadEgresados");%>
<%int cantidadEstudiantes = (int) request.getAttribute("cantidadEstudiantes");%>
<jsp:useBean id="integrantesPorActividadLista" scope="request" type="ArrayList<com.example.proyecto.Dtos.IntegrantesPorActividad>"/>
<jsp:useBean id="donacionesPorFechaLista" scope="request" type="ArrayList<com.example.proyecto.Dtos.DonacionesPorFecha>"/>
<jsp:useBean id="sumaDonacionesPorFechaLista" scope="request" type="ArrayList<com.example.proyecto.Dtos.DonacionesPorFecha>"/>

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
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
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
                <a href="#" class="dropdown-toggle nav-link text-decoration-none" data-bs-toggle="dropdown"> <span class="user-img"><%DelegadoGeneral delegadoGenerallogueado = (DelegadoGeneral) session.getAttribute("usuariologueado");%>
                    <img
                            class="rounded-circle" src="<%=request.getContextPath()%>/ImgServlet?action=fotoPerfilDeleGen&idDeleGen=<%=delegadoGenerallogueado.getIdDelegadoGeneral()%>" width="50" height="50"></span> </a>
                <!-- MENU DESPLEGABLE DE LA FLECHITA DE LA FOTO DE PERFIL -->
                <div class="dropdown-menu">
                    <div class="user-header">
                        <!-- nombre y rol del usuario -->
                        <div class="user-text">
                            <%if (session.getAttribute("usuariologueado") == null) {%>
                            <span class="email">codigo@pucp.edu.com</span>
                            <%} else {%>
                            <%DelegadoGeneral delegadoGenerallogueado1 = (DelegadoGeneral) session.getAttribute("usuariologueado");%>
                            <h6><%=delegadoGenerallogueado1.getNombre() + " " + delegadoGenerallogueado1.getApellido()%>
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
                            <li><a class="text-decoration-none" href="<%=request.getContextPath() %>/DelegadoGeneralServlet?action=usuarios_rechazados"> Rechazados </a></li>
                            <li><a class="text-decoration-none" href="<%=request.getContextPath() %>/DelegadoGeneralServlet?action=usuarios_baneados"> Baneados </a></li>
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
    <div class="page-wrapper" style="min-height: 755px;">
        <div class="content container-fluid">
            <div class="page-header">
                <div class="row">
                    <div class="col-sm-12 mt-5">
                        <h3 class="page-title mt-3">¡Bienvenido! Tu centro de comando está listo</h3>
                        <ul class="breadcrumb">
                            <li class="breadcrumb-item active">Dashboard</li>
                        </ul>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-md-12 d-flex">
                    <div class="card flex-fill">
                        <div class="card-header">
                            <h4 class="card-title">PARTICIPANTES</h4></div>
                        <div class="card-body">
                            <div class="row">
                                <!-- grafica pastel para participantes (alumnos y egresados) -->
                                <div class="col-lg-5 d-flex justify-content-center">
                                    <div style="width: 350px">
                                        <canvas id="participantes" width="350" height="350" style="display: block; box-sizing: border-box; height: 350px; width: 350px;"></canvas>
                                    </div>

                                </div>
                                <div class="col-lg-6 d-flex justify-content-center align-items-center">
                                    <div>
                                        <p class="text-justify">Esta representación ofrece un análisis porcentual detallado que compara la participación de nuestros alumnos y egresados
                                            de la carrera de Telecomunicaciones.
                                            Para obtener información más específica sobre los participantes, te invitamos a explorar la sección de usuarios registrados.</p>
                                        <a class="btn btn-block active" href="<%=request.getContextPath() %>/DelegadoGeneralServlet?action=lista_usuarios">Usuarios registrados</a>
                                    </div>
                                </div>

                            </div>

                        </div>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-md-12 d-flex">
                    <div class="card flex-fill">
                        <div class="card-header">
                            <h4 class="card-title">DONACIONES</h4></div>
                        <div class="card-body">
                            <p>La siguiente gráfica ilustra las recaudaciones
                                resultantes de las donaciones realizadas por los usuarios de Teleweek hacia
                                la AITEL durante la semana de Ingeniería.</p>
                            <!-- grafica lineal de donaciones por fechas -->
                            <div style="min-height: 350px">
                                <canvas id="donaciones" width="1184" height="300" style="display: block; box-sizing: border-box; height: 150px; width: 592px;"></canvas>
                            </div>

                        </div>
                    </div>
                </div>
            </div>

            <div class="row">
                <div class="col-md-12 d-flex">
                    <div class="card flex-fill">
                        <div class="card-header">
                            <h4 class="card-title">DONACIONES</h4></div>
                        <div class="card-body">
                            <p>La siguiente gráfica ilustra las recaudaciones
                                resultantes de las donaciones realizadas por los usuarios de Teleweek hacia
                                la AITEL durante la semana de Ingeniería.</p>
                            <!-- grafica lineal de la suma de las donaciones por fechas -->
                            <div style="min-height: 350px">
                                <canvas id="donacionesSuma" width="1184" height="300" style="display: block; box-sizing: border-box; height: 150px; width: 592px;"></canvas>
                            </div>

                        </div>
                    </div>
                </div>
            </div>

            <div class="row">
                <div class="col-md-12 d-flex">
                    <div class="card flex-fill">
                        <div class="card-header">
                            <h4 class="card-title">APOYO ACTIVIDADES</h4>
                        </div>
                        <div class="card-body">
                            <p>La siguiente gráfica estadística detalla la distribución de apoyos
                                según diversas actividades dentro de nuestra organización, este apoyo se divide entre
                                equipo y barra.</p>
                            <div style="min-height: 350px">
                                <canvas id="apoyoAct" width="1184" height="300" style="display: block; box-sizing: border-box; height: 150px; width: 592px;"></canvas>
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
<!-- participantes -->
<script>
    let participantes = document.getElementById("participantes").getContext("2d");
    var chart = new Chart(participantes, {
        type: "doughnut",
        data: {
            labels: ["Estudiante", "Egresado"],
            datasets: [{
                label: 'Inscritos a Teleweek',
                data: [<%=cantidadEstudiantes%>, <%=cantidadEgresados%>],
                backgroundColor: [
                    'rgb(255, 99, 132)',
                    'rgba(75, 192, 192, 1)',
                ],
                hoverOffset: 4
            }]
        }
    })
</script>
<!-- donaciones -->
<script>
    document.addEventListener("DOMContentLoaded", function () {
        let donaciones = document.getElementById("donaciones").getContext("2d");
        var chart = new Chart(donaciones, {
            type: "line",
            data: {
                labels: [<%for(DonacionesPorFecha d: donacionesPorFechaLista){%><%="'" + d.getFecha() + "',"%><%}%>],
                datasets: [
                    {
                        label: "Donaciones",
                        borderColor: 'rgba(75, 192, 192, 1)', // Color del borde
                        borderWidth: 1,
                        data: [<%for(DonacionesPorFecha d: donacionesPorFechaLista){%><%=d.getSumaDonaciones() + ","%><%}%>], // Valores para cada categoría
                    }
                ]
            },
            options: {
                maintainAspectRatio: false,
                responsive: true
            }
        });
    });
</script>
<!-- donaciones suma-->
<script>
    document.addEventListener("DOMContentLoaded", function () {
        let donaciones = document.getElementById("donacionesSuma").getContext("2d");
        var chart = new Chart(donaciones, {
            type: "line",
            data: {
                labels: [<%for(DonacionesPorFecha d: donacionesPorFechaLista){%><%="'" + d.getFecha() + "',"%><%}%>],
                datasets: [
                    {
                        label: "Donaciones",
                        borderColor: 'rgba(75, 192, 192, 1)', // Color del borde
                        borderWidth: 1,
                        data: [<%for(DonacionesPorFecha d: sumaDonacionesPorFechaLista){%><%=d.getSumaDonaciones() + ","%><%}%>], // Valores para cada categoría
                    }
                ]
            },
            options: {
                maintainAspectRatio: false,
                responsive: true
            }
        });
    });
</script>
<!-- apoyo actividad -->
<script>
    document.addEventListener("DOMContentLoaded", function () {
        let apoyoAct = document.getElementById("apoyoAct").getContext("2d");
        var chart = new Chart(apoyoAct, {
            type: "bar",
            data: {
                labels: [<%for(IntegrantesPorActividad i: integrantesPorActividadLista){%><%="'" + i.getActividad().getTitulo() + "',"%><%}%>],
                datasets: [
                    {
                        label: "Equipo",
                        backgroundColor: 'rgba(75, 192, 192, 0.2)', // Color de fondo
                        borderColor: 'rgba(75, 192, 192, 1)', // Color del borde
                        borderWidth: 1,
                        data: [<%for(IntegrantesPorActividad i: integrantesPorActividadLista){%><%=i.getCantidadIntegrantesEquipo() + ","%><%}%>], // Valores para cada categoría
                    }, {
                        label: 'Barra',
                        backgroundColor: 'rgba(255, 99, 132, 0.2)',
                        borderColor: 'rgba(255, 99, 132, 1)',
                        borderWidth: 1,
                        data: [<%for(IntegrantesPorActividad i: integrantesPorActividadLista){%><%=i.getCantidadIntegrantesBarra() + ","%><%}%>],
                    }
                ]
            },
            options: {
                maintainAspectRatio: false,
                responsive: true
            }
        });
    });
</script>
</body>

</html>
