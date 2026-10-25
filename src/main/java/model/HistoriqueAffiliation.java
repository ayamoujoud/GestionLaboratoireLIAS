package model;

public class HistoriqueAffiliation {

    private int    id;
    private int    membreId;
    private String dateDebut;
    private String dateFin;
    private String motif;

    public int    getId()        { return id; }
    public void   setId(int id)  { this.id = id; }

    public int    getMembreId()           { return membreId; }
    public void   setMembreId(int mid)    { this.membreId = mid; }

    public String getDateDebut()              { return dateDebut; }
    public void   setDateDebut(String d)      { this.dateDebut = d; }

    public String getDateFin()                { return dateFin; }
    public void   setDateFin(String d)        { this.dateFin = d; }

    public String getMotif()                  { return motif; }
    public void   setMotif(String m)          { this.motif = m; }
}