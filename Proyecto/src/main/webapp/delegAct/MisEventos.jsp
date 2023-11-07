<%@ page import="java.util.ArrayList" %>
<%@ page import="com.example.proyecto.beans.AlumnoEvento" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:useBean id="lista_mis_eventos" scope="request" type="ArrayList<AlumnoEvento>" />
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Mis Eventos</title>
    <!-- Icono de pestaña -->
    <link rel="icon" href="images/IconoBat.png" />
    <!-- Iconos -->
    <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
    <!-- bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
    <!-- css -->
    <link rel="stylesheet" href="css/styleEventos.css">
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
                <a href="<%=request.getContextPath() %>/DelegadoActividadServlet?action=main_page">
                    <ion-icon name="home-outline"></ion-icon>
                    <span>Inicio</span>
                </a>
            </li>

            <div class="linea"></div>

            <li>
                <a id="misEventos" href="<%=request.getContextPath() %>/DelegadoActividadServlet?action=mis_eventos">
                    <ion-icon name="calendar-clear-outline"></ion-icon>
                    <span>Mis eventos</span>
                </a>
            </li>
            <li>
                <a href="<%=request.getContextPath() %>/DelegadoActividadServlet?action=eventos_finalizados">
                    <ion-icon name="medal-outline"></ion-icon>
                    <span>Finalizados</span>
                </a>
            </li>

            <div class="linea"></div>

            <li>
                <a href="<%=request.getContextPath() %>/DelegadoActividadServlet?action=donaciones">
                    <ion-icon name="heart-outline"></ion-icon>
                    <span>Donaciones</span>
                </a>
            </li>

            <li>
                <a href="<%=request.getContextPath() %>/DelegadoActividadServlet?action=mi_actividad">
                    <ion-icon name="clipboard-outline"></ion-icon>
                    <span>Mi actividad</span>
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
                <a href="<%=request.getContextPath()%>/DelegadoActividadServlet?action=cerrar_sesion">
                    <ion-icon name="log-out-outline"></ion-icon>
                    <span>Cerrar sesión</span>
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
        <!-- header -->
        <div class="row header" style="background-color: #7c9da0;">
            <div class="col">
                <h1>Eventos inscritos</strong></h1>
            </div>
        </div>

        <!-- Eventos inscritos -->
        <div class="row eventos-inscritos">
            <div class="col">



                <!-- Generador por bucle: ----------------------------------------------------------------------------------------------->
                <%for (AlumnoEvento aE: lista_mis_eventos){%>
                <!-- Info de evento inscrito -->
                <div class="row box-info rounded-4" style="background-color: #f8f8f8;">
                    <div class="col">
                        <!-- Titulo de la actividad -->
                        <h2 class="text-center"><strong><%=aE.getEvento().getActividad().getDescripcion()%></strong></h2>
                        <div class="row">
                            <!-- Imagen del evento -->
                            <div class="col-md-5 img-event">
                                <img src="images/valorant.avif" class="rounded-3" width="100%">
                            </div>
                            <!-- Info del evento -->
                            <div class="col-md-7 info-event">
                                <div class="info-event-child">
                                    <div class="row">
                                        <h4>Descripcion</h4>
                                        <p><%=aE.getEvento().getDescripcion()%>
                                        </p>
                                    </div>

                                    <div class="row">
                                        <div class="col">
                                            <h4>Fecha:</h4>
                                            <p><%=aE.getEvento().getFechaIn()%></p>
                                        </div>
                                        <div class="col">
                                            <h4>Hora:</h4>
                                            <p><%=aE.getEvento().getHora()%></p>
                                        </div>

                                    </div>

                                    <div class="row">
                                        <h4>Lugar:</h4>
                                        <p><%=aE.getEvento().getLugar()%></p>
                                    </div>

                                    <div class="row">
                                        <h4>Rol:</h4>
                                        <p><%= aE.getIntegrante().getDescripcion()%></p>
                                    </div>

                                </div>
                            </div>
                        </div>

                    </div>
                </div>
                <%}%>
            </div>
        </div>



        <!-- Footer -->
        <div class="row footer">
            <div class="col">
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


    <script type="module" src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.esm.js"></script>
    <script nomodule src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.js"></script>
    <script src="../js/mainscript.js"></script>
    <!--Script de bootstrap  -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL"
            crossorigin="anonymous"></script>
</body>

</html>
