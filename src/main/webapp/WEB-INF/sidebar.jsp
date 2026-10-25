<%-- WEB-INF/includes/sidebar.jsp --%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="model.Utilisateur" %>

<%
    Utilisateur _u = (Utilisateur) session.getAttribute("user");

    String _email = (_u != null && _u.getEmail() != null)
            ? _u.getEmail()
            : "?";

    String _role = (_u != null && _u.getRole() != null)
            ? _u.getRole()
            : "";

    String _initials = _email.length() >= 2
            ? _email.substring(0, 2).toUpperCase()
            : "?";

    String _cp = (String) request.getAttribute("currentPage");

    if (_cp == null) {
        _cp = "";
    }
%>

<aside class="sidebar">

    <div class="sidebar-top">

        <a href="dashboard" class="logo">
            <div class="logo-mark">L</div>

            <div>
                <div class="logo-text">LIAS</div>
                <div class="logo-sub">Laboratoire</div>
            </div>
        </a>

        <div class="user-badge" style="margin-top:16px;">
            <div class="avatar"><%= _initials %></div>

            <div class="user-info">
                <div class="user-name"><%= _email %></div>
                <div class="user-role"><%= _role %></div>
            </div>
        </div>

    </div>

    <nav class="nav">

        

        

        <!-- MEMBRES -->
        <div class="nav-section">Membres</div>

        <a href="listeMembres"
           class="<%= "membres".equals(_cp) ? "active" : "" %>">
            <span class="icon">👥</span>
            Membres
        </a>

        <a href="listeEquipes"
           class="<%= "equipes".equals(_cp) ? "active" : "" %>">
            <span class="icon">🏛</span>
            Équipes
        </a>

        <a href="listeDemandes"
           class="<%= "demandes".equals(_cp) ? "active" : "" %>">
            <span class="icon">📋</span>
            Demandes d'adhésion
        </a>

        <!-- SCIENTIFIQUE -->
        <div class="nav-section">Scientifique</div>

        <a href="listePublications"
           class="<%= "publications".equals(_cp) ? "active" : "" %>">
            <span class="icon">📄</span>
            Publications
        </a>

        <a href="listeEvenements"
           class="<%= "evenements".equals(_cp) ? "active" : "" %>">
            <span class="icon">🗓</span>
            Événements
        </a>

        <!-- ADMINISTRATIF -->
        <div class="nav-section">Administratif</div>

        <a href="documents"
           class="<%= "documents".equals(_cp) ? "active" : "" %>">
            <span class="icon">🗂</span>
            Documents
        </a>

        <a href="materiel"
           class="<%= "materiel".equals(_cp) ? "active" : "" %>">
            <span class="icon">📦</span>
            Matériel
        </a>
        <a href="besoins"
           class="<%= "besoins".equals(_cp) ? "active" : "" %>">
            <span  class="icon">🛒</span>
            Besoins matériel
        </a>

        <a href="conventions"
           class="<%= "conventions".equals(_cp) ? "active" : "" %>">
            <span class="icon">🤝</span>
            Conventions
        </a>

        <a href="pv"
           class="<%= "pv".equals(_cp) ? "active" : "" %>">
            <span class="icon">📝</span>
            Procès-verbaux
        </a>

        <!-- PILOTAGE -->
        <div class="nav-section">Pilotage</div>

        <a href="rapport"
           class="<%= "rapport".equals(_cp) ? "active" : "" %>">
            <span class="icon">📊</span>
            Rapport annuel
        </a>

        <a href="calendrier"
           class="<%= "calendrier".equals(_cp) ? "active" : "" %>">
            <span class="icon">📅</span>
            Calendrier
        </a>

        <a href="messagerie"
           class="<%= "messagerie".equals(_cp) ? "active" : "" %>">
            <span class="icon">✉️</span>
            Messagerie
        </a>

           <a href="notifications"
           class="<%= "notifications".equals(_cp) ? "active" : "" %>">
            <span class="icon">🔔</span>
            Notifications

            <%
                Object nbObj = session.getAttribute("nbNotifs");
                int nbNotifs = 0;

                if (nbObj instanceof Integer) {
                    nbNotifs = (Integer) nbObj;
                }

                if (nbNotifs > 0) {
            %>
                <span style="background:#DC2626;color:white;border-radius:50%;
                             min-width:18px;height:18px;padding:0 5px;
                             display:inline-flex;align-items:center;
                             justify-content:center;font-size:10px;
                             font-weight:700;margin-left:auto;">
                    <%= nbNotifs %>
                </span>
            <%
                }
            %>
        </a>

        <a href="recherche"
           class="<%= "recherche".equals(_cp) ? "active" : "" %>">
            <span class="icon">🔍</span>
            Recherche
        </a>

        <a href="mandats"
           class="<%= "mandats".equals(_cp) ? "active" : "" %>">
            <span class="icon">🏛️</span>
            Gouvernance
        </a>

        <!-- DECONNEXION -->
        <a href="logout" class="logout" style="margin-top:20px;">
            <span class="icon">↩</span>
            Déconnexion
        </a>

    </nav>

</aside>