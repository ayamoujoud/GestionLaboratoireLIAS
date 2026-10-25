<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="fr">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Connexion — LIAS</title>
<style>
@import url('https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600&display=swap');
*{margin:0;padding:0;box-sizing:border-box;}
body{
  font-family:'Inter',Arial,sans-serif;
  min-height:100vh;
  display:flex;
  background:#0B1F45;
}
.left-panel{
  flex:1;
  display:flex;
  flex-direction:column;
  justify-content:center;
  padding:60px;
  color:#fff;
}
.lp-badge{
  display:inline-flex;align-items:center;gap:8px;
  background:rgba(255,255,255,0.1);
  border:1px solid rgba(255,255,255,0.15);
  border-radius:20px;padding:6px 14px;
  font-size:12px;color:rgba(255,255,255,0.7);
  margin-bottom:40px;width:fit-content;
}
.lp-badge span{width:6px;height:6px;border-radius:50%;background:#34d399;display:block;}
.left-panel h1{font-size:38px;font-weight:600;line-height:1.2;margin-bottom:16px;}
.left-panel h1 em{color:#60a5fa;font-style:normal;}
.left-panel p{font-size:14px;color:rgba(255,255,255,0.55);line-height:1.7;max-width:380px;}
.features{margin-top:48px;display:flex;flex-direction:column;gap:14px;}
.feat{display:flex;align-items:center;gap:12px;font-size:13px;color:rgba(255,255,255,0.65);}
.feat-dot{width:24px;height:24px;border-radius:6px;background:rgba(37,99,235,0.4);display:flex;align-items:center;justify-content:center;font-size:12px;flex-shrink:0;}

.right-panel{
  width:460px;
  background:#fff;
  display:flex;
  flex-direction:column;
  justify-content:center;
  padding:60px 52px;
}
.right-panel .logo-row{display:flex;align-items:center;gap:10px;margin-bottom:48px;}
.logo-box{width:36px;height:36px;background:#2563EB;border-radius:9px;display:flex;align-items:center;justify-content:center;color:#fff;font-weight:600;font-size:16px;}
.logo-name{font-size:17px;font-weight:600;color:#0B1F45;}
.logo-name small{display:block;font-size:11px;color:#6B7A99;font-weight:400;}

h2{font-size:22px;font-weight:600;color:#1A1F36;margin-bottom:6px;}
.subtitle{font-size:13.5px;color:#6B7A99;margin-bottom:32px;}

.form-group{margin-bottom:18px;}
.form-group label{display:block;font-size:12.5px;font-weight:500;color:#1A1F36;margin-bottom:6px;}
.form-group input{
  width:100%;padding:11px 14px;
  border:1px solid #E4E9F2;border-radius:8px;
  font-size:14px;font-family:inherit;color:#1A1F36;
  transition:border-color .15s;
}
.form-group input:focus{outline:none;border-color:#2563EB;}

.error-msg{
  background:#FEF2F2;border:1px solid #fecaca;
  color:#DC2626;padding:10px 14px;border-radius:8px;
  font-size:13px;margin-bottom:18px;
}
.btn-login{
  width:100%;padding:12px;
  background:#2563EB;color:#fff;
  border:none;border-radius:8px;
  font-size:14px;font-weight:500;font-family:inherit;
  cursor:pointer;transition:background .15s;
  margin-top:4px;
}
.btn-login:hover{background:#1D4ED8;}
.form-footer{margin-top:28px;font-size:12px;color:#6B7A99;text-align:center;}
</style>
</head>
<body>

<div class="left-panel">
  <div class="lp-badge"><span></span>Plateforme active</div>
  <h1>Gestion du<br>laboratoire <em>LIAS</em></h1>
  <p>Plateforme intégrée pour la gestion administrative et scientifique du Laboratoire d'Informatique, d'Automatique et de Systèmes.</p>
  <div class="features">
    <div class="feat"><div class="feat-dot">👥</div>Gestion des membres et équipes</div>
    <div class="feat"><div class="feat-dot">📄</div>Suivi des publications et événements</div>
    <div class="feat"><div class="feat-dot">📊</div>Rapport annuel automatisé</div>
    <div class="feat"><div class="feat-dot">🗂</div>Archivage documentaire centralisé</div>
  </div>
</div>

<div class="right-panel">
  <div class="logo-row">
    <div class="logo-box">L</div>
    <div class="logo-name">LIAS<small>Faculté des Sciences Ben M'Sik</small></div>
  </div>

  <h2>Connexion</h2>
  <p class="subtitle">Accédez à votre espace de gestion</p>

  <% if(request.getParameter("erreur") != null){ %>
  <div class="error-msg">Email ou mot de passe incorrect. Veuillez réessayer.</div>
  <% } %>

  <form action="login" method="post">
    <div class="form-group">
      <label>Adresse email</label>
      <input type="email" name="email" placeholder="votre@email.ma" required autofocus>
    </div>
    <div class="form-group">
      <label>Mot de passe</label>
      <input type="password" name="motDePasse" placeholder="••••••••" required>
    </div>
    <button type="submit" class="btn-login">Se connecter</button>
  </form>
  <div class="form-footer">© 2026 Université Hassan II — Laboratoire LIAS</div>
</div>

</body>
</html>
