package com.example.proyecto.daos;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public abstract class DaoBase {

    public Connection getConnection() throws SQLException {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            throw new RuntimeException(e);
        }

        String username = "root";
        String password = "root";
        String database = "proyecto";
        String url = "jdbc:mysql://localhost:3306/" + database;

        return DriverManager.getConnection(url, username, password);
       // return DriverManager.getConnection("jdbc:mysql://35.193.202.145/"+database,"root","Dsu~j\"2I^GZO>]HU");


    }
}
