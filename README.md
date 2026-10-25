# GestionLaboratoireLIAS

Java EE web application to manage a research laboratory (LIAS): members, teams, publications, events, equipment, documents, agreements, meeting minutes, messaging and reports.

## Tech stack
- Java 17
- Jakarta Servlet / JSP (Tomcat 10.1)
- MySQL (JDBC driver included in `WEB-INF/lib`)
- iText 7 (PDF report export)

## Main features
- Role-based access control (ADMIN, DIRECTEUR, MEMBRE) enforced server-side by `AuthFilter`
- Management of members, teams, publications, events and calendar
- Equipment inventory and equipment requests
- Documents, agreements (conventions), meeting minutes (PV), mandates
- Messaging and notifications
- Membership requests (public form)
- PDF report export

## Project structure
```
src/main/java/
  controller/   Servlets
  dao/          Database access
  model/        Entities
  filter/       Authentication and authorization filter
src/main/webapp/
  *.jsp         Views
  WEB-INF/      web.xml, shared JSP fragments, libraries
```

## Configuration
Database credentials are read from environment variables (never hard-coded):

| Variable | Default |
|---|---|
| `LIAS_DB_URL` | `jdbc:mysql://localhost:3306/lias?useUnicode=true&characterEncoding=UTF-8&serverTimezone=UTC` |
| `LIAS_DB_USER` | `root` |
| `LIAS_DB_PASSWORD` | *(empty)* |

## Run locally
1. Create the MySQL database `lias` and import the SQL schema.
2. Set the environment variables above.
3. Import the project in Eclipse (Dynamic Web Project), target Tomcat 10.1, then `Project > Clean`.
4. Deploy on Tomcat and open `http://localhost:8080/GestionLaboratoireLIAS/`.

## Authors
aya moujoud 
