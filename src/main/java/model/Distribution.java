package model;

public class Distribution {

    private int    id;
    private int    materielId;
    private String designationMateriel;
    private int    membreId;
    private String nomMembre;
    private int    quantite;
    private String dateDistribution;
    private String notes;

    public int    getId()                        { return id; }
    public void   setId(int id)                  { this.id = id; }

    public int    getMaterielId()                { return materielId; }
    public void   setMaterielId(int m)           { this.materielId = m; }

    public String getDesignationMateriel()       { return designationMateriel; }
    public void   setDesignationMateriel(String d){ this.designationMateriel = d; }

    public int    getMembreId()                  { return membreId; }
    public void   setMembreId(int m)             { this.membreId = m; }

    public String getNomMembre()                 { return nomMembre; }
    public void   setNomMembre(String n)         { this.nomMembre = n; }

    public int    getQuantite()                  { return quantite; }
    public void   setQuantite(int q)             { this.quantite = q; }

    public String getDateDistribution()          { return dateDistribution; }
    public void   setDateDistribution(String d)  { this.dateDistribution = d; }

    public String getNotes()                     { return notes; }
    public void   setNotes(String n)             { this.notes = n; }
}