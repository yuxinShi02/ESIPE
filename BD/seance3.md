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
 >In ARCHIVELOG mode, the database will make copies of all online redo logs after they are filled. These copies are called archived redo logs. The archived redo logs are created via the ARCH process. The ARCH process copies the archived redo log files to one or more archive log destination directories.
```sql
--With this sql request we know that database is in mode noarchivelog.
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
```sql
--Firstly, it's imperative to connect database with a legitimate role
CONNECT TARGET SYS
--than we show it's report schema
report shcema;
```
![](/home/tearsyu/Pictures/tp3_21.png)
2. Affichez dans l’environnement rman des informations sur les paramètres de confi-guration en cours du gestionnaire rman.
```
SHOW ALL;
```
![](/home/tearsyu/Pictures/tp3_22.png)
3. Configurez l’environnement rman pour omettre la sauvegarde d’un fichier si le fichier a déjà fait l’objet d’une sauvegarde par le gestionnaire rman au préalable et qu’il n’a pas été modifié depuis.
```sql
-- Activate backup option
configure backup optimization on;
```
![](/home/tearsyu/Pictures/tp3_23.png)
4. Une fois la configuration par défaut établie, effectuez une sauvegarde complète de votre base dans l’environnement rman.
— Identifier l’emplacement de la sauvegarde effectuée par RMAN.
— Identifier la "backup piece" contenant la sauvegarde du fichier de contrôle.
```sql
--To make a complete backup (so also archivelog)
BACKUP DATABASE;

--To identify the location of backup
LIST BACKUPSE

--To identify bakcup piece
LIST BACKUP OF CONTROLFILE;
```
![](/home/tearsyu/Pictures/tp3_341.png)  

![](/home/tearsyu/Pictures/tp3_342.png)  

## Récupération fichier de contrôle
Assurez-vous de disposer de n fichiers de contrôle (n>2) avant d’effectuer les exercices  suivants.
1. Supprimez par une commande du système d’exploitation l’un de vos fichiers de contrôle. Décrivez les opérations de restauration de ce fichier de contrôle étape par étape.
```sql
--make sure that I have at least 2 control files(the other is in DISK_REPLIQUE);
SELECT NAME FROM v$controlfile;
```
2. Créer un tablespace ayant un fichier de données.
```sql
CREATE TABLESPACE td_tb3 DATAFILE 'tb_tb3.dbf' SIZE 30M ONLINE;
```
3. Créer un schéma/utilisateur « ventes ». Connectez-vous à ce compte et générez les objets du schéma à l’aide du script fourni. Les objets de ventes doivent être stockées dans le tablespace de la question précédente.
```sql
CREATE USER ventes IDENTIFIED BY ventes;
GRANT CONNECT TO ventes;
Alter USER ventes quota 30M on td_tb3;
Alter USER ventes default TABLESPACE td_tb3;
GRANT CREATE TABLE TO ventes;
CONNECT  ventes/ventes;
@~/Documents/ESIPE/BD/create_ventes.sql
```
4. Simuler la perte du fichier de données contenant les objets de « ventes ». Constater sle dysfonctionnement.
```sql
--Before delete td_tb3.dbf, I make a backup in using RMAN
RMAN> BAKCUP DATABASE;
--Delete this tablespace file
bash$ rm $ORACLE_HOME/dbs/td_tb3.dbf

--Error occurs when I shutdown the database:
ORA-01110: data file 7: '/u01/app/oracle/product/11.2.0/xe/dbs/tb_tb3.dbf'
```

5. Utiliser RMAN pour restaurer le fichier de données.
```sql
--To restore datafile, showing that the number of datafile
RMAN > list backup of tablespace system;
--The datafile indicate that it's number
RMAN > restore datafile 7
```
![](/home/tearsyu/Pictures/tp3_43.png)
![](/home/tearsyu/Pictures/tp3_452.png)
Here we see that tb_tb3.dbf is restored.
![](/home/tearsyu/Pictures/tp3_45.png)

I had a problem when I did this exercice, I restored the datafile in mode mounted, but I can't open database after restoring.
>SQL> alter database open;
>alter database open*
>ERROR at line 1:
>ORA-01113: file 4 needs media recovery
>ORA-01110: data file 4: '/u01/app/oracle/oradata/XE/users.dbf'   

Solution:
```sql
recover datafile '/u01/app/oracle/oradata/XE/users.dbf'
```

6. Les n fichiers de contrôle sont endommagés, construisez un scénario de restauration de la base étape par étape.
```sql
--Delete control file
-- Show all the backup of control files
RMAN > list backup of CONTROLFILE;
--Choose one to restore, and restore it in mode NOMOUNT
RMAN > restore controlfile from
'/u01/app/oracle/fast_recovery_area/XE/XE/backupset/2017_11_10/o1_mf_ncnnf_TAG20171110T110216_f0by9b0t_.bkp'
```
![](/home/tearsyu/Pictures/tp3_46.png)

7. Tous les fichier physique de la base sont perdus, construisez un scénario de restauration de la base étape par étape.

```sql
RMAN > RESTORE DATABASE;
```

`http://www.thegeekstuff.com/2013/08/oracle-rman-backup/`
