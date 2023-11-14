<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Cambiar contrasenia</title>
    <link rel="icon" href="images/IconoBat.png" />

    <!-- Iconos -->
    <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
    <!-- Enlazamos archivo css -->
    <link rel="stylesheet" href="css/styleInicio.css">
    <link rel="stylesheet" href="css/styleContra.css" />
</head>

<body>
<div class="container-form">
    <div class="header-information"></div>
    <div class="form-information overflow-auto">
        <div class="form-information-childs">
            <div class="mb-3">
                <img src="images/candado.png" width="80px">
            </div>

            <h2>Cambie su contraseña</h2>

            <!-- Cambiar Contraseña -->
            <form class="form">
                <div class="field create-password">
                    <div class="input-field">
                        <input type="password" placeholder="Nueva contraseña" class="password" />
                        <i class="bx bx-hide show-hide"></i>
                    </div>
                    <span class="error password-error">
              <i class="bx bx-error-circle error-icon"></i>
              <p class="error-text">
                Por favor, ingrese al menos 8 carácteres entre ellos un número,
                símbolo, letra minúscula y mayúscula.
              </p>
            </span>
                </div>
                <div class="field confirm-password">
                    <div class="input-field">
                        <input type="password" placeholder="Confirme contraseña" class="cPassword" />
                        <i class="bx bx-hide show-hide"></i>
                    </div>
                    <span class="error cPassword-error">
              <i class="bx bx-error-circle error-icon"></i>
              <p class="error-text">Las contraseñas no coinciden</p>
            </span>
                </div>


                <div>
                    <input class="presionar" type="submit" value="Cambiar contraseña" />
                </div>

            </form>

            <!-- Se cambió la contraseña exitosamente -->
            <div id="passwordChangeSuccess" style="display: none;">
                <a class="presionar text-decoration-none" href="InicioSesion.html" role="button">Iniciar sesión</a>
            </div>

        </div>
    </div>
</div>
<!-- Archivo script -->
<script src="js/passwordscript.js"></script>
</body>

</html>