<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
if (session.getAttribute("user") == null) { response.sendRedirect("login.jsp"); return; }
%>
<!DOCTYPE html>
<html lang="fr">
<head>
<meta charset="UTF-8">
<title>Calendrier — LIAS</title>
<%@ include file="/WEB-INF/style.jsp" %>
<!-- FullCalendar CDN -->
<link href="https://cdnjs.cloudflare.com/ajax/libs/fullcalendar/6.1.10/index.global.min.css" rel="stylesheet">
<script src="https://cdnjs.cloudflare.com/ajax/libs/fullcalendar/6.1.10/index.global.min.js"></script>
<style>
#calendrier {
    background: white;
    padding: 20px;
    border-radius: 16px;
}
.fc-toolbar-title {
    font-size: 18px !important;
    font-weight: 700 !important;
    color: var(--dark) !important;
}
.fc-button {
    background: var(--blue) !important;
    border-color: var(--blue) !important;
    font-size: 13px !important;
}
.fc-button:hover {
    background: #1D4ED8 !important;
}
.fc-daygrid-event {
    border-radius: 6px !important;
    font-size: 12px !important;
    padding: 2px 6px !important;
}
/* Popup détail */
#eventPopup {
    display: none;
    position: fixed;
    z-index: 9999;
    background: white;
    border-radius: 14px;
    padding: 20px 24px;
    box-shadow: 0 20px 60px rgba(0,0,0,0.2);
    min-width: 280px;
    max-width: 340px;
}
#eventPopup h3 {
    margin: 0 0 10px 0;
    font-size: 16px;
    color: var(--dark);
}
#eventPopup .detail-row {
    font-size: 13px;
    color: var(--text-muted);
    margin-bottom: 6px;
    display: flex;
    gap: 8px;
}
#eventPopup .close-btn {
    position: absolute;
    top: 12px; right: 14px;
    border: none; background: none;
    font-size: 18px; cursor: pointer;
    color: var(--text-muted);
}
</style>
</head>
<body>
<%@ include file="/WEB-INF/sidebar.jsp" %>

<main class="main">
  <div class="page-header page-header-row">
    <div>
      <h1>Calendrier des événements</h1>
      <p>Visualisation mensuelle de toutes les activités du laboratoire</p>
    </div>
    <a href="ajouterEvenement.jsp" class="btn btn-primary">+ Nouvel événement</a>
  </div>

  <!-- Légende -->
  <div style="display:flex;gap:20px;margin-bottom:20px;flex-wrap:wrap;">
    <div style="display:flex;align-items:center;gap:6px;font-size:13px;">
      <span style="width:14px;height:14px;border-radius:3px;background:#9333EA;display:inline-block;"></span>
      Conférence
    </div>
    <div style="display:flex;align-items:center;gap:6px;font-size:13px;">
      <span style="width:14px;height:14px;border-radius:3px;background:#16A34A;display:inline-block;"></span>
      Séminaire
    </div>
    <div style="display:flex;align-items:center;gap:6px;font-size:13px;">
      <span style="width:14px;height:14px;border-radius:3px;background:#D97706;display:inline-block;"></span>
      Workshop
    </div>
    <div style="display:flex;align-items:center;gap:6px;font-size:13px;">
      <span style="width:14px;height:14px;border-radius:3px;background:#2563EB;display:inline-block;"></span>
      Autre
    </div>
  </div>

  <!-- Calendrier -->
  <div class="card" style="padding:20px;">
    <div id="calendrier"></div>
  </div>
</main>

<!-- Popup détail événement -->
<div id="eventPopup">
  <button class="close-btn" onclick="fermerPopup()">✕</button>
  <h3 id="popupTitre"></h3>
  <div class="detail-row"><span>📌</span><span id="popupType"></span></div>
  <div class="detail-row"><span>📍</span><span id="popupLieu"></span></div>
  <div class="detail-row"><span>📅</span><span id="popupDates"></span></div>
</div>

<script>
document.addEventListener('DOMContentLoaded', function () {
    var calEl = document.getElementById('calendrier');

    var calendar = new FullCalendar.Calendar(calEl, {
        initialView: 'dayGridMonth',
        locale: 'fr',
        headerToolbar: {
            left: 'prev,next today',
            center: 'title',
            right: 'dayGridMonth,timeGridWeek,listMonth'
        },
        buttonText: {
            today: "Aujourd'hui",
            month: 'Mois',
            week: 'Semaine',
            list: 'Liste'
        },
        events: '<%=request.getContextPath()%>/api/evenements',
        eventClick: function(info) {
            var e = info.event;
            var props = e.extendedProps;

            document.getElementById('popupTitre').textContent = e.title;
            document.getElementById('popupType').textContent = props.type || '—';
            document.getElementById('popupLieu').textContent = props.lieu || '—';

            var debut = e.start ? e.start.toLocaleDateString('fr-FR') : '—';
            var fin   = e.end   ? e.end.toLocaleDateString('fr-FR')   : debut;
            document.getElementById('popupDates').textContent =
                debut === fin ? debut : debut + ' → ' + fin;

            var popup = document.getElementById('eventPopup');
            popup.style.display = 'block';
            popup.style.top  = (info.jsEvent.clientY - 20) + 'px';
            popup.style.left = (info.jsEvent.clientX + 10) + 'px';

            // Ajustement bord droit
            var rect = popup.getBoundingClientRect();
            if (rect.right > window.innerWidth - 20) {
                popup.style.left = (info.jsEvent.clientX - rect.width - 10) + 'px';
            }
        }
    });

    calendar.render();

    // Fermer popup en cliquant ailleurs
    document.addEventListener('click', function(ev) {
        var popup = document.getElementById('eventPopup');
        if (!popup.contains(ev.target) && popup.style.display === 'block') {
            fermerPopup();
        }
    });
});

function fermerPopup() {
    document.getElementById('eventPopup').style.display = 'none';
}
</script>
</body>
</html>