```jsp
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Présentation du projet - LIAS</title>

    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: Arial, sans-serif;
            background: #f4f7fc;
            color: #263449;
            line-height: 1.8;
        }

        header {
            background: #0B1F45;
            color: white;
            padding: 25px 8%;
        }

        header h1 {
            font-size: 30px;
            margin-bottom: 5px;
        }

        header p {
            color: #dbeafe;
        }

        nav {
            background: #163565;
            padding: 14px 8%;
            display: flex;
            flex-wrap: wrap;
            gap: 22px;
        }

        nav a {
            color: white;
            text-decoration: none;
            font-weight: bold;
        }

        nav a:hover {
            color: #93c5fd;
        }

        .hero {
            background: linear-gradient(135deg, #0B1F45, #2563EB);
            color: white;
            padding: 55px 8%;
            text-align: center;
        }

        .hero h2 {
            font-size: 34px;
            margin-bottom: 18px;
        }

        .hero p {
            max-width: 850px;
            margin: auto;
            font-size: 17px;
        }

        .container {
            max-width: 1100px;
            margin: 35px auto;
            padding: 0 20px;
        }

        .section {
            background: white;
            padding: 28px;
            margin-bottom: 25px;
            border-radius: 12px;
            box-shadow: 0 4px 14px rgba(15, 35, 70, 0.08);
        }

        .section h2 {
            color: #0B1F45;
            margin-bottom: 15px;
            font-size: 24px;
        }

        .section p {
            margin-bottom: 13px;
            text-align: justify;
        }

        .cards {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(220px, 1fr));
            gap: 20px;
            margin-top: 20px;
        }

        .card {
            background: #f8faff;
            border-left: 5px solid #2563EB;
            border-radius: 8px;
            padding: 20px;
        }

        .card h3 {
            color: #163565;
            margin-bottom: 10px;
        }

        .card p {
            margin: 0;
            text-align: left;
        }

        .highlight {
            background: #eff6ff;
            border-left: 5px solid #2563EB;
            padding: 18px;
            border-radius: 8px;
            margin-top: 15px;
        }

        .highlight p {
            margin: 0;
        }

        ul {
            padding-left: 25px;
        }

        li {
            margin-bottom: 10px;
        }

        .button {
            display: inline-block;
            background: #2563EB;
            color: white;
            text-decoration: none;
            padding: 12px 24px;
            border-radius: 7px;
            margin-top: 15px;
            font-weight: bold;
        }

        .button:hover {
            background: #1d4ed8;
        }

        footer {
            background: #0B1F45;
            color: white;
            text-align: center;
            padding: 22px;
            margin-top: 40px;
        }

        @media (max-width: 600px) {
            .hero h2 {
                font-size: 26px;
            }

            .section {
                padding: 20px;
            }

            header h1 {
                font-size: 25px;
            }
        }
    </style>
</head>

<body>

<header>
    <h1>LIAS</h1>
    <p>Plateforme de gestion et de valorisation des activités de l'association</p>
</header>

<nav>
    <a href="index.jsp">Accueil</a>
    <a href="presentation.jsp">Présentation</a>
    <a href="listeEquipes">Équipes</a>
    <a href="listeEvenements">Événements</a>
    <a href="listePublications">Publications</a>
    <a href="demandeAdhesion.jsp">Adhérer</a>
</nav>

<section class="hero">
    <h2>Bienvenue dans l'univers de LIAS</h2>
    <p>
        LIAS est un projet qui vise à faciliter la gestion des activités,
        à améliorer la communication entre les membres et à mettre en valeur
        les différentes initiatives de l'association grâce à une plateforme
        web simple, moderne et accessible.
    </p>
</section>

<main class="container">

    <section class="section">
        <h2>1. Présentation générale</h2>

        <p>
            Dans un environnement où les outils numériques occupent une place
            de plus en plus importante, la gestion des activités associatives
            nécessite des solutions efficaces, organisées et faciles à utiliser.
            Les informations concernant les membres, les événements et les
            publications doivent pouvoir être consultées et mises à jour de
            manière claire.
        </p>

        <p>
            C'est dans cette perspective que s'inscrit le projet LIAS.
            L'objectif est de proposer une plateforme web qui centralise les
            principales informations de l'association et facilite l'accès
            aux différents services proposés aux visiteurs, aux membres et
            aux responsables.
        </p>

        <p>
            La plateforme offre un espace organisé dans lequel les utilisateurs
            peuvent découvrir les activités de l'association, consulter les
            événements et les publications, ainsi que demander à rejoindre
            la communauté.
        </p>
    </section>

    <section class="section">
        <h2>2. Problématique</h2>

        <p>
            La gestion manuelle des informations peut entraîner plusieurs
            difficultés : dispersion des données, perte de temps lors de la
            recherche d'informations, difficulté à suivre les demandes
            d'adhésion et manque de visibilité sur les activités organisées.
        </p>

        <p>
            Il devient donc nécessaire de disposer d'un espace centralisé
            permettant de présenter les informations de façon structurée et
            de simplifier certaines opérations de gestion.
        </p>

        <div class="highlight">
            <p>
                <strong>Problématique principale :</strong>
                comment concevoir une application web qui facilite l'accès
                aux informations de l'association et améliore la gestion
                de ses membres et de ses activités ?
            </p>
        </div>
    </section>

    <section class="section">
        <h2>3. Objectifs du projet</h2>

        <p>Le projet LIAS poursuit plusieurs objectifs importants :</p>

        <div class="cards">
            <div class="card">
                <h3>Centralisation</h3>
                <p>
                    Regrouper les informations essentielles de l'association
                    dans une seule plateforme.
                </p>
            </div>

            <div class="card">
                <h3>Communication</h3>
                <p>
                    Faciliter la diffusion des actualités, des publications
                    et des événements.
                </p>
            </div>

            <div class="card">
                <h3>Gestion des adhésions</h3>
                <p>
                    Permettre aux visiteurs de soumettre une demande
                    d'adhésion et faciliter son suivi.
                </p>
            </div>

            <div class="card">
                <h3>Accessibilité</h3>
                <p>
                    Proposer une interface claire, compréhensible et adaptée
                    aux différents utilisateurs.
                </p>
            </div>
        </div>
    </section>

    <section class="section">
        <h2>4. Fonctionnalités principales</h2>

        <p>
            La plateforme est organisée autour de plusieurs fonctionnalités
            complémentaires, destinées à répondre aux besoins des visiteurs,
            des membres et des responsables de l'association.
        </p>

        <ul>
            <li>
                <strong>Page d'accueil :</strong>
                présente la plateforme et donne accès aux principales rubriques.
            </li>

            <li>
                <strong>Présentation :</strong>
                explique le contexte, les objectifs et l'intérêt du projet.
            </li>

            <li>
                <strong>Gestion des équipes :</strong>
                permet de consulter les informations relatives aux équipes,
                selon les données disponibles dans l'application.
            </li>

            <li>
                <strong>Événements :</strong>
                permet de découvrir les activités organisées ou annoncées
                par l'association.
            </li>

            <li>
                <strong>Publications :</strong>
                rassemble les informations et les contenus publiés.
            </li>

            <li>
                <strong>Demande d'adhésion :</strong>
                permet à un visiteur de transmettre ses informations et sa
                motivation pour rejoindre l'association.
            </li>

            <li>
                <strong>Espace d'administration :</strong>
                peut permettre aux responsables autorisés de consulter et
                de traiter les demandes d'adhésion, selon les fonctionnalités
                effectivement développées.
            </li>
        </ul>
    </section>

    <section class="section">
        <h2>5. Les utilisateurs de la plateforme</h2>

        <p>
            L'application peut distinguer plusieurs catégories d'utilisateurs
            afin de mieux organiser les accès et les responsabilités.
        </p>

        <div class="cards">
            <div class="card">
                <h3>Visiteurs</h3>
                <p>
                    Ils peuvent découvrir l'association, consulter les
                    informations publiques et envoyer une demande d'adhésion.
                </p>
            </div>

            <div class="card">
                <h3>Membres</h3>
                <p>
                    Ils représentent les personnes appartenant à l'association.
                    Les services qui leur sont accessibles dépendent des
                    fonctionnalités mises en place.
                </p>
            </div>

            <div class="card">
                <h3>Administrateurs</h3>
                <p>
                    Ils sont chargés des opérations de gestion autorisées,
                    notamment le suivi des demandes et la mise à jour des
                    informations, lorsque ces fonctions sont disponibles.
                </p>
            </div>
        </div>
    </section>

    <section class="section">
        <h2>6. Technologies utilisées</h2>

        <p>
            Le projet s'appuie sur les technologies du développement web Java
            EE, aujourd'hui également associé à l'écosystème Jakarta EE,
            pour structurer l'application et organiser son fonctionnement.
        </p>

        <ul>
            <li>
                <strong>JSP (JavaServer Pages) :</strong>
                permet de construire les pages web et d'afficher les
                informations destinées aux utilisateurs.
            </li>

            <li>
                <strong>HTML :</strong>
                structure le contenu des pages.
            </li>

            <li>
                <strong>CSS :</strong>
                assure la mise en forme, les couleurs, la disposition des
                éléments et l'adaptation aux différents écrans.
            </li>

            <li>
                <strong>Java :</strong>
                peut gérer la logique métier de l'application à travers
                les composants Java prévus dans le projet.
            </li>

            <li>
                <strong>Apache Tomcat :</strong>
                permet d'exécuter l'application web Java et de traiter
                les pages JSP.
            </li>

            <li>
                <strong>MySQL :</strong>
                peut servir à stocker les informations persistantes de
                l'application, selon la configuration de la base de données.
            </li>
        </ul>

        <div class="highlight">
            <p>
                Les pages JSP correspondent à la partie visible de
                l'application. Pour enregistrer réellement des données,
                interroger la base ou traiter des demandes, elles doivent
                être reliées aux composants Java et aux mécanismes d'accès
                aux données prévus dans le projet.
            </p>
        </div>
    </section>

    <section class="section">
        <h2>7. Avantages attendus</h2>

        <p>
            La mise en place de LIAS présente plusieurs avantages. Elle permet
            d'abord de rendre les informations plus faciles à trouver et à
            consulter. Elle contribue également à structurer les demandes
            d'adhésion et à améliorer la visibilité des activités de
            l'association.
        </p>

        <p>
            En regroupant les différentes rubriques dans une interface unique,
            la plateforme peut réduire certaines tâches répétitives et rendre
            les informations plus accessibles. Son organisation modulaire
            permet aussi d'envisager l'ajout de nouvelles fonctionnalités
            en fonction des besoins futurs.
        </p>
    </section>

    <section class="section">
        <h2>8. Conclusion et perspectives</h2>

        <p>
            En conclusion, LIAS représente une solution web destinée à
            organiser et à valoriser les informations et les activités de
            l'association. Le projet met l'accent sur la centralisation des
            contenus, l'accessibilité de l'interface et la simplification
            de certaines opérations de gestion.
        </p>

        <p>
            À l'avenir, la plateforme pourrait évoluer avec l'ajout de
            fonctionnalités complémentaires, telles que des notifications,
            une recherche avancée, des outils de suivi des activités ou un
            espace personnel pour les membres, si ces évolutions correspondent
            aux besoins du projet.
        </p>

        <p>
            L'objectif final est de disposer d'une application claire,
            évolutive et adaptée aux besoins de ses utilisateurs.
        </p>

        <a href="index.jsp" class="button">Retour à l'accueil</a>
        <a href="demandeAdhesion.jsp" class="button">Demander une adhésion</a>
    </section>

</main>

<footer>
    <p>&copy; 2026 LIAS - Plateforme de gestion associative</p>
</footer>

</body>
</html>
```