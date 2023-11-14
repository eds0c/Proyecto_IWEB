<%--
  Created by IntelliJ IDEA.
  User: ARKEL
  Date: 7/11/2023
  Time: 18:31
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.example.proyecto.beans.Alumno" %>
<<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Validar registro</title>
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
                <a id="inicio" href="<%=request.getContextPath() %>/DelegadoGeneralServlet?action=main_page">
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
                <a href="<%=request.getContextPath() %>/DelegadoGeneralServlet?action=editar_actividades">
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
                <h1>Registro de usuarios</strong></h1>
            </div>
        </div>

        <!-- Nuevos Participantes -->
        <div class="row participantes">
            <div class="col p-4 participantes rounded-4" style="background-color: #ffffff">
                <div class="row search">
                    <div class="col">
                        <h2>Nuevas solicitudes:</h2>
                    </div>

                    <div class="col">
                        <form class="search-form" id="search-container">
                            <input type="search" placeholder="Buscar participante..." id="search-input">
                            <button class="btn-search">
                                <ion-icon name="search-outline"></ion-icon>
                            </button>

                        </form>
                    </div>
                </div>
                <!-- Tabla de participantes -->
                <table class="table table-hover">
                    <thead>
                    <tr>
                        <th scope="col">#</th>
                        <th scope="col">Nombre </th>
                        <th scope="col">Correo</th>
                        <th scope="col">Estado</th>
                        <th scope="col">Rol</th>
                        <th scope="col"></th>
                    </tr>
                    </thead>
                    <tbody>
                    <tr>
                        <th scope="row">1</th>
                        <td>Nombre Apellido</td>
                        <td>nombre_apellidop@pucp.edu.pe</td>
                        <td>
                            <input type="radio" name="flexRadioDefault" id="Aceptado" />
                            <label for="Alumno">Aceptado</label>

                            <input type="radio" name="flexRadioDefault" id="Denegado" />
                            <label for="barra">Denegado</label>
                        </td>
                        <td>
                            <!-- averiguar como desmarcar -->
                            <input type="radio" id="barra" />
                            <label for="Alumno">Delegado</label>
                        </td>
                        <td>
                            <!-- Enviar Notificación -->
                            <button class="opcion">
                                <a href="mailto:nombre_apellido@pucp.edu.pe"
                                   class="text-dark text-decoration-none" target="_blank">
                                    <ion-icon name="mail-outline"></ion-icon>
                                </a>
                            </button>
                        </td>
                    </tr>
                    <tr>
                        <th scope="row">2</th>
                        <td>Nombre Apellido</td>
                        <td>nombre_apellidop@pucp.edu.pe</td>
                        <td>
                            <input type="radio" name="flexRadioDefault" id="Aceptado" />
                            <label for="Alumno">Aceptado</label>

                            <input type="radio" name="flexRadioDefault" id="Denegado" />
                            <label for="barra">Denegado</label>
                        </td>
                        <td>
                            <!-- averiguar como desmarcar -->
                            <input type="radio" id="barra" />
                            <label for="Alumno">Delegado</label>
                        </td>
                        <td>
                            <!-- Enviar Notificación -->
                            <button class="opcion">
                                <a href="mailto:nombre_apellido@pucp.edu.pe"
                                   class="text-dark text-decoration-none" target="_blank">
                                    <ion-icon name="mail-outline"></ion-icon>
                                </a>
                            </button>
                        </td>
                    </tr>
                    <tr>
                        <th scope="row">3</th>
                        <td>Nombre Apellido</td>
                        <td>nombre_apellidop@pucp.edu.pe</td>
                        <td>
                            <input type="radio" name="flexRadioDefault" id="Aceptado" />
                            <label for="Alumno">Aceptado</label>

                            <input type="radio" name="flexRadioDefault" id="Denegado" />
                            <label for="barra">Denegado</label>
                        </td>
                        <td>
                            <!-- averiguar como desmarcar -->
                            <input type="radio" id="barra" />
                            <label for="Alumno">Delegado</label>
                        </td>
                        <td>
                            <!-- Enviar Notificación -->
                            <button class="opcion">
                                <a href="mailto:nombre_apellido@pucp.edu.pe"
                                   class="text-dark text-decoration-none" target="_blank">
                                    <ion-icon name="mail-outline"></ion-icon>
                                </a>
                            </button>
                        </td>
                    </tr>


                    </tbody>
                </table>
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

                <!-- Guardar nuevos participantes revisar si es necesario poner doble si es lo mismo-->
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

        </div>

        <!-- Participantes  -->
        <div class="row participantes">
            <div class="col p-4 rounded-4" style="background-color: #ffffff">
                <div class="row search">
                    <div class="col">
                        <h2>Lista de participantes:</h2>
                    </div>

                    <div class="col">
                        <form class="search-form" id="search-container">
                            <input type="search" placeholder="Buscar participante..." id="search-input">
                            <button class="btn-search">
                                <ion-icon name="search-outline"></ion-icon>
                            </button>

                        </form>
                    </div>
                </div>
                <!-- Tabla de participantes -->
                <table class="table table-hover">
                    <thead>
                    <tr>
                        <th scope="col">#</th>
                        <th scope="col">Nombre </th>
                        <th scope="col">Correo</th>
                        <th scope="col">Rol</th>
                        <th scope="col">Opciones</th>
                    </tr>
                    </thead>
                    <tbody>
                    <tr>
                        <th scope="row">1</th>
                        <td>Nombre Apellido</td>
                        <td>nombre_apellidop@pucp.edu.pe</td>
                        <td>Alumno</td>

                        <td>
                            <!-- Ver alumno -->
                            <button class="opcion" data-bs-toggle="modal" data-bs-target="#modalMostrar">
                                <ion-icon name="eye-outline"></ion-icon>
                            </button>
                            <!-- Enviar Notificación -->
                            <button class="opcion">
                                <a href="mailto:nombre_apellido@pucp.edu.pe"
                                   class="text-dark text-decoration-none" target="_blank">
                                    <ion-icon name="mail-outline"></ion-icon>
                                </a>
                            </button>
                            <!-- Banear alumno -->
                            <button class="opcion" data-bs-toggle="modal" href="#eliminarAlumno">
                                <ion-icon name="ban-outline"></ion-icon>
                            </button>
                        </td>
                    </tr>
                    <tr>
                        <th scope="row">2</th>
                        <td>Nombre Apellido</td>
                        <td>nombre_apellidop@pucp.edu.pe</td>
                        <td>Alumno</td>
                        <td>
                            <!-- Ver alumno -->
                            <button class="opcion" data-bs-toggle="modal" data-bs-target="#modalMostrar">
                                <ion-icon name="eye-outline"></ion-icon>
                            </button>
                            <!-- Enviar Notificación -->
                            <button class="opcion">
                                <a href="mailto:nombre_apellido@pucp.edu.pe"
                                   class="text-dark text-decoration-none" target="_blank">
                                    <ion-icon name="mail-outline"></ion-icon>
                                </a>
                            </button>
                            <!-- Banear alumno -->
                            <button class="opcion" data-bs-toggle="modal" href="#eliminarAlumno">
                                <ion-icon name="ban-outline"></ion-icon>
                            </button>
                        </td>
                    </tr>
                    <tr>
                        <th scope="row">3</th>
                        <td>Nombre Apellido</td>
                        <td>nombre_apellidop@pucp.edu.pe</td>
                        <td>Alumno</td>
                        <td>
                            <!-- Ver alumno -->
                            <button class="opcion" data-bs-toggle="modal" data-bs-target="#modalMostrar">
                                <ion-icon name="eye-outline"></ion-icon>
                            </button>
                            <!-- Enviar Notificación -->
                            <button class="opcion">
                                <a href="mailto:nombre_apellido@pucp.edu.pe"
                                   class="text-dark text-decoration-none" target="_blank">
                                    <ion-icon name="mail-outline"></ion-icon>
                                </a>
                            </button>
                            <!-- Banear alumno -->
                            <button class="opcion" data-bs-toggle="modal" href="#eliminarAlumno">
                                <ion-icon name="ban-outline"></ion-icon>
                            </button>
                        </td>
                    </tr>

                    <tr>
                        <th scope="row">4</th>
                        <td>Nombre Apellido</td>
                        <td>nombre_apellidop@pucp.edu.pe</td>
                        <td>Alumno</td>
                        <td>
                            <!-- Ver alumno -->
                            <button class="opcion" data-bs-toggle="modal" data-bs-target="#modalMostrar">
                                <ion-icon name="eye-outline"></ion-icon>
                            </button>
                            <!-- Enviar Notificación -->
                            <button class="opcion">
                                <a href="mailto:nombre_apellido@pucp.edu.pe"
                                   class="text-dark text-decoration-none" target="_blank">
                                    <ion-icon name="mail-outline"></ion-icon>
                                </a>
                            </button>
                            <!-- Banear alumno -->
                            <button class="opcion" data-bs-toggle="modal" href="#eliminarAlumno">
                                <ion-icon name="ban-outline"></ion-icon>
                            </button>
                        </td>
                    </tr>

                    <tr>
                        <th scope="row">5</th>
                        <td>Nombre Apellido</td>
                        <td>nombre_apellidop@pucp.edu.pe</td>
                        <td>Delegado</td>
                        <td>
                            <!-- Ver alumno -->
                            <button class="opcion" data-bs-toggle="modal" data-bs-target="#modalMostrar">
                                <ion-icon name="eye-outline"></ion-icon>
                            </button>
                            <!-- Enviar Notificación -->
                            <button class="opcion">
                                <a href="mailto:nombre_apellido@pucp.edu.pe"
                                   class="text-dark text-decoration-none" target="_blank">
                                    <ion-icon name="mail-outline"></ion-icon>
                                </a>
                            </button>
                            <!-- Banear alumno -->
                            <button class="opcion" data-bs-toggle="modal" href="#eliminarAlumno">
                                <ion-icon name="ban-outline"></ion-icon>
                            </button>
                        </td>
                    </tr>

                    <tr>
                        <th scope="row">6</th>
                        <td>Nombre Apellido</td>
                        <td>nombre_apellidop@pucp.edu.pe</td>
                        <td>Alumno</td>
                        <td>
                            <!-- Ver alumno -->
                            <button class="opcion" data-bs-toggle="modal" data-bs-target="#modalMostrar">
                                <ion-icon name="eye-outline"></ion-icon>
                            </button>
                            <!-- Enviar Notificación -->
                            <button class="opcion">
                                <a href="mailto:nombre_apellido@pucp.edu.pe"
                                   class="text-dark text-decoration-none" target="_blank">
                                    <ion-icon name="mail-outline"></ion-icon>
                                </a>
                            </button>
                            <!-- Banear alumno -->
                            <button class="opcion" data-bs-toggle="modal" href="#eliminarAlumno">
                                <ion-icon name="ban-outline"></ion-icon>
                            </button>
                        </td>
                    </tr>

                    <tr>
                        <th scope="row">7</th>
                        <td>Nombre Apellido</td>
                        <td>nombre_apellidop@pucp.edu.pe</td>
                        <td>Delegado</td>
                        <td>
                            <!-- Ver alumno -->
                            <button class="opcion" data-bs-toggle="modal" data-bs-target="#modalMostrar">
                                <ion-icon name="eye-outline"></ion-icon>
                            </button>
                            <!-- Enviar Notificación -->
                            <button class="opcion">
                                <a href="mailto:nombre_apellido@pucp.edu.pe"
                                   class="text-dark text-decoration-none" target="_blank">
                                    <ion-icon name="mail-outline"></ion-icon>
                                </a>
                            </button>
                            <!-- Banear alumno -->
                            <button class="opcion" data-bs-toggle="modal" href="#eliminarAlumno">
                                <ion-icon name="ban-outline"></ion-icon>
                            </button>
                        </td>
                    </tr>

                    <tr>
                        <th scope="row">8</th>
                        <td>Nombre Apellido</td>
                        <td>nombre_apellidop@pucp.edu.pe</td>
                        <td>Delegado</td>
                        <td>
                            <!-- Ver alumno -->
                            <button class="opcion" data-bs-toggle="modal" data-bs-target="#modalMostrar">
                                <ion-icon name="eye-outline"></ion-icon>
                            </button>
                            <!-- Enviar Notificación -->
                            <button class="opcion">
                                <a href="mailto:nombre_apellido@pucp.edu.pe"
                                   class="text-dark text-decoration-none" target="_blank">
                                    <ion-icon name="mail-outline"></ion-icon>
                                </a>
                            </button>
                            <!-- Banear alumno -->
                            <button class="opcion" data-bs-toggle="modal" href="#eliminarAlumno">
                                <ion-icon name="ban-outline"></ion-icon>
                            </button>
                        </td>
                    </tr>

                    <tr>
                        <th scope="row">9</th>
                        <td>Nombre Apellido</td>
                        <td>nombre_apellidop@pucp.edu.pe</td>
                        <td>Delegado</td>
                        <td>
                            <!-- Ver alumno -->
                            <button class="opcion" data-bs-toggle="modal" data-bs-target="#modalMostrar">
                                <ion-icon name="eye-outline"></ion-icon>
                            </button>
                            <!-- Enviar Notificación -->
                            <button class="opcion">
                                <a href="mailto:nombre_apellido@pucp.edu.pe"
                                   class="text-dark text-decoration-none" target="_blank">
                                    <ion-icon name="mail-outline"></ion-icon>
                                </a>
                            </button>
                            <!-- Banear alumno -->
                            <button class="opcion" data-bs-toggle="modal" href="#eliminarAlumno">
                                <ion-icon name="ban-outline"></ion-icon>
                            </button>
                        </td>
                    </tr>

                    <tr>
                        <th scope="row">10</th>
                        <td>Nombre Apellido</td>
                        <td>nombre_apellidop@pucp.edu.pe</td>
                        <td>Delegado</td>
                        <td>
                            <!-- Ver alumno -->
                            <button class="opcion" data-bs-toggle="modal" data-bs-target="#modalMostrar">
                                <ion-icon name="eye-outline"></ion-icon>
                            </button>
                            <!-- Enviar Notificación -->
                            <button class="opcion">
                                <a href="mailto:nombre_apellido@pucp.edu.pe"
                                   class="text-dark text-decoration-none" target="_blank">
                                    <ion-icon name="mail-outline"></ion-icon>
                                </a>
                            </button>
                            <!-- Banear alumno -->
                            <button class="opcion" data-bs-toggle="modal" href="#eliminarAlumno">
                                <ion-icon name="ban-outline"></ion-icon>
                            </button>
                        </td>
                    </tr>


                    </tbody>
                </table>
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

                <!-- Modal de Mostrar actividad -->
                <div class="modal fade" id="modalMostrar" tabindex="-1" aria-labelledby="exampleModalLabel"
                     aria-hidden="true">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <form>

                                <div class="modal-header">
                                    <h1 class="modal-title fs-5" id="nuevoModalLabel">Nombre actividad</h1>
                                    <button type="button" class="btn-close" data-bs-dismiss="modal"
                                            aria-label="Close"></button>
                                </div>
                                <div class="modal-body">
                                    <div class="mb-3 d-flex justify-content-center align-items-center flex-column">
                                        <img src="images/usuario.jpg" alt="Imagen del usuario" id="userImage"
                                             class="img-thumbnail w-50">
                                    </div>

                                    <div class="row mb-2">
                                        <div class="col">
                                            <h5>Nombre:</h5>
                                            <p>Juan</p>
                                        </div>
                                        <div class="col">
                                            <h5>Apellido:</h5>
                                            <p>Perez</p>
                                        </div>
                                    </div>
                                    <div class="row mb-2">
                                        <div class="col">
                                            <h5>Rol:</h5>
                                            <p>Delegado de deportes</p>
                                        </div>
                                        <div class="col">
                                            <h5>Código:</h5>
                                            <p>20201234</p>
                                        </div>
                                    </div>


                                    <div class="mb-3">
                                        <h5>Correo:</h5>
                                        <p>20201234@pucp.edu.pe</p>
                                    </div>

                                </div>
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-danger"
                                            data-bs-dismiss="modal">Cerrar</button>
                                </div>

                            </form>
                        </div>
                    </div>
                </div>




                <!-- Modal eliminar alumno -->
                <div class="modal fade" id="eliminarAlumno" aria-hidden="true"
                     aria-labelledby="exampleModalToggleLabel" tabindex="-1">
                    <div class="modal-dialog modal-dialog-centered">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title" id="eliminarAlumno">Eliminar alumno</h5>
                                <button type="button" class="btn-close" data-bs-dismiss="modal"
                                        aria-label="Close"></button>
                            </div>
                            <div class="modal-body">
                                ¿Estás seguro que deseas eliminar a este alumno?
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-danger"
                                        data-bs-dismiss="modal">Cancelar</button>
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
                                <h5 class="modal-title" id="eliminarConfirmado">Alumno eliminado</h5>
                                <button type="button" class="btn-close" data-bs-dismiss="modal"
                                        aria-label="Close"></button>
                            </div>
                            <div class="modal-body">
                                Se expulsó al alumno correctamente.
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-primary" data-bs-dismiss="modal">Ok</button>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- BORRAR SI ES REDUNDANTA O NO  -->
                <div class="row text-center">
                    <div class="col">
                        <a class="btn btn-dark" data-bs-toggle="modal" href="#guardarNuevos" role="button">Guardar
                            cambios</a>
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
