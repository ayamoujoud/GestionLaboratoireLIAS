package model;

public class ProcesVerbal {
    private int id;
    private String dateReunion;
    private String ordreDuJour;
    private String pvPath;
    private int creePar;
    private String nomCreateur;
    private String dateUpload;

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public String getDateReunion() { return dateReunion; }
    public void setDateReunion(String dateReunion) { this.dateReunion = dateReunion; }
    public String getOrdreDuJour() { return ordreDuJour; }
    public void setOrdreDuJour(String ordreDuJour) { this.ordreDuJour = ordreDuJour; }
    public String getPvPath() { return pvPath; }
    public void setPvPath(String pvPath) { this.pvPath = pvPath; }
    public int getCreePar() { return creePar; }
    public void setCreePar(int creePar) { this.creePar = creePar; }
    public String getNomCreateur() { return nomCreateur; }
    public void setNomCreateur(String nomCreateur) { this.nomCreateur = nomCreateur; }
    public String getDateUpload() { return dateUpload; }
    public void setDateUpload(String dateUpload) { this.dateUpload = dateUpload; }
}