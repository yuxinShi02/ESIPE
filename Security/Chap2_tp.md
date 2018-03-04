`Editor: Yuxin SHI 02/03/2018`
```SQL
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
INSERT INTO emp VALUES('Alain', 20000, 'informatique');
INSERT INTO emp VALUES('Alice', 19000, 'RH');
INSERT INTO emp VALUES('Odile', 30000, 'RH');
INSERT INTO emp VALUES('Pierre', 22000, 'informatique');
INSERT INTO emp VALUES('Isabelle', 22000, 'informatique');

CREATE VIEW affectation AS
SELECT nom, nom_dpt FROM emp ORDER BY nom_dpt;
SELECT * FROM affectation;


```
