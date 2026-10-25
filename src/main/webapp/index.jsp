<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
Integer nbPublications = (Integer) request.getAttribute("nbPublications");
Integer nbEvenements   = (Integer) request.getAttribute("nbEvenements");

if(nbPublications == null) nbPublications = 0;
if(nbEvenements == null) nbEvenements = 0;
%>

<!DOCTYPE html>
<html lang="fr">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Accueil — LIAS</title>

<style>
body{
    margin:0;
    font-family:'Segoe UI',Arial,sans-serif;
    background:#f5f7fb;
    color:#1f2937;
}

.navbar{
    height:90px;
    background:#f5f7fb;
    display:flex;
    justify-content:space-between;
    align-items:center;
    padding:0 70px;
}

.logo{
    font-size:26px;
    font-weight:900;
    color:#0B1F45;
    text-decoration:none;
}

.logo span{
    color:#2563eb;
}

.nav-links{
    display:flex;
    gap:18px;
    align-items:center;
}

.nav-links a{
    text-decoration:none;
    color:#0B1F45;
    font-weight:800;
    background:white;
    padding:14px 24px;
    border-radius:18px;
    box-shadow:0 10px 25px rgba(0,0,0,.08);
    transition:.3s;
}

.nav-links a:hover{
    transform:translateY(-5px);
    color:#2563eb;
    box-shadow:0 18px 35px rgba(0,0,0,.12);
}

.nav-links a.active{
    background:#2563eb;
    color:white;
}

.nav-links a.login-btn{
    background:#0B1F45;
    color:white;
}

.nav-links a.login-btn:hover{
    background:#2563eb;
    color:white;
}

.hero{
    min-height:430px;
    background:linear-gradient(135deg,#0B1F45,#123C8C,#2563EB);
    color:white;
    display:flex;
    align-items:center;
    justify-content:center;
    text-align:center;
    padding:60px 20px;
}

.hero-content{
    max-width:850px;
}

.hero h1{
    font-size:48px;
    margin-bottom:18px;
}

.hero p{
    font-size:19px;
    line-height:1.7;
    color:#e5e7eb;
}

.hero-actions{
    margin-top:30px;
}

.btn{
    display:inline-block;
    text-decoration:none;
    padding:13px 24px;
    border-radius:14px;
    font-weight:700;
    margin:8px;
}

.btn-primary{
    background:white;
    color:#0B1F45;
}

.btn-outline{
    border:1px solid white;
    color:white;
}

.section{
    width:85%;
    margin:60px auto;
}

.section-title{
    text-align:center;
    margin-bottom:35px;
}

.section-title h2{
    font-size:32px;
    color:#0B1F45;
}

.section-title p{
    color:#6b7280;
}

.cards{
    display:grid;
    grid-template-columns:repeat(auto-fit,minmax(240px,1fr));
    gap:25px;
}

.card{
    background:white;
    padding:30px;
    border-radius:24px;
    box-shadow:0 12px 30px rgba(0,0,0,.08);
    transition:.3s;
}

.card:hover{
    transform:translateY(-6px);
}

.icon{
    width:60px;
    height:60px;
    border-radius:18px;
    background:#eff6ff;
    display:flex;
    align-items:center;
    justify-content:center;
    font-size:30px;
    margin-bottom:18px;
}

.card h3{
    color:#0B1F45;
    margin-bottom:12px;
}

.card p{
    color:#6b7280;
    line-height:1.6;
}

.card a{
    display:inline-block;
    margin-top:15px;
    color:#2563eb;
    font-weight:700;
    text-decoration:none;
}

.stats{
    display:grid;
    grid-template-columns:repeat(auto-fit,minmax(220px,1fr));
    gap:25px;
}

.stat{
    background:white;
    text-align:center;
    padding:30px;
    border-radius:24px;
    box-shadow:0 10px 25px rgba(0,0,0,.07);
}

.stat-num{
    font-size:36px;
    color:#2563eb;
    font-weight:800;
}

.stat-label{
    color:#6b7280;
    margin-top:8px;
}

.join{
    background:linear-gradient(135deg,#0B1F45,#1D4ED8);
    color:white;
    padding:45px;
    border-radius:28px;
    display:flex;
    justify-content:space-between;
    align-items:center;
    gap:20px;
}

.join h2{
    margin:0 0 10px;
}

.join p{
    color:#e5e7eb;
}

.join a{
    background:white;
    color:#0B1F45;
    padding:14px 22px;
    border-radius:14px;
    text-decoration:none;
    font-weight:800;
    white-space:nowrap;
}

.footer{
    text-align:center;
    padding:25px;
    color:#6b7280;
}

/* ===== Zone dynamique (Publications / Activités) ===== */
#zoneContenu{
    display:none;
}

.public-container{
    max-width:1200px;
    margin:35px auto;
    padding:0 24px;
}

.retour-link{
    display:inline-block;
    margin-bottom:20px;
    color:#2563eb;
    font-weight:700;
    text-decoration:none;
}

.public-header{
    margin-bottom:25px;
}

.public-header h1{
    color:#0B1F45;
    font-size:30px;
    margin-bottom:8px;
}

.public-header p{
    color:#64748b;
}

.public-card{
    background:white;
    padding:24px;
    border-radius:12px;
    box-shadow:0 4px 15px rgba(15,35,70,.08);
}

.search-row{
    display:flex;
    gap:12px;
    flex-wrap:wrap;
    margin-bottom:22px;
}

.search-row input,
.search-row select{
    padding:10px 12px;
    border:1px solid #dbe2ea;
    border-radius:8px;
    font-size:14px;
    background:white;
}

.search-row input{
    flex:1;
    min-width:220px;
}

.table-wrap{
    overflow-x:auto;
}

.public-table{
    width:100%;
    border-collapse:collapse;
}

.public-table th{
    background:#f1f5f9;
    color:#0B1F45;
    text-align:left;
    padding:14px;
    white-space:nowrap;
}

.public-table td{
    padding:14px;
    border-bottom:1px solid #e8edf4;
}

.public-table tbody tr:hover{
    background:#f8faff;
}

.badge{
    display:inline-block;
    padding:5px 10px;
    border-radius:20px;
    background:#dbeafe;
    color:#1d4ed8;
    font-size:12px;
}

.empty-state{
    text-align:center;
    padding:45px 15px;
    color:#64748b;
}

.empty-state .icon{
    width:auto;
    height:auto;
    background:none;
    display:block;
    margin:0 auto 12px;
    font-size:38px;
}

@media(max-width:750px){
    .navbar{
        padding:0 20px;
    }

    .nav-links a{
        margin-left:10px;
        font-size:13px;
    }

    .hero h1{
        font-size:34px;
    }

    .join{
        flex-direction:column;
        text-align:center;
    }

    .public-container{
        padding:0 12px;
    }

    .public-card{
        padding:14px;
    }
}
</style>
</head>

<body>

<div class="navbar">
    <a href="index.jsp" class="logo">LIAS<span>.</span></a>

    <div class="nav-links">
    <a href="presentation.jsp" class="ajax-link">Présentation</a>
    <a href="listeEquipes?mode=public" class="ajax-link">Équipes</a>
    <a href="listeEvenements?mode=public" class="ajax-link">Activités</a>
    <a href="listePublications?mode=public" class="ajax-link">Publications</a>
    <a href="login.jsp" class="login-btn">Connexion</a>
</div>
</div>

<!-- ===== Contenu de l'accueil (masqué quand on ouvre une section) ===== -->
<div id="accueil">

    <section class="hero">
        <div class="hero-content">
            <h1>Laboratoire LIAS</h1>
            <p>
                Plateforme de gestion et de valorisation des activités scientifiques,
                des publications, des équipes et des événements du laboratoire LIAS.
            </p>

            <div class="hero-actions">
                <a href="listePublications?mode=public" class="btn btn-primary ajax-link">Voir les publications</a>
                <a href="demandeAdhesion.jsp" class="btn btn-outline">Demande d’adhésion</a>
            </div>
        </div>
    </section>

    <section class="section">
        <div class="section-title">
            <h2>Espace public</h2>
            <p>Consultation libre sans authentification</p>
        </div>

        <div class="cards">

            <div class="card">
                <div class="icon">🏛</div>
                <h3>Présentation</h3>
                <p>Découvrir le laboratoire LIAS, ses missions, ses axes de recherche et son organisation.</p>
                <a href="presentation.jsp">Consulter →</a>
            </div>

            <div class="card">
                <div class="icon">👥</div>
                <h3>Équipes</h3>
                <p>Consulter les équipes de recherche, leurs thématiques et leurs membres.</p>
                                <a href="listeEquipes?mode=public" class="ajax-link">Consulter →</a>
            </div>

            <div class="card">
                <div class="icon">🗓</div>
                <h3>Activités</h3>
                <p>Voir les conférences, séminaires, workshops et événements scientifiques.</p>
                                <a href="listeEvenements?mode=public" class="ajax-link">Consulter →</a>
            </div>

            <div class="card">
                <div class="icon">📄</div>
                <h3>Publications</h3>
                <p>Accéder aux publications scientifiques classées par auteur, année et équipe.</p>
                <a href="listePublications?mode=public" class="ajax-link">Consulter →</a>
            </div>

        </div>
    </section>

    <section class="section">
        <div class="stats">

            <div class="stat">
                <div class="stat-num"><%= nbPublications %></div>
                <div class="stat-label">Publications scientifiques</div>
            </div>

            <div class="stat">
                <div class="stat-num"><%= nbEvenements %></div>
                <div class="stat-label">Activités scientifiques</div>
            </div>

            <div class="stat">
                <div class="stat-num">LIAS</div>
                <div class="stat-label">Laboratoire de recherche</div>
            </div>

        </div>
    </section>

    <section class="section">
        <div class="join">
            <div>
                <h2>Vous souhaitez rejoindre le laboratoire ?</h2>
                <p>
                    Envoyez une demande d’adhésion en ligne avec vos informations,
                    votre CV et votre motivation.
                </p>
            </div>

            <a href="demandeAdhesion.jsp">Envoyer une demande</a>
        </div>
    </section>

</div>

<!-- ===== Zone où s'affichent Publications ou Activités ===== -->
<div id="zoneContenu"></div>

<div class="footer">
    © 2026 Laboratoire LIAS — Faculté des Sciences Ben M'Sik
</div>

<script>
const accueil = document.getElementById("accueil");
const zone = document.getElementById("zoneContenu");

function afficherAccueil() {
    zone.style.display = "none";
    zone.innerHTML = "";
    accueil.style.display = "";
    document.querySelectorAll(".nav-links a").forEach(function (a) {
        a.classList.remove("active");
    });
    window.scrollTo(0, 0);
}

// Finds the main content of the loaded page, without its own navbar/footer
function extraireContenu(doc) {
    const candidats = [".public-container", "main", ".container", ".content", ".main"];
    for (let i = 0; i < candidats.length; i++) {
        const el = doc.querySelector(candidats[i]);
        if (el) return el;
    }
    const body = doc.body.cloneNode(true);
    body.querySelectorAll(".navbar, nav, .footer, footer, .sidebar, script")
        .forEach(function (e) { e.remove(); });
    return body;
}

function chargerSection(url, lien) {
    fetch(url)
        .then(function (r) {
            if (!r.ok) throw new Error("HTTP " + r.status);
            return r.text();
        })
        .then(function (html) {
            const doc = new DOMParser().parseFromString(html, "text/html");
            const contenu = extraireContenu(doc);

            // Remove the "back" link of the loaded page (we add our own)
            contenu.querySelectorAll(".retour-link").forEach(function (e) { e.remove(); });

            const styles = Array.from(doc.querySelectorAll("style"))
                .map(function (s) { return s.outerHTML; }).join("");

            zone.innerHTML =
                styles +
                '<div class="public-container">' +
                '<a href="#" class="retour-link" id="retourAccueil">← Retour à l\'accueil</a>' +
                contenu.innerHTML +
                '</div>';

            accueil.style.display = "none";
            zone.style.display = "block";

            document.querySelectorAll(".nav-links a").forEach(function (a) {
                a.classList.remove("active");
            });
            if (lien) lien.classList.add("active");

            window.scrollTo(0, 0);
        })
        .catch(function () {
            window.location.href = url; // fallback: open the page normally
        });
}

document.querySelectorAll(".ajax-link").forEach(function (link) {
    link.addEventListener("click", function (e) {
        e.preventDefault();
        chargerSection(link.href, link.closest(".nav-links") ? link : null);
    });
});

zone.addEventListener("click", function (e) {
    if (e.target.id === "retourAccueil") {
        e.preventDefault();
        afficherAccueil();
    }
});

// Search + year filter (Publications and Activités)
function filterTable() {
    const q = document.getElementById("searchInput").value.toLowerCase();
    const annee = document.getElementById("filterAnnee").value;
    const rows = document.querySelectorAll("#zoneContenu .public-table tbody tr");

    rows.forEach(function (row) {
        if (row.cells.length < 4) return;

        const rowAnnee = row.dataset.annee || row.cells[2].innerText.trim();
        const okRecherche = row.innerText.toLowerCase().includes(q);
        const okAnnee = !annee || rowAnnee === annee;

        row.style.display = okRecherche && okAnnee ? "" : "none";
    });
}
</script>

</body>
</html>