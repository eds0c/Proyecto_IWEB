
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.example.proyecto.beans.Alumno" %>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Donaciones</title>
    <link rel="icon" href="images/IconoBat.png" />
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
                <a href="<%=request.getContextPath()%>/AlumnoServlet?action=main_page">
                    <ion-icon name="home-outline"></ion-icon>
                    <span>Inicio</span>
                </a>
            </li>

            <div class="linea"></div>

            <li>
                <a href="<%=request.getContextPath()%>/AlumnoServlet?action=mis_eventos">
                    <ion-icon name="calendar-clear-outline"></ion-icon>
                    <span>Mis eventos</span>
                </a>
            </li>
            <li>
                <a href="<%=request.getContextPath()%>/AlumnoServlet?action=eventos_finalizados">
                    <ion-icon name="medal-outline"></ion-icon>
                    <span>Finalizados</span>
                </a>
            </li>

            <div class="linea"></div>

            <li>
                <a id="donaciones" href="<%=request.getContextPath()%>/AlumnoServlet?action=donaciones">
                    <ion-icon name="heart-outline"></ion-icon>
                    <span>Donaciones</span>
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
                <h1>Donación a AITEL</h1>
            </div>
        </div>
        <!-- Contenido donaciones -->
        <div class="row mt-3 ">
            <div class="col">
                <p style="text-align: justify;">En caso de ser egresado de la facultad de Telecomunicaciones,
                    el monto mínimo de pago será de 100 soles, debido a la entrega de un kit teleco.</p>
            </div>
        </div>
        <div class="row">
            <div class="col box-form">
                <form class="p-4 mb-4 bg-body-secondary rounded-4">
                    <!-- Medio de pago -->
                    <div class="row paso">
                        <div class="col">
                            <h2>Paso 1:</h2>
                            <hr>
                            <p>Escanea el QR según tu medio de pago.</p>
                            <div class="row medio-pago">
                                <div class="col text-center yape">
                                    <label for="yape"><img class="img-pago" height="300px"
                                                           src="images/yape.jpg" /></label><br />
                                    <input class="form-check-input" type="radio" name="flexRadioDefault"
                                           id="yape" required/>
                                </div>
                                <div class="col text-center plin">
                                    <label for="plin"><img class="img-pago" height="300px"
                                                           src="images/plin.jpg" /></label><br />
                                    <input class="form-check-input" type="radio" name="flexRadioDefault"
                                           id="plin" required/>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Monto a pagar -->
                    <div class="row paso">
                        <div class="col">
                            <h2>Paso 2:</h2>
                            <hr>
                            <p>Ingrese el monto de donación.</p>
                            <div class="row monto">
                                <div class="col">
                                    <label class="mb-2">Monto (S/.):</label>
                                    <input id="monto" name="monto" class="form-control" placeholder="Monto en soles"
                                           type="" required/>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Comprobante de pago -->
                    <div class="row paso">
                        <div class="col">
                            <h2>Paso 3:</h2>
                            <hr>
                            <p>Sube tu comprobante de pago:</p>
                            <div class="row comprobante">
                                <div class="col field">
                                    <input class="form-control" type="file" id="comprobante" required>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Botón envío -->
                    <div class="row send-button">
                        <div class="col text-center">
                            <button type="submit" class="btn btn-dark mb-3" data-bs-toggle="modal"
                                    data-bs-target="#exampleModal">
                                Enviar Donación
                            </button>
                        </div>
                    </div>

                </form>
            </div>
        </div>
    </div>
    <!-- Modal de confirmación -->
    <div class="modal fade" id="confirmacionModal"  tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">

                <div class="modal-header">
                    <h5 class="modal-title fs-5">Aviso</h5>
                </div>

                <div class="modal-body">
                    <p>Se le enviará la confirmación al correo PUCP después de ser validada la
                        donación.</p>
                </div>

                <div class="modal-footer">
                    <button type="button" class="btn btn-success" data-bs-dismiss="modal"
                            aria-label="Close">Entendido</button>
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
<script>
    document.addEventListener('DOMContentLoaded', function () {
        var formulario = document.getElementById('EmailForm');
        var confirmacionModal = new bootstrap.Modal(document.getElementById('confirmacionModal'));

        formulario.addEventListener('submit', function (event) {
            event.preventDefault(); // Evitar el envío del formulario

            // Realizar la lógica de validación del formulario aquí
            // Mostrar el modal de confirmación después de validar el formulario
            confirmacionModal.show();
        });
    });
</script>
</body>

</html>