<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="model.Utilisateur" %>

<%
if(session.getAttribute("user") == null){
    response.sendRedirect("login.jsp");
    return;
}

Utilisateur user = (Utilisateur) session.getAttribute("user");
String role = (String) session.getAttribute("role");

if(role == null || (!"ADMIN".equalsIgnoreCase(role) && !"DIRECTEUR".equalsIgnoreCase(role))){
    response.sendRedirect("membreDashboard.jsp");
    return;
}

request.setAttribute("currentPage", "dashboard");
%>

<!DOCTYPE html>
<html lang="fr">
<head>
<meta charset="UTF-8">
<title>Espace Admin — LIAS</title>

<%@ include file="/WEB-INF/style.jsp" %>

<style>
.hero{
    background:linear-gradient(135deg,#0B1F45,#123C8C,#2563EB);
    padding:42px;
    border-radius:30px;
    color:white;
    margin-bottom:35px;
    box-shadow:0 18px 40px rgba(37,99,235,.25);
}

.hero h1{
    margin:0 0 10px;
    font-size:38px;
}

.hero p{
    margin:0;
    color:#e5e7eb;
    font-size:17px;
}

.cards{
    display:grid;
    grid-template-columns:repeat(auto-fit,minmax(260px,1fr));
    gap:26px;
}

.card-admin{
    background:white;
    border-radius:28px;
    padding:30px;
    box-shadow:0 15px 38px rgba(0,0,0,.08);
    transition:.3s;
}

.card-admin:hover{
    transform:translateY(-8px);
    box-shadow:0 22px 45px rgba(0,0,0,.12);
}

.card-icon{
    width:64px;
    height:64px;
    border-radius:22px;
    background:#eff6ff;
    display:flex;
    align-items:center;
    justify-content:center;
    font-size:30px;
    margin-bottom:20px;
}

.card-admin h3{
    font-size:20px;
    font-weight:700;
    color:#0B1F45;
}

.card-admin p{
    color:#64748b;
    line-height:1.6;
    font-size:14px;
}

.card-admin a{
    display:inline-block;
    margin-top:18px;
    background:#2563eb;
    color:white;
    padding:12px 22px;
    border-radius:14px;
    text-decoration:none;
    font-weight:800;
}

.card-admin a:hover{
    background:#1D4ED8;
}
</style>
</head>

<body>

<%@ include file="/WEB-INF/sidebar.jsp" %>

<main class="main">

    <section class="hero">
        <h1>Espace Administrateur</h1>
        <p>Gestion technique : comptes utilisateurs, paramétrage et maintenance du système LIAS.</p>
    </section>

    <div class="cards">

        <div class="card-admin">
            <div class="card-icon">👥</div>
            <h3>Comptes utilisateurs</h3>
            <p>Créer, modifier, désactiver les comptes des membres, doctorants et administrateurs.</p>
            <a href="listeMembres">Gérer</a>
        </div>

        <div class="card-admin">
            <div class="card-icon">⚙️</div>
            <h3>Paramétrage</h3>
            <p>Configurer les paramètres généraux de la plateforme LIAS.</p>
               <a href="parametrage.jsp">Ouvrir</a>
        </div>

        <div class="card-admin">
            <div class="card-icon">🛠</div>
            <h3>Maintenance</h3>
            <p>Suivre l’état du système, la maintenance et les actions importantes.</p>
                        <a href="maintenance.jsp">Ouvrir</a>
        </div>

        <div class="card-admin">
            <div class="card-icon">📋</div>
            <h3>Demandes d’adhésion</h3>
            <p>Consulter, accepter ou refuser les demandes envoyées par les visiteurs.</p>
            <a href="listeDemandes">Gérer</a>
        </div>

        <div class="card-admin">
            <div class="card-icon">📄</div>
            <h3>Publications</h3>
            <p>Gérer les publications scientifiques du laboratoire.</p>
            <a href="listePublications">Gérer</a>
        </div>

        <div class="card-admin">
            <div class="card-icon">🗓</div>
            <h3>Événements</h3>
            <p>Créer et organiser les conférences, séminaires et workshops.</p>
             <a href="listeEvenements"
           class="<%= "evenements".equals(_cp) ? "active" : "" %>">Gérer</a>
        </div>

    </div>

</main>

</body>
</html>