<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="model.DemandeAdhesion" %>

<%
if(session.getAttribute("user") == null){
    response.sendRedirect("login.jsp");
    return;
}

List<DemandeAdhesion> demandes =
(List<DemandeAdhesion>) request.getAttribute("demandes");

request.setAttribute("currentPage","demandes");
%>

<!DOCTYPE html>
<html lang="fr">
<head>
<meta charset="UTF-8">
<title>Demandes d'adhésion — LIAS</title>

<%@ include file="/WEB-INF/style.jsp" %>

</head>

<body>

<%@ include file="/WEB-INF/sidebar.jsp" %>

<main class="main">

<div class="page-header">
    <h1>Demandes d'adhésion</h1>
    <p>Validation des demandes d'intégration au laboratoire</p>
</div>

<% if("ok".equals(request.getParameter("action"))){ %>

<div class="alert alert-success">
La demande a été traitée avec succès.
</div>

<% } %>

<div class="card">

<div class="table-wrap">

<table>

<thead>

<tr>
    <th>Demandeur</th>
    <th>Email</th>
    <th>Établissement</th>
    <th>Motivation</th>
    <th>Statut</th>
    <th>Actions</th>
</tr>

</thead>

<tbody>

<%
if(demandes != null && !demandes.isEmpty()){

for(DemandeAdhesion d : demandes){

String statut = d.getStatut();

String badge = "badge-amber";
String texte = "En attente";

if("ACCEPTE".equals(statut)){
    badge = "badge-green";
    texte = "Acceptée";
}
else if("REFUSE".equals(statut)){
    badge = "badge-red";
    texte = "Refusée";
}
%>

<tr>

<td>
<strong>
<%= d.getPrenom() %> <%= d.getNom() %>
</strong>
</td>

<td>
<%= d.getEmail() %>
</td>

<td>
<%= d.getEtablissement() %>
</td>

<td>
<%= d.getMotivation() %>
</td>

<td>

<span class="badge <%= badge %>">
<%= texte %>
</span>

</td>

<td>

<% if("EN_ATTENTE".equals(statut)){ %>

<form action="listeDemandes" method="post" style="display:inline;">

<input type="hidden" name="id" value="<%= d.getId() %>">

<input type="hidden" name="decision" value="accepter">

<button
class="btn btn-primary btn-sm"
type="submit"
onclick="return confirm('Accepter cette demande ?')">

✓ Accepter

</button>

</form>

<form action="listeDemandes" method="post" style="display:inline;">

<input type="hidden" name="id" value="<%= d.getId() %>">

<input type="hidden" name="decision" value="refuser">

<button
class="btn btn-danger btn-sm"
type="submit"
onclick="return confirm('Refuser cette demande ?')">

✕ Refuser

</button>

</form>

<% }else{ %>

<span style="color:gray;">
Traitée
</span>

<% } %>

</td>

</tr>

<%
}

}else{
%>

<tr>

<td colspan="6">

<div class="empty-state">

<div class="es-icon">📋</div>

<h3>Aucune demande en attente</h3>

<p>Les nouvelles demandes apparaîtront ici.</p>

</div>

</td>

</tr>

<%
}
%>

</tbody>

</table>

</div>

</div>

</main>

</body>

</html>