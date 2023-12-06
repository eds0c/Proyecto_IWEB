package com.example.proyecto.Filters;

import jakarta.servlet.*;
import jakarta.servlet.annotation.*;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebFilter(filterName = "FilterSesionDelegadoActividad", servletNames = {"DelegadoActividadServlet"})
public class FilterSesionDelegadoActividad implements Filter {

    @Override
    public void doFilter(ServletRequest req, ServletResponse resp, FilterChain chain)
            throws ServletException, IOException {

        HttpServletRequest request = (HttpServletRequest) req;
        HttpServletResponse response = (HttpServletResponse) resp;



        if (request.getSession().getAttribute("usuariologueado") == null) {
            response.sendRedirect(request.getContextPath());
        } else {

            int tipoUsuario = (int) request.getSession().getAttribute("tipoUsuario");

            switch (tipoUsuario){

                case 1:
                    response.sendRedirect(request.getContextPath() + "/DelegadoGeneralServlet");
                    break;
                case 2:
                    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1.
                    response.setHeader("Pragma", "no-cache"); // HTTP 1.0.
                    response.setDateHeader("Expires", 0);
                    chain.doFilter(request, response);
                    break;
                case 3:
                    response.sendRedirect(request.getContextPath() + "/DelegadoGeneralServlet");
                    break;
            }

        }

    }
}

