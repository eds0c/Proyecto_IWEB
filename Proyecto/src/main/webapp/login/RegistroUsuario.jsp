<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Registro</title>
    <link rel="icon" href="images/IconoBat.png" />

    <!-- Iconos -->
    <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
    <!-- bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
    <!-- Enlazamos archivo css -->
    <link rel="stylesheet" href="css/styleRegistro.css">
    <!-- <link rel="stylesheet" href="css/styleContra.css"> -->

</head>

<body>
<div class="container  overflow-auto">
    <div class="row text-center">
        <div class="col">
            <h1>Crea una cuenta</h1>
        </div>
    </div>
    <hr>
    <!-- VERIFICAR SI ESTE ORDEN DE FORM DENTRO DE COL DENTRO DE ROW ES OPTIMO -->
    <div class="row">
        <div class="col">
            <!-- FORMULARIO PARA LOS DATOS Y EL BOTÓN DE ENVÍO -->
            <form class="form" id="Registro" method="post" action="<%=request.getContextPath()%>/SesionServlet?action=registro_usuario">
                <ul>
                    <!-- INGRESO DE DATOS -->
                    <div class="row">
                        <div class="col-md-6">
                            <!-- foto -->
                            <li>Sube una foto de perfil para que los delegados te reconozcan:</li>
                            <!-- <p>Sube una foto de perfil para que los delegados te reconozcan:</p> -->
                            <div class="field">
                                <input class="form-control" type="file" id="formFile" name="foto">
                            </div>

                            <li>Ingresa tus datos personales:</li>
                            <!-- <p>Ingresa tus datos personales:</p> -->
                            <!-- nombre -->
                            <div class="field">
                                <label>
                                    <i class='bx bx-user'></i>
                                    <input id="nombre" name="nombre" type="text" placeholder="Nombre"
                                           required>
                                </label>
                            </div>
                            <!-- apellido -->
                            <div class="field">
                                <label>
                                    <i class='bx bx-user'></i>
                                    <input id="apellido" name="apellido" type="text" placeholder="Apellido"
                                           required>
                                </label>
                            </div>
                            <!-- codigo -->
                            <div class="field">
                                <label>
                                    <i class='bx bxs-graduation'></i>
                                    <input id="codigo" name="codigo" type="text" placeholder="Código PUCP" required>
                                </label>
                            </div>
                            <!-- correo -->
                            <div class="field">
                                <label>
                                    <i class='bx bx-envelope'></i>
                                    <input id="correo" name="correo" type="email" placeholder="Correo PUCP"
                                           required>
                                    <div class="invalid-feedback">
                                        Por favor ingrese su correo.
                                    </div>
                                </label>
                            </div>


                        </div>
                        <div class="col-md-6">
                            <!-- contraseña -->
                            <li>Crea y confirma una contraseña:</li>
                            <!-- <p>Crea y confirma una contraseña:</p> -->
                            <div class="field create-password">
                                <div class="input-field">
                                    <label>
                                        <i class='bx bx-lock-alt'></i>
                                        <input name="password" type="password" placeholder="Nueva contraseña" class="password" required />
                                        <i class="bx bx-hide show-hide"></i>
                                    </label>

                                </div>
                                <span class="error password-error">
                                        <i class="bx bx-error-circle error-icon"></i>
                                        <p class="error-text">
                                            Por favor, ingrese al menos 8 carácteres entre ellos un número,
                                            símbolo, letra minúscula y mayúscula.
                                        </p>
                                    </span>
                            </div>
                            <!-- verificación de contra -->
                            <div class="field confirm-password">
                                <div class="input-field">
                                    <label>
                                        <i class='bx bx-lock-alt'></i>
                                        <input type="password" placeholder="Confirme contraseña"
                                               class="cPassword" required />
                                        <i class="bx bx-hide show-hide"></i>
                                    </label>

                                </div>
                                <span class="error cPassword-error">
                                        <i class="bx bx-error-circle error-icon"></i>
                                        <p class="error-text">Las contraseñas no coinciden</p>
                                    </span>
                            </div>

                            <!-- estado -->
                            <div>
                                <li>Marca según tu estado:</li>
                                <!-- <p>Marca según tu estado:</p> -->
                                <div class="row mt-3">
                                    <div class="col-sm text-center">
                                        <input class="form-check-input" type="radio" name="estadoAcademico" value="Estudiante"
                                               id="estudiante" style="cursor: pointer;" required />
                                        <label>Estudiante</label>
                                    </div>

                                    <div class="col-sm text-center">
                                        <input class="form-check-input" type="radio" name="estadoAcademico" value="Egresado"
                                               id="egresado" style="cursor: pointer;" required />
                                        <label>Egresado</label>
                                    </div>
                                </div>
                            </div>

                        </div>
                    </div>
                </ul>
                <!-- BOTON DE ENVÍO -->
                <div class="row">
                    <div class="col text-center">
                        <button type="button" class="presionar" data-bs-toggle="modal" data-bs-target="#confirmacionModal">Registrarse</button>
                    </div>
                </div>


                <!-- Modal de Confirmación -->
                <div class="modal fade" id="confirmacionModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h1 class="modal-title fs-5" id="exampleModalLabel">Registro enviado</h1>
                            </div>

                            <div class="modal-body">
                                Se le enviará la confirmación del registro a su correo PUCP después de ser validados sus datos por el delegado general.
                            </div>

                            <div class="modal-footer">
                                <button type="submit" class="presionar">Entendido</button>
                            </div>
                        </div>
                    </div>
                </div>


            </form>
            <!-- FIN DEL FORM -->
        </div>
    </div>

    <!-- YA TIENES UNA CUENTA -->
    <div class="row text-center">
        <div class="col">
            <p class="d-inline-block">¿Ya tienes una cuenta?</p>
            <a href="<%=request.getContextPath()%>/SesionServlet?action=inicio_sesion"class="text-dark text-decoration-none">Entrar</a>
        </div>
    </div>
</div>




<!--Script de bootstrap  -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL" crossorigin="anonymous">
</script>

<script>

    document.addEventListener('DOMContentLoaded', function () {
        var formulario = document.getElementById('Registro');
        //var confirmacionModal = new bootstrap.Modal(document.getElementById('confirmacionModal'));


// Esconder y mostrar contraseña
        const eyeIcons = document.querySelectorAll(".show-hide");

        eyeIcons.forEach((eyeIcon) => {
            eyeIcon.addEventListener("click", () => {
                const pInput = eyeIcon.parentElement.querySelector("input");
                if (pInput.type === "password") {
                    eyeIcon.classList.replace("bx-hide", "bx-show");
                    return (pInput.type = "text");
                }
                eyeIcon.classList.replace("bx-show", "bx-hide");
                pInput.type = "password";
            });
        });

        /*
        formulario.addEventListener('submit', function (event) {
            event.preventDefault(); // Evitar el envío del formulario

            // Realizar la lógica de validación del formulario aquí
            const form = document.querySelector("form"),
                passField = form.querySelector(".create-password"),
                passInput = passField.querySelector(".password"),
                cPassField = form.querySelector(".confirm-password"),
                cPassInput = cPassField.querySelector(".cPassword");


            // Validar contraseña
            function createPass() {
                const passPattern =
                    /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&-])[A-Za-z\d@$!%*?&-]{8,}$/;

                if (!passInput.value.match(passPattern)) {
                    return passField.classList.add("invalid"); //contraseñas no coinciden
                }
                passField.classList.remove("invalid"); //contraseñas coinciden
            }

            function confirmPass() {
                if (passInput.value !== cPassInput.value || cPassInput.value === "") {
                    return cPassField.classList.add("invalid");
                }
                cPassField.classList.remove("invalid");
            }

         */
            //Mostrar el modal de confirmación después de validar el formulario
            /*
            form.addEventListener("submit", (e) => {
                e.preventDefault();
                createPass();
                confirmPass();

                passInput.addEventListener("keyup", createPass);
                cPassInput.addEventListener("keyup", confirmPass);

                if (
                    !passField.classList.contains("invalid") &&
                    !cPassField.classList.contains("invalid")
                ) {
                    confirmacionModal.show();

                }


            });

        });*/
    });

</script>

</body>

</html>