
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Olvido de contraseña</title>
    <link rel="icon" href="images/IconoBat.png" />
    <!-- Iconos -->
    <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
    <!-- bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
    <!-- Enlazamos archivo css -->
    <link rel="stylesheet" href="css/styleInicio.css">
</head>

<body>
<div class="container-form">
    <div class="header-information"></div>
    <div class="form-information">
        <div class="form-information-childs">
            <div class="mb-3">
                <img src="images/candado.png" width="80px">
            </div>

            <h2>Recupere su contraseña</h2>
            <p>Coloque su correo PUCP y le enviaremos un enlace para restablecer tu contraseña.</p>
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

            <!-- Recuperar Contraseña -->
            <form class="form" id="EmailForm" method="POST" action="<%=request.getContextPath()%>/SesionServlet?action=generar_token">
                <label class="mb-1">
                    <i class='bx bx-envelope'></i>
                    <input id="email" type="email" placeholder="Correo PUCP" name="correoOlvidoContra" required>
                </label>

                <!-- Button trigger modal -->
                <button type="submit" class="presionar">Enviar enlace</button>
                <!-- Modal de aviso  -->
                <div class="modal fade" id="confirmacionModal" data-bs-backdrop="static" data-bs-keyboard="false" aria-hidden="true">
                    <div class="modal-dialog modal-dialog-centered">
                        <div class="modal-content">

                            <div class="modal-header">
                                <h5 class="modal-title fs-5">Aviso</h5>
                            </div>

                            <div class="modal-body">
                                <p>Revise su correo PUCP para reestablecer su contraseña.</p>
                            </div>

                            <div class="modal-footer">
                                <button type="submit" class="presionar">Entendido</button>
                            </div>

                        </div>
                    </div>
                </div>

            </form>

            <div>
                <p class="d-inline-block">¿No tienes una cuenta?</p>
                <a href="<%=request.getContextPath()%>/SesionServlet?action=registro_usuario"  class="text-dark text-decoration-none">Regístrate</a>
            </div>

            <div>
                <a href="<%=request.getContextPath()%>/SesionServlet?action=inicio_sesion"  class="text-dark text-decoration-none">Volver al inicio</a>
            </div>

        </div>
    </div>
</div>


<!--Script de bootstrap  -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL"
        crossorigin="anonymous">
</script>

</body>
</html>