package model;

import java.time.LocalDateTime;

public class DemandeAdhesion {

    private int id;
    private String nom;
    private String prenom;
    private String email;
    private String etablissement;
    private String motivation;
    private String cvPath;
    private String statut;
    private LocalDateTime dateSoumission;

    public DemandeAdhesion() {
    }

    public DemandeAdhesion(int id, String nom, String prenom, String email,
                           String etablissement, String motivation,
                           String cvPath, String statut,
                           LocalDateTime dateSoumission) {

        this.id = id;
        this.nom = nom;
        this.prenom = prenom;
        this.email = email;
        this.etablissement = etablissement;
        this.motivation = motivation;
        this.cvPath = cvPath;
        this.statut = statut;
        this.dateSoumission = dateSoumission;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }


    public String getNom() {
        return nom;
    }

    public void setNom(String nom) {
        this.nom = nom;
    }


    public String getPrenom() {
        return prenom;
    }

    public void setPrenom(String prenom) {
        this.prenom = prenom;
    }


    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }


    public String getEtablissement() {
        return etablissement;
    }

    public void setEtablissement(String etablissement) {
        this.etablissement = etablissement;
    }


    public String getMotivation() {
        return motivation;
    }

    public void setMotivation(String motivation) {
        this.motivation = motivation;
    }


    public String getCvPath() {
        return cvPath;
    }

    public void setCvPath(String cvPath) {
        this.cvPath = cvPath;
    }


    public String getStatut() {
        return statut;
    }

    public void setStatut(String statut) {
        this.statut = statut;
    }


    public LocalDateTime getDateSoumission() {
        return dateSoumission;
    }

    public void setDateSoumission(LocalDateTime dateSoumission) {
        this.dateSoumission = dateSoumission;
    }

    @Override
    public String toString() {
        return "DemandeAdhesion{" +
                "id=" + id +
                ", nom='" + nom + '\'' +
                ", prenom='" + prenom + '\'' +
                ", email='" + email + '\'' +
                ", etablissement='" + etablissement + '\'' +
                ", motivation='" + motivation + '\'' +
                ", cvPath='" + cvPath + '\'' +
                ", statut='" + statut + '\'' +
                ", dateSoumission=" + dateSoumission +
                '}';
    }
}