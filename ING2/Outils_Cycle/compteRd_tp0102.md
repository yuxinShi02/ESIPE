`Editor: Yuxin SHI`
`SI 2 FISE`
# Compte rendue : Outils pour cycle de vie Logiciel
## TP01
Selon le guide et grace à eclipse on peut créer un projet maven rapidement.
Normalement Eclipse EE est déjà integré Maven outil. Dans le fichier pom.xml on va définir les paramètres nécéssaires pour le projet, par example __modelVersion, groupId, artifactId et les dependencies__.
<br/>
![](maven0.png)

Quand on savegarde les modifications de pom.xml, eclipse detecte automatiqueses modifications et le recompile.

## TP2 Application Spring boot : WS REST
1. Crée un projet maven pour implémenter les fonctionnalités du cas‘
gestion de la réservation’ basé sur le principe de l’héritage vu dans le cours.

Ceci les configurations de maven:
- Lib de springboot framework
- JPA pour la couche persistance
- Driver jdbc pour mysql
- Plugin spring boot
![](maven1.png)

Ceci la structure du projet:
![](structure.png)
2. Implémenter une fonctionnalité de votre choix pour l’utilisateur.
**La fonctionnalité que je vais implementer est "consulter les reservations."**
Mais dans cette étape là, je fais un test du serveur REST il y a un erreur:
```bash
# curl -i http://localhost:8080/reserv/src/1
HTTP/1.1 500
Content-Type: application/json;charset=UTF-8
Transfer-Encoding: chunked
Date: Tue, 24 Oct 2017 08:59:12 GMT
Connection: close

{
    "timestamp": 1508881513632,
    "status": 500,
    "error": "Internal Server Error",
    "exception": "org.springframework.dao.InvalidDataAccessApiUsageException",
    "message": "org.hibernate.hql.internal.ast.QuerySyntaxException: reservation is not mapped [FROM reservation as rsv ORDER BY rsv.id]; nested exception is java.lang.IllegalArgumentException: org.hibernate.hql.internal.ast.QuerySyntaxException: reservation is not mapped [FROM reservation as rsv ORDER BY rsv.id]",
    "path": "/reserv/src"
}

ou {}

rien du tout avec le chemin "/reserv/1" == /reserv/{id}
```
Je ne sais pas pourquoi il n'arrive pas a mapping..j'ai pas resolu ce bug.

a. Ajouter les dépendances nécessaires pour votre client-serveur rest
.

b. Afficher les dépendances transitives.
3. Générer les packages de livraison.
4. Démarrer localement les deux jars (client – serveur Rest)
