-- create user
CREATE USER tearsyu IDENTIFIED BY toto;

--GRANT ALL privileges TO tearsyu;

-- create tablespaces with 30Mo
CREATE TABLESPACE tb_td1 DATAFILE 'tb_td1.dbf' SIZE 30M ONLINE;

-- Donner les autorisations a l'utilisateur
GRANT CONNECT TO tearsyu;
Alter USER tearsyu quota 10M on tb_td1;
Alter USER tearsyu default TABLESPACE tb_td1;
GRANT CREATE TABLE TO tearsyu;
GRANT CREATE TRIGGER TO tearsyu;

--Connect with tearsyu
connect tearsyu/toto

--Show info
SELECT tablespace_name, table_name FROM user_tables/all_tables;
DESC 'table_name';

SELECT column_name, position FROM all_cons_columns WHERE constraint_name = (
  SELECT constraint_name FROM user_constraints
  WHERE UPPER(table_name) = UPPER('city')
);



--Create table
CREATE TABLE responsable(
	nr		       int,
	nom		       varchar(50) not null,
	prenom 	 	   varchar(50) not null,
	dpt		       varchar(50) not null,
	primary key (nr)
);

CREATE TABLE cours(
	nc		       int primary key,
	code_cours	 varchar(50) not null,
	intitule	   varchar(50) not null,
	ects		     int not null,
	nr		       int not null,
  dpt          varchar(50) not null,
  foreign key (nr) references responsable(nr)
);

CREATE TABLE etudiant(
	ne		      int,
	nom		      varchar(50) not null,
	prenom 		  varchar(50) not null,
	ville		    varchar(50) not null,
  age         int,
	primary key (ne)
);

CREATE TABLE inscrit(
  ne          int not null,
  nc          int not null,
  annee       int not null,
  primary key(ne, nc, annee),
  foreign key (ne) references etudiant(ne),
  foreign key (nc) references cours(nc)
);

CREATE TABLE resultat(
  ne          int not null,
  nc          int not null,
  annee       int not null,
  note        int not null,
  foreign key (ne, nc, annee) references inscrit(ne, nc, annee)
);

--Insert data
INSERT INTO responsable VALUES (1, 'Michael', 'Mico', 'informatique');
INSERT INTO responsable VALUES (2, 'Demail', 'Logic', 'informatique');
INSERT INTO responsable VALUES (3, 'Yuxin', 'SHI', 'securite');
INSERT INTO responsable VALUES (4, 'Yi', 'Master', 'architecture');

INSERT INTO etudiant VALUES(1, 'Zixi', 'DENG', 'Melborne', 26);
INSERT INTO etudiant VALUES(2, 'Anais', 'Anais','Paris', 23);
INSERT INTO etudiant VALUES(3, 'Zadi', 'Laetitia', 'Paris', 22);

INSERT INTO cours VALUES(1, 'INFO_01', 'BD', 4, 1, 'informatique');
INSERT INTO cours VALUES(2, 'INFO_02', 'Prog', 5, 3, 'informatique');
INSERT INTO cours VALUES(3, 'INFO_03', 'Network', 3, 3, 'securite');
INSERT INTO cours VALUES(4, 'ARCHI_01', 'Design', 4, 2, 'architecture');
INSERT INTO cours VALUES(5, 'ARCHI_02', 'Enviroment', 3, 1, 'architecture');
INSERT INTO cours VALUES(6, 'INFO_04', 'EcoSys', 3, 2, 'securite');

INSERT INTO inscrit VALUES (1, 1, 2015);
INSERT INTO inscrit VALUES (1, 2, 2016);
INSERT INTO inscrit VALUES (1, 2, 2017);
INSERT INTO inscrit VALUES (2, 3, 2015);
INSERT INTO inscrit VALUES (3, 1, 2015);
INSERT INTO inscrit VALUES (3, 4, 2015);


INSERT INTO resultat VALUES (1, 1, 2015, 10);
INSERT INTO resultat VALUES (1, 2, 2016, 18);
INSERT INTO resultat VALUES (1, 2, 2017, 16);
INSERT INTO resultat VALUES (2, 3, 2015, 14);
INSERT INTO resultat VALUES (3, 1, 2015, 17);
INSERT INTO resultat VALUES (3, 4, 2015, 8);

-- Create trigger
CREATE OR REPLACE TRIGGER NOTE_TG
BEFORE INSERT ON resultat FOR EACH ROW
BEGIN
	IF :new.note > 20  THEN
    RAISE_APPLICATION_ERROR(-20000, 'Notes can not be greater than 20!');
  END IF;
END;
/

CREATE OR REPLACE TRIGGER DPT_CHECK
BEFORE INSERT ON cours FOR EACH ROW
DECLARE
  dptr varchar(50);
  newdpt varchar(50);
BEGIN
  SELECT :new.dpt INTO newdpt FROM dual;
  SELECT responsable.dpt into dptr FROM responsable
  WHERE newdpt = responsable.dpt;
  EXCEPTION WHEN NO_DATA_FOUND TH
    RAISE_APPLICATION_ERROR(-20001, 'Department is not presented in reponsable.');
END;
/

--h.
SELECT ne, sum(note) FROM resultat WHERE note > 10 GROUP BY ne;
--i
SELECT count(etudiant.ne), max(etudiant.age), avg(resultat.note) as moyenne
FROM etudiant INNER JOIN resultat ON resultat.ne = etudiant.ne
INNER JOIN cours ON resultat.nc = cours.nc
WHERE cours.dpt='informatique' AND (SELECT avg(note) FROM resultat) >=12
GROUP BY cours.dpt;

SELECT table_name FROM user_tables;

SELECT constraint_name FROM USER_CONSTRAINTS;
