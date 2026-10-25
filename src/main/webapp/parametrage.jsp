
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="fr">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Paramétrage - LIAS</title>
<style>
* { box-sizing: border-box; }
body {
    margin: 0; font-family: "Segoe UI", Arial, sans-serif;
    color: #0B1F45; background: #f3f6fc;
}
header {
    background: white; padding: 22px 6%;
    display: flex; justify-content: space-between; align-items: center;
}
.logo { font-size: 25px; font-weight: 800; }
.logo span { color: #2563EB; }
a { color: #2563EB; text-decoration: none; }
main { max-width: 850px; margin: 45px auto; padding: 0 22px; }
h1 { margin-bottom: 8px; }
.muted { color: #64748b; }
.panel {
    background: white; border-radius: 20px; padding: 30px;
    margin-top: 25px; box-shadow: 0 8px 30px #0b1f450b;
}
label { display: block; font-weight: 600; margin: 20px 0 8px; }
input, select {
    width: 100%; padding: 13px; border: 1px solid #dbe3ef;
    border-radius: 10px; font-size: 16px; background: white;
}
button {
    margin-top: 25px; padding: 14px 22px; border: 0;
    border-radius: 12px; background: #2563EB; color: white;
    font-size: 16px; font-weight: bold; cursor: pointer;
}
button:hover { background: #1d4ed8; }
.notice {
    display: none; margin-top: 20px; padding: 14px;
    border-radius: 10px; background: #dcfce7; color: #166534;
}
.back { display: inline-block; margin-top: 25px; }
</style>
</head>
<body>
<header>
    <div class="logo">LIAS<span>.</span></div>
    <a href="${pageContext.request.contextPath}/index.jsp">← Dashboard</a>
</header>

<main>
    <h1>⚙️ Paramétrage</h1>
    <p class="muted">Configuration générale de la plateforme LIAS.</p>

    <form class="panel" id="settingsForm">
        <h2>Paramètres généraux</h2>

        <label for="platform">Nom de la plateforme</label>
        <input id="platform" name="platform" value="LIAS" required>

        <label for="language">Langue</label>
        <select id="language" name="language">
            <option value="fr">Français</option>
            <option value="en">English</option>
            <option value="ar">العربية</option>
        </select>

        <label for="email">Email de contact</label>
        <input id="email" name="email" type="email"
               placeholder="admin@lias.com">

        <label for="theme">Thème de l'interface</label>
        <select id="theme" name="theme">
            <option value="blue">Bleu professionnel</option>
            <option value="light">Clair</option>
        </select>

        <button type="submit">Enregistrer les paramètres</button>
        <div class="notice" id="notice" role="status">
            ✓ Paramètres validés avec succès !
        </div>
    </form>

       <a href="${pageContext.request.contextPath}/adminDashboard.jsp">← Dashboard</a>
      
    </a>
</main>

<script>
document.getElementById("settingsForm").addEventListener("submit", function(e) {
    e.preventDefault();
    document.getElementById("notice").style.display = "block";
});
</script>
</body>
</html>
