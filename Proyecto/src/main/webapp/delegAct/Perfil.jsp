<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.example.proyecto.beans.Alumno" %>
<%boolean actividadIsFinalizada = (Boolean) request.getAttribute("actividadIsFinalizada");%>
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
                    <li><a class="text-decoration-none" href="<%=request.getContextPath() %>/DelegadoActividadServlet?action=actividades_finalizadas"><i class="bi bi-calendar2-check-fill"></i><span>Act finalizadas</span></a>
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
            <div class="page-header mt-5">
                <div class="row">
                    <div class="col">
                        <h3 class="page-title">Perfil</h3>
                        <ul class="breadcrumb">
                            <li class="breadcrumb-item"><a class="text-decoration-none" href="<%=request.getContextPath() %>/DelegadoActividadServlet?action=main_page">Inicio</a></li>
                            <li class="breadcrumb-item active">Perfil</li>
                        </ul>
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
            <div class="row">
                <div class="col-md-12">
                    <div class="profile-header">
                        <div class="row align-items-center">
                            <div class="col-auto profile-image">
                                <!--VER LA FOTO DE PERFIL -->
                                <img class="rounded-circle" alt="User Image"
                                     src="<%=request.getContextPath()%>/ImgServlet?action=fotoPerfilDeleAct&idd=<%=alumnologueado.getIdAlumno()%>" style="width: 100px; height: 100px;">
                            </div>
                            <div class="col ml-md-n2 profile-user-info">
                                <%if(session.getAttribute("usuariologueado")==null) {%>
                                <span class="email">codigo@pucp.edu.com</span>
                                <%}else{%>
                                <%Alumno alumnologueado2 = (Alumno) session.getAttribute("usuariologueado");%>
                                <span class="email"><%=alumnologueado.getNombre() + " " + alumnologueado.getApellido()%></span>
                                <%}%>
                                <%Alumno alumnologueado2 = (Alumno) session.getAttribute("usuariologueado");%>
                                <h6 class="text-muted mt-1">Delegado Actividad</h6>
                                <!-- COLOCAR LO Q HACE EL ALUMNO -->
                                <div class="about-text text-justify">
                                    El delegado de actividad tiene la capacidad de explorar y respaldar eventos de la semana de ingeniería como cualquier alumno.
                                    Sin embargo, se le asignan funciones adicionales, permitiéndole crear, editar y borrar eventos. Además, podrá gestionar los registros
                                    de los usuarios interesados.
                                </div>
                                <!-- VER SI COLOCAMOS MAS INFORMACION -->
                            </div>
                            <div class="col-auto profile-btn">
                                <a class="edit-link text-decoration-none" data-toggle="modal" href="#edit_personal_details"><i
                                        class="fa fa-edit mr-1"></i>Editar</a>
                            </div>
                            <!-- MODAL EDITAR PERFIL -->
                            <div class="modal fade" id="edit_personal_details" aria-hidden="true" role="dialog">
                                <div class="modal-dialog modal-dialog-centered" role="document">
                                    <div class="modal-content">
                                        <div class="modal-header">
                                            <h5 class="modal-title">Editar foto de perfil</h5>
                                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                                <span aria-hidden="true">&times;</span></button>
                                        </div>
                                        <form method="POST" action="<%=request.getContextPath()%>/DelegadoActividadServlet?action=editar_perfil"
                                              enctype="multipart/form-data">
                                        <div class="modal-body">
                                            <!-- editar el form -->

                                                <!-- CONFIGURAR PARA EDITAR UNA FOTO? -->
                                            <div class="mb-3 d-flex justify-content-center align-items-center flex-column">
                                                <img src="<%=request.getContextPath()%>/ImgServlet?action=fotoPerfilAlumno&idAlumno=<%=alumnologueado.getIdAlumno()%>"
                                                     alt="Imagen de muestra" id="exampleImage"
                                                     class="img-thumbnail w-50">
                                                <label class="form-label" for="imageUpload">Suba una foto</label>
                                                <input type="file" class="form-control" id="imageUpload"
                                                       accept="image/*" name="usuarioFoto" required>
                                            </div>
                                                <div class="mb-3">
                                                    <input type="hidden" class="form-control" name="usuarioId" value="<%=alumnologueado.getIdAlumno()%>">
                                                </div>
                                                <button type="submit" class="btn btn-primary btn-block">Guardar
                                                    cambios
                                                </button>
                                        </div>
                                        </form>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="profile-menu">
                        <ul class="nav">
                            <li> <a class="btn btn-primary" href="<%=request.getContextPath() %>/DelegadoActividadServlet?action=editar_contra">Cambiar contraseña</a> </li>
                        </ul>
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
