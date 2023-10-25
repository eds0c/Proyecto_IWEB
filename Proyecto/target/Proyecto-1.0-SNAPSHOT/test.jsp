<%@ page import="java.util.ArrayList" %>
<%@ page import="com.example.proyecto.beans.Evento" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:useBean id="lista" scope="request" type="ArrayList<Evento>" />
<html>
<head>
    <title>Trabajos</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN"
          crossorigin="anonymous">
</head>
<body>
<div class="container">

    <table class="table table-striped mt-3">
        <tr class="table-primary">
            <  th>ID</th>
            <th>Job Title</th>
            <th>Min Salary</th>
            <th>Max Salary</th>
        </tr>
        <% for (Evento job : lista) { %>
        <tr>
            <td><%=job.getDescripcion()  %>
            </td>
            <td><%=job.getIdActividad()%>
            </td>
            <td><%=job.getFechaFin()%>
            </td>
            <td><%=job.getDescripcion()%>
            </td>

        </tr>
        <% } %>
    </table>
</div>
</body>
</html>
