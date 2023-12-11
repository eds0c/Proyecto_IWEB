<%@ page import="java.util.ArrayList" %>
<%@ page import="com.example.proyecto.beans.Evento" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.example.proyecto.beans.Alumno" %>
<jsp:useBean id="lista3" scope="request" type="ArrayList<Evento>"/>
<jsp:useBean id="usuariologueado" scope="session" type="com.example.proyecto.beans.Alumno"
             class="com.example.proyecto.beans.Alumno"/>
<jsp:useBean id="textoBusqueda" scope="request" type="java.lang.String" class="java.lang.String"/>
<%boolean actividadIsFinalizada = (Boolean) request.getAttribute("actividadIsFinalizada");%>
<html lang="en">

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0">
    <title>Eventos Activos</title>
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
            <a href="<%=request.getContextPath() %>/DelegadoActividadServlet?action=main_page"
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
                        class="user-img"><img
                        class="rounded-circle" src="assets/img/profiles/usuario.jpg" width="50"></span>
                </a>
                <!-- MENU DESPLEGABLE DE LA FLECHITA DE LA FOTO DE PERFIL -->
                <div class="dropdown-menu">
                    <div class="user-header">
                        <!-- nombre y rol del usuario -->
                        <div class="user-text">
                            <%if (session.getAttribute("usuariologueado") == null) {%>
                            <span class="email">codigo@pucp.edu.com</span>
                            <%} else {%>
                            <%Alumno alumnologueado = (Alumno) session.getAttribute("usuariologueado");%>
                            <span class="email"><%=alumnologueado.getNombre() + " " + alumnologueado.getApellido()%></span>
                            <%}%>
                            <p class="text-muted mb-0">Delegado Actividad</p>
                        </div>
                    </div>
                    <a class="dropdown-item text-decoration-none"
                       href="<%=request.getContextPath() %>/DelegadoActividadServlet?action=perfil">Mi
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
                    <li><a class="text-decoration-none"
                           href="<%=request.getContextPath() %>/DelegadoActividadServlet?action=main_page"><i
                            class="bi bi-house-fill"></i>
                        <span>Inicio</span></a></li>
                    <li class="list-divider"></li>

                    <li class="menu-title mt-3"><span>PARTICIPACION</span></li>
                    <!-- EVENTOS INSCRITOS -->
                    <li><a class="text-decoration-none"
                           href="<%=request.getContextPath() %>/DelegadoActividadServlet?action=mis_eventos"><i
                            class="bi bi-calendar-event-fill"></i><span>Mis eventos</span></a>
                    </li>

                    <!-- DONACION -->
                    <li><a class="text-decoration-none"
                           href="<%=request.getContextPath() %>/DelegadoActividadServlet?action=donaciones"><i
                            class="bi bi-heart-fill"></i><span>Donaciones</span></a>
                    </li>

                    <!-- MI ACTIVIDAD -->
                    <li class="list-divider"></li>
                    <li class="menu-title mt-3"><span>ACCIONES</span></li>
                    <li class="submenu"><a class="text-decoration-none" href="#"><i
                            class="bi bi-file-earmark-text-fill"></i> <span>Mi Actividad</span> <span
                            class="menu-arrow"></span></a>
                        <ul class="submenu_class" style="display: none;">

                            <%if(!actividadIsFinalizada){%>
                            <li><a class="active text-decoration-none" href="<%=request.getContextPath() %>/DelegadoActividadServlet?action=mi_actividad">Eventos activos</a></li>
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
                            <h4 class="card-title float-left mt-2">Lista de eventos</h4>
                            <button class="btn btn-light active float-right veiwbutton"
                                    data-bs-toggle="modal"
                                    data-bs-target="#modalNuevo">
                                Crear Evento
                            </button>
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
            <!-- BUSCAR EVENTO IMPLEMENTAR EN EL SERVLET Y DAO -->
            <form method="post" action="<%=request.getContextPath()%>/DelegadoActividadServlet?action=buscar">
                <div class="input-group mb-3">
                    <input type="text" class="form-control" placeholder="Buscar por nombre" name="textoBuscar"
                           value="<%=textoBusqueda%>"/>
                    <button class="input-group-text" type="submit">
                        <i class="bi bi-search"></i>
                    </button>
                    <a class="input-group-text"
                       href="<%=request.getContextPath()%>/DelegadoActividadServlet?action=editar_actividades">
                        <i class="bi bi-x-circle"></i>
                    </a>
                </div>
            </form>
            <!-- LISTA DE EVENTOS -->
            <div class="row">
                <div class="col-sm-12">
                    <div class="card">
                        <div class="card-body">
                            <div class="table-responsive">
                                <!-- TABLA EVENTOS -->
                                <table class="table table-hover mt-1 mb-1">
                                    <thead>
                                    <tr>
                                        <th>#</th>
                                        <th>Evento</th>
                                        <th>Fecha</th>
                                        <th>Observar</th>
                                        <th>Participantes</th>
                                        <th>Finalizar</th>
                                        <th>Eliminar</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <%int i = 1;%>
                                    <%for (Evento e : lista3) {%>
                                    <tr>
                                        <td><%=i%>
                                        </td>
                                        <td><%=e.getTitulo()%>
                                        </td>
                                        <td><%=e.getFechaIn()%>
                                        </td>

                                        <!-- OBSERVAR INFO EVENT -->
                                        <td>
                                            <button class="btn btn-secondary" data-bs-toggle="modal"
                                                    data-bs-target="#modalMostrar<%=i%>">
                                                <i class="bi bi-eye"></i>
                                            </button>
                                        </td>

                                        <%-- MODAL  OBSERVAR EVENT --%>
                                        <div class="modal fade" id="modalMostrar<%=i%>"
                                             aria-hidden="true">
                                            <div class="modal-dialog modal-dialog-centered">
                                                <div class="modal-content">
                                                    <form>
                                                        <div class="modal-header">
                                                            <h5 class="modal-title fw-bold"><%=e.getTitulo()%>
                                                            </h5>
                                                            <button type="button" class="btn-close"
                                                                    data-bs-dismiss="modal"
                                                                    aria-label="Close"></button>
                                                        </div>
                                                        <div class="modal-body">
                                                            <div class="mb-3 d-flex justify-content-center align-items-center flex-column">
                                                                <img src="<%=request.getContextPath()%>/ImgServlet?id=<%=e.getIdEvento()%>"
                                                                     alt="Imagen de evento"
                                                                     class="img-thumbnail w-70">
                                                            </div>
                                                            <div class="mb-3">
                                                                <h6 class="fw-bold">Descripción:</h6>
                                                                <p class="form-control"><%=e.getDescripcion()%>
                                                                </p>
                                                            </div>

                                                            <div class="row mb-3">
                                                                <div class="col-6">
                                                                    <h6 class="fw-bold">Fecha:</h6>
                                                                    <p class="form-control"><%=e.getFechaIn()%>
                                                                    </p>
                                                                </div>
                                                                <div class="col-6">
                                                                    <h6 class="fw-bold">Hora:</h6>
                                                                    <p class="form-control"><%=e.getHora()%>
                                                                    </p>
                                                                </div>
                                                            </div>

                                                            <div class="mb-3">
                                                                <h6 class="fw-bold">Lugar:</h6>
                                                                <p class="form-control"><%=e.getLugar()%>
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
                                                          action="<%=request.getContextPath()%>/DelegadoActividadServlet?action=editar"
                                                          enctype="multipart/form-data">

                                                        <div class="modal-header">
                                                            <h1 class="modal-title fs-5" id="nuevoModalLabel">Editar
                                                                evento</h1>
                                                            <button type="button" class="btn-close"
                                                                    data-bs-dismiss="modal"
                                                                    aria-label="Close"></button>
                                                        </div>
                                                        <div class="modal-body">
                                                            <div class="mb-3 d-flex justify-content-center align-items-center flex-column">
                                                                <img src="https://yaktribe.games/community/media/placeholder-jpg.84782/full"
                                                                     alt="Imagen de muestra"
                                                                     class="img-thumbnail w-50">
                                                                <!--<label class="form-label" for="imageUpload">Subir Foto</label>
                                                                <input type="file" class="form-control" id="imageUpload" accept="image/*"> -->
                                                                <label>Subir Foto</label>
                                                                <input type="file" class="form-control"
                                                                       name="eventoFoto" accept="image/*"
                                                                       value="<%=e.getFoto()%>">
                                                            </div>
                                                            <div class="mb-3">
                                                                <label>Título</label>
                                                                <input type="text" class="form-control" name="titulo"
                                                                       value="<%=e.getTitulo()%>"
                                                                       placeholder="Ingrese el título del evento">
                                                            </div>
                                                            <div class="mb-3">
                                                                <!--<label for="exampleDescription" class="form-label">Descripción</label>
                                                                <textarea class="form-control" id="exampleDescription" rows="4"
                                                                          placeholder="Ingrese la descripción aquí"></textarea>-->
                                                                <label>Descripción</label>

                                                                <textarea class="form-control" name="eventoDescripcion"
                                                                          rows="4"
                                                                          placeholder="Ingrese la descripción aquí"><%=e.getDescripcion()%></textarea>
                                                            </div>
                                                            <div class="row mb-3">
                                                                <div class="col">
                                                                    <!-- <label for="exampleDate" class="form-label">Fecha</label> -->
                                                                    <label>Fecha</label>
                                                                    <input type="date" class="form-control"
                                                                           name="eventoFecha"
                                                                           value="<%=e.getFechaIn()%>">
                                                                    <input type="hidden" class="form-control"
                                                                           name="eventoID" value="<%=e.getIdEvento()%>">
                                                                </div>
                                                                <div class="col">
                                                                    <!--  <label for="exampleTime" class="form-label">Hora</label> -->
                                                                    <label>Hora</label>
                                                                    <input type="time" class="form-control"
                                                                           name="eventoHora" value="<%=e.getHora()%>">
                                                                    <!-- <input type="time" class="form-control" id="exampleTime"> -->
                                                                </div>
                                                            </div>
                                                            <div class="mb-3">
                                                                <label>Lugar</label>
                                                                <input type="text" class="form-control"
                                                                       name="eventoLugar" value="<%=e.getLugar()%>"
                                                                       placeholder="Ingrese el lugar">
                                                            </div>

                                                        </div>
                                                        <div class="modal-footer">
                                                            <!-- <button type="button" class="btn btn-danger"
                                                                    data-bs-dismiss="modal">Cancelar</button>   -->
                                                            <a href="<%=request.getContextPath()%>/DelegadoActividadServlet?action=mi_actividad"
                                                               class="btn btn-danger">Cancelar</a>
                                                            <button type="submit" class="btn btn-primary">Guardar
                                                                Cambios
                                                            </button>
                                                            <!--<button type="button" class="btn btn-primary" data-bs-toggle="modal"
                                                                    data-bs-target="#SaveNewEvent">Guardar Cambios</button> -->
                                                        </div>

                                                    </form>
                                                </div>
                                            </div>
                                        </div>
                                        <%-- FIN MODAL EDITAR --%>

                                        <!-- PARTICIPANTES EVENT -->
                                        <td>
                                            <a href="<%=request.getContextPath()%>/DelegadoActividadServlet?action=participantes&idEventoParticipantes=<%=e.getIdEvento()%>"
                                               type="button" class=" btn btn-primary text-light text-decoration-none">
                                                <i class="bi bi-people-fill"></i>
                                            </a>
                                        </td>
                                        <!-- FIN PARTICIPANTES EVENT -->

                                        <!-- FINALIZAR EVENTO -->
                                        <td>
                                            <button class="btn btn-info active" data-bs-toggle="modal"
                                                    data-bs-target="#finalizarEvento<%=i%>">
                                                <i class="bi bi-check2-square"></i>
                                            </button>
                                        </td>
                                        <!-- MODAL FINALIZAR EVENTO -->
                                        <div class="modal fade" id="finalizarEvento<%=i%>" aria-hidden="true">
                                            <div class="modal-dialog modal-dialog-centered">
                                                <div class="modal-content">
                                                    <div class="modal-header">
                                                        <h5 class="modal-title">Finalizar evento</h5>
                                                        <button type="button" class="btn-close" data-bs-dismiss="modal"
                                                                aria-label="Close"></button>
                                                    </div>
                                                    <div class="modal-body">
                                                        ¿Estás seguro de que deseas finalizar el evento?
                                                    </div>
                                                    <div class="modal-footer">
                                                        <form method="post"
                                                              action="<%=request.getContextPath()%>/DelegadoActividadServlet?action=finalizar_evento">

                                                            <button type="button" class="btn btn-danger"
                                                                    data-bs-dismiss="modal">Cancelar
                                                            </button>
                                                            <input type="hidden" class="form-control"
                                                                   name="idEventoFinalizar" value="<%=e.getIdEvento()%>">
                                                            <button type="submit" class="btn btn-primary"
                                                                    data-bs-target="#eliminarConfirmado<%=i%>"
                                                                    data-bs-toggle="modal" data-bs-dismiss="modal">Sí
                                                            </button>

                                                        </form>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>

                                        <!-- ELIMINAR EVENT -->
                                        <td>
                                            <button class="btn btn-danger" data-bs-toggle="modal"
                                                    href="#eliminarEvento<%=i%>">
                                                <i class="bi bi-trash"></i>
                                            </button>
                                        </td>
                                        <%-- MODAL ELIMINAR EVENT --%>
                                        <div class="modal fade" id="eliminarEvento<%=i%>" aria-hidden="true">
                                            <div class="modal-dialog modal-dialog-centered">
                                                <div class="modal-content">
                                                    <div class="modal-header">
                                                        <h5 class="modal-title">Eliminar evento</h5>
                                                        <button type="button" class="btn-close" data-bs-dismiss="modal"
                                                                aria-label="Close"></button>
                                                    </div>
                                                    <div class="modal-body">
                                                        <p>¿Estás seguro de que deseas eliminar este evento?</p>
                                                    </div>

                                                    <div class="modal-footer">
                                                        <form method="post"
                                                              action="<%=request.getContextPath()%>/DelegadoActividadServlet?action=eliminar_evento">

                                                            <button type="button" class="btn btn-danger"
                                                                    data-bs-dismiss="modal">Cancelar
                                                            </button>
                                                            <input type="hidden" class="form-control"
                                                                   name="idEventoEliminar" value="<%=e.getIdEvento()%>">
                                                            <button type="submit" class="btn btn-primary"
                                                                    data-bs-target="#eliminarConfirmado<%=i%>"
                                                                    data-bs-toggle="modal" data-bs-dismiss="modal">Sí
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

                                <!-- PAGINACION -->
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
                                <!-- MODAL AGREGAR EVENT -->
                                <div class="modal fade" id="modalNuevo"
                                     aria-hidden="true">
                                    <div class="modal-dialog">
                                        <div class="modal-content">
                                            <!--Aquí haremos las pruebas con debug -->
                                            <form method="post"
                                                  action="<%=request.getContextPath()%>/DelegadoActividadServlet?action=crear"
                                                  enctype="multipart/form-data"><!--Agregando el enctype para la foto-->

                                                <div class="modal-header">
                                                    <h1 class="modal-title fs-5">Nuevo evento</h1>
                                                    <button type="button" class="btn-close" data-bs-dismiss="modal"
                                                            aria-label="Close"></button>
                                                </div>
                                                <div class="modal-body">
                                                    <div class="mb-3 d-flex justify-content-center align-items-center flex-column">
                                                        <img src="https://yaktribe.games/community/media/placeholder-jpg.84782/full"
                                                             alt="Imagen de muestra"
                                                             class="img-thumbnail w-50">
                                                        <!--<label class="form-label" for="imageUpload">Subir Foto</label>
                                                        <input type="file" class="form-control" id="imageUpload" accept="image/*"> -->
                                                        <label>Subir Foto</label>
                                                        <input type="file" class="form-control" name="eventoFoto"
                                                               accept="image/*" required>
                                                    </div>
                                                    <div class="mb-3">
                                                        <label>Título</label>
                                                        <input type="text" class="form-control" name="titulo"
                                                               placeholder="Ingrese el título del evento">
                                                    </div>
                                                    <div class="mb-3">
                                                        <label>Descripción</label>
                                                        <textarea class="form-control" name="eventoDescripcion" rows="4"
                                                                  placeholder="Ingrese la descripción aquí"></textarea>
                                                    </div>
                                                    <div class="row mb-3">
                                                        <div class="col">
                                                            <!-- <label for="exampleDate" class="form-label">Fecha</label> -->
                                                            <label>Fecha</label>
                                                            <input type="date" class="form-control" name="eventoFecha">
                                                        </div>
                                                        <div class="col">
                                                            <!--  <label for="exampleTime" class="form-label">Hora</label> -->
                                                            <label>Hora</label>
                                                            <input type="time" class="form-control" name="eventoHora">
                                                            <!-- <input type="time" class="form-control" id="exampleTime"> -->
                                                        </div>
                                                    </div>
                                                    <div class="mb-3">
                                                        <label>Lugar</label>
                                                        <input type="text" class="form-control" name="eventoLugar"
                                                               placeholder="Ingrese el lugar">
                                                    </div>
                                                </div>
                                                <div class="modal-footer">
                                                    <!-- <button type="button" class="btn btn-danger"
                                                            data-bs-dismiss="modal">Cancelar</button>   -->
                                                    <a href="<%=request.getContextPath()%>/DelegadoActividadServlet?action=mi_actividad"
                                                       class="btn btn-danger">Cancelar</a>
                                                    <button type="submit" class="btn btn-primary">Guardar Cambios
                                                    </button>

                                                </div>

                                            </form>
                                        </div>
                                    </div>
                                </div>
                                <!-- FIN MODAL AGREGAR ACT -->
                            </div>

                            <!-- FINALIZAR ACTIVIDAD: cambiar todos los eventos a finalizados -->
                            <div class="text-center">
                                <a class="btn btn-dark" data-bs-toggle="modal" href="#finalizarAct" role="button">Finalizar
                                    actividad</a>
                            </div>
                            <!-- MODAL FINALIZAR ACT-->
                            <div class="modal fade" id="finalizarAct" aria-hidden="true">
                                <div class="modal-dialog modal-dialog-centered">
                                    <div class="modal-content">
                                        <div class="modal-header">
                                            <h5 class="modal-title">Finalizar actividad</h5>
                                            <button type="button" class="btn-close" data-bs-dismiss="modal"
                                                    aria-label="Close"></button>
                                        </div>
                                        <div class="modal-body">
                                            ¿Estás seguro que deseas finalizar la actividad?
                                        </div>
                                        <div class="modal-footer">
                                            <form method="post"
                                                  action="<%=request.getContextPath()%>/DelegadoActividadServlet?action=finalizar_actividad">

                                                <button type="button" class="btn btn-danger"
                                                        data-bs-dismiss="modal">Cancelar
                                                </button>
                                                <input type="hidden" class="form-control"
                                                       name="idActividadFinalizar" value="<%=usuariologueado.getDelegadoActividad().getActividad().getIdActividad()%>">
                                                <button type="submit" class="btn btn-primary"
                                                        data-bs-target="#eliminarConfirmado<%=i%>"
                                                        data-bs-toggle="modal" data-bs-dismiss="modal">Sí
                                                </button>

                                            </form>
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