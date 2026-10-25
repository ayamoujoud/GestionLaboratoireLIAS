package model;

public class Materiel {
    private int id;
    private String designation;
    private int quantiteTotale;
    private String dateArrivage;
    private String description;
    private int quantiteDistribuee;

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public String getDesignation() { return designation; }
    public void setDesignation(String designation) { this.designation = designation; }
    public int getQuantiteTotale() { return quantiteTotale; }
    public void setQuantiteTotale(int quantiteTotale) { this.quantiteTotale = quantiteTotale; }
    public String getDateArrivage() { return dateArrivage; }
    public void setDateArrivage(String dateArrivage) { this.dateArrivage = dateArrivage; }
    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }
    public int getQuantiteDistribuee() { return quantiteDistribuee; }
    public void setQuantiteDistribuee(int quantiteDistribuee) { this.quantiteDistribuee = quantiteDistribuee; }
    public int getDisponible() { return quantiteTotale - quantiteDistribuee; }
}