
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.example.proyecto.beans.Actividad" %>
<%@ page import="com.example.proyecto.beans.DelegadoActividad" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.example.proyecto.beans.Alumno" %>
<jsp:useBean id="listaActividades" scope="request" type="ArrayList<com.example.proyecto.beans.DelegadoActividad>" />
<jsp:useBean id="listaAlumnos_DelegadosActividad" scope="request" type="ArrayList<com.example.proyecto.beans.Alumno>" />

<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Actividades</title>
    <!-- Icono de pestaña -->
    <link rel="icon" href="images/IconoBat.png" />
    <!-- Iconos -->
    <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
    <!-- bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
    <!-- css -->
    <link rel="stylesheet" href="css/styleDelGeneral.css">

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
                <a href="<%=request.getContextPath() %>/DelegadoGeneralServlet?action=main_page">
                    <ion-icon name="home-outline"></ion-icon>
                    <span>Inicio</span>
                </a>
            </li>

            <div class="linea"></div>

            <li>
                <a href="<%=request.getContextPath() %>/DelegadoGeneralServlet?action=validar_registro">
                    <ion-icon name="people-outline"></ion-icon>
                    <span>Validar registro</span>
                </a>
            </li>

            <li>
                <a href="<%=request.getContextPath() %>/DelegadoGeneralServlet?action=validar_donaciones">
                    <ion-icon name="heart-outline"></ion-icon>
                    <span>Validar donaciones</span>
                </a>
            </li>


            <li>
                <a id="editarActividades" href="<%=request.getContextPath() %>/DelegadoGeneralServlet?action=editar_actividades">
                    <ion-icon name="clipboard-outline"></ion-icon>
                    <span>Editar actividades</span>
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
                <a href="<%=request.getContextPath() %>/SesionServlet?action=cerrar_sesion">
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
        <!-- header -->
        <div class="row header" style="background-color: #7c9da0;">
            <div class="col">
                <h1><strong>Actividades</strong></h1>
            </div>
        </div>

        <div class="row box">
            <div class="col p-4 mb-4 rounded-4" style="background-color: #ffffff">
                <!-- <h2>Lista de eventos:</h2> -->
                <div class="row search">

                    <div class="col">
                        <h2>Lista de actividades:</h2>
                    </div>


                    <div class="col">
                        <form class="search-form" id="search-container">
                            <input type="search" placeholder="Buscar actividad..." id="search-input">
                            <button class="btn-search">
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
                        <th scope="col">Actividad</th>
                        <th scope="col">Delegado</th>
                        <th scope="col">Enviar correo</th>
                        <th scope="col">Opciones</th>
                    </tr>
                    </thead>
                    <tbody>
                    <%int i = 1;%>
                    <%for (DelegadoActividad delegadoActividad: listaActividades){%>

                    <tr>
                        <th scope="row"><%=i%></th>
                        <td><%=delegadoActividad.getActividad().getTitulo()%></td>
                        <td><%=listaAlumnos_DelegadosActividad.get(i-1).getNombre() +" " + listaAlumnos_DelegadosActividad.get(i-1).getApellido()%></td>
                        <td>
                            <!-- Enviar Notificación -->
                            <button class="opcion btn btn-secondary">
                                <a href="<%=listaAlumnos_DelegadosActividad.get(i-1).getCorreo()%>"
                                   class="text-light text-decoration-none" target="_blank">
                                    <ion-icon name="mail-outline"></ion-icon>
                                </a>
                            </button>
                        </td>
                        <td>
                            <!-- Ver actividad -->
                            <button class="opcion btn btn-primary" data-bs-toggle="modal" data-bs-target="#modalMostrar<%=i%>">
                                <ion-icon name="eye-outline"></ion-icon>
                            </button>
                            <!-- Eliminar actividad -->
                            <button class="opcion btn btn-danger" data-bs-toggle="modal" href="#eliminarActividad<%=i%>">
                                <ion-icon name="trash-outline"></ion-icon>
                            </button>

                        </td>
                    </tr>


                    <!------------------------------------------------ Modals ---------------------------------------------->

                    <!-- Modal de Mostrar actividad -->
                    <div class="modal fade" id="modalMostrar<%=i%>" tabindex="-1" aria-labelledby="exampleModalLabel"
                         aria-hidden="true">
                        <div class="modal-dialog">
                            <div class="modal-content">
                                <form>

                                    <div class="modal-header">
                                        <h1 class="modal-title fs-5" id="nuevoModalLabel"><%=delegadoActividad.getActividad().getTitulo()%></h1>
                                        <button type="button" class="btn-close" data-bs-dismiss="modal"
                                                aria-label="Close"></button>
                                    </div>
                                    <div class="modal-body">
                                        <div class="mb-3 d-flex justify-content-center align-items-center flex-column">
                                            <img src="images/deportes.jpg" alt="Imagen de evento" id="eventImage"
                                                 class="img-thumbnail w-70">
                                        </div>
                                        <div class="mb-3">
                                            <h5>Descripción:</h5>
                                            <p><%=delegadoActividad.getActividad().getDescripcion()%>
                                            </p>
                                        </div>
                                        <!-- Creo que es innecesario para actividad
                                        <div class="row mb-3">
                                            <div class="col">
                                                <h5>Fecha:</h5>
                                                <p>dd/mm/aaaa</p>
                                            </div>
                                            <div class="col">
                                                <h5>Hora:</h5>
                                                <p>hh:mm</p>
                                            </div>
                                        </div>
                                        ------------------------------------------------>

                                        <div class="mb-3">
                                            <h5>Estado:</h5>
                                            <p><%=delegadoActividad.getActividad().getEstado()%></p>
                                        </div>
                                    </div>
                                    <div class="modal-footer">
                                        <button type="button" class="btn btn-danger" data-bs-dismiss="modal">Cerrar</button>
                                        <button type="button" class="btn btn-primary">Editar</button>
                                    </div>

                                </form>
                            </div>
                        </div>
                    </div>

                    <!-- Modal eliminar actividad -->
                    <div class="modal fade" id="eliminarActividad<%=i%>" aria-hidden="true"
                         aria-labelledby="exampleModalToggleLabel" tabindex="-1">
                        <div class="modal-dialog modal-dialog-centered">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h5 class="modal-title" id="eliminarActividad">Eliminar actividad</h5>
                                    <button type="button" class="btn-close" data-bs-dismiss="modal"
                                            aria-label="Close"></button>
                                </div>
                                <div class="modal-body">
                                    ¿Estás seguro que deseas eliminar esta actividad?
                                </div>
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-danger" data-bs-dismiss="modal">Cancelar</button>
                                    <button type="button" class="btn btn-primary" data-bs-target="#eliminarConfirmado"
                                            data-bs-toggle="modal" data-bs-dismiss="modal">Sí</button>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="modal fade" id="eliminarConfirmado" aria-hidden="true"
                         aria-labelledby="exampleModalToggleLabel2" tabindex="-1">
                        <div class="modal-dialog modal-dialog-centered">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h5 class="modal-title" id="eliminarConfirmado">Actividad eliminada</h5>
                                    <button type="button" class="btn-close" data-bs-dismiss="modal"
                                            aria-label="Close"></button>
                                </div>
                                <div class="modal-body">
                                    Se eliminó la actividad exitosamente.
                                </div>
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-primary" data-bs-dismiss="modal">Ok</button>
                                </div>
                            </div>
                        </div>
                    </div>


                    <%i++;%>
                    <%}%>

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

                <!-- Agregar actividad -->
                <div class="row">
                    <div class="col text-center mb-3">
                        <a type="button" class="link-dark" data-bs-toggle="modal"
                           data-bs-target="#modalNuevo"><ion-icon name="add-circle-outline"></ion-icon>
                            Agregar actividad
                        </a>
                    </div>
                </div>

                <!-- Guardar cambios-->
                <div class="modal fade" id="guardarNuevos" aria-hidden="true"
                     aria-labelledby="exampleModalToggleLabel" tabindex="-1">
                    <div class="modal-dialog modal-dialog-centered">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title" id="guardarNuevosLabel">Guardar cambios</h5>
                                <button type="button" class="btn-close" data-bs-dismiss="modal"
                                        aria-label="Close"></button>
                            </div>
                            <div class="modal-body">
                                ¿Estás seguro que quieres guardar los cambios?
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-secondary"
                                        data-bs-dismiss="modal">Cancelar</button>
                                <button type="button" class="btn btn-primary" data-bs-target="#guardarNuevos2"
                                        data-bs-toggle="modal" data-bs-dismiss="modal">Sí</button>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="modal fade" id="guardarNuevos2" aria-hidden="true"
                     aria-labelledby="exampleModalToggleLabel2" tabindex="-1">
                    <div class="modal-dialog modal-dialog-centered">
                        <div class="modal-content">
                            <div class="modal-body">
                                Se guardaron los cambios exitosamente.
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-primary" data-bs-dismiss="modal">Ok</button>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="row text-center">
                    <div class="col">
                        <a class="btn btn-dark" data-bs-toggle="modal" href="#guardarNuevos" role="button">Guardar
                            cambios</a>
                    </div>
                </div>

            </div>




            <!-- Modal de NUEVO -->
            <div class="modal fade" id="modalNuevo" tabindex="-1" aria-labelledby="exampleModalLabel"
                 aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <form>

                            <div class="modal-header">
                                <h1 class="modal-title fs-5" id="nuevoModalLabel">Nuevo actividad</h1>
                                <button type="button" class="btn-close" data-bs-dismiss="modal"
                                        aria-label="Close"></button>
                            </div>
                            <div class="modal-body">
                                <div class="mb-3 d-flex justify-content-center align-items-center flex-column">
                                    <img src="https://yaktribe.games/community/media/placeholder-jpg.84782/full"
                                         alt="Imagen de muestra" id="exampleImage" class="img-thumbnail w-50">
                                    <label class="form-label" for="imageUpload">Subir Foto</label>
                                    <input type="file" class="form-control" id="imageUpload" accept="image/*">
                                </div>
                                <div class="mb-3">
                                    <label for="exampleDescription" class="form-label">Descripción</label>
                                    <textarea class="form-control" id="exampleDescription" rows="4"
                                              placeholder="Ingrese la descripción aquí"></textarea>
                                </div>
                                <div class="row mb-3">
                                    <div class="col">
                                        <label for="exampleDate" class="form-label">Fecha</label>
                                        <input type="date" class="form-control" id="exampleDate">
                                    </div>
                                    <div class="col">
                                        <label for="exampleTime" class="form-label">Hora</label>
                                        <input type="time" class="form-control" id="exampleTime">
                                    </div>
                                </div>
                                <div class="mb-3">
                                    <label for="exampleLocation" class="form-label">Lugar</label>
                                    <input type="text" class="form-control" id="exampleLocation"
                                           placeholder="Ingrese el lugar">
                                </div>
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-danger"
                                        data-bs-dismiss="modal">Cancelar</button>

                                <button type="button" class="btn btn-primary" data-bs-toggle="modal"
                                        data-bs-target="#SaveNewEvent">Guardar Cambios</button>
                            </div>

                        </form>
                    </div>
                </div>
            </div>

            <!-- Mini modal de guardar -->
            <div class="modal fade" id="SaveNewEvent" tabindex="-1" aria-labelledby="exampleModalLabel"
                 aria-hidden="true">
                <div class="modal-dialog modal-dialog-centered">
                    <div class="modal-content">
                        <div class="modal-body">
                            Se guardaron los cambios exitosamente.
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-primary" data-bs-dismiss="modal">Ok</button>
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
