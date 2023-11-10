
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Semana Teleco</title>
    <link rel="icon" href="images/IconoBat.png" />

    <!-- Iconos -->
    <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
    <!-- bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
    <!-- Enlazamos archivo css -->
    <link rel="stylesheet" href="css/styleInicio.css">

</head>

<body  style="background-color: rgb(90, 124, 124);">
<div class="container-form">
    <div class="header-information"></div>
    <div class="form-information">
        <div class="form-information-childs">
            <h2>Bienvenido a la Semana de Ingeniería</h2>
            <p>Ingrese sus datos para iniciar sesión</p>

            <!-- Login -->
            <form class="form" action="MainPage.html" method="POST">
                <label>
                    <i class='bx bx-user' ></i>
                    <input id="email" name="email" type="email" placeholder="Correo PUCP" required>
                </label>
                <label class="mb-1">
                    <i class='bx bx-lock-alt' ></i>
                    <input id="password" name="password" type="password" placeholder="Contraseña" required>
                </label>

                <a href="<%=request.getContextPath()%>/SesionServlet?action=olvido_contra"  class="text-dark text-decoration-none">¿Has olvidado tu contraseña?</a>
                <br>

                <button type="submit" class="presionar">
                    Iniciar sesión
                </button>

            </form>

            <div>
                <p class="d-inline-block">¿No tienes una cuenta?</p>
                <a href="<%=request.getContextPath()%>/SesionServlet?action=registro_usuario"  class="text-dark text-decoration-none">Regístrate</a>
            </div>

            <!-- Iconos de contacto -->
            <p>Contáctanos:</p>
            <div class="icons">
                <a href="https://www.instagram.com/aitel.pucp/" class="text-decoration-none" target="_blank">
                    <i class='bx bxl-instagram-alt'></i>
                </a>
                <a href="mailto:aitel@pucp.pe" class="text-decoration-none" target="_blank">
                    <i class='bx bxl-gmail'></i>
                </a>
            </div>

        </div>
    </div>
</div>


</body>
</html>
