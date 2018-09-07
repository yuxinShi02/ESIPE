`Editor: Yuxin SHI`
`SI 2 FISE`
# Compte rendue : Outils pour cycle de vie Logiciel
## Sujet: Gestion d'une application Rest de reservation de terrain de mini-foot

1. Donner le diagramme de cas d'utilisation associe.
![](TPFinUC.png)

2. En s'appuyant sur le principe de l'heritage ou de multi-modules vues dans le cours. Donnez le graphe de dependances associees.
![](TPFinDpd.png)
3. Donnez un exemple de dependance transitive presente dans votre graphe et expliquez pourquoi.
> Selon de graphe, la ligne rouge est une dependance transitive, parceque Service est dependant de Controller et Common, Controller est dependant de Common aussi, donc Service depends de Controller ca suffit, dans ce module on peut utiliser Common.

4. Cloner le depot.
```bash
$ git clone git@192.168.1.187:/opt/git/repositories/test.git
```
5. Creer une branche et en basculer.
```bash
$ git checkout -b b1_shi
```
6. Reserver un terrain

7. Implementer deux tests unitaires.
![](TPFINTU.png)
8. git checkout -b b2_shi
9. Merge b2 avec b1
```
$ git add * && git commit -m "before merge"
$ git merge b1_shi
```
10. Ajouter une dependance et push a distance
![](TPFinGitPush.png)

11. Add tag
![](TPFinTag.png)
12. Serveur d'integration continue
![](TPFinConfigJK.png)
![](TPFinConfigJK1.png)

13. Error of compilation Junit
![](TPFinRes.png)

14. Envoyer a distance serveur(J'ai une version reussie, donc j'utilise celle d'avant:http://192.168.4.187:8080/job/esipeMavenYuxin/configure)
![](TPFinConfigJK2.png)

15 SonarQube Configuration
![](TPFinConfigJK3.png)
