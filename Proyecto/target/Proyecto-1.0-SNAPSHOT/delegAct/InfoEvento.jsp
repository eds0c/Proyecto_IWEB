<%@ page import="java.util.ArrayList" %>
<%@ page import="com.example.proyecto.beans.Evento" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.example.proyecto.beans.Alumno" %>
<jsp:useBean id="evento" scope="request" type="Evento" />
<jsp:useBean id="lista2" scope="request" type="ArrayList<Evento>" />
<%boolean participando = (Boolean) request.getAttribute("participando");%>


<html lang="en">

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
    <link rel="stylesheet" href="css/styleInfoEvento.css">
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
                <a id="inicio" href="<%=request.getContextPath() %>/DelegadoActividadServlet?action=main_page">
                    <ion-icon name="home-outline"></ion-icon>
                    <span>Inicio</span>
                </a>
            </li>

            <div class="linea"></div>

            <li>
                <a href="<%=request.getContextPath() %>/DelegadoActividadServlet?action=mis_eventos">
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
            <!-- Aquí hacemos CRUD -->
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
                <a href="<%=request.getContextPath()%>/SesionServlet?action=cerrar_sesion">
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
                    <!--<span class="email">codigo@pucp.edu.com</span>-->
                    <%if(session.getAttribute("usuariologueado")==null) {%>
                    <span class="email">codigo@pucp.edu.com</span>
                    <%}else{%>
                    <%Alumno alumnologueado = (Alumno) session.getAttribute("usuariologueado");%>
                    <span class="email"><%=alumnologueado.getNombre() + " " + alumnologueado.getApellido()%></span>
                    <%}%>
                </div>
                <!-- Colocarle función cambiar foto de perfil -->
                <ion-icon name="ellipsis-vertical-outline"></ion-icon>
            </div>
        </div>
    </div>

</div>


<main style="background-color: #c6e2e4;">
    <div class="container-fluid">
        <!-- Info de evento -->
        <div class="row info rounded-4" style="background-color: #f8f8f8;">
            <div class="col">
                <!-- Titulo del evento -->
                <h2 class="text-center"><strong><%=evento.getActividad().getTitulo()%>: <%=evento.getTitulo()%></strong></h2>
                <div class="row">
                    <!-- Imagen del evento -->
                    <div class="col-md-5 img-event" >
                        <!--<img src="images/valorant.avif" class="rounded-3" width="100%">-->
                        <img src="<%=request.getContextPath()%>/ImgServlet?id=<%=evento.getIdEvento()%>" width="100%" height="230">
                    </div>
                    <!-- Info del evento -->

                    <div class="col-md-7 info-event">
                        <div class="info-event-child">
                            <div class="row">
                                <h4>Descripción:</h4>
                                <p><%=evento.getDescripcion()%>
                                </p>
                            </div>

                            <div class="row">
                                <div class="col">
                                    <h4>Fecha:</h4>
                                    <p><%=evento.getFechaIn()%></p>
                                </div>
                                <div class="col">
                                    <h4>Hora:</h4>
                                    <p><%=evento.getHora()%></p>
                                </div>

                            </div>

                            <div class="row">
                                <h4>Lugar:</h4>
                                <p><%=evento.getLugar()%></p>
                            </div>



                            <div class="row">
                                <div class="col event_button">
                                    <%if (!participando){%>
                                    <button type="button" id="button-help"  class="btn btn-dark mx-auto"
                                            data-bs-toggle="modal" data-bs-target="#exampleModal">Apoyar al evento</button>
                                    <%}%>

                                    <%if(participando){%>
                                    <button type="button" aria-label="Close" id="button-help" class="btn btn-dark mx-auto disabled"
                                            data-bs-toggle="modal" data-bs-target="#exampleModal">Inscrito</button>
                                    <%};%>
                                </div>
                            </div>



                        </div>
                    </div>
                </div>




            </div>
        </div>
        <!-- Otros Eventos que puedan interesar -->
        <div class="row others">
            <div class="col">
                <h3>Otros eventos</h3>
                <div class="row row-cols-1 row-cols-sm-2 row-cols-md-3 row-cols-lg-4  g-4 mt-1 mb-3">

                    <%for (Evento e:lista2){%>
                    <!-- Evento 1 -->
                    <div class="col event mt-3">
                        <div class="card h-100">
                            <img src="<%=request.getContextPath()%>/ImgServlet?id=<%=e.getIdEvento()%>" width="250" height="230">
                            <div class="card-body d-flex justify-content-between">
                                <h5 class="card-title"><%=e.getActividad().getTitulo()%>: <div class="d-flex justify-content-between"><%=e.getTitulo()%></div></h5>
                                <!-- <div class="d-flex justify-content-between">
                                    <p class="card-text">Teleco vs. Ing electrónica</p>
                                    <p class="card-text mr-4 text-success">25 de octubre</p>
                                </div> -->
                                <a href="<%=request.getContextPath()%>/DelegadoActividadServlet?action=info_eventos&idEvento=<%=e.getIdEvento()%>" class="card-link" data-toggle="modal"
                                   data-target="#modalId">Ver
                                    evento</a>
                            </div>
                        </div>
                    </div>
                    <%}%>

                </div>
            </div>

        </div>

        <!-- Modal -->
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
                    <form method="post" action="<%=request.getContextPath()%>/AlumnoServlet?action=apoyar_evento">
                        <input type="hidden" class="form-control" name="idEventoApoyar" value=<%=evento.getIdEvento()%>>
                        <div class="modal-footer">
                            <button type="submit" class="btn btn-primary" data-bs-dismiss="modal">Ok</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>

</main>

<!-- Para deshabilitar el boton -->
<script>
    document.getElementById("button-help").addEventListener("click", function () {
        var button = this;
        button.innerHTML = "Solicitud enviada";
        button.style.backgroundColor = "rgba(0, 0, 0, 0.7)";
        button.disabled = true;
    });
</script>

<script type="module" src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.esm.js"></script>
<script nomodule src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.js"></script>
<script src="js/mainscript.js"></script>
<!--Script de bootstrap  -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL"
        crossorigin="anonymous"></script>
</body>

</html>