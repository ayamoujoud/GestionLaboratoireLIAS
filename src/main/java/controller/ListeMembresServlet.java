package controller;

import java.io.IOException;
import java.util.List;

import dao.MembreDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Membre;

@WebServlet("/listeMembres")
public class ListeMembresServlet extends HttpServlet {

    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        MembreDAO dao = new MembreDAO();
        List<Membre> membres = dao.getAllMembres();

        request.setAttribute("membres", membres);
        request.getRequestDispatcher("listeMembres.jsp").forward(request, response);
    }
}