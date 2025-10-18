use projet_bd;

-- Suppression des colonnes DuréeContenu(Contenu), Date_début et Date_fin(Abonnement)
ALTER TABLE Contenu
DROP CONSTRAINT chk_duree_contenu;

ALTER TABLE Abonnement
DROP CONSTRAINT chk_date_abonnement;

ALTER TABLE Contenu
DROP COLUMN DuréeContenu;

ALTER TABLE Abonnement
DROP COLUMN Date_début,
DROP COLUMN Date_fin;

ALTER TABLE Commande
DROP COLUMN DetailProduitCommande;

-- Modification de la contrainte liée au type de contenu
ALTER TABLE Contenu
DROP CONSTRAINT chk_type_contenu;

ALTER TABLE Contenu
ADD CONSTRAINT chk_type_contenu 
CHECK (TypeContenu IN ('Film', 'Série', 'Musique', 'Documentaire', 'Jeu'));

-- Modification de clé primaire de la table DonnerAvis
ALTER TABLE DonnerAvis
DROP PRIMARY KEY,
ADD PRIMARY KEY (IDClient, IDElément);


-- Modification de la table Compléter_accessoire_
ALTER TABLE `Compléter_accessoire_`
ADD COLUMN `NomAccessoire` VARCHAR(100);

ALTER TABLE Client
MODIFY TelClient BIGINT NOT NULL;

ALTER TABLE `Compléter_accessoire_`
MODIFY COLUMN `NomAccessoire` VARCHAR(100) AFTER `RefProduit_1`;

DROP TABLE `Compléter_accessoire_`;

CREATE TABLE `Compléter_accessoire_` (
   IDAccessoire INT AUTO_INCREMENT PRIMARY KEY,
   RefProduit INT NOT NULL,
   RefProduit_1 INT NOT NULL,
   NomAccessoire VARCHAR(100) NOT NULL,
   TypeAccessoire VARCHAR(50) NOT NULL,
   FOREIGN KEY(RefProduit) REFERENCES Produit(RefProduit),
   FOREIGN KEY(RefProduit_1) REFERENCES Produit(RefProduit),
   CONSTRAINT chk_type_accessoire CHECK (TypeAccessoire IN ('Câble', 'Coque', 'Support', 'Clavier', 'Souris')),
   INDEX idx_produit(RefProduit),
   INDEX idx_accessoire(RefProduit_1)
);










