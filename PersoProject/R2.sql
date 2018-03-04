CREATE TABLE Client(
    id_client int NOT NULL AUTO_INCREMENT,
    nom VARCHAR(25) NOT NULL,
    prenom VARCHAR(25) NOT NULL,
    adresse VARCHAR(25) NOT NULL,
    email VARCHAR(25) NOT NULL,
    tel VARCHAR(25) NOT NULL,
    PRIMARY KEY(id_client)
);

CREATE TABLE CatVehicule(
    id_cat int NOT NULL AUTO_INCREMENT,
    cat ENUM('berline', 'espace', 'classique'),
    tarif_cat float,
    PRIMARY KEY(id_cat)
);

CREATE TABLE PlageHoraire(
    id_plageHoraire int NOT NULL AUTO_INCREMENT,
    plage_horaire VARCHAR(25) NOT NULL,
    taux float,
    PRIMARY KEY(id_plageHoraire)
);

CREATE TABLE Retard(
    id_retard int NOT NULL AUTO_INCREMENT,
    minute_retard VARCHAR(50) NOT NULL,
    penalite DECIMAL(3,2) NOT NULL,
    PRIMARY KEY(id_retard)
);

CREATE TABLE Tarif(
    id_tarif int NOT NULL AUTO_INCREMENT,
    nom_tarif VARCHAR(200) NOT NULL,
    montant DECIMAL(4,2) NOT NULL,
    id_plageHoraire int NOT NULL,
    id_cat int NOT NULL,
    PRIMARY KEY(id_tarif),
    FOREIGN KEY(id_plageHoraire) REFERENCES PlageHoraire(id_plageHoraire),
    FOREIGN KEY(id_cat) REFERENCES CatVehicule(id_cat)
);

CREATE TABLE Vehicule(
    id_vehicule int NOT NULL AUTO_INCREMENT,
    couleur VARCHAR(25) NOT NULL,
    volume int NOT NULL,
    id_cat int NOT NULL,
    marque VARCHAR(25) NOT NULL,
    PRIMARY KEY(id_vehicule),
    FOREIGN KEY (id_cat) REFERENCES CatVehicule(id_cat)
);

CREATE TABLE Parking(
    id_parking int NOT NULL AUTO_INCREMENT,
    nom_parking VARCHAR(50) NOT NULL,
    adresse VARCHAR(200) NOT NULL,
    lng DECIMAL(11, 8) NOT NULL, 
    lat DECIMAL(10, 8) NOT NULL,
    volume int NOT NULL,
    PRIMARY KEY(id_parking)
);

CREATE TABLE Reservation(
    id_reservation INT NOT NULL AUTO_INCREMENT,
    id_tarif int NOT NULL,
    id_parking_depart int NOT NULL,
    id_parking_arrive int NOT NULL,
    id_vehicule int NOT NULL,
    PRIMARY KEY(id_reservation),
    FOREIGN KEY(id_tarif) REFERENCES Tarif(id_tarif),
    FOREIGN KEY(id_parking_depart) REFERENCES Parking(id_parking),
    FOREIGN KEY(id_parking_arrive) REFERENCES Parking(id_parking),
    FOREIGN KEY(id_vehicule) REFERENCES Vehicule(id_vehicule)
);

CREATE TABLE Occupation(
    id_occupation int NOT NULL AUTO_INCREMENT,
    id_vehicule int NOT NULL,
    id_reservation int NOT NULL,
    PRIMARY KEY(id_occupation),
    FOREIGN KEY(id_vehicule) REFERENCES Vehicule(id_vehicule),
    FOREIGN KEY(id_reservation) REFERENCES Reservation(id_reservation)
);

DROP TABLE IF EXISTS `Course`;
CREATE TABLE Course(
    id_client int NOT NULL,
    id_vehicule int NOT NULL,
    lng DECIMAL(11, 8) NOT NULL, 
    lat DECIMAL(10, 8) NOT NULL,
    heure_arrivee_prevu TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    heure_arrivee_reelle TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    heure_depart TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY(id_client) REFERENCES Client(id_client),
    FOREIGN KEY(id_vehicule) REFERENCES Vehicule(id_vehicule)
);

CREATE TABLE HistoriqueCourse(
    id_histoire int NOT NULL AUTO_INCREMENT,
    id_client int NOT NULL,
    id_vehicule int NOT NULL,
    heure_arrivee_reelle TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    heure_depart TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    id_tarif int NOT NULL, 
    montant DECIMAL(5,2) NOT NULL,
    PRIMARY KEY(id_histoire),
    FOREIGN KEY(id_client) REFERENCES Client(id_client),
    FOREIGN KEY(id_vehicule) REFERENCES Vehicule(id_vehicule),
    FOREIGN KEY(id_tarif) REFERENCES Tarif(id_tarif)
);

CREATE TABLE penalite(
    id_penalite INT NOT NULL AUTO_INCREMENT,
    id_histoire int NOT NULL, 
    id_retard int NOT NULL,
    montant DECIMAL(5,2) NOT NULL,
    PRIMARY KEY(id_penalite),
    FOREIGN KEY(id_histoire) REFERENCES HistoriqueCourse(id_histoire),
    FOREIGN KEY(id_retard) REFERENCES Retard(id_retard)
);

