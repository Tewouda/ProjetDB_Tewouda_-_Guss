use projet_bd;


-- CONTRAINTES DE VALIDATION

-- Table CLIENT
ALTER TABLE Client
ADD CONSTRAINT chk_email_client CHECK (EmailClient LIKE '%@%.%'),
ADD CONSTRAINT chk_tel_client CHECK (LENGTH(TelClient) BETWEEN 8 AND 15),
ADD CONSTRAINT chk_nom_client CHECK (NomClient <> ''),
ADD CONSTRAINT chk_prenom_client CHECK (PrénomClient <> '');

-- Table COMMANDE
ALTER TABLE Commande
ADD CONSTRAINT chk_montant_commande CHECK (Montant >= 0),
ADD CONSTRAINT chk_date_commande CHECK (DateCommande <= '2026-01-01');

-- Table PRODUIT
ALTER TABLE Produit
ADD CONSTRAINT chk_prix_produit CHECK (PrixProduit >= 0),
ADD CONSTRAINT chk_nom_produit CHECK (NomProduit <> ''),
ADD CONSTRAINT chk_date_lancement CHECK (Date_lancement <= '2026-01-01');

-- Table SERVICE
ALTER TABLE Service
ADD CONSTRAINT chk_tarif_mensuel CHECK (Tarif_mensuel > 0),
ADD CONSTRAINT chk_nom_service CHECK (NomService <> '');

-- Table ABONNEMENT
ALTER TABLE Abonnement
ADD CONSTRAINT chk_date_abonnement CHECK (Date_début < Date_fin),
ADD CONSTRAINT chk_prix_abonnement CHECK (PrixAbonnement >= 0);

-- Table LIVRAISON
ALTER TABLE Livraison
ADD CONSTRAINT chk_statut_livraison CHECK (StatutLivraison IN ('En cours', 'Livrée', 'Annulée'));

-- Table DONNERAVIS
ALTER TABLE DonnerAvis
ADD CONSTRAINT chk_note CHECK (Note BETWEEN 0 AND 5),
ADD CONSTRAINT chk_commentaire CHECK (LENGTH(Commentaire) <= 500);

-- Table CONTENU
ALTER TABLE Contenu
ADD CONSTRAINT chk_titre_contenu CHECK (TitreContenu <> ''),
ADD CONSTRAINT chk_duree_contenu CHECK (DuréeContenu > 0),
ADD CONSTRAINT chk_type_contenu CHECK (TypeContenu IN ('Film', 'Série', 'Musique', 'Documentaire')),
ADD CONSTRAINT chk_date_sortie CHECK (DateDeSortie <= '2026-01-01');

-- Table ELEMENTNOTABLE
ALTER TABLE ElémentNotable
ADD CONSTRAINT chk_type_element CHECK (TypeElement_servive_ou_produit_ IN ('Service', 'Produit'));

-- Table COMPLETER (association Produits / accessoires)
ALTER TABLE Compléter_accessoire_
ADD CONSTRAINT chk_type_accessoire CHECK (TypeAccessoire IN ('Câble', 'Coque', 'Support', 'Clavier', 'Souris'));
