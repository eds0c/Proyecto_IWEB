package com.example.proyecto.servlets;

import com.example.proyecto.daos.EventoDao;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;

@WebServlet(name = "ImgServlet", value = "/ImgServlet")
public class ImgServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html");
        EventoDao eventoDao = new EventoDao();
        int id = Integer.parseInt(request.getParameter("id"));
        eventoDao.listarImg(id,response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}

