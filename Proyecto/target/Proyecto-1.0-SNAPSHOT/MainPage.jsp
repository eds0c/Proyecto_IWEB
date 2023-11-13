<%@ page import="java.util.ArrayList" %>
<%@ page import="com.example.proyecto.beans.Evento" %>
<%@ page import="com.example.proyecto.beans.DelegadoActividad" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:useBean id="lista" scope="request" type="ArrayList<Evento>" />
<jsp:useBean id="listaActividades" scope="request" type="ArrayList<com.example.proyecto.beans.DelegadoActividad>" />

<html>

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Semana Teleco</title>
    <!-- Icono de pestaña -->
    <link rel="icon" href="images/IconoBat.png" />
    <!-- Iconos -->
    <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
    <!-- bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
    <!-- css -->
    <link rel="stylesheet" href="css/styleMain.css">

</head>

<body>
<div class="menu">
    <ion-icon name="menu-outline"></ion-icon>
    <ion-icon name="close-outline"></ion-icon>
</div>

<div class="barra-lateral">
    <div>
        <div class="nombre-pagina">
            <ion-icon id="menubar" name="menu-outline"></ion-icon>
            <span>Semana Teleco</span>

        </div>

    </div>

    <nav class="navegacion">
        <ul>
            <li>
                <!-- Se coloca id para que cuando estemos en esa opción del menú este icono esté seleccionado -->
                <a id="inicio" href="<%=request.getContextPath()%>/AlumnoServlet?action=main_page">
                    <ion-icon name="home-outline"></ion-icon>
                    <span>Inicio</span>
                </a>
            </li>

            <div class="linea"></div>

            <li>
                <a href="<%=request.getContextPath()%>/AlumnoServlet?action=mis_eventos">
                    <ion-icon name="calendar-clear-outline"></ion-icon>
                    <span>Mis eventos</span>
                </a>
            </li>
            <li>
                <a href="<%=request.getContextPath()%>/AlumnoServlet?action=eventos_finalizados">
                    <ion-icon name="medal-outline"></ion-icon>
                    <span>Finalizados</span>
                </a>
            </li>

            <div class="linea"></div>

            <li>
                <a href="<%=request.getContextPath()%>/AlumnoServlet?action=donaciones">
                    <ion-icon name="heart-outline"></ion-icon>
                    <span>Donaciones</span>
                </a>
            </li>

            <div class="linea"></div>

            <li>
                <a href="https://www.instagram.com/aitel.pucp/" target="_blank">
                    <ion-icon name="logo-instagram"></ion-icon>
                    <span>Instagram</span>
                </a>
            </li>
            <li>
                <a href="mailto:aitel@pucp.pe" target="_blank">
                    <ion-icon name="mail-outline"></ion-icon>
                    <span>Gmail</span>
                </a>
            </li>
            <div class="linea"></div>
            <li>
                <a href="<%=request.getContextPath()%>/SesionServlet?action=inicio_sesion">
                    <ion-icon name="log-out-outline"></ion-icon>
                    <span>Iniciar sesión</span>
                </a>
            </li>
        </ul>
    </nav>

    <div>
        <div class="linea"></div>
        <!-- Tratar de colocar el botón de cerrar sesión aqui -->
        <div class="modo-oscuro">
            <div class="info">
                <ion-icon name="moon-outline"></ion-icon>
                <span>Dark Mode</span>
            </div>
            <div class="switch">
                <div class="base">
                    <div class="circulo">

                    </div>
                </div>
            </div>

        </div>


        <div class="usuario">
            <img src="images/usuario.jpg">
            <div class="info-usuario">
                <div class="nombre-email">
                    <span class="nombre">Usuario</span>
                    <span class="email">codigo@pucp.edu.com</span>
                </div>
                <!-- Colocarle función cambiar foto de perfil -->
                <ion-icon name="ellipsis-vertical-outline"></ion-icon>
            </div>
        </div>
    </div>

</div>

<main style="background-color: #c6e2e4;">
    <div class="container-fluid">
        <!-- Header -->
        <div class="row header">
            <div class="col">
                <!-- Busqueda eventos -->
                <div class="row search">
                    <div class="col">
                        <form class="search-form" id="search-container">
                            <input type="search" placeholder="Buscar evento..." id="search-input">
                            <button class="btn-search">
                                <ion-icon name="search-outline"></ion-icon>
                            </button>

                        </form>
                    </div>
                </div>
                <!-- Filtro por actividades -->
                <div class="row filter">
                    <div class="col">
                        <div class="filter-buttons" id="buttons">
                            <ion-icon name="chevron-back-outline" class="prev"></ion-icon>
                            <div class="slider">
                                <%for (DelegadoActividad dA : listaActividades){%>
                                <a href="<%=request.getContextPath()%>/DelegadoActividadServlet?idAct=<%=dA.getActividad().getIdActividad()%>" class="button-value" role="button" ><%=dA.getActividad().getTitulo()%></a>
                                <%};%>
                            </div>
                            <ion-icon name="chevron-forward-outline" class="next"></ion-icon>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Contenido -->
        <div class="row content">
            <div class="col">
                <div class="row row-cols-1 row-cols-sm-2 row-cols-md-3 row-cols-lg-4  g-4 mt-2 mb-3">

                    <%for (Evento e: lista){%>
                    <!-- Eventos -->
                    <div class="col event">
                        <div class="card h-100">
                            <img src="images/valorant.avif" class="card-img-top" alt="...">
                            <div class="card-body">
                                <h5 class="card-title"><%=e.getActividad().getTitulo()%></h5>
                                <div class="d-flex justify-content-between">
                                    <p class="card-text"><%=e.getTitulo()%></p>
                                    <p class="card-text mr-4 text-success">Fecha: <%=e.getFechaIn()%></p>
                                </div>
                                <a href="<%=request.getContextPath()%>/AlumnoServlet?action=info_eventos&idEvento=<%=e.getIdEvento()%>" class="card-link" data-toggle="modal" data-target="#modalId">Ver
                                    evento</a>
                            </div>
                        </div>
                    </div>
                    <%};%>

                </div>
            </div>
        </div>


        <!-- Footer -->
        <div class="row footer">
            <div class="col">
                <nav aria-label="Page navigation example">
                    <ul class="pagination">
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


</main>



<!-- js para icons -->
<script type="module" src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.esm.js"></script>
<script nomodule src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.js"></script>
<script src="js/mainscript.js"></script>
<!--Script de bootstrap  -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL"
        crossorigin="anonymous"></script>
</body>

</html>