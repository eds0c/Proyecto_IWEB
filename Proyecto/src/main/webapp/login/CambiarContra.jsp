<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%String casoUsuario = (String) request.getAttribute("casoC");%>
<%String idUsuario = (String) request.getAttribute("idParaCambiar");%>
<%String tokenEnvioPost = (String) request.getAttribute("tokenEnvio");%>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Cambiar contrasenia</title>
    <link rel="icon" href="images/IconoBat.png"/>

    <!-- Iconos -->
    <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
    <!-- Enlazamos archivo css -->
    <link rel="stylesheet" href="css/styleInicio.css">
    <link rel="stylesheet" href="css/styleContra.css"/>
</head>

<body>
<div class="container-form">
    <div class="header-information"></div>
    <div class="form-information">
        <div class="form-information-childs">
            <div class="mb-3">
                <img src="images/candado.png" width="80px">
            </div>

            <h2>Cambie su contraseña</h2>
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
            <!-- Cambiar Contraseña -->
            <form class="form" method="POST" action="<%=request.getContextPath()%>/SesionServlet?action=reestablecer_contra&caseC=<%=casoUsuario%>">
                <div class="field create-password mt-3">
                    <div class="input-field">
                        <input type="password" placeholder="Nueva contraseña" class="password" name="contra1" required>
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
                        <input type="password" placeholder="Confirme contraseña" class="cPassword" name="contra2" required>
                        <i class="bx bx-hide show-hide"></i>
                    </div>
                    <span class="error cPassword-error">
                                        <i class="bx bx-error-circle error-icon"></i>
                                        <p class="error-text">Las contraseñas no coinciden</p>
                                    </span>
                </div>
                <input type="hidden" name="idUsuarioCambiar" value="<%=idUsuario%>">
                <input type="hidden" name="tokenPost" value="<%=tokenEnvioPost%>">
                <div class="text-center">
                    <button type="submit" class="btn btn-primary">Guardar cambios</button>
                </div>

            </form>

            <!-- Se cambió la contraseña exitosamente -->
            <div id="passwordChangeSuccess" style="display: none;">
                <a class="presionar text-decoration-none" href="<%=request.getContextPath()%>/SesionServlet" role="button">Iniciar sesión</a>
            </div>

        </div>
    </div>
</div>
<!-- Archivo script -->
<script src="js/contrasena.js"></script>
</body>

</html>