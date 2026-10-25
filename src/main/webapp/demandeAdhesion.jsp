
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="fr">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Demande d'adhésion - LIAS</title>

<style>
* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}

body {
    font-family: Arial, sans-serif;
    background: #f0f4ff;
    min-height: 100vh;
    padding: 40px 20px;
    color: #1a1f36;
}

.topbar {
    max-width: 780px;
    margin: 0 auto 30px;
    display: flex;
    justify-content: space-between;
    align-items: center;
}

.logo {
    font-size: 26px;
    font-weight: 800;
    color: #0B1F45;
}

.logo span {
    color: #2563EB;
}

.back-link {
    text-decoration: none;
    color: #64748b;
}

.back-link:hover {
    color: #2563EB;
}

.card {
    max-width: 780px;
    margin: auto;
    padding: 40px;
    background: white;
    border-radius: 20px;
    box-shadow: 0 8px 32px rgba(0, 0, 0, 0.08);
}

h1 {
    color: #0B1F45;
    font-size: 28px;
    margin-bottom: 12px;
}

.subtitle {
    color: #64748b;
    font-size: 14px;
    line-height: 1.7;
    margin-bottom: 28px;
}

.form-grid {
    display: grid;
    grid-template-columns: 1fr 1fr;
    gap: 18px;
}

.form-group {
    display: flex;
    flex-direction: column;
    gap: 8px;
    margin-bottom: 20px;
}

label {
    font-size: 14px;
    font-weight: 600;
}

input, textarea {
    width: 100%;
    padding: 13px 14px;
    border: 1px solid #dbe3ef;
    border-radius: 9px;
    font-family: inherit;
    font-size: 14px;
}

input:focus, textarea:focus {
    outline: none;
    border-color: #2563EB;
    box-shadow: 0 0 0 3px rgba(37, 99, 235, 0.1);
}

textarea {
    min-height: 130px;
    resize: vertical;
}

.btn {
    display: inline-block;
    padding: 14px 24px;
    background: #2563EB;
    color: white;
    border: none;
    border-radius: 10px;
    font-size: 14px;
    font-weight: 700;
    cursor: pointer;
}

.btn:hover {
    background: #1D4ED8;
}

.success {
    padding: 15px;
    margin-bottom: 24px;
    border-radius: 10px;
    background: #f0fdf4;
    color: #166534;
    border: 1px solid #bbf7d0;
}

.error {
    padding: 15px;
    margin-bottom: 24px;
    border-radius: 10px;
    background: #fef2f2;
    color: #991b1b;
    border: 1px solid #fecaca;
}

@media (max-width: 600px) {
    .card {
        padding: 24px;
    }

    .form-grid {
        grid-template-columns: 1fr;
        gap: 0;
    }

    h1 {
        font-size: 23px;
    }
}
</style>
</head>

<body>

<div class="topbar">
    <div class="logo">LIAS<span>.</span></div>
    <a href="index.jsp" class="back-link">← Retour à l'accueil</a>
</div>

<div class="card">

    <h1>Rejoindre le laboratoire LIAS</h1>

    <p class="subtitle">
        Remplissez ce formulaire pour soumettre votre demande d'adhésion.
        Votre candidature sera examinée par l'administration du laboratoire.
    </p>

    <% if ("ok".equals(request.getParameter("status"))) { %>
        <div class="success">
            Votre demande a été envoyée avec succès !
            Elle est en attente de validation par l'administrateur.
        </div>
    <% } %>

    <% if ("erreur".equals(request.getParameter("status"))) { %>
        <div class="error">
            Une erreur est survenue lors de l'envoi.
            Vérifiez vos informations et réessayez.
        </div>
    <% } %>

    <form action="${pageContext.request.contextPath}/soumettreDemande"
          method="post">

        <div class="form-grid">
            <div class="form-group">
                <label for="nom">Nom *</label>
                <input type="text" id="nom" name="nom"
                       maxlength="100" placeholder="Votre nom" required>
            </div>

            <div class="form-group">
                <label for="prenom">Prénom *</label>
                <input type="text" id="prenom" name="prenom"
                       maxlength="100" placeholder="Votre prénom" required>
            </div>
        </div>

        <div class="form-group">
            <label for="email">Adresse e-mail *</label>
            <input type="email" id="email" name="email"
                   maxlength="150" placeholder="votre@email.ma" required>
        </div>

        <div class="form-group">
            <label for="etablissement">Établissement d'origine *</label>
            <input type="text" id="etablissement" name="etablissement"
                   maxlength="200" placeholder="Université, faculté..." required>
        </div>

        <div class="form-group">
            <label for="motivation">Lettre de motivation *</label>
            <textarea id="motivation" name="motivation"
                      placeholder="Présentez votre parcours et vos motivations..."
                      required></textarea>
        </div>

        <button type="submit" class="btn">
            Soumettre ma candidature →
        </button>

    </form>

</div>

</body>
</html>
