
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Error 404 - SemanaTeleco</title>
  <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css">
  <style>
    body {
      background-color: #f8f9fa;
    }
    .error-container {
      display: flex;
      justify-content: center;
      align-items: center;
      height: 100vh;
    }
    .error-content {
      text-align: center;
    }
    .error-title {
      font-size: 4rem;
      margin-bottom: 1rem;
    }
    .error-message {
      font-size: 2rem;
      margin-bottom: 2rem;
    }
    .error-button {
      padding: 1rem 2rem;
      font-size: 1.5rem;
      background-color: #007bff;
      color: #fff;
      border: none;
      border-radius: 4px;
      cursor: pointer;
    }
    .error-button:hover {
      background-color: #0056b3;
    }
  </style>
</head>
<body>
<div class="error-container">
  <div class="error-content">
    <h1 class="error-title">Error 404</h1>
    <p class="error-message">¡Oops! La página que buscas no existe.</p>
    <a href="javascript:history.back()" class="error-button">Volver</a>
  </div>
</div>
</body>
</html>

