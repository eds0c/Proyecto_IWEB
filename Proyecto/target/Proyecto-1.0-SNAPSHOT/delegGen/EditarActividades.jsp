<%@ page import="java.util.ArrayList" %>
<%@ page import="com.example.proyecto.beans.Actividad" %>
<%@ page import="com.example.proyecto.beans.DelegadoActividad" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.example.proyecto.beans.Alumno" %>
<jsp:useBean id="listaActividades" scope="request" type="ArrayList<com.example.proyecto.beans.DelegadoActividad>"/>
<jsp:useBean id="listaAlumnos_DelegadosActividad" scope="request" type="ArrayList<com.example.proyecto.beans.Alumno>"/>
<jsp:useBean id="listaAlumnosCandidatos" scope="request" type="ArrayList<com.example.proyecto.beans.Alumno>"/>
<jsp:useBean id="textoBusqueda" scope="request" type="java.lang.String" class="java.lang.String"/>
<%@ page import="com.example.proyecto.beans.DelegadoGeneral" %>
<html lang="en">

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0">
    <title>Actividades</title>
    <link rel="shortcut icon" type="image/x-icon" href="assets/img/IconoBat.png">
    <link rel="stylesheet" href="assets/css/bootstrap.min.css">
    <link rel="stylesheet" href="assets/plugins/fontawesome/css/all.min.css">
    <link rel="stylesheet" href="assets/css/feathericon.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.0/font/bootstrap-icons.css">
    <%-- BOOTSTRAP 5--%>
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
            <a href="<%=request.getContextPath() %>/DelegadoGeneralServlet?action=main_page"
               class="logo text-decoration-none"> <img
                    src="assets/img/IconoBat.png" width="30" height="50" alt="logo"> <span
                    class="logoclass">TELEWEEK</span> </a>
        </div>
        <!-- LAS RAYITAS Q ABREN A LA BARRA LISTOOO-->
        <a class="text-decoration-none" href="javascript:void(0);" id="toggle_btn"> <i
                class="fe fe-text-align-left"></i> </a>
        <a class="mobile_btn text-decoration-none" id="mobile_btn"> <i class="fas fa-bars"></i> </a>
        <!-- NAVBAR -->
        <ul class="nav user-menu">
            <!-- FOTO DE PERFIL CON LAS OPCIONES DE EDITAR PERFIL Y DEMAS -->
            <li class="nav-item dropdown has-arrow">
                <a href="#" class="dropdown-toggle nav-link text-decoration-none" data-bs-toggle="dropdown"> <span
                        class="user-img"><%DelegadoGeneral delegadoGenerallogueado = (DelegadoGeneral) session.getAttribute("usuariologueado");%>
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
                    <a class="dropdown-item text-decoration-none"
                       href="<%=request.getContextPath() %>/DelegadoGeneralServlet?action=perfil">Mi
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
                    <li><a class="text-decoration-none"
                           href="<%=request.getContextPath() %>/DelegadoGeneralServlet?action=main_page"><i
                            class="fas fa-tachometer-alt"></i> <span>Dashboard</span></a></li>
                    <li class="list-divider"></li>

                    <li class="menu-title mt-3"><span>ACCIONES</span></li>
                    <!-- USUARIOS -->
                    <li class="submenu"><a class="text-decoration-none" href="#"><i class="fas fa-user"></i> <span> Usuarios </span>
                        <span
                                class="menu-arrow"></span></a>
                        <ul class="submenu_class" style="display: none;">
                            <li><a class="text-decoration-none"
                                   href="<%=request.getContextPath() %>/DelegadoGeneralServlet?action=validar_registro">
                                Solicitudes </a></li>
                            <li><a class="text-decoration-none"
                                   href="<%=request.getContextPath() %>/DelegadoGeneralServlet?action=lista_usuarios">
                                Registrados </a></li>
                            <li><a class="text-decoration-none" href="<%=request.getContextPath() %>/DelegadoGeneralServlet?action=usuarios_rechazados"> Rechazados </a></li>
                            <li><a class="text-decoration-none" href="<%=request.getContextPath() %>/DelegadoGeneralServlet?action=usuarios_baneados"> Baneados </a></li>

                        </ul>
                    </li>

                    <!-- DONACIONES -->
                    <li class="submenu"><a class="text-decoration-none" href="#"><i class="bi bi-heart-fill"></i> <span> Donaciones </span>
                        <span
                                class="menu-arrow"></span></a>
                        <ul class="submenu_class" style="display: none;">
                            <li>
                                <a class="text-decoration-none"
                                   href="<%=request.getContextPath() %>/DelegadoGeneralServlet?action=validar_donaciones">Por verificar</a>
                            </li>
                            <li><a class="text-decoration-none"
                                   href="<%=request.getContextPath() %>/DelegadoGeneralServlet?action=lista_donaciones">Verificadas</a>
                            </li>
                            <li><a class="text-decoration-none" href="<%=request.getContextPath() %>/DelegadoGeneralServlet?action=donaciones_rechazadas">No validadas</a></li>

                        </ul>
                    </li>

                    <!-- ACTIVIDADES -->
                    <li class="active"><a class="text-decoration-none"
                                          href="<%=request.getContextPath() %>/DelegadoGeneralServlet?action=editar_actividades"><i
                            class="bi bi-calendar-fill"></i><span>Actividades</span></a>
                    </li>

                    <!-- CONTACTOS -->
                    <li class="list-divider"></li>
                    <li class="menu-title mt-3"><span>CONTACTOS</span></li>
                    <li><a class="text-decoration-none" href="https://www.instagram.com/aitel.pucp/" target="_blank"><i
                            class="bi bi-instagram"></i><span>Instagram</span></a></li>
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
                            <h4 class="card-title float-left mt-2">Lista de actividades</h4>
                            <button class="btn btn-light active float-right veiwbutton"
                                    data-bs-toggle="modal"
                                    data-bs-target="#modalNuevo">
                                Crear Actividad
                            </button>
                        </div>
                    </div>
                </div>
            </div>
            <!-- MENSAJES DE ERROR O CONFIRMACION -->
            <% if (session.getAttribute("msg") != null) {%>
            <div class="alert alert-success" role="alert"><%=session.getAttribute("msg")%>
            </div>
            <% session.removeAttribute("msg");} %>
            <% if (session.getAttribute("err") != null) {%>
            <div class="alert alert-danger" role="alert"><%=session.getAttribute("err")%>
            </div>
            <% session.removeAttribute("err");} %>
            <% if (session.getAttribute("errDesc") != null) {%>
            <div class="alert alert-danger" role="alert"><%=session.getAttribute("errDesc")%>
            </div>
            <% session.removeAttribute("errDesc");} %>

            <!-- LISTA DE ACTIVIDADES -->
            <div class="row">
                <div class="col-sm-12">
                    <div class="card">
                        <div class="card-body">
                            <div class="table-responsive">
                                <!-- TABLA ACTIVIDADES -->
                                <table class="table table-hover mt-1 mb-1">
                                    <thead>
                                    <tr>
                                        <th>#</th>
                                        <th>Actividad</th>
                                        <th>Delegado</th>
                                        <th>Observar</th>
                                        <th>Eliminar</th>
                                    </tr>
                                    </thead>
                                    <%if (listaActividades.isEmpty()){%>
                                    <p class="lead">No existen actividades aún</p>
                                    <%}%>
                                    <tbody>
                                    <%int i = 1;%>
                                    <%for (DelegadoActividad delegadoActividad : listaActividades) {%>
                                    <tr>
                                        <td><%=i%>
                                        </td>
                                        <td><%=delegadoActividad.getActividad().getTitulo()%>
                                        </td>
                                        <td><%=listaAlumnos_DelegadosActividad.get(i - 1).getNombre() + " " + listaAlumnos_DelegadosActividad.get(i - 1).getApellido()%>
                                        </td>

                                        <!-- OBSERVAR INFO ACT -->
                                        <td>
                                            <button class="btn btn-secondary" data-bs-toggle="modal"
                                                    data-bs-target="#modalMostrar<%=i%>">
                                                <i class="bi bi-eye"></i>
                                            </button>
                                        </td>

                                        <%-- MODAL  OBSERVAR ACT --%>
                                        <div class="modal fade" id="modalMostrar<%=i%>"
                                             aria-hidden="true">
                                            <div class="modal-dialog modal-dialog-centered">
                                                <div class="modal-content">
                                                    <form>
                                                        <div class="modal-header">
                                                            <h5 class="modal-title fw-bold"><%=delegadoActividad.getActividad().getTitulo()%>
                                                            </h5>
                                                            <button type="button" class="btn-close"
                                                                    data-bs-dismiss="modal"
                                                                    aria-label="Close"></button>
                                                        </div>
                                                        <div class="modal-body">
                                                            <div class="mb-3 d-flex justify-content-center align-items-center flex-column">
                                                                <img src="<%=request.getContextPath()%>/ImgServlet?action=fotoActividad&idActividadMostrarFoto=<%=delegadoActividad.getActividad().getIdActividad()%>" alt="Imagen de evento"
                                                                     class="img-thumbnail w-70">
                                                            </div>
                                                            <div class="mb-3">
                                                                <h6 class="fw-bold">Descripción:</h6>
                                                                <p class="form-control" style="height: auto" ><%=delegadoActividad.getActividad().getDescripcion()%>
                                                                </p>
                                                            </div>

                                                            <div class="mb-3">
                                                                <h6 class="fw-bold">Estado:</h6>
                                                                <p class="form-control text-uppercase"><%=delegadoActividad.getActividad().getEstado()%>
                                                                </p>
                                                            </div>
                                                        </div>
                                                        <div class="modal-footer">
                                                            <button type="button" class="btn btn-danger"
                                                                    data-bs-dismiss="modal">Cerrar
                                                            </button>
                                                            <!-- BOTÓN PARA EL MODAL EDITAR -->
                                                            <button type="button" class="btn btn-primary"
                                                                    data-bs-toggle="modal"
                                                                    data-bs-target="#modalEditar<%=i%>">Editar
                                                            </button>
                                                        </div>
                                                    </form>
                                                </div>
                                            </div>
                                        </div>
                                        <%-- FIN MODAL  OBSERVAR ACT --%>

                                        <!-- MODAL EDITAR ACT -->
                                        <div class="modal fade" id="modalEditar<%=i%>"
                                             aria-hidden="true">
                                            <div class="modal-dialog modal-dialog-centered">
                                                <div class="modal-content">
                                                    <form method="post"
                                                          action="<%=request.getContextPath()%>/DelegadoGeneralServlet?action=editar"
                                                          enctype="multipart/form-data">

                                                        <div class="modal-header">
                                                            <h5 class="modal-title fw-bold"><%=delegadoActividad.getActividad().getTitulo()%>
                                                            </h5>
                                                            <button type="button" class="btn-close"
                                                                    data-bs-dismiss="modal"
                                                                    aria-label="Close"></button>
                                                        </div>
                                                        <div class="modal-body">
                                                            <div class="mb-3 d-flex justify-content-center align-items-center flex-column">
                                                                <label class="form-label" for="imageUpload">Suba una foto</label>
                                                                <img src="<%=request.getContextPath()%>/ImgServlet?action=fotoActividad&idActividadMostrarFoto=<%=delegadoActividad.getActividad().getIdActividad()%>" alt="Imagen de evento"
                                                                     class="img-thumbnail w-70">
                                                                <input type="file" class="form-control"
                                                                       accept="image/*" name="fotoActividadEditada" required>
                                                            </div>

                                                            <div class="mb-3">
                                                                <label for="tituloActividad" class="fw-bold">Nombre de
                                                                    la actividad:</label>
                                                                <input type="text" class="form-control form-control-sm"
                                                                       name="tituloActividad" id="tituloActividad"
                                                                       value="<%=delegadoActividad.getActividad().getTitulo()%>" required>
                                                            </div>
                                                            <div class="mb-3">
                                                                <label for="descripcionActividad" class="fw-bold">Descripción:</label>
                                                                <textarea class="form-control" id="descripcionActividad"
                                                                          rows="4" name="descripcionActividad"
                                                                          placeholder="Ingrese la descripción aquí" required><%=delegadoActividad.getActividad().getDescripcion()%></textarea>
                                                            </div>
                                                            <div class="mb-3">
                                                                <label for="idAlumnoDelegadoActividad" class="fw-bold">Delegado
                                                                    de Actividad:</label>
                                                                <select name="idAlumnoDelegadoActividad"
                                                                        class="form-select"
                                                                        id="idAlumnoDelegadoActividad">

                                                                    <option value="0" <%="selected"%>>-- Mantener Delegado de Actividad--
                                                                    </option>
                                                                    <% for (Alumno alumno : listaAlumnosCandidatos) { %>
                                                                    <option value="<%=alumno.getIdAlumno()%>"><%=alumno.getNombre() + " " + alumno.getApellido()%>
                                                                    </option>
                                                                    <% } %>

                                                                </select>
                                                                <input type="hidden" class="form-control"
                                                                       name="idAlumnoDelegadoActividadActual"
                                                                       value="<%=listaAlumnos_DelegadosActividad.get(i-1).getIdAlumno()%>">
                                                            </div>

                                                        </div>

                                                        <div class="modal-footer">
                                                            <a href="<%=request.getContextPath()%>/DelegadoGeneralServlet?action=editar_actividades"
                                                               class="btn btn-danger">Cancelar</a>
                                                            <button type="submit" class="btn btn-primary">Guardar
                                                                Cambios
                                                            </button>

                                                        </div>
                                                    </form>
                                                </div>
                                            </div>
                                        </div>
                                        <%-- FIN MODAL EDITAR --%>
                                        <!-- ELIMINAR ACT -->
                                        <td>
                                            <button class="btn btn-danger" data-bs-toggle="modal"
                                                    href="#eliminarActividad<%=i%>">
                                                <i class="bi bi-trash"></i>
                                            </button>
                                        </td>
                                        <%-- MODAL ELIMINAR --%>
                                        <div class="modal fade" id="eliminarActividad<%=i%>" aria-hidden="true">
                                            <div class="modal-dialog modal-dialog-centered">
                                                <div class="modal-content">
                                                    <div class="modal-header">
                                                        <h5 class="modal-title">Eliminar actividad</h5>
                                                        <button type="button" class="btn-close" data-bs-dismiss="modal"
                                                                aria-label="Close"></button>
                                                    </div>
                                                    <div class="modal-body">
                                                        <p>¿Estás seguro que deseas eliminar esta actividad?</p>
                                                    </div>

                                                    <div class="modal-footer">
                                                        <form method="post"
                                                              action="<%=request.getContextPath()%>/DelegadoGeneralServlet?action=eliminar_actividad">
                                                            <button type="button" class="btn btn-danger"
                                                                    data-bs-dismiss="modal">Cancelar
                                                            </button>
                                                            <input type="hidden" class="form-control"
                                                                   name="idAlumnoDelegadoActividadEliminar"
                                                                   value="<%=listaAlumnos_DelegadosActividad.get(i-1).getIdAlumno()%>">
                                                            <input type="hidden" class="form-control"
                                                                   name="idDelegadoActividadEliminar"
                                                                   value="<%=delegadoActividad.getIdDelegadoActividad()%>">
                                                            <input type="hidden" class="form-control"
                                                                   name="idActividadEliminar"
                                                                   value="<%=delegadoActividad.getActividad().getIdActividad()%>">
                                                            <button type="submit" class="btn btn-primary"
                                                                    data-bs-toggle="modal"
                                                                    data-bs-target="#eliminarConfirmado<%=i%>">Sí
                                                            </button>
                                                        </form>
                                                    </div>

                                                </div>
                                            </div>
                                        </div>
                                        <!-- PONER MENSAJES COMO EL PROFE QUE INDIQUE LA CONFIRMACIÓN -->

                                    </tr>
                                    <%
                                            i++;
                                        }
                                    %>

                                    </tbody>
                                </table>



                                <!-- MODAL AGREGAR ACT -->
                                <div class="modal fade" id="modalNuevo"
                                     aria-hidden="true">
                                    <div class="modal-dialog">
                                        <div class="modal-content">
                                            <form method="post"
                                                  action="<%=request.getContextPath()%>/DelegadoGeneralServlet?action=crear"
                                                  enctype="multipart/form-data">

                                                <div class="modal-header">
                                                    <h5 class="modal-title fw-bold">Nueva
                                                        actividad</h5>
                                                    <button type="button" class="btn-close" data-bs-dismiss="modal"
                                                            aria-label="Close"></button>
                                                </div>
                                                <div class="modal-body">
                                                    <div class="mb-3 d-flex justify-content-center align-items-center flex-column">
                                                        <img src="https://yaktribe.games/community/media/placeholder-jpg.84782/full"
                                                             alt="Imagen de muestra" id="exampleImage"
                                                             class="img-thumbnail w-50">
                                                        <label class="form-label" for="imageUpload">Suba una foto</label>
                                                        <input type="file" class="form-control" id="imageUpload"
                                                               accept="image/*" name="fotoActividad" required>
                                                    </div>

                                                    <div class="mb-3">
                                                        <label for="tituloActividad">Ingrese el nombre de la actividad:</label>
                                                        <input type="text" class="form-control form-control-sm"
                                                               name="tituloActividad" required>
                                                    </div>
                                                    <div class="mb-3">
                                                        <label for="descripcionActividad">Ingrese una descripción:</label>
                                                        <textarea class="form-control"
                                                                  rows="4" name="descripcionActividad"
                                                                  placeholder="Ingrese la descripción aquí" required></textarea>
                                                    </div>
                                                    <div class="mb-3">
                                                        <label for="idAlumnoDelegadoActividad">Seleccione un delegado de
                                                            Actividad:</label>
                                                        <select name="idAlumnoDelegadoActividad" class="form-select" required>
                                                            <%if (listaAlumnosCandidatos.isEmpty()) {%>
                                                            <option value="0">-- Sin Posibles Candidatos --</option>
                                                            <%} else {%>
                                                            <% for (Alumno alumno : listaAlumnosCandidatos) { %>
                                                            <option value="<%=alumno.getIdAlumno()%>"><%=alumno.getNombre() + " " + alumno.getApellido()%>
                                                            </option>
                                                            <% } %>
                                                            <%}%>

                                                        </select>
                                                    </div>

                                                </div>
                                                <div class="modal-footer">
                                                    <button type="button" class="btn btn-danger"
                                                            data-bs-dismiss="modal">Cancelar
                                                    </button>

                                                    <button type="submit" class="btn btn-primary">Guardar Cambios
                                                    </button>
                                                </div>
                                                <!-- MENSAJE DE CONFIRMACION COMO EL PROFE -->
                                            </form>
                                        </div>
                                    </div>
                                </div>
                                <!-- FIN MODAL AGREGAR ACT -->
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