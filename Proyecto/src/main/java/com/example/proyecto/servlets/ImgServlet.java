package com.example.proyecto.servlets;

import com.example.proyecto.daos.AlumnoDao;
import com.example.proyecto.daos.DelegadoGeneralDao;
import com.example.proyecto.daos.EventoDao;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;

@WebServlet(name = "ImgServlet", value = "/ImgServlet")
public class ImgServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action") == null ? "fotoEvento" : request.getParameter("action");

        switch (action) {
            case "fotoEvento":
                EventoDao eventoDao = new EventoDao();
                int id = Integer.parseInt(request.getParameter("id"));
                eventoDao.listarImg(id, response);
                break;
            case "fotoPerfilAlumno":
                AlumnoDao alumnoDao = new AlumnoDao();
                int idAlumno = Integer.parseInt(request.getParameter("idAlumno"));
                System.out.println(idAlumno);
                alumnoDao.fotoPerfil(idAlumno, response);
                break;
            case "fotoPerfilDeleAct":
                AlumnoDao alumnoDao1 = new AlumnoDao();
                int idd = Integer.parseInt(request.getParameter("idd"));
                System.out.println(idd);
                alumnoDao1.fotoPerfil(idd, response);
                break;
            case "fotoPerfilDeleGen":
                DelegadoGeneralDao delegadoGeneralDao = new DelegadoGeneralDao();
                int idDeleGen = Integer.parseInt(request.getParameter("idDeleGen"));
                System.out.println(idDeleGen);
                delegadoGeneralDao.fotoPerfil(idDeleGen, response);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}

