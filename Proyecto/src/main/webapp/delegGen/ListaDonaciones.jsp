<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.example.proyecto.beans.Alumno" %>
<%@ page import="com.example.proyecto.beans.DelegadoGeneral" %>
<%@ page import="com.example.proyecto.beans.Donacion" %>
<%int cantidadPaginas = (int) request.getAttribute("cantidadPaginas");%>
<%int currentPageJsp = (int) request.getAttribute("currentPageJsp");%>
<jsp:useBean id="textoBusqueda" scope="request" type="java.lang.String" class="java.lang.String"/>
<jsp:useBean id="lista3" scope="request" type="ArrayList<com.example.proyecto.beans.Donacion>" />
<%@ page import="java.util.ArrayList" %>

<html lang="en">

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0">
    <title>Donaciones verificadas</title>
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
        <!-- CABECERA DE LA BARRA LATERAL LISTOOOOO -->
        <div class="header-left">
            <a href="<%=request.getContextPath() %>/DelegadoGeneralServlet?action=main_page" class="logo text-decoration-none"> <img
                    src="assets/img/IconoBat.png" width="30" height="50" alt="logo"> <span
                    class="logoclass">TELEWEEK</span> </a>
        </div>
        <!-- LAS RAYITAS Q ABREN A LA BARRA LISTOOO-->
        <a class="text-decoration-none" href="javascript:void(0);" id="toggle_btn"> <i class="fe fe-text-align-left"></i> </a>
        <a class="mobile_btn text-decoration-none" id="mobile_btn"> <i class="fas fa-bars"></i> </a>
        <!-- NAVBAR -->
        <ul class="nav user-menu">
            <!-- FOTO DE PERFIL CON LAS OPCIONES DE EDITAR PERFIL Y DEMAS -->
            <li class="nav-item dropdown has-arrow">
                <a href="#" class="dropdown-toggle nav-link text-decoration-none" data-bs-toggle="dropdown"> <span class="user-img"><%DelegadoGeneral delegadoGenerallogueado = (DelegadoGeneral) session.getAttribute("usuariologueado");%>
                    <img
                            class="rounded-circle" src="<%=request.getContextPath()%>/ImgServlet?action=fotoPerfilDeleGen&idDeleGen=<%=delegadoGenerallogueado.getIdDelegadoGeneral()%>" width="50" height="50"></span>
                </a>
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
                    <!-- revisar ruta -->
                    <a class="dropdown-item text-decoration-none"
                       href="<%=request.getContextPath() %>/DelegadoGeneralServlet?action=cerrar_sesion">Cerrar
                        Sesión</a>
                </div>
            </li>
        </ul>
    </div>
    <!-- FIN CABECERA -->

    <!-- BARRA LATERAL -->
    <div class="sidebar" id="sidebar">
        <div class="sidebar-inner slimscroll">
            <div id="sidebar-menu" class="sidebar-menu">
                <ul>
                    <li><a class="text-decoration-none" href="<%=request.getContextPath() %>/DelegadoGeneralServlet?action=main_page"><i
                            class="fas fa-tachometer-alt"></i> <span>Dashboard</span></a>
                    </li>
                    <li class="list-divider"></li>

                    <li class="menu-title mt-3"><span>ACCIONES</span></li>
                    <!-- USUARIOS -->
                    <li class="submenu"><a class="text-decoration-none" href="#"><i class="fas fa-user"></i> <span> Usuarios </span> <span
                            class="menu-arrow"></span></a>
                        <ul class="submenu_class" style="display: none;">
                            <li><a class="text-decoration-none"
                                   href="<%=request.getContextPath() %>/DelegadoGeneralServlet?action=validar_registro">
                                Solicitudes </a></li>
                            <li><a class="text-decoration-none" href="<%=request.getContextPath() %>/DelegadoGeneralServlet?action=lista_usuarios">
                                Registrados </a></li>
                            <li><a class="text-decoration-none" href="<%=request.getContextPath() %>/DelegadoGeneralServlet?action=usuarios_rechazados"> Rechazados </a></li>
                            <li><a class="text-decoration-none" href="<%=request.getContextPath() %>/DelegadoGeneralServlet?action=usuarios_baneados"> Baneados </a></li>

                        </ul>
                    </li>

                    <!-- DONACIONES -->
                    <li class="submenu"><a class="text-decoration-none" href="#"><i class="bi bi-heart-fill"></i> <span> Donaciones </span>
                        <span class="menu-arrow"></span></a>
                        <ul class="submenu_class" style="display: none;">
                            <li>
                                <a class="text-decoration-none" href="<%=request.getContextPath() %>/DelegadoGeneralServlet?action=validar_donaciones">Por verificar </a>
                            </li>
                            <li><a class="active text-decoration-none" href="<%=request.getContextPath() %>/DelegadoGeneralServlet?action=lista_donaciones">Verificadas</a>
                            </li>
                            <li><a class="text-decoration-none" href="<%=request.getContextPath() %>/DelegadoGeneralServlet?action=donaciones_rechazadas">No validadas</a></li>

                        </ul>
                    </li>

                    <!-- ACTIVIDADES -->
                    <li><a class="text-decoration-none" href="<%=request.getContextPath() %>/DelegadoGeneralServlet?action=editar_actividades"><i
                            class="bi bi-calendar-fill"></i><span>Actividades</span></a>
                    </li>

                    <!-- CONTACTOS -->
                    <li class="list-divider"></li>
                    <li class="menu-title mt-3"><span>CONTACTOS</span></li>
                    <li><a class="text-decoration-none" href="https://www.instagram.com/aitel.pucp/" target="_blank">
                        <i class="bi bi-instagram"></i> <span>Instagram</span></a></li>
                    <li><a class="text-decoration-none" href="mailto:aitel@pucp.pe" target="_blank"><i class="fas fa-envelope"></i>
                        <span>Gmail</span></a></li>

                </ul>
            </div>
        </div>
    </div>
    <!-- FIN BARRA LATERAL -->

    <!-- TODO LO Q ESTA EN LA PAGINA SIN BARRA LATERAL -->
    <div class="page-wrapper">
        <div class="content container-fluid">
            <div class="page-header">
                <div class="row align-items-center">
                    <div class="col">
                        <div class="mt-5">
                            <h4 class="card-title float-left mt-2">Donaciones verificadas</h4>
                        </div>
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

            <!-- LISTA DE DONACIONES VERIFICADAS -->
            <div class="row">
                <div class="col-sm-12">
                    <div class="card">
                        <div class="card-body">
                            <div class="table-responsive">
                                <%if (lista3.isEmpty()){%>
                                    <p class="lead"> Aún no hay donaciones verificadas </p>
                                <%}%>
                                <!-- TABLA DE DONACIONES VERIFICADAS -->
                                <table class="table table-hover mt-1 mb-1">
                                    <thead>
                                    <tr>
                                        <th>#</th>
                                        <th>Usuario</th>
                                        <th>Correo</th>
                                        <th>Egresado/Estudiante</th>
                                        <th>Fecha</th>
                                        <th>Medio de pago</th>
                                        <th>Monto</th>
                                        <th>Motivo</th>

                                    </tr>
                                    </thead>



                                    <tbody>
                                    <%int i = (currentPageJsp - 1) * (10) + 1;%>
                                        <%for (Donacion d: lista3){%>

                                            <tr>
                                                <th><%=i%></th>
                                                <td><%=d.getAlumno().getNombre()+" "+d.getAlumno().getApellido()%></td>
                                                <td><%=d.getAlumno().getCorreo()%></td>
                                                <td><%=d.getAlumno().getEgresado()%></td>
                                                <td><%=d.getFecha()%></td>
                                                <td>
                                                    <%if(d.getTipoDonacion().getIdTipoDonacion()==1){%>
                                                        <img src="images/yape_logo.jpg" alt="Pago" width="32px"
                                                             style="border-radius: 25%;">
                                                    <%} else if(d.getTipoDonacion().getIdTipoDonacion()==2){%>
                                                    <img src="images/plin_logo.jpg" alt="Pago" width="32px"
                                                     style="border-radius: 25%;">
                                                    <%}%>
                                                </td>
                                                <td>S/. <%=d.getMonto()%></td>
                                                <td>
                                                    <button class="btn btn-secondary" data-bs-toggle="modal" data-bs-target="#modalMostrar<%=i%>">
                                                        <i class="bi bi-eye"></i>
                                                    </button>
                                                </td>
                                                <!-- MODAL OBSERVAR COMPROBANTE-->
                                                <div class="modal fade" id="modalMostrar<%=i%>" aria-hidden="true">
                                                    <div class="modal-dialog modal-dialog-centered">
                                                        <div class="modal-content">
                                                            <form>
                                                                <div class="modal-header">
                                                                    <h5 class="fw-bold">Verificación</h5>
                                                                    <button type="button" class="btn-close"
                                                                            data-bs-dismiss="modal"
                                                                            aria-label="Close"></button>
                                                                </div>
                                                                <div class="modal-body">

                                                                    <div class="mb-3">
                                                                        <h6 class="fw-bold">Motivo de la verificación:</h6>
                                                                        <!-- IMPLEMENTAR EL DAO -->
                                                                        <p class="form-control"><%=d.getMotivo()%>
                                                                        </p>
                                                                    </div>

                                                                </div>

                                                            </form>
                                                        </div>
                                                    </div>
                                                </div>

                                            </tr>
                                            <%i++;%>
                                            <%};%>
                                    </tbody>
                                </table>

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
                                                    <a class="page-link" href="<%=request.getContextPath() %>/DelegadoGeneralServlet?action=lista_donaciones&currentPage=<%=auxStart%>" aria-label="Previous">
                                                        <span aria-hidden="true">&laquo;</span>
                                                    </a>
                                                </li>
                                                <%for (int j=1;j<=cantidadPaginas;j++){%>
                                                <%if(currentPageJsp == j){%>
                                                <li class="page-item"><a class="page-link active" href="<%=request.getContextPath() %>/DelegadoGeneralServlet?action=lista_donaciones&currentPage=<%=j%>"><%=j%></a></li>
                                                <%} else {%>
                                                <li class="page-item"><a class="page-link" href="<%=request.getContextPath() %>/DelegadoGeneralServlet?action=lista_donaciones&currentPage=<%=j%>"><%=j%></a></li>
                                                <%}%>
                                                <%}%>
                                                <li class="page-item">
                                                    <a class="page-link" href="<%=request.getContextPath() %>/DelegadoGeneralServlet?action=lista_donaciones&currentPage=<%=auxEnd%>" aria-label="Next">
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