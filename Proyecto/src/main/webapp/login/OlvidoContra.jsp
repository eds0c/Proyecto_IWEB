
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Recuperar contraseña</title>
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
    <div class="form-information overflow-auto">
        <div class="form-information-childs">
            <div class="mb-3">
                <img src="images/candado.png" width="80px">
            </div>

            <h2>Recupere su contraseña</h2>
            <p>Introduce tu correo PUCP y te enviaremos un enlace para restablecer tu contraseña.</p>

            <!-- Recuperar Contraseña -->
            <form class="form" id="EmailForm">
                <label class="mb-1">
                    <i class='bx bx-envelope'></i>
                    <input id="email" type="email" placeholder="Correo PUCP" required>
                </label>

                <!-- Button trigger modal -->
                <button class="presionar" type="submit">Enviar enlace</button>

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

<!-- Modal de confirmación -->
<div class="modal fade" id="confirmacionModal"  tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">

            <div class="modal-header">
                <h5 class="modal-title fs-5">Aviso</h5>
            </div>

            <div class="modal-body">
                <p>Revise su correo PUCP para reestablecer su contraseña.</p>
            </div>

            <div class="modal-footer">
                <a href="<%=request.getContextPath()%>/SesionServlet?action=inicio_sesion" class="btn btn-success">Entendido</a>
            </div>

        </div>
    </div>
</div>
<!--Script de bootstrap  -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL"
        crossorigin="anonymous">
</script>
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