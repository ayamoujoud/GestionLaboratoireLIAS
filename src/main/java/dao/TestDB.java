package dao;

import java.sql.Connection;

public class TestDB {

    public static void main(String[] args) {

        Connection con = DBConnection.getConnection();

        if (con != null) {
            System.out.println("Connexion MySQL réussie ✅");
        } else {
            System.out.println("Connexion MySQL échouée ❌");
        }
    }
}