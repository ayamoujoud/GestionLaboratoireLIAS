package model;

public class Convention {
    private int id;
    private String titre;
    private String partenaire;
    private String typeConvention;
    private String dateSignature;
    private String dateFin;
    private String documentPath;
    private String description;

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public String getTitre() { return titre; }
    public void setTitre(String titre) { this.titre = titre; }
    public String getPartenaire() { return partenaire; }
    public void setPartenaire(String partenaire) { this.partenaire = partenaire; }
    public String getTypeConvention() { return typeConvention; }
    public void setTypeConvention(String typeConvention) { this.typeConvention = typeConvention; }
    public String getDateSignature() { return dateSignature; }
    public void setDateSignature(String dateSignature) { this.dateSignature = dateSignature; }
    public String getDateFin() { return dateFin; }
    public void setDateFin(String dateFin) { this.dateFin = dateFin; }
    public String getDocumentPath() { return documentPath; }
    public void setDocumentPath(String documentPath) { this.documentPath = documentPath; }
    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }
}