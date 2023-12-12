package com.example.proyecto.servlets;

import com.example.proyecto.daos.*;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;

@WebServlet(name = "ImgServlet", value = "/ImgServlet")
public class ImgServlet extends HttpServlet {
    EventoDao eventoDao = new EventoDao();
    AlumnoDao alumnoDao = new AlumnoDao();
    DelegadoGeneralDao delegadoGeneralDao = new DelegadoGeneralDao();
    ActividadDao actividadDao = new ActividadDao();
    DonacionDao donacionDao = new DonacionDao();
    FotosActividadDao fotosActividadDao = new FotosActividadDao();


    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action") == null ? "fotoEvento" : request.getParameter("action");

        switch (action) {
            case "fotoEvento":
                int id = Integer.parseInt(request.getParameter("id"));
                eventoDao.listarImg(id, response);
                break;
            case "fotoPerfilAlumno":
                int idAlumno = Integer.parseInt(request.getParameter("idAlumno"));
                //System.out.println(idAlumno);
                alumnoDao.fotoPerfil(idAlumno, response);
                break;
            case "fotoPerfilDeleAct":
                int idd = Integer.parseInt(request.getParameter("idd"));
                //System.out.println(idd);
                alumnoDao.fotoPerfil(idd, response);
                break;
            case "fotoPerfilDeleGen":
                int idDeleGen = Integer.parseInt(request.getParameter("idDeleGen"));
                //System.out.println(idDeleGen);
                delegadoGeneralDao.fotoPerfil(idDeleGen, response);
                break;
            case "donacion":
                int idDonacion = Integer.parseInt(request.getParameter("idDonacion"));
                donacionDao.fotoComprobante(idDonacion, response);
            case "fotoActividad":
                int idActividad = Integer.parseInt(request.getParameter("idActividadMostrarFoto"));
                //System.out.println(idActividad);
                actividadDao.fotoActividad(idActividad, response);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}

