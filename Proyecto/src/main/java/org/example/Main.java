package org.example;

public class Main {
    public static void main(String[] args) {
        System.out.println("Hello world!");

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            throw new RuntimeException(e);
        }

        String url = "jdbc:mysql://localhost:3306"
    }


}