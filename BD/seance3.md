# <center>Compte Rendue --- Sauvegarde et récupération
</center>
<center>Yuxin SHI</center>   
<br/>

##  Archivage
1. Écrivez un ordre SQL permettant d’afficher le nom de tous les fichiers physiques de votre base.
```sql
SELECT c.name, l.member, d.name
FROM V$CONTROLFILE c, V$LOGFILE l, V$DATAFILE d;
```
2. Réutilisez le résultat du point 1 pour écrire un script destiné à réaliser la sauvegarde complète de votre base de données fonctionnant en mode noarchivelog.
```sql
--With this sql request we know that database is in mode noarchivelog
SELECT log_mode FROM sys.v$databse;
```
![](/home/tearsyu/Pictures/tp3_12.png)    
With mode NOARCHIVELOG:
- NOARCHIVELOG mode protects a database from instance failure but not from media failure. Only the most recent changes made to the database, which are stored in the online redo log groups, are available for instance recovery.
- If a media failure occurs while the database is in NOARCHIVELOG mode, you can only restore the database to the point of the most recent full database backup. You cannot recover transactions subsequent to that backup.       
<br/>
There are two ways to create a backup noarchivelog:
- By sql, I didn't find doc with this way, so I will choose second one.
- By bash script, I just copy all the file of XE that I find in EXO1.
```bash
# For datafile and control file
$ sudo cp $ORACLE_BASE/oradata/XE/* $ORACLE_BASE/backup/XE/
$ sudo cp $ORACLE_HOME/dbs/tb_td1.dbf $ORACLE_BASE/backup/XE/dbs/
$ sudo cp $ORACLE_HOME/dbs/users.dbf $ORACLE_BASE/backup/XE/dbs/
# For log file
$ sudo cp $ORACLE_BASE/fast_recovery_area/XE/onlinelog/o1_mf_2_dwdnm14d_.log $ORACLE_BASE/backup/XE/log/
# For init file
$ sudo cp $ORACLE_HOME/dbs/initXE.ora $ORACLE_BASE/backup/dbs/
$ sudo cp $ORACLE_HOME/dbs/spfileXE.ora $ORACLE_BASE/backup/dbs/

```
3. Faire passer une base de données du mode noarchivelog au mode archivelog.
```sql
--we close the database and reopen with mode mount
SHUTDOWN
STARTUP MOUNT
--than alter the databse that I change mode to archivelog.
ALTER DATABASE ARCHIVELOG;
ALTER DATABASE OPEN;
-- show current mode
SQL> select log_mode from sys.v$database;

LOG_MODE
------------
ARCHIVELOG

```
![](/home/tearsyu/Pictures/tp3_13.png)

##  RMAN
1. Dans l’environnement rman, écrivez la ou les instructions qui renvoient les mêmes informations que l’instruction suivante :
SQL> select name, bytes from v$datafile ;
2. Affichez dans l’environnement rman des informations sur les paramètres de confi-guration en cours du gestionnaire rman.
```
SHOW ALL;
```
![](/home/tearsyu/Pictures/tp3_22.png)
3. Configurez l’environnement rman pour omettre la sauvegarde d’un fichier si le fichier a déjà fait l’objet d’une sauvegarde par le gestionnaire rman au préalable et qu’il n’a pas été modifié depuis.
4. Une fois la configuration par défaut établie, effectuez une sauvegarde complète de votre base dans l’environnement rman.
— Identifier l’emplacement de la sauvegarde effectuée par RMAN.
— Identifier la "backup piece" contenant la sauvegarde du fichier de contrôle.
