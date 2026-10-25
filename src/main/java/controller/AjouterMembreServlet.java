package controller;

import java.io.IOException;

import dao.MembreDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Membre;

@WebServlet("/ajouterMembre")
public class AjouterMembreServlet extends HttpServlet {

   

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
	        throws ServletException, IOException {

	    System.out.println("Servlet exécuté");

	    String nom = request.getParameter("nom");
	    String prenom = request.getParameter("prenom");
	    String email = request.getParameter("email");
	    String statut = request.getParameter("statut");
	    String etablissement = request.getParameter("etablissement");
	    String laboratoireOrigine = request.getParameter("laboratoireOrigine");
	    String biographie = request.getParameter("biographie");
	    String centresInteret = request.getParameter("centresInteret");
	    String equipe = request.getParameter("equipe");
	    Membre m = new Membre();

	    m.setNom(nom);
	    m.setPrenom(prenom);
	    m.setEmail(email);
	    m.setStatut(statut);
	    m.setEtablissement(etablissement);
	    m.setLaboratoireOrigine(laboratoireOrigine);
	    m.setBiographie(biographie);
	    m.setCentresInteret(centresInteret);
	    m.setEquipe(equipe);
	    MembreDAO dao = new MembreDAO();
	    dao.ajouterMembre(m);

	    response.sendRedirect("listeMembres");
	}
    
    
}