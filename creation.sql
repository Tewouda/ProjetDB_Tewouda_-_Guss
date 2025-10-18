use projet_bd;

CREATE TABLE Produit(
   RefProduit INT,
   NomProduit VARCHAR(100) NOT NULL,
   Catégorie VARCHAR(100) NOT NULL,
   PrixProduit DECIMAL(15,2) NOT NULL,
   Date_lancement DATE NOT NULL,
   PRIMARY KEY(RefProduit)
);

CREATE TABLE Service(
   RefService VARCHAR(50),
   NomService VARCHAR(100) NOT NULL,
   Tarif_mensuel DECIMAL(15,2) NOT NULL,
   Date_disponibilité DATE NOT NULL,
   PRIMARY KEY(RefService)
);

CREATE TABLE Client(
   IDClient INT,
   AdresseClient VARCHAR(100),
   NomClient VARCHAR(100) NOT NULL,
   PrénomClient VARCHAR(100) NOT NULL,
   EmailClient VARCHAR(100) NOT NULL,
   TelClient INT NOT NULL,
   PRIMARY KEY(IDClient),
   UNIQUE(EmailClient),
   UNIQUE(TelClient)
);

CREATE TABLE Commande(
   IDCommande INT,
   DateCommande DATE NOT NULL,
   Montant INT NOT NULL,
   DetailProduitCommande VARCHAR(50),
   IDClient INT NOT NULL,
   PRIMARY KEY(IDCommande),
   FOREIGN KEY(IDClient) REFERENCES Client(IDClient)
);

CREATE TABLE Livraison(
   IDCommande INT,
   IDLivraison INT,
   StatutLivraison VARCHAR(100) NOT NULL,
   PRIMARY KEY(IDCommande, IDLivraison),
   UNIQUE(IDCommande),
   FOREIGN KEY(IDCommande) REFERENCES Commande(IDCommande)
);

CREATE TABLE Abonnement(
   IDAbonnement INT,
   PrixAbonnement DECIMAL(15,2) NOT NULL,
   Date_début DATE NOT NULL,
   Date_fin DATE NOT NULL,
   PRIMARY KEY(IDAbonnement)
);

CREATE TABLE Artiste(
   IDartiste INT,
   NomArtiste VARCHAR(100) NOT NULL,
   PRIMARY KEY(IDartiste)
);

CREATE TABLE Contenu(
   IDContenu INT,
   TitreContenu VARCHAR(50) NOT NULL,
   DuréeContenu VARCHAR(50),
   DateDeSortie VARCHAR(50),
   TypeContenu VARCHAR(50) NOT NULL,
   RefService VARCHAR(50) NOT NULL,
   PRIMARY KEY(IDContenu),
   FOREIGN KEY(RefService) REFERENCES Service(RefService)
);

CREATE TABLE ElémentNotable(
   IDElément INT,
   TypeElement_servive_ou_produit_ VARCHAR(50),
   NomElement VARCHAR(50) NOT NULL,
   PRIMARY KEY(IDElément)
);

CREATE TABLE Contenir(
   RefProduit INT,
   IDCommande INT,
   PRIMARY KEY(RefProduit, IDCommande),
   FOREIGN KEY(RefProduit) REFERENCES Produit(RefProduit),
   FOREIGN KEY(IDCommande) REFERENCES Commande(IDCommande)
);

CREATE TABLE Souscrire(
   RefService VARCHAR(50),
   IDClient INT,
   IDAbonnement INT,
   Date_debut DATE NOT NULL,
   Date_fin DATE NOT NULL,
   PRIMARY KEY(RefService, IDClient, IDAbonnement),
   FOREIGN KEY(RefService) REFERENCES Service(RefService),
   FOREIGN KEY(IDClient) REFERENCES Client(IDClient),
   FOREIGN KEY(IDAbonnement) REFERENCES Abonnement(IDAbonnement)
);

CREATE TABLE Lier(
   IDartiste INT,
   IDContenu INT,
   PRIMARY KEY(IDartiste, IDContenu),
   FOREIGN KEY(IDartiste) REFERENCES Artiste(IDartiste),
   FOREIGN KEY(IDContenu) REFERENCES Contenu(IDContenu)
);

CREATE TABLE DonnerAvis(
   IDClient INT,
   Note DECIMAL(15,2) NOT NULL,
   Commentaire VARCHAR(50),
   IDElément INT NOT NULL,
   PRIMARY KEY(IDClient),
   FOREIGN KEY(IDClient) REFERENCES Client(IDClient),
   FOREIGN KEY(IDElément) REFERENCES ElémentNotable(IDElément)
);

CREATE TABLE Compléter_accessoire_(
   RefProduit INT,
   RefProduit_1 INT,
   TypeAccessoire VARCHAR(50) NOT NULL,
   PRIMARY KEY(RefProduit, RefProduit_1),
   FOREIGN KEY(RefProduit) REFERENCES Produit(RefProduit),
   FOREIGN KEY(RefProduit_1) REFERENCES Produit(RefProduit)
);
