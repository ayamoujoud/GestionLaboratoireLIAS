package model;

public class Membre {

    private int id;
    private String nom;
    private String prenom;
    private String email;
    private String statut;
    private String photo;
    private String etablissement;
    private String laboratoireOrigine;
    private String biographie;
    private String centresInteret;
    public String getEtablissement() {
		return etablissement;
	}

	public void setEtablissement(String etablissement) {
		this.etablissement = etablissement;
	}

	public String getLaboratoireOrigine() {
		return laboratoireOrigine;
	}

	public void setLaboratoireOrigine(String laboratoireOrigine) {
		this.laboratoireOrigine = laboratoireOrigine;
	}

	public String getBiographie() {
		return biographie;
	}

	public void setBiographie(String biographie) {
		this.biographie = biographie;
	}

	public String getCentresInteret() {
		return centresInteret;
	}

	public void setCentresInteret(String centresInteret) {
		this.centresInteret = centresInteret;
	}

	public String getEquipe() {
		return equipe;
	}

	public void setEquipe(String equipe) {
		this.equipe = equipe;
	}

	private String equipe;

    public Membre() {
    }

    public Membre(int id, String nom, String prenom, String email, String statut) {
        this.id = id;
        this.nom = nom;
        this.prenom = prenom;
        this.email = email;
        this.statut = statut;
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

    public String getStatut() {
        return statut;
    }

    public void setStatut(String statut) {
        this.statut = statut;
    }
    public String getPhoto() {
        return photo;
    }

    public void setPhoto(String photo) {
        this.photo = photo;
    }
    private String typeMembre;
    private String etatCompte;

    public String getTypeMembre() {
        return typeMembre;
    }

    public void setTypeMembre(String typeMembre) {
        this.typeMembre = typeMembre;
    }

    public String getEtatCompte() {
        return etatCompte;
    }

    public void setEtatCompte(String etatCompte) {
        this.etatCompte = etatCompte;
    }
}