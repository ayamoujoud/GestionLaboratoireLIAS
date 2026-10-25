package filter;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.Arrays;
import java.util.List;

@WebFilter("/*")
public class AuthFilter implements Filter {

    private static final List<String> PAGES_PUBLIQUES = Arrays.asList(
        "/login", "/login.jsp", "/logout",
        "/index.jsp", "/accueil", "/accueil.jsp", "/presentation.jsp",
        "/soumettreDemande", "/demandeAdhesion.jsp",
        "/listePublications", "/listeEvenements", "/listeEquipes"
    );

    @Override
    public void doFilter(ServletRequest req, ServletResponse res, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest  request  = (HttpServletRequest)  req;
        HttpServletResponse response = (HttpServletResponse) res;

        String uri         = request.getRequestURI();
        String contextPath = request.getContextPath();
        String path        = uri.substring(contextPath.length());

        // Page d'accueil du site (racine) → laisser passer
        if (path.isEmpty() || path.equals("/")) {
            chain.doFilter(req, res);
            return;
        }

        // Ressources statiques → laisser passer
        if (path.startsWith("/WEB-INF") || path.contains(".css")
                || path.contains(".js")  || path.contains(".png")
                || path.contains(".jpg") || path.contains(".ico")) {
            chain.doFilter(req, res);
            return;
        }

        // Pages publiques → laisser passer
        for (String page : PAGES_PUBLIQUES) {
            if (path.equals(page) || path.startsWith(page)) {
                chain.doFilter(req, res);
                return;
            }
        }

        // Vérifier la session
        HttpSession session  = request.getSession(false);
        boolean     connecte = (session != null && session.getAttribute("user") != null);

        if (connecte) {
            // Mettre à jour le badge notifications
            try {
                model.Utilisateur u = (model.Utilisateur) session.getAttribute("user");
                if (u != null) {
                    int nb = new dao.NotificationDAO().countNonLues(u.getId());
                    session.setAttribute("nbNotifs", nb);
                }
            } catch (Exception ex) { /* silencieux */ }

            chain.doFilter(req, res); // UNE SEULE FOIS
        } else {
            response.sendRedirect(contextPath + "/login.jsp");
        }
    }
}