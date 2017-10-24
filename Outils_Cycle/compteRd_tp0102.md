`Editor: Yuxin SHI`   
`SI 2 FISE`
# Compte rendue : Outils pour cycle de vie Logiciel
## TP01
Selon le guide et grace à eclipse on peut créer un projet maven rapidement.
Normalement Eclipse EE est déjà integré Maven outil. Dans le fichier pom.xml on va définir les paramètres nécéssaires pour le projet, par example __modelVersion, groupId, artifactId et les dependencies__.
<br/>
![](/home/tearsyu/Pictures/cycletp1.png)

Quand on savegarde les modifications de pom.xml, eclipse detecte automatiqueses modifications et le recompile.

## TP2 Application Spring boot : WS REST
1. Crée un projet maven pour implémenter les fonctionnalités du cas‘
gestion de la réservation’ basé sur le principe de l’héritage vu dans le cours.  

Ceci les configurations de maven:   
- Lib de springboot framework
- Mybatis pour la couche persistance
- Driver jdbc pour mysql
- Plugin spring boot
![](/home/tearsyu/Pictures/pom_spring.png)
![](/home/tearsyu/Pictures/pom_springboot2.png)

Ceci la structure du projet:   
![](/home/tearsyu/Pictures/structure_boot.png)
2. Implémenter une fonctionnalité de votre choix pour l’utilisateur.   
**La fonctionnalité que je vais implementer est "consulter les reservations."**
Mais dans cette étape là, je fais un test du serveur REST il y a un erreur:
```bash
# curl -i http://localhost:8080/reserv?name=info1
HTTP/1.1 500
Content-Type: application/json;charset=UTF-8
Transfer-Encoding: chunked
Date: Tue, 24 Oct 2017 08:59:12 GMT
Connection: close
```
```json
{"timestamp":1508835551967,
  "status":500,
  "error":"Internal ServerError",
  "exception":"java.lang.NullPointerException",
  "message":"No message available",
  "path":"/reserv"}
```
Il me semble que la méthode de créer la requêtte à la base de données ou recupérer l'info depuis la base de données capture un NullPointerException. Et j'ai pas réussi à résoudre.   
 
a. Ajouter les dépendances nécessaires pour votre client-serveur rest
.
b. Afficher les dépendances transitives.
3. Générer les packages de livraison.
4. Démarrer localement les deux jars (client – serveur Rest)
