package model;

public class Message {
    private int id;
    private int expediteurId;
    private String nomExpediteur;
    private int destinataireId;
    private String nomDestinataire;
    private String equipeDest;
    private String contenu;
    private String dateEnvoi;
    private boolean lu;

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public int getExpediteurId() { return expediteurId; }
    public void setExpediteurId(int expediteurId) { this.expediteurId = expediteurId; }
    public String getNomExpediteur() { return nomExpediteur; }
    public void setNomExpediteur(String nomExpediteur) { this.nomExpediteur = nomExpediteur; }
    public int getDestinatataireId() { return destinataireId; }
    public void setDestinatataireId(int destinataireId) { this.destinataireId = destinataireId; }
    public String getNomDestinataire() { return nomDestinataire; }
    public void setNomDestinataire(String nomDestinataire) { this.nomDestinataire = nomDestinataire; }
    public String getEquipeDest() { return equipeDest; }
    public void setEquipeDest(String equipeDest) { this.equipeDest = equipeDest; }
    public String getContenu() { return contenu; }
    public void setContenu(String contenu) { this.contenu = contenu; }
    public String getDateEnvoi() { return dateEnvoi; }
    public void setDateEnvoi(String dateEnvoi) { this.dateEnvoi = dateEnvoi; }
    public boolean isLu() { return lu; }
    public void setLu(boolean lu) { this.lu = lu; }
}