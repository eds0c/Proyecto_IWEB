
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
</head>

<body>
<!-- Inicia el cuerpo -->

<div class="container-form2">
    <div class="col container">

        <div class="title">
            <h2>Crea una cuenta nueva</h2>
        </div>

        <form class="ingreso-datos">
            <div class="row">
                <div class="col">
                    <p>Ingresa tus datos personales:</p>
                    <!-- Ingreso de datos -->
                    <div class="datos">
                        <label>
                            <i class='bx bx-user'></i>
                            <input id="nombre" name="nombre" type="text" placeholder="Nombre Apellido">
                        </label>

                        <label>
                            <i class='bx bxs-graduation'></i>
                            <input id="codigo" name="codigo" type="text" placeholder="Código PUCP">
                        </label>

                        <label>
                            <i class='bx bx-envelope'></i>
                            <input id="correo" name="correo" type="email" placeholder="Correo PUCP">
                        </label>

                        <label>
                            <i class='bx bx-lock-alt'></i>
                            <input id="password" name="password" type="password" placeholder="Contraseña">
                        </label>

                    </div>

                    <p>Marca según tu estado:</p>
                    <div class="row">
                        <div class="col-sm text-center">
                            <input class="form-check-input" type="radio" name="flexRadioDefault" id="estudiante"/>
                            <label for="estudiante">Estudiante</label>
                        </div>

                        <div class="col-sm text-center">
                            <input class="form-check-input" type="radio" name="flexRadioDefault" id="egresado"/>
                            <label for="delegado">Egresado</label>
                        </div>
                    </div>


                </div>

                <div class="col">
                    <p>Sube una foto de perfil para que los delegados te reconozcan:</p>
                    <div class="text-center">
                        <input type="file" />
                    </div>
                </div>
            </div>
        </form>

        <!-- Envio de datos -->
        <div class="container text-center">
            <!-- Button trigger modal -->
            <button class="presionar" type="button" data-bs-toggle="modal" data-bs-target="#staticBackdrop">
                Registrarse
            </button>

            <!-- Modal -->
            <div class="modal fade" id="staticBackdrop" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h1 class="modal-title fs-5" id="exampleModalLabel">Aviso</h1>
                        </div>

                        <div class="modal-body">
                            Se le enviará la confirmación del registro a su correo PUCP después de ser validados sus datos por el delegado general.
                        </div>

                        <div class="modal-footer">
                            <a href="<%=request.getContextPath()%>/SesionServlet?action=inicio_sesion" class="btn btn-success">Entendido</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Ya tiene una cuenta -->
        <div class="container text-center">
            <p class="d-inline-block">¿Ya tienes una cuenta?</p>
            <a href="<%=request.getContextPath()%>/SesionServlet?action=inicio_sesion" class="text-dark text-decoration-none">Entrar</a>
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
