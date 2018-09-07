`Editor: Yuxin SHI 02/03/2018`
```SQL
grant all privileges on secutp1.* to 'alice'@'localhost' with grant option;

CREATE TABLE dpt(
  nom           varchar(50),
  responsable   varchar(50),
  primary key(nom)
);

CREATE TABLE emp(
  nom           varchar(50),
  salaire       int,
  nom_dpt           varchar(50),
  primary key(nom),
  foreign key (nom_dpt) references dpt(nom)
);

ALTER TABLE dpt ADD CONSTRAINT fk_responsable FOREIGN KEY(responsable) REFERENCES emp(nom);
ALTER TABLE dpt DROP FOREIGN KEY fk_responsable;
INSERT INTO dpt VALUES('informatique', 'Alain');
INSERT INTO dpt VALUES('RH', 'Odile');
INSERT INTO dpt VALUES ('compta', 'Pierre');
INSERT INTO emp VALUES('Alain', 20000, 'informatique');
INSERT INTO emp VALUES('Alice', 19000, 'RH');
INSERT INTO emp VALUES('Odile', 30000, 'RH');
INSERT INTO emp VALUES('Pierre', 22000, 'informatique');
INSERT INTO emp VALUES('Isabelle', 22000, 'informatique');

CREATE VIEW affectation AS
SELECT nom, nom_dpt FROM emp ORDER BY nom_dpt;
SELECT * FROM affectation;
GRANT SELECT ON affectation TO alain@localhost;
GRANT SELECT ON affectation TO odile@localhost;
GRANT SELECT ON affectation TO pierre@localhost;
GRANT SELECT ON affectation TO isabelle@localhost;

CREATE VIEW nom_employe AS (SELECT
nom, salaire FROM emp WHERE nom_dpt IN
(SELECT nom FROM dpt WHERE responsable like substring_index(user(), '@', 1)));
GRANT SELECT ON nom_employe to alain@localhost;
GRANT SELECT(nom), UPDATE(nom_dpt) ON emp TO odile@localhost;
GRANT SELECT, UPDATE(responsable) ON departement TO odile@localhost;
GRANT SELECT(nom), UPDATE(salaire) ON emp TO pierre@localhost;
REVOKE UPDATE(salaire) ON emp FROM pierre@localhost;
/*Odile*/
UPDATE emp SET nom_dpt = 'RH' WHERE nom = 'Alain';
```
