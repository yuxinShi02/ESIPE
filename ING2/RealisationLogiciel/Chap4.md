# Diagramme UML
Pour MOA:
- UC Diagram
- Activity Diagram

Pour MOE
- Sequence Diagram
- Classe Diagram
- Package Diagram

## Architecture logicielle
- Composant Diagram : l'architecture est definie par un ensemble de composants et de relation entre eux.


## StarUML
Un composant contrient un ensemble de classes. Il a un état:
1. Lors de la livraison: le format du composant est un jar.
2. Lors de l'installation: le client doit disposer d'un serveur par exemple: Tomcat.
3. Lors de l'exécution; un composant peut être invoqué par une requête http. Par exemple: http://localhost:8080/exemple, Le serveur qui execute le port 8080 resoît le requête et déclenche la classe principale du composant qui traite la requête du client. Dans le cas d'une application Web; la classe principale est appelée Front Controller, c'est une servlet http.
4. Un composant doit toujours exposer une interface. Elle joue le rôle de content de service avec les usagers. Cest une obligation de codage.
5. Structurer son application en composants permet de distribuer sur plusieurs machine. Donc les machines se répartissent la charge du travail de l'application. Construire un diagramme de composant en UML, c'est découper par le projet global en sous projet(un par composant). Les interface présentes sur le diagramme de composants doivent apparaître sur le diagramme de classes. Il y aura 3 projets de developpement avec IDE et Maven, un par composant; le resultat du travail de Maven est un jar.(Déclarer dans le pom.xml et packaging)


## L'architecture materielle
Deployement diagramme  
Le diagramme de deployement représente les machines; les logiciels utiles sur ces machines, le réseau et ces capacités de chacun d'eux représente une machine susceptible de recevoir un composant lors de la phase d'installation elle doit disposer d'un nom unique, une liste de logiciels en cours d'éxécution et de ports d'écoute(interface réseau)

## Réalisation logicielle
BUt: Construire un composant = créer un projet Maven et utiliser sur cycle de vie(phase install) pour un livrable = un fichier avec un Manifest.
Le développement des méthodes est obtenu par lecture des diagrammes de séquence.
