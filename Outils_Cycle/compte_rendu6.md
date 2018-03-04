`Editor: Yuxin SHI`
`SI 2 FISE`
# Compte rendue : Outils pour cycle de vie Logiciel
## TP6 Jenkins

Ajouter un US, modifier un planning, ceci le resultat de test JUnit:
![](codejunit.png)
![](testres.png)

En suite, on le push sur a distance en deployant sur jenkins:
![](jenkinsres1.png)
Mais je comprend pas pourquoi le temps de compilation moduleServer est si long.
![](jenkinsres2.png)

Executer a distance:
La commande que j'ai ajoute dans jenkins:
```bash
java -jar /home/guest/deploy/moduleServer-0.0.1-SNAPSHOT
& java -jar /home/guest/deploy/moduleCommon-0.0.1-SNAPSHOT
```
Mais ca ne fonctionne pas:
![](jenkensres3.png)

Vue que je ne peux pas acceder a cette machine et que jenkins ne retourne pas le resultat, il est difficile de comprendre pourquoi l'exception: unable to access jarfile. 
