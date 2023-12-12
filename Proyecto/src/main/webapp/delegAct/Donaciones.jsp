<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.example.proyecto.beans.Alumno" %>
<%boolean actividadIsFinalizada = (Boolean) request.getAttribute("actividadIsFinalizada");%>
<html lang="en">

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0">
    <title>Donaciones</title>
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
                <a href="#" class="dropdown-toggle nav-link text-decoration-none" data-bs-toggle="dropdown"> <span class="user-img"><%Alumno alumnologueado = (Alumno) session.getAttribute("usuariologueado");%>
                    <img
                            class="rounded-circle" src="<%=request.getContextPath()%>/ImgServlet?action=fotoPerfilDeleAct&idd=<%=alumnologueado.getIdAlumno()%>" width="50" height="50"></span> </a>
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
                    <li class="active"><a class="text-decoration-none" href="<%=request.getContextPath() %>/DelegadoActividadServlet?action=donaciones"><i class="bi bi-heart-fill"></i><span>Donaciones</span></a>
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
                    <li><a class="text-decoration-none"
                           href="<%=request.getContextPath() %>/DelegadoActividadServlet?action=actividades_finalizadas"><i
                            class="bi bi-calendar2-check-fill"></i><span>Act finalizadas</span></a>
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
        <div class="content mt-5">
            <div class="row">
                <div class="col-sm-12">
                    <h4 class="page-title">Donación a AITEL
                    </h4>
                </div>
                <div class="row mt-2">
                    <div class="col-sm-12">
                        <p style="text-align: justify;">En el caso de que el usuario sea un egresado de la facultad de Telecomunicaciones, se establece un monto mínimo de donación de 100 soles.
                            Esta determinación se fundamenta en la inclusión de un kit teleco que se entregará como parte de los beneficios para los egresados.
                            Esta contribución mínima tiene como objetivo respaldar y fortalecer las iniciativas de la AITEL.
                            Agradecemos de antemano el apoyo y compromiso continuo de nuestros egresados para con nuestra comunidad académica y
                            las actividades promovidas por la institución.</p>
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

            <div class="row mt-3">
                <div class="col-md-10 mx-auto">
                    <div class="blog-view">
                        <article class="blog blog-single-post">
                            <form method="POST" action="<%=request.getContextPath()%>/DelegadoActividadServlet?action=donar" enctype="multipart/form-data">
                                <!-- Medio de pago -->
                                <h3 class="blog-title">Paso 1
                                </h3>
                                <hr>
                                <div class="blog-content mt-3 mb-5">
                                    <p>Escanea el QR según tu medio de pago.</p>
                                    <div class="row">
                                        <div class="col text-center yape mt-3 mb-3">
                                            <label for="yape"><img class="img-pago" height="300px"
                                                                   src="images/yape.jpg" /></label><br />
                                            <input value="1" class="form-check-input" type="radio" name="donacionTipo"
                                                   id="yape" required/>
                                        </div>
                                        <div class="col text-center plin mt-3 mb-3">
                                            <label for="plin"><img class="img-pago" height="300px"
                                                                   src="images/plin.jpg" /></label><br />
                                            <input value="2" class="form-check-input" type="radio" name="donacionTipo"
                                                   id="plin" required/>
                                        </div>
                                    </div>

                                </div>

                                <!-- Monto a pagar -->
                                <h3 class="blog-title">Paso 2
                                </h3>
                                <hr>
                                <div class="blog-content mt-3 mb-5">
                                    <p>Ingrese el monto de donación.</p>
                                    <div class="row">
                                        <div class="col">
                                            <label class="mb-2">Monto (S/.):</label>
                                            <input name="donacionMonto" class="form-control" placeholder="Monto en soles"
                                                   required/>
                                        </div>
                                    </div>

                                </div>

                                <!-- Comprobante de pago -->
                                <h3 class="blog-title">Paso 3
                                </h3>
                                <hr>
                                <div class="blog-content mt-3 mb-5">
                                    <p>Sube tu comprobante de pago.</p>
                                    <div class="row">
                                        <div class="col field">
                                            <input accept="image/*" class="form-control" type="file" name="donacionFoto" required>
                                        </div>
                                    </div>

                                </div>
                                <!-- Id Alumno donador -->
                                <%Alumno alumnologueado2 = (Alumno) session.getAttribute("usuariologueado");%>
                                <input type="hidden" class="form-control"
                                       name="alumnoIDdonador" value="<%=alumnologueado2.getIdAlumno()%>">

                                <!-- Botón envío -->
                                <div class="row">
                                    <div class="col text-center">
                                        <button type="submit" class="btn btn-dark mb-3" data-bs-toggle="modal"
                                                data-bs-target="#confirmacionModal">
                                            Enviar Donación
                                        </button>
                                    </div>
                                </div>
                            </form>
                        </article>
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
