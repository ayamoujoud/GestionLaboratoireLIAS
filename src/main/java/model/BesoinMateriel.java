package model;

public class BesoinMateriel {

    private int    id;
    private int    membreId;
    private String nomMembre;
    private String description;
    private int    quantite;
    private String statut;       // en_attente, valide, refuse
    private String dateDemande;
    private String dateTraitement;
    private int    traitePar;

    public int    getId()                   { return id; }
    public void   setId(int id)             { this.id = id; }

    public int    getMembreId()             { return membreId; }
    public void   setMembreId(int m)        { this.membreId = m; }

    public String getNomMembre()            { return nomMembre; }
    public void   setNomMembre(String n)    { this.nomMembre = n; }

    public String getDescription()          { return description; }
    public void   setDescription(String d)  { this.description = d; }

    public int    getQuantite()             { return quantite; }
    public void   setQuantite(int q)        { this.quantite = q; }

    public String getStatut()              { return statut; }
    public void   setStatut(String s)      { this.statut = s; }

    public String getDateDemande()          { return dateDemande; }
    public void   setDateDemande(String d)  { this.dateDemande = d; }

    public String getDateTraitement()           { return dateTraitement; }
    public void   setDateTraitement(String d)   { this.dateTraitement = d; }

    public int    getTraitePar()            { return traitePar; }
    public void   setTraitePar(int t)       { this.traitePar = t; }
}