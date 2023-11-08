<%--
  Created by IntelliJ IDEA.
  User: ARKEL
  Date: 7/11/2023
  Time: 18:32
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="en">

<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Validar Donaciones</title>
  <!-- Icono de pestaña -->
  <link rel="icon" href="images/IconoBat.png" />
  <!-- Iconos -->
  <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
  <!-- bootstrap -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet"
        integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
  <!-- css -->
  <link rel="stylesheet" href="css/styleDelGeneral.css">

</head>

<body>
<div class="menu">
  <ion-icon name="menu-outline"></ion-icon>
  <ion-icon name="close-outline"></ion-icon>
</div>

<div class="barra-lateral">
  <div>
    <div class="nombre-pagina">
      <ion-icon id="menubar" name="menu-outline"></ion-icon>
      <span>Semana Teleco</span>

    </div>

  </div>

  <nav class="navegacion">
    <ul>
      <li>
        <!-- Se coloca id para que cuando estemos en esa opción del menú este icono esté seleccionado -->
        <a id="inicio" href="<%=request.getContextPath() %>/DelegadoGeneralServlet?action=main_page">
          <ion-icon name="home-outline"></ion-icon>
          <span>Inicio</span>
        </a>
      </li>

      <div class="linea"></div>

      <li>
        <a href="<%=request.getContextPath() %>/DelegadoGeneralServlet?action=validar_registro">
          <ion-icon name="people-outline"></ion-icon>
          <span>Validar registro</span>
        </a>
      </li>

      <li>
        <a href="<%=request.getContextPath() %>/DelegadoGeneralServlet?action=validar_donaciones">
          <ion-icon name="heart-outline"></ion-icon>
          <span>Validar donaciones</span>
        </a>
      </li>


      <li>
        <a href="<%=request.getContextPath() %>/DelegadoGeneralServlet?action=editar_actividades">
          <ion-icon name="clipboard-outline"></ion-icon>
          <span>Editar actividades</span>
        </a>
      </li>

      <div class="linea"></div>

      <li>
        <a href="https://www.instagram.com/aitel.pucp/" target="_blank">
          <ion-icon name="logo-instagram"></ion-icon>
          <span>Instagram</span>
        </a>
      </li>
      <li>
        <a href="mailto:aitel@pucp.pe" target="_blank">
          <ion-icon name="mail-outline"></ion-icon>
          <span>Gmail</span>
        </a>
      </li>
      <div class="linea"></div>
      <li>
        <a href="<%=request.getContextPath() %>/DelegadoGeneralServlet?action=cerrar_sesion">
          <ion-icon name="log-out-outline"></ion-icon>
          <span>Cerrar sesión</span>
        </a>
      </li>
    </ul>
  </nav>

  <div>
    <div class="linea"></div>
    <!-- Tratar de colocar el botón de cerrar sesión aqui -->
    <div class="modo-oscuro">
      <div class="info">
        <ion-icon name="moon-outline"></ion-icon>
        <span>Dark Mode</span>
      </div>
      <div class="switch">
        <div class="base">
          <div class="circulo">

          </div>
        </div>
      </div>

    </div>


    <div class="usuario">
      <img src="images/usuario.jpg">
      <div class="info-usuario">
        <div class="nombre-email">
          <span class="nombre">Usuario</span>
          <span class="email">codigo@pucp.edu.com</span>
        </div>
        <!-- Colocarle función cambiar foto de perfil -->
        <ion-icon name="ellipsis-vertical-outline"></ion-icon>
      </div>
    </div>
  </div>

</div>

<main style="background-color: #c6e2e4;">
  <div class="container-fluid">
    <!-- header -->
    <div class="row header" style="background-color: #7c9da0;">
      <div class="col">
        <h1>Donaciones</h1>
      </div>
    </div>

    <div class="row p-5">
      <div class="col p-4 mb-4 rounded-4" style="background-color: #ffffff">
        <div class="row search">
          <div class="col">
            <h2>Comprobar donaciones:</h2>
          </div>

          <div class="col">
            <form class="search-form" id="search-container">
              <input type="search" placeholder="Buscar usuario..." id="search-input">
              <button class="btn-search">
                <ion-icon name="search-outline"></ion-icon>
              </button>

            </form>
          </div>
        </div>
        <!-- Tabla de donaciones -->
        <div class="row">
          <div class="col">
            <table class="table table-hover">
              <thead>
              <tr>
                <th scope="col">#</th>
                <th scope="col">Usuario</th>
                <th scope="col">Correo</th>
                <th scope="col">Fecha</th>
                <th scope="col">Medio de pago</th>
                <th scope="col">Comprobante</th>
                <th scope="col">Estado</th>
                <th scope="col"></th>
              </tr>
              </thead>
              <tbody>
              <tr>
                <th scope="row">1</th>
                <td>Nombre Apellido</td>
                <td>nombre@pucp.edu.pe</td>
                <td>dd/mm/aaaa</td>
                <td class="text-center">
                  <img src="images/yape_logo.jpg" alt="Pago" width="32px"
                       style="border-radius: 25%;">
                </td>
                <td class="text-center">
                  <!-- Ver comprobante -->
                  <button class="opcion" data-bs-toggle="modal"
                          data-bs-target="#modalMostrar">
                    <ion-icon name="eye-outline"></ion-icon>
                  </button>
                </td>
                <td>
                  <input type="radio" name="flexRadioDefault" id="Aceptado" />
                  <label for="Equipo">Aceptado</label>

                  <input type="radio" name="flexRadioDefault" id="Denegado" />
                  <label for="Barra">Denegado</label>
                </td>
                <td>
                  <!-- Enviar Notificación -->
                  <button class="opcion">
                    <a href="mailto:nombre_apellido@pucp.edu.pe"
                       class="text-dark text-decoration-none" target="_blank">
                      <ion-icon name="mail-outline"></ion-icon>
                    </a>
                  </button>
                </td>
              </tr>
              <tr>
                <th scope="row">2</th>
                <td>Nombre Apellido</td>
                <td>nombre@pucp.edu.pe</td>
                <td>dd/mm/aaaa</td>
                <td class="text-center">
                  <img src="images/plin_logo.jpg" alt="Pago" width="32px"
                       style="border-radius: 25%;">
                </td>
                <td class="text-center">
                  <!-- Ver comprobante -->
                  <button class="opcion" data-bs-toggle="modal"
                          data-bs-target="#modalMostrar">
                    <ion-icon name="eye-outline"></ion-icon>
                  </button>
                </td>
                <td>
                  <input type="radio" name="flexRadioDefault" id="Aceptado" />
                  <label for="Equipo">Aceptado</label>

                  <input type="radio" name="flexRadioDefault" id="Denegado" />
                  <label for="Barra">Denegado</label>
                </td>
                <td>
                  <!-- Enviar Notificación -->
                  <button class="opcion">
                    <a href="mailto:nombre_apellido@pucp.edu.pe"
                       class="text-dark text-decoration-none" target="_blank">
                      <ion-icon name="mail-outline"></ion-icon>
                    </a>
                  </button>
                </td>
              </tr>
              <tr>
                <th scope="row">3</th>
                <td>Nombre Apellido</td>
                <td>nombre@pucp.edu.pe</td>
                <td>dd/mm/aaaa</td>
                <td class="text-center">
                  <img src="images/yape_logo.jpg" alt="Pago" width="32px"
                       style="border-radius: 25%;">
                </td>
                <td class="text-center">
                  <!-- Ver comprobante -->
                  <button class="opcion" data-bs-toggle="modal"
                          data-bs-target="#modalMostrar">
                    <ion-icon name="eye-outline"></ion-icon>
                  </button>
                </td>
                <td>
                  <input type="radio" name="flexRadioDefault" id="Aceptado" />
                  <label for="Equipo">Aceptado</label>

                  <input type="radio" name="flexRadioDefault" id="Denegado" />
                  <label for="Barra">Denegado</label>
                </td>
                <td>
                  <!-- Enviar Notificación -->
                  <button class="opcion">
                    <a href="mailto:nombre_apellido@pucp.edu.pe"
                       class="text-dark text-decoration-none" target="_blank">
                      <ion-icon name="mail-outline"></ion-icon>
                    </a>
                  </button>
                </td>
              </tr>

              <tr>
                <th scope="row">4</th>
                <td>Nombre Apellido</td>
                <td>nombre@pucp.edu.pe</td>
                <td>dd/mm/aaaa</td>
                <td class="text-center">
                  <img src="images/plin_logo.jpg" alt="Pago" width="32px"
                       style="border-radius: 25%;">
                </td>
                <td class="text-center">
                  <!-- Ver comprobante -->
                  <button class="opcion" data-bs-toggle="modal"
                          data-bs-target="#modalMostrar">
                    <ion-icon name="eye-outline"></ion-icon>
                  </button>
                </td>
                <td>
                  <input type="radio" name="flexRadioDefault" id="Aceptado" />
                  <label for="Equipo">Aceptado</label>

                  <input type="radio" name="flexRadioDefault" id="Denegado" />
                  <label for="Barra">Denegado</label>
                </td>
                <td>
                  <!-- Enviar Notificación -->
                  <button class="opcion">
                    <a href="mailto:nombre_apellido@pucp.edu.pe"
                       class="text-dark text-decoration-none" target="_blank">
                      <ion-icon name="mail-outline"></ion-icon>
                    </a>
                  </button>
                </td>
              </tr>

              </tbody>
            </table>
          </div>
        </div>


        <!-- Footer -->
        <div class="row footer">
          <div class="col">
            <nav aria-label="Page navigation example justify-content-center">
              <ul class="pagination justify-content-center">
                <li class="page-item">
                  <a class="page-link" href="#" aria-label="Previous">
                    <span aria-hidden="true">&laquo;</span>
                  </a>
                </li>
                <li class="page-item"><a class="page-link" href="#">1</a></li>
                <li class="page-item"><a class="page-link" href="#">2</a></li>
                <li class="page-item"><a class="page-link" href="#">3</a></li>
                <li class="page-item">
                  <a class="page-link" href="#" aria-label="Next">
                    <span aria-hidden="true">&raquo;</span>
                  </a>
                </li>
              </ul>
            </nav>
          </div>
        </div>

        <!-- Guardar cambios -->
        <div class="row text-center">
          <div class="col">
            <a class="btn btn-dark" data-bs-toggle="modal" href="#guardarNuevos" role="button">Guardar
              cambios</a>
          </div>
        </div>


      </div>

      <!-- Modal de Mostrar Comprobante -->
      <div class="modal fade" id="modalMostrar" tabindex="-1" aria-labelledby="exampleModalLabel"
           aria-hidden="true">
        <div class="modal-dialog">
          <div class="modal-content">
            <form>

              <div class="modal-header">
                <h1 class="modal-title fs-5" id="nuevoModalLabel">Comprobante de pago</h1>
                <button type="button" class="btn-close" data-bs-dismiss="modal"
                        aria-label="Close"></button>
              </div>
              <div class="modal-body">
                <div class="mb-3 d-flex justify-content-center align-items-center flex-column">
                  <img src="images/comprobante.png" alt="Imagen de evento" id="eventImage"
                       class="img-thumbnail w-70">
                </div>

                <div class="mb-3">
                  <h5>Monto ingresado:</h5>
                  <p>S/. 100</p>
                </div>
              </div>
              <div class="modal-footer">
                <button type="button" class="btn btn-danger" data-bs-dismiss="modal">Cerrar</button>
              </div>

            </form>
          </div>
        </div>
      </div>


      <!-- Modal guardar cambios -->
      <div class="modal fade" id="guardarNuevos" aria-hidden="true"
           aria-labelledby="exampleModalToggleLabel" tabindex="-1">
        <div class="modal-dialog modal-dialog-centered">
          <div class="modal-content">
            <div class="modal-header">
              <h5 class="modal-title" id="guardarNuevosLabel">Guardar cambios</h5>
              <button type="button" class="btn-close" data-bs-dismiss="modal"
                      aria-label="Close"></button>
            </div>
            <div class="modal-body">
              ¿Estás seguro que quieres guardar los cambios?
            </div>
            <div class="modal-footer">
              <button type="button" class="btn btn-secondary"
                      data-bs-dismiss="modal">Cancelar</button>
              <button type="button" class="btn btn-primary" data-bs-target="#guardarNuevos2"
                      data-bs-toggle="modal" data-bs-dismiss="modal">Sí</button>
            </div>
          </div>
        </div>
      </div>
      <div class="modal fade" id="guardarNuevos2" aria-hidden="true"
           aria-labelledby="exampleModalToggleLabel2" tabindex="-1">
        <div class="modal-dialog modal-dialog-centered">
          <div class="modal-content">
            <div class="modal-body">
              Se guardaron los cambios exitosamente.
            </div>
            <div class="modal-footer">
              <button type="button" class="btn btn-primary" data-bs-dismiss="modal">Ok</button>
            </div>
          </div>
        </div>
      </div>

    </div>

    <!-- Donaciones comprobadas -->
    <div class="row p-5">
      <div class="col p-4 mb-4 rounded-4" style="background-color: #ffffff">
        <div class="row search">
          <div class="col">
            <h2>Lista de donaciones aprobadas:</h2>
          </div>

          <div class="col">
            <form class="search-form" id="search-container">
              <input type="search" placeholder="Buscar usuario..." id="search-input">
              <button class="btn-search">
                <ion-icon name="search-outline"></ion-icon>
              </button>

            </form>
          </div>
        </div>
        <!-- Tabla de donaciones -->
        <div class="row">
          <div class="col">
            <table class="table table-hover">
              <thead>
              <tr>
                <th scope="col">#</th>
                <th scope="col">Usuario</th>
                <th scope="col">Correo</th>
                <th scope="col">Fecha</th>
                <th scope="col">Medio de pago</th>
                <th scope="col">Comprobante</th>
              </tr>
              </thead>
              <tbody>
              <tr>
                <th scope="row">1</th>
                <td>Nombre Apellido</td>
                <td>nombre@pucp.edu.pe</td>
                <td>dd/mm/aaaa</td>
                <td class="text-center">
                  <img src="images/yape_logo.jpg" alt="Pago" width="32px"
                       style="border-radius: 25%;">
                </td>
                <td class="text-center">
                  <!-- Ver comprobante -->
                  <button class="opcion" data-bs-toggle="modal"
                          data-bs-target="#modalMostrar">
                    <ion-icon name="eye-outline"></ion-icon>
                  </button>
                </td>
              </tr>
              <tr>
                <th scope="row">2</th>
                <td>Nombre Apellido</td>
                <td>nombre@pucp.edu.pe</td>
                <td>dd/mm/aaaa</td>
                <td class="text-center">
                  <img src="images/plin_logo.jpg" alt="Pago" width="32px"
                       style="border-radius: 25%;">
                </td>
                <td class="text-center">
                  <!-- Ver comprobante -->
                  <button class="opcion" data-bs-toggle="modal"
                          data-bs-target="#modalMostrar">
                    <ion-icon name="eye-outline"></ion-icon>
                  </button>
                </td>
              </tr>
              <tr>
                <th scope="row">3</th>
                <td>Nombre Apellido</td>
                <td>nombre@pucp.edu.pe</td>
                <td>dd/mm/aaaa</td>
                <td class="text-center">
                  <img src="images/yape_logo.jpg" alt="Pago" width="32px"
                       style="border-radius: 25%;">
                </td>
                <td class="text-center">
                  <!-- Ver comprobante -->
                  <button class="opcion" data-bs-toggle="modal"
                          data-bs-target="#modalMostrar">
                    <ion-icon name="eye-outline"></ion-icon>
                  </button>
                </td>
              </tr>

              <tr>
                <th scope="row">4</th>
                <td>Nombre Apellido</td>
                <td>nombre@pucp.edu.pe</td>
                <td>dd/mm/aaaa</td>
                <td class="text-center">
                  <img src="images/plin_logo.jpg" alt="Pago" width="32px"
                       style="border-radius: 25%;">
                </td>
                <td class="text-center">
                  <!-- Ver comprobante -->
                  <button class="opcion" data-bs-toggle="modal"
                          data-bs-target="#modalMostrar">
                    <ion-icon name="eye-outline"></ion-icon>
                  </button>
                </td>
              </tr>

              <tr>
                <th scope="row">5</th>
                <td>Nombre Apellido</td>
                <td>nombre@pucp.edu.pe</td>
                <td>dd/mm/aaaa</td>
                <td class="text-center">
                  <img src="images/yape_logo.jpg" alt="Pago" width="32px"
                       style="border-radius: 25%;">
                </td>
                <td class="text-center">
                  <!-- Ver comprobante -->
                  <button class="opcion" data-bs-toggle="modal"
                          data-bs-target="#modalMostrar">
                    <ion-icon name="eye-outline"></ion-icon>
                  </button>
                </td>
              </tr>

              <tr>
                <th scope="row">6</th>
                <td>Nombre Apellido</td>
                <td>nombre@pucp.edu.pe</td>
                <td>dd/mm/aaaa</td>
                <td class="text-center">
                  <img src="images/yape_logo.jpg" alt="Pago" width="32px"
                       style="border-radius: 25%;">
                </td>
                <td class="text-center">
                  <!-- Ver comprobante -->
                  <button class="opcion" data-bs-toggle="modal"
                          data-bs-target="#modalMostrar">
                    <ion-icon name="eye-outline"></ion-icon>
                  </button>
                </td>
              </tr>

              <tr>
                <th scope="row">7</th>
                <td>Nombre Apellido</td>
                <td>nombre@pucp.edu.pe</td>
                <td>dd/mm/aaaa</td>
                <td class="text-center">
                  <img src="images/plin_logo.jpg" alt="Pago" width="32px"
                       style="border-radius: 25%;">
                </td>
                <td class="text-center">
                  <!-- Ver comprobante -->
                  <button class="opcion" data-bs-toggle="modal"
                          data-bs-target="#modalMostrar">
                    <ion-icon name="eye-outline"></ion-icon>
                  </button>
                </td>
              </tr>

              <tr>
                <th scope="row">8</th>
                <td>Nombre Apellido</td>
                <td>nombre@pucp.edu.pe</td>
                <td>dd/mm/aaaa</td>
                <td class="text-center">
                  <img src="images/plin_logo.jpg" alt="Pago" width="32px"
                       style="border-radius: 25%;">
                </td>
                <td class="text-center">
                  <!-- Ver comprobante -->
                  <button class="opcion" data-bs-toggle="modal"
                          data-bs-target="#modalMostrar">
                    <ion-icon name="eye-outline"></ion-icon>
                  </button>
                </td>
              </tr>

              </tbody>
            </table>
          </div>
        </div>


        <!-- Footer -->
        <div class="row footer">
          <div class="col">
            <nav aria-label="Page navigation example justify-content-center">
              <ul class="pagination justify-content-center">
                <li class="page-item">
                  <a class="page-link" href="#" aria-label="Previous">
                    <span aria-hidden="true">&laquo;</span>
                  </a>
                </li>
                <li class="page-item"><a class="page-link" href="#">1</a></li>
                <li class="page-item"><a class="page-link" href="#">2</a></li>
                <li class="page-item"><a class="page-link" href="#">3</a></li>
                <li class="page-item">
                  <a class="page-link" href="#" aria-label="Next">
                    <span aria-hidden="true">&raquo;</span>
                  </a>
                </li>
              </ul>
            </nav>
          </div>
        </div>


      </div>

      <!-- Modal de Mostrar Comprobante lo borre -->

    </div>
  </div>

  </div>
</main>

<script type="module" src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.esm.js"></script>
<script nomodule src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.js"></script>
<script src="js/mainscript.js"></script>
<!--Script de bootstrap  -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL"
        crossorigin="anonymous"></script>

</body>

</html>
