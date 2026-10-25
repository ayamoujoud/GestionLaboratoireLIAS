<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
if(session.getAttribute("user") == null){
    response.sendRedirect("login.jsp");
    return;
}
%>

<!DOCTYPE html>
<html lang="fr">
<head>
<meta charset="UTF-8">
<title>Espace Membre — LIAS</title>

<style>
body{
    margin:0;
    font-family:'Segoe UI',Arial,sans-serif;
    background:#f5f7fb;
    color:#0B1F45;
}

.topbar{
    height:75px;
    background:white;
    display:flex;
    justify-content:space-between;
    align-items:center;
    padding:0 70px;
    box-shadow:0 8px 25px rgba(0,0,0,.08);
}

.logo{
    font-size:26px;
    font-weight:900;
}

.logo span{
    color:#2563eb;
}

.logout{
    background:#0B1F45;
    color:white;
    padding:12px 22px;
    border-radius:14px;
    text-decoration:none;
    font-weight:700;
}

.hero{
    background:linear-gradient(135deg,#0B1F45,#123C8C,#2563EB);
    color:white;
    padding:55px 75px;
    border-radius:0 0 40px 40px;
}

.hero h1{
    margin:0;
    font-size:42px;
}

.hero p{
    font-size:18px;
    color:#e5e7eb;
}

.container{
    width:86%;
    margin:45px auto;
}

.cards{
    display:grid;
    grid-template-columns:repeat(auto-fit,minmax(260px,1fr));
    gap:28px;
}

.card{
    background:white;
    border-radius:28px;
    padding:32px;
    box-shadow:0 16px 38px rgba(0,0,0,.08);
    transition:.3s;
}

.card:hover{
    transform:translateY(-8px);
    box-shadow:0 22px 45px rgba(0,0,0,.12);
}

.icon{
    width:65px;
    height:65px;
    border-radius:22px;
    background:#eff6ff;
    display:flex;
    align-items:center;
    justify-content:center;
    font-size:30px;
    margin-bottom:20px;
}

.card h3{
    font-size:23px;
    margin-bottom:12px;
}

.card p{
    color:#64748b;
    line-height:1.7;
    font-size:15px;
}

.card a{
    display:inline-block;
    margin-top:18px;
    background:#2563eb;
    color:white;
    padding:12px 22px;
    border-radius:14px;
    text-decoration:none;
    font-weight:800;
}

.card a:hover{
    background:#1D4ED8;
}
</style>
</head>

<body>

<div class="topbar">
    <div class="logo">LIAS<span>.</span></div>
    <a href="logout" class="logout">Déconnexion</a>
</div>

<section class="hero">
    <h1>Espace Membre</h1>
    <p>Bienvenue dans votre espace personnel du laboratoire LIAS.</p>
</section>

<div class="container">
    <div class="cards">

        <div class="card">
            <div class="icon">👤</div>
            <h3>Mon profil</h3>
            <p>Consulter mes informations personnelles, mon statut, mon équipe et mes publications.</p>
            <a href="monProfil">Voir mon profil</a>
        </div>

        <div class="card">
            <div class="icon">✏️</div>
            <h3>Modifier mon profil</h3>
            <p>Modifier ma photo, ma biographie, mes centres d’intérêt et mes informations.</p>
            <a href="modifierMonProfil">Modifier</a>
        </div>

        <div class="card">
            <div class="icon">👥</div>
            <h3>Profils membres</h3>
            <p>Consulter les profils des autres membres du laboratoire.</p>
                        <a href="profilsMembres.jsp">Consulter</a>
        </div>

        <div class="card">
            <div class="icon">📄</div>
            <h3>Publications</h3>
            <p>Ajouter ou consulter les publications scientifiques du laboratoire.</p>
            <a href="listePublications">Publications</a>
        </div>

    </div>
</div>

</body>
</html>