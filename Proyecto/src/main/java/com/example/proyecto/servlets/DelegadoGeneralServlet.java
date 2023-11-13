package com.example.proyecto.servlets;

import com.example.proyecto.beans.*;
import com.example.proyecto.daos.ActividadDao;
import com.example.proyecto.daos.AlumnoDao;
import com.example.proyecto.daos.DelegadoActividadDao;
import com.example.proyecto.daos.EventoDao;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.util.ArrayList;

@WebServlet(name = "DelegadoGeneralServlet", value = "/DelegadoGeneralServlet")
public class DelegadoGeneralServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        response.setContentType("text/html");

        String action = request.getParameter("action") == null ? "main_page" : request.getParameter("action");

        EventoDao eDao = new EventoDao();
        ActividadDao aDao= new ActividadDao();
        DelegadoActividadDao dADao = new DelegadoActividadDao();
        AlumnoDao alumnoDao = new AlumnoDao();

        switch (action){
            case "main_page":
                request.getRequestDispatcher("delegGen/MainPage.jsp").forward(request,response);
                break;

            case "editar_actividades":


                ArrayList<DelegadoActividad> list = dADao.listarActividades(100,0);
                //mandar las lista a la vista -> /MainPage.jsp
                request.setAttribute("listaAlumnos_DelegadosActividad",alumnoDao.listarDelegadosDeActividad());
                request.setAttribute("listaActividades",list);
                request.getRequestDispatcher("delegGen/EditarActividades.jsp").forward(request,response);
                break;
            case "validar_donaciones":

                request.getRequestDispatcher("delegGen/ValidarDonaciones.jsp").forward(request,response);
                break;
            case "validar_registro":
                request.getRequestDispatcher("delegGen/ValidarRegistro.jsp").forward(request,response);
                break;

            case "cerrar_sesion":
                response.sendRedirect(request.getContextPath() + "/SesionServlet");
                break;
        }

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}

