
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Rol</title>
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
<div class="container-fluid p-5">
    <div class="row">
        <div class="col text-center mb-5">
            <h1>¿Cuál es tu rol?</h1>
        </div>
    </div>

    <div class="row">
        <div class="col">
            <div class="row">
                <div class="col text-center mb-3">
                    <img src="images/candado.png" width="100px">
                </div>
            </div>
            <div class="row">
                <div class="col text-center">
                    <a href="<%=request.getContextPath()%>/RolServlet?action=alumno"><h3>Alumno</h3></a>
                </div>
            </div>
        </div>

        <div class="col">
            <div class="row">
                <div class="col text-center mb-3">
                    <img src="images/candado.png" width="100px">
                </div>
            </div>
            <div class="row">
                <div class="col text-center">
                    <a href="<%=request.getContextPath()%>/RolServlet?action=delegado_actividad"><h3>Delegado <br> Actividad</h3></a>
                </div>
            </div>
        </div>

        <div class="col">
            <div class="row">
                <div class="col text-center mb-3">
                    <img src="images/candado.png" width="100px">
                </div>
            </div>
            <div class="row">
                <div class="col text-center">
                    <a href="<%=request.getContextPath()%>/RolServlet?action=delegado_general"><h3>Delegado <br> General</h3></a>
                </div>
            </div>
        </div>

    </div>
</div>



<script type="module" src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.esm.js"></script>
<script nomodule src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.js"></script>

<!--Script de bootstrap  -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL"
        crossorigin="anonymous"></script>
</body>


</html>