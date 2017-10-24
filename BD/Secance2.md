# <center>Compte Rendue --- Gestion de fichiers et création d’une BD
</center>
<center>Yuxin SHI</center>   
<br/>

## 1 Gestions des fichiers de la base de données

1. Localiser le fichier de contrôle (en utilisant le dictionnaire).
```sql
SELECT NAME FROM V$CONTROLFILE;
```
![](/home/tearsyu/Pictures/tp2_bd1.png)   
Et on voit qu'il y a juste un fichier de controle dans la base de donnees.

2. Installer une version multiplexée du fichier de contrôle dans le répertoire préalablement créé /DISK_REPLIQUE.
```sql
--On declare que la deuxieme fichier de control:
ALTER SYSTEM SET CONTROL_FILES = '/u01/app/oracle/oradata/XE/control.dbf',
'/DISK_REPLIQUE/control2.dbf' scope = spfile;
--On ferme le system
SHUTDOWN;
--On copie le fichier de control dans /DISK_REPLIQUE/control2.dbf
# cp /u02/appl/oradata/XE/control.dbf /DISK_REPLIQUE/control2.dbf
--On change le droit pour le role ORACLE
# sudo chown oracle:dba /DISK_REPLIQUE/control2.dbf
-- -rwxr-xr-- 1 oracle dba 9748480 oct.   6 12:59 /DISK_REPLIQUE/control2.dbf*
```
![](/home/tearsyu/Pictures/tp2_db2.png)
3. Localiser les fichiers journaux (en utilisant le dictionnaire).
```sql
SELECT group#,member FROM v$logfile;
```
![](/home/tearsyu/Pictures/tp2_bd3.png)
4. Installer une copie d’un membre de chaque groupe dans le répertoire /DISK_REPLIQUE.
```sql
ALTER database ADD logfile member '/DISK_REPLIQUE/logfile_cp_01.log' TO GROUP 2;
ALTER database ADD logfile member '/DISK_REPLIQUE/logfile_cp_02.log' TO GROUP 1;
---It's important to change group member from root to oracle for "DISK_REPLIQUE", or the error of permission occurs.
```
We check directory "DISK_REPLIQUE", there are two log files are generated. Note that for each group, their members are uniform.
![](/home/tearsyu/Pictures/tp2_4.png)

5. Ajouter un nouveau groupe de fichiers de journaux ayant deux membres de 10Mo (un membre dans chaque répertoire utilisé par les autres groupes).
```sql
ALTER database add logfile GROUP 3 '/u01/app/oracle/fast_recovery_area/XE/onlinelog/logfile_3.log'
size 10m;
ALTER database add logfile member '/DISK_REPLIQUE/logfile_cp_03.log' TO GROUP 3;
```
![](/home/tearsyu/Pictures/tp2_5.png)

6. Déplacer un membre du groupe créer à la question 5 afin que les deux membres soient dans le répertoire /DISK_REPLIQUE.   
I have done it before I did this question...Well, I create a 3th log file and I move it to /DISK_REPLIQUE.
```sql
ALTER database ADD logfile member '/u01/app/oracle/fast_recovery_area/XE/onlinelog/logfile_4.log' TO GROUP 3;
--Move file, firstly I shutdown the database and I move this logfile to /DISK_REPLIQUE, and I startup the database then I alter this action I did.
# mv /u01/app/oracle/fast_recovery_area/XE/onlinelog/logfile_4.log /DISK_REPLIQUE/logfile_cp_04.log
# startup
ALTER database RENAME file '/u01/app/oracle/fast_recovery_area/XE/onlinelog/logfile_4.log' TO '/DISK_REPLIQUE/logfile_cp_04.log';
```
7. Supprimer un membre du groupe créer dans la question 5.
```sql
ALTER DATABASE DROP LOGFILE  MEMBER '/DISK_REPLIQUE/logfile_cp_04.log';
```
8. Supprimer le groupe créer à la question 5.
```sql
ALTER DATABASE DROP LOGFILE  GROUP 3;
```
![](/home/tearsyu/Pictures/tp2_8.png)
9. Localiser les fichiers de données (en utilisant le dictionnaire).
```sql
SELECT name FROM v$datafile;
```
![](/home/tearsyu/Pictures/tp2_9.png)
10. Ajouter un fichier de données au tablespace créé lors du TP1.
```sql
ALTER DATABASE OPEN;
ALTER TABLESPACE tb_td1 ADD DATAFILE 'users.dbf' SIZE 20M AUTOEXTEND ON;
```
11. Donner une requête qui associe le numéro d’un tablespace (ts#) aux fichiers de données.
```sql
SELECT ts#, name FROM v$datafile;
```
![](/home/tearsyu/Pictures/tp2_11.png)

## Création d’une instance et d’une base Oracle
1. Créer les différents répertoires sur le disques.
```bash
The new database name is "TP2_BASE"
# mkdir /u01/app/oracle/admin/TP2_BASE
# cd /u01/app/oracle/admin/TP2_BASE
# mkdir adump dbs dpdump pfile
# cd /u01/app/oracle/oradata/
```
2. Créer un fichier de paramètres texte.
We will create an init file for new database. And we modify the parameters of this file.
```bash
# cp $ORACLE_HOME/dbs/init.ora $ORACLE_HOME/dbs/initTP2_BASH.ora
# vim initTP2_BASH.ora
```
![](/home/tearsyu/Pictures/TP2_2.2.png)

3. Créer un fichier de mots de passe en utilisant orapwd.
4. Positionner la variable d’environnement ORACLE_SID.
To create a password configuration file, we have to export the ORACLE_SID and ORACLE_HOME, then we create a folder at the new ORACLE_HOME for TP2_BASE.
```sql
# export ORACLE_SID=TP2_BASE
# export ORACLE_HOME=/u01/app/oracle/product/11.2.0/TP2_BASE
# mkdir /u01/app/oracle/product/11.2.0/TP2_BASE/dbs
# sudo $ORACLE_HOME/bin/orapwd file=/u01/app/oracle/product/11.2.0/TP2_BASE/dbs/pwdTP2_BASE.ora
# sudo chown oracle:dba /u01/app/oracle/admin/TP2_BASE/*
--And given the permission to other folders and files that are created to oracle:dba.
```

5. Créer le fichier de paramètre serveurs.   
A spfile is a binary file which is used to configure the current database, it instances the database when the database mounts. Here I just let my database's spfile locate to default location($ORACLE_HOME/dbs/).
```bash
# create spfile from pfile;
```
After shutdown the XE, I got this:  
![](/home/tearsyu/Pictures/tp2_error.png)
And unluckily, I got an other error when I want to change to XE:
![](/home/tearsyu/Pictures/tp2_error2.png)
It seens that I lose initXE.ora file somehow...    
Well I rechange ORACLE_SID=TP2_BASE, and I solved *ORA-01075: you are currently logged on*:
```bash
# ps -ef | grep TP
# kill -9 <id_of_pmon>
```

6. Se connecter à la base et la démarrée (en nomount).  
```sql
startup nomount
```
![](/home/tearsyu/Pictures/tp2_26.png)

7. Créer une base de données avec les caractéristiques suivantes :
  - un tablespace SYSTEM de 50 Mo.
  - un tablespace SYSAUX de 20 Mo.
  - Un tablespace TEMP de 10 Mo.
  - Un tablespace UNDO de 10Mo.
  - Un tablespace par défaut et de taille 10 Mo.
  - Deux groupes de fichiers journaux ayant chacun deux membres de 5 Mo.
  - Le nombre d’instances est limité à 1.
  - Le nombre de fichiers de données est limité à 128.
  - L’instance est dans un étant NOARCHIVELOG à la création.
  - Les différents tablepace peuvent être étendu de 10 Mo à chaque fois que l’espace fois que l’espace initialement alloué est complètement utilisé.
```sql
CREATE DATABASE TP2_BASE USER SYS IDENTIFIED BY toto
  USER SYSTEM IDENTIFIED BY toto
  LOGFILE GROUP 1('/u01/app/oracle/oradata/TP2_BASE/redo10.log',
          '/u01/app/oracle/oradata/TP2_BASE/redo11.log') SIZE 5M,
          GROUP 2('/u01/app/oracle/oradata/TP2_BASE/redo20.log',
          '/u01/app/oracle/oradata/TP2_BASE/redo21.log') SIZE 5M
  NOARCHIVELOG
  DATAFILE
      '/u01/app/oracle/oradata/TP2_BASE/system01.dbf' SIZE 50M REUSE
  SYSAUX DATAFILE
      '/u01/app/oracle/oradata/TP2_BASE/sysaux01.dbf' SIZE 20M REUSE
  DEFAULT TABLESPACE users
      DATAFILE '/u01/app/oracle/oradata/TP2_BASE/users01.dbf'
      SIZE 10M REUSE AUTOEXTEND ON MAXSIZE 10M
   DEFAULT TEMPORARY TABLESPACE tempts1
      TEMPFILE '/u01/app/oracle/oradata/TP2_BASE/temp01.dbf'
      SIZE 10M REUSE
   UNDO TABLESPACE undotbs
      DATAFILE '/u01/app/oracle/oradata/TP2_BASE/undotbs01.dbf'
      SIZE 10M REUSE AUTOEXTEND ON MAXSIZE UNLIMITED
   MAXINSTANCES 1
   MAXDATAFILES 128;
```
![](/home/tearsyu/Pictures/TP2_28.png)
8. Lancer les scripts qui créent le dictionnaire.    
```sql
@/u01/app/oracle/product/11.2.0/xe/rdbms/admin/catalog.sql
@/u01/app/oracle/product/11.2.0/xe/rdbms/admin/catproc.sql
```
