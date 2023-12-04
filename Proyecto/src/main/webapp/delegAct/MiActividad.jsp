
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.example.proyecto.beans.Evento" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.example.proyecto.beans.Alumno" %>
<jsp:useBean id="lista3" scope="request" type="ArrayList<Evento>" />
<jsp:useBean id="usuariologueado" scope="session" type="com.example.proyecto.beans.Alumno" class="com.example.proyecto.beans.Alumno"/>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Mi Actividad</title>
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

            <li>
                <a id="miActividad" href="<%=request.getContextPath() %>/DelegadoActividadServlet?action=mi_actividad">
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


<main>
    <div class="container-fluid">
        <!-- header -->
        <div class="row header" style="background-color: #7c9da0;">
            <div class="col">
                <h1><strong><%=usuariologueado.getDelegadoActividad().getActividad().getTitulo() == null ? "Actividad" : usuariologueado.getDelegadoActividad().getActividad().getTitulo()%></strong></h1>
            </div>
        </div>

        <div class="row box-form">
            <div class="col p-4 mb-4 rounded-4" style="background-color: #ffffff">
                <!-- <h2>Lista de eventos:</h2> -->
                <div class="row search">

                    <div class="col">
                        <h2>Lista de eventos:</h2>
                    </div>


                    <div class="col">
                        <form method="GET" action="<%=request.getContextPath()%>/DelegadoActividadServlet" class="search-form" id="search-container">
                            <input aria-label="action" type="hidden" name="action" value="buscarEvento">
                            <input aria-label="Buscar evento..." name="evento" type="search" placeholder="Buscar evento..." id="search-input">
                            <button type="submit" class="btn-search">
                                <ion-icon name="search-outline"></ion-icon>
                            </button>
                        </form>
                    </div>
                </div>
                <!-- Tabla de eventos -->
                <table class="table table-hover">
                    <thead>
                    <tr>
                        <th scope="col">#</th>
                        <th scope="col">Evento</th>
                        <th scope="col">Fecha</th>
                        <th scope="col">Opciones</th>
                    </tr>
                    </thead>
                    <tbody>

                    <%int i=1;%>
                    <%for (Evento e: lista3){%>
                    <!-- Aquí-->
                    <tr>

                            <th scope="row"><%=i%></th>
                        <td><%=e.getTitulo()%></td>
                        <td><%=e.getFechaIn()%></td>
                        <td>

                            <!-- Ver evento -->
                            <button class="opcion btn btn-primary" data-bs-toggle="modal" data-bs-target="#modalMostrar<%=i%>">
                                <ion-icon name="eye-outline"></ion-icon>
                            </button>
                            <!-- Ver participantes -->
                            <button class="opcion btn btn-success">
                                <a href="<%=request.getContextPath()%>/DelegadoActividadServlet?action=participantes&idEventoParticipantes=<%=e.getIdEvento()%>" class="text-light text-decoration-none">
                                    <ion-icon name="people-outline"></ion-icon>
                                </a>
                            </button>
                            <!-- Eliminar evento -->
                            <button class="opcion btn btn-danger" data-bs-toggle="modal" data-bs-target="#eliminarEvento<%=i%>">
                                <ion-icon name="trash-outline"></ion-icon>
                            </button>

                        </td>
                        <%i=i+1;%>
                    </tr>

                    <%};%>



                    </tbody>
                </table>

                <!-- Footer -->
                <div class="row footer">
                    <div class="col">
                        <nav aria-label="Page navigation example justify-content-center">
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

                <!-- Agregar evento -->
                <div class="row">
                    <div class="col text-center">
                        <!-- <a href="AddEvent.html">Agregar evento</a> -->
                        <a type="button" class="link-dark" data-bs-toggle="modal"
                           data-bs-target="#modalNuevo"><ion-icon name="add-circle-outline"></ion-icon>
                            Agregar evento
                        </a>
                    </div>
                </div>

            </div>

            <!------------- MODALS OPCIONES EVENTO-------------------->

            <%int j=1;%>
            <%for (Evento e: lista3){%>

            <!-- Modal de Mostrar evento -->
            <div class="modal fade" id="modalMostrar<%=j%>" tabindex="-1" aria-labelledby="exampleModalLabel"
                 aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <form>

                            <div class="modal-header">
                                <h1 class="modal-title fs-5" id="nuevoModalLabel"><%=e.getTitulo()%></h1>
                                <button type="button" class="btn-close" data-bs-dismiss="modal"
                                        aria-label="Close"></button>
                            </div>
                            <div class="modal-body">
                                <div class="mb-3 d-flex justify-content-center align-items-center flex-column">
                                    <img src="<%=request.getContextPath()%>/ImgServlet?id=<%=e.getIdEvento()%>" width="250" height="230">
                                </div>
                                <div class="mb-3">
                                    <h5>Descripción:</h5>
                                    <p><%=e.getDescripcion()%>
                                    </p>
                                </div>
                                <div class="row mb-3">
                                    <div class="col">
                                        <h5>Fecha:</h5>
                                        <p><%=e.getFechaIn()%></p>
                                    </div>
                                    <div class="col">
                                        <h5>Hora:</h5>
                                        <p><%=e.getHora()%></p>
                                    </div>
                                </div>
                                <div class="mb-3">
                                    <h5>Lugar:</h5>
                                    <p><%=e.getLugar()%></p>
                                </div>
                            </div>
                            <div class="modal-footer">
                                <!-- <button type="button" class="btn btn-danger" data-bs-dismiss="modal">Cerrar</button> -->
                                <a href="<%=request.getContextPath()%>/DelegadoActividadServlet?action=mi_actividad" class="btn btn-danger">Cerrar</a>
                                <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#modalEditar<%=j%>">Editar</button>
                            </div>

                        </form>
                    </div>
                </div>
            </div>

            <!-- Modal de Editar -->
            <div class="modal fade" id="modalEditar<%=j%>" tabindex="-1" aria-labelledby="exampleModalLabel"
                 aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">


                        <form method="post" action="<%=request.getContextPath()%>/DelegadoActividadServlet?action=editar" enctype="multipart/form-data">

                            <div class="modal-header">
                                <h1 class="modal-title fs-5" id="nuevoModalLabel">Editar evento</h1>
                                <button type="button" class="btn-close" data-bs-dismiss="modal"
                                        aria-label="Close"></button>
                            </div>
                            <div class="modal-body">
                                <div class="mb-3 d-flex justify-content-center align-items-center flex-column">
                                    <img src="https://yaktribe.games/community/media/placeholder-jpg.84782/full"
                                         alt="Imagen de muestra" id="exampleImage" class="img-thumbnail w-50">
                                    <!--<label class="form-label" for="imageUpload">Subir Foto</label>
                                    <input type="file" class="form-control" id="imageUpload" accept="image/*"> -->
                                    <label>Subir Foto</label>
                                    <input type="file" class="form-control" name="eventoFoto" accept="image/*" value="<%=e.getFoto()%>">
                                </div>
                                <div class="mb-3">
                                    <label>Título</label>
                                    <input type="text" class="form-control" name="titulo" value="<%=e.getTitulo()%>"
                                           placeholder="Ingrese el título del evento">
                                </div>
                                <div class="mb-3">
                                    <!--<label for="exampleDescription" class="form-label">Descripción</label>
                                    <textarea class="form-control" id="exampleDescription" rows="4"
                                              placeholder="Ingrese la descripción aquí"></textarea>-->
                                    <label>Descripción</label>

                                    <textarea class="form-control" name="eventoDescripcion" rows="4"
                                              placeholder="Ingrese la descripción aquí"><%=e.getDescripcion()%></textarea>
                                </div>
                                <div class="row mb-3">
                                    <div class="col">
                                        <!-- <label for="exampleDate" class="form-label">Fecha</label> -->
                                        <label>Fecha</label>
                                        <input type="date" class="form-control" name="eventoFecha" value="<%=e.getFechaIn()%>">
                                        <input type="hidden" class="form-control" name="eventoID" value="<%=e.getIdEvento()%>">
                                    </div>
                                    <div class="col">
                                        <!--  <label for="exampleTime" class="form-label">Hora</label> -->
                                        <label>Hora</label>
                                        <input type="time" class="form-control" name="eventoHora" value="<%=e.getHora()%>">
                                        <!-- <input type="time" class="form-control" id="exampleTime"> -->
                                    </div>
                                </div>
                                <div class="mb-3">
                                    <label>Lugar</label>
                                    <input type="text" class="form-control" name="eventoLugar" value="<%=e.getLugar()%>"
                                           placeholder="Ingrese el lugar">
                                </div>

                            </div>
                            <div class="modal-footer">
                                <!-- <button type="button" class="btn btn-danger"
                                        data-bs-dismiss="modal">Cancelar</button>   -->
                                <a href="<%=request.getContextPath()%>/DelegadoActividadServlet?action=mi_actividad" class="btn btn-danger">Cancelar</a>
                                <button type="submit" class="btn btn-primary">Guardar Cambios</button>
                                <!--<button type="button" class="btn btn-primary" data-bs-toggle="modal"
                                        data-bs-target="#SaveNewEvent">Guardar Cambios</button> -->
                            </div>

                        </form>
                    </div>
                </div>
            </div>
            <!-- Modal eliminar evento -->
            <div class="modal fade" id="eliminarEvento<%=j%>" aria-hidden="true" aria-labelledby="exampleModalToggleLabel"
                 tabindex="-1">
                <div class="modal-dialog modal-dialog-centered">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="eliminarEvento">Eliminar evento</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal"
                                    aria-label="Close"></button>
                        </div>
                        <div class="modal-body">
                            ¿Estás seguro que deseas eliminar este evento?
                        </div>
                        <form method="post" action="<%=request.getContextPath()%>/DelegadoActividadServlet?action=eliminar_evento">
                        <div class="modal-footer">
                            <button type="button" class="btn btn-danger" data-bs-dismiss="modal">Cancelar</button>
                            <input type="hidden" class="form-control" name="idEventoEliminar" value="<%=e.getIdEvento()%>">
                            <button type="submit" class="btn btn-primary" data-bs-target="#eliminarConfirmado<%=j%>"
                                    data-bs-toggle="modal" data-bs-dismiss="modal">Sí</button>
                        </div>
                        </form>
                    </div>
                </div>
            </div>
            <div class="modal fade" id="eliminarConfirmado<%=j%>" aria-hidden="true"
                 aria-labelledby="exampleModalToggleLabel2" tabindex="-1">
                <div class="modal-dialog modal-dialog-centered">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="eliminarConfirmado">Evento eliminado</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal"
                                    aria-label="Close"></button>
                        </div>
                        <div class="modal-body">
                            Se eliminó el evento exitosamente.
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-primary" data-bs-dismiss="modal">Ok</button>
                        </div>
                    </div>
                </div>
            </div>
            <%j = j+1;%>
            <%};%>


            <!-- Modal finalizar -->
            <div class="modal fade" id="exampleModalToggle" aria-hidden="true"
                 aria-labelledby="exampleModalToggleLabel" tabindex="-1">
                <div class="modal-dialog modal-dialog-centered">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="exampleModalToggleLabel">Finalizar actividad</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal"
                                    aria-label="Close"></button>
                        </div>
                        <div class="modal-body">
                            ¿Estás seguro que deseas finalizar la actividad?
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-danger" data-bs-dismiss="modal">Cancelar</button>
                            <button type="button" class="btn btn-primary" data-bs-target="#exampleModalToggle2"
                                    data-bs-toggle="modal" data-bs-dismiss="modal">Sí</button>
                        </div>
                    </div>
                </div>
            </div>
            <div class="modal fade" id="exampleModalToggle2" aria-hidden="true"
                 aria-labelledby="exampleModalToggleLabel2" tabindex="-1">
                <div class="modal-dialog modal-dialog-centered">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="exampleModalToggleLabel2">Actividad finalizada</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal"
                                    aria-label="Close"></button>
                        </div>
                        <div class="modal-body">
                            Se finalizó la actividad exitosamente.
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-primary" data-bs-dismiss="modal">Ok</button>
                        </div>
                    </div>
                </div>
            </div>
            <a class="btn btn-dark" data-bs-toggle="modal" href="#exampleModalToggle" role="button">Finalizar
                actividad</a>

            <!-- Modal de NUEVO -->
            <div class="modal fade" id="modalNuevo" tabindex="-1" aria-labelledby="exampleModalLabel"
                 aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">

                        <!--Aquí haremos las pruebas con debug -->
                        <form method="post" action="<%=request.getContextPath()%>/DelegadoActividadServlet?action=crear" enctype="multipart/form-data"> <!--Agregando el enctype para la foto-->

                            <div class="modal-header">
                                <h1 class="modal-title fs-5" id="nuevoModalLabel">Nuevo evento</h1>
                                <button type="button" class="btn-close" data-bs-dismiss="modal"
                                        aria-label="Close"></button>
                            </div>
                            <div class="modal-body">
                                <div class="mb-3 d-flex justify-content-center align-items-center flex-column">
                                    <img src="https://yaktribe.games/community/media/placeholder-jpg.84782/full"
                                         alt="Imagen de muestra" id="exampleImage" class="img-thumbnail w-50">
                                    <!--<label class="form-label" for="imageUpload">Subir Foto</label>
                                    <input type="file" class="form-control" id="imageUpload" accept="image/*"> -->
                                    <label>Subir Foto</label>
                                    <input type="file" class="form-control" name="eventoFoto" accept="image/*">
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
                                <a href="<%=request.getContextPath()%>/DelegadoActividadServlet?action=mi_actividad" class="btn btn-danger">Cancelar</a>
                                <button type="submit" class="btn btn-primary">Guardar Cambios</button>
                                <!--<button type="button" class="btn btn-primary" data-bs-toggle="modal"
                                        data-bs-target="#SaveNewEvent">Guardar Cambios</button> -->
                            </div>

                        </form>
                    </div>
                </div>
            </div>

            <!-- Mini modal de guardar -->
            <div class="modal fade" id="SaveNewEvent" tabindex="-1"
                 aria-labelledby="exampleModalLabel" aria-hidden="true">
                <div class="modal-dialog modal-dialog-centered">
                    <div class="modal-content">
                        <div class="modal-body">
                            Se guardaron los cambios exitosamente.
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-primary"
                                    data-bs-dismiss="modal">Ok</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>

    </div>

</main>



<script type="module" src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.esm.js"></script>
<script nomodule src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.js"></script>
<script src="js/mainscript.js"></script>
<!--Script de bootstrap  -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL"
        crossorigin="anonymous"></script>

</body>

</html>
