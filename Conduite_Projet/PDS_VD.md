# Analyse de Vision Doc
## Volume-metric
### Connections simultanement
La population de Paris(75, 92, 93, 94):1 081 697  
https://www.paris.fr/actualites/a-paris-seuls-22-des-conducteurs-ont-reellement-besoin-d-un-vehicule-3876

A paris, les menages disposant une voiture est faible, les parisiens ont besoin de vehicule dans ce cas la, mais grace aux reseaux de transports, il est plus pratique de prendre les transports en commun.
Les transports en commun ne sont pas tout-puissant. Par exemple, les voyages familials, les utilisateurs individuels etc.
![](http://transports.blog.lemonde.fr/files/2015/04/Taux-motorisation-2.jpg)

Prend reference de Ubeeqo, elle a 110+ points de garage a Paris, chaque point de garage a une volume de 7-18 capacites. Posons qu'on a 5*110 = 550 voitures, et 2000 velos a la base.       
Le max nombre de connection simultanement est 1081697 * 0.7 * 0.001= 757.   
Et pour le serveur de HTTP, on utilise Tomcat, son default connections simultanement est 10000, il est largement suffisant.
