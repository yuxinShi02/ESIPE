# Class Diagram

But de diagramme:    
mettre des relations autres class => créer les parties privées constrint des classes abstraites et des interfaces(utils au diagramme du composants).

Notation:   
On utilise 6 relations possibles.   
a. Association orientée: elle amène le génération d'un attribut dans la classe placée à l'origine de l'association. Le concepteur édoit ajouter un nom de rôle à l'extrémité de l'association éventuellement une coordinalité à l'extrémité de l'association.

> 1. Quand crée t on des attributs et quand crée-t-on une association?   
On place en attribut d'une classe, uniquements des données de type élémentaire: int, float, string..
Si une lettre a un format alors que les classes lettre et format sont présentes sur la diagramme des classes alors il est indispensable et faire une association orientée depuis le Lettre vers la classe Format.  
Un nom du rôle tel que format signifie que la classe Lettre possède un attribut nommé format de type Format. Par défault la cardinalité est toujours de 1.

b. L'agrégation: elle signifie qu'une classe est structurée à partir d'autres classe. Tout objet de la classe ) l'origine de l'agrégation est constitué de plusieurs objets de classes situées à l'extrémité de la relation.

c. La composition: ces particulier de l'agrégation, elle ajoute une contrainte supplémentaire qui stipule que les objets situés aux extrémité des flèches de composition, ne peuvent changer.   
_Un contrat d'assurance est crée pour un Assuré. Il n'est pas possible de changer la valeur de l'attribut propriétaire. C'est une constante initialisée à la création du l'objet du type ContratASSURANCE._

d. La relation d'héritage: c'est une relation entre type de données. La classe Enfant hérite de tout ce que possible de classe Parent sauf:
  1. constructeur/destructeur
  2. operation d'éffectuation.

e. La relation de réalisation.(虚线+箭头)   
Parmi toutes les classes, il en existe certaines qui ne sont pas instanciable, ce sont des classes abtraites.    
_Un stéréotype permet d'ajouter un qualificatif à une classe ou à toute notion UML en général._

Il existe un cas particulier de classe abstraite: interface.

f. Relation de dépendance: elle exrime qu'une classe a besoin d'une autre au cours d'une éxécution. Mais elle n'entraine aucune génération attribut. En revenche, elle imposse que ces 2 classes appartient au même composant.   

## Désign Pattern
- GoF pattern
  - Patterns de création
  - pattern de structure
  - pattern de comportement
