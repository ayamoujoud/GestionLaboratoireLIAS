package controller;

import dao.*;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.Calendar;

@WebServlet("/rapport")
public class RapportServlet extends HttpServlet {

    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse res)
	        throws IOException, ServletException {

	    int annee = req.getParameter("annee") != null
	            ? Integer.parseInt(req.getParameter("annee"))
	            : Calendar.getInstance().get(Calendar.YEAR);

	    try {

	        MembreDAO membreDAO = new MembreDAO();
	        PublicationDAO publicationDAO = new PublicationDAO();
	        EvenementDAO evenementDAO = new EvenementDAO();

	        var membres = membreDAO.listerActifs();
	        var publications = publicationDAO.listerParAnnee(annee);
	        var evenements = evenementDAO.listerParAnnee(annee);

	        req.setAttribute("annee", annee);

	        req.setAttribute("membres", membres);
	        req.setAttribute("publications", publications);
	        req.setAttribute("evenements", evenements);

	        req.setAttribute("nbMembres", membres.size());
	        req.setAttribute("nbPublications", publications.size());
	        req.setAttribute("nbEvenements", evenements.size());

	        req.getRequestDispatcher("/rapport.jsp").forward(req, res);

	    } catch (Exception e) {
	        throw new ServletException(e);
	    }
	}
}