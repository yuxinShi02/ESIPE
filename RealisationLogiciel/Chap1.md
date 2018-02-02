`Editor: Yuxin`
# Logiciel

Il y a 2 dragram d'architecture...:
- Composant Diagram: il decrit l'architecture logicielle du projet il y a autant de composant que de projet Eclipse/Maven. Le but d'un projet est de fournir livrable au client. Le diagramme de composant peut  de decrire le contenue, la format du livrable.  Par ex: Le composant , le contenue , le package et  pour format war.
- Deployemnt Diagram: il decrit l'architecture logicille du rojet.  Il y a autant du diagramme de deploiment quil y a de client a ce projet. (Avec les clients, le reseau, les logiciel deja installe, base du donnees, serveur...)

Grace a ces 2 types du diagramme, il est possible de decrire l'installation du futur logiciel sur le reseau du client.

Cependant: le but est de definir un futur script d'utilisation du logiciel afin d'automatiser les taches.
Probleme a modeliser: sur le site de la poste, des documents sont fournis par calculer le prix des officielle nette de lettre et de colis. Il est demande de realiser le developpement d'un logiciel pour une machine a officielle qui serait installe dans un bureau de poste.

# Architecture logicielle
Une application doit respecter une architecture. Celle-ci est définie au début du projet. Son but est d'assurer la maintenance, l'évolutivité, éventuellement d'autres propriétés par fonctionnelles.
- Il existe des design pattern d'architecture. Oracle a défini un pattern nommé Layers pattern qui stipule et découpe en 5 couche au tiers. Il est possible lorsque ce choix d'architecture est fait, de faire apparaître cette architecture des les diagrammes d'activité par l'emploi de swimlane (=couche tier)
- Génerationement ce découpage "multi layer" s'adapte à ce nombreux applications: par ex: par les application web. En générale, le découpage permet ensuite d'appliquer un framework logiciel par couche.
- 
