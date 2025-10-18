use projet_bd;

-- 1. Liste des clients ayant passé une commande entre deux dates
SELECT NomClient, PrénomClient, EmailClient, DateCommande
FROM Commande C
JOIN Client CL ON C.IDClient = CL.IDClient
WHERE DateCommande BETWEEN '2025-04-01' AND '2025-10-01'
ORDER BY DateCommande DESC;

-- 2. Liste des produits coûtant entre 500 et 1500 €
SELECT NomProduit, PrixProduit
FROM Produit
WHERE PrixProduit BETWEEN 500 AND 1500
ORDER BY PrixProduit ASC;

-- 3. Contenus dont le titre contient le mot "Music" (masque avec LIKE)
SELECT TitreContenu, TypeContenu, DateDeSortie
FROM Contenu
WHERE TitreContenu LIKE '%Music%';

-- 4. Clients ayant une adresse contenant "Paris" ou "Lyon"
SELECT NomClient, PrénomClient, AdresseClient
FROM Client
WHERE AdresseClient LIKE '%Paris' or '%Lyon';

-- 5. Produits lancés avant 2025 triés par date de lancement décroissante
SELECT NomProduit, Date_lancement
FROM Produit
WHERE Date_lancement < '2025-01-01'
ORDER BY Date_lancement DESC;

-- 6. Nombre de commandes supérieur à 5 par client**
SELECT IDClient, COUNT(*) AS NbCommandes
FROM Commande
GROUP BY IDClient
HAVING COUNT(*) > 4;

-- 7. Prix moyen des produits par catégorie
SELECT Catégorie, ROUND(AVG(PrixProduit),2) AS PrixMoyen
FROM Produit
GROUP BY Catégorie;

-- 8. Montant total des commandes par client
SELECT IDClient, SUM(Montant) AS TotalCommandes
FROM Commande
GROUP BY IDClient
ORDER BY TotalCommandes DESC;

-- 9. Moyenne des notes données aux éléments notables
SELECT IDElément, ROUND(AVG(Note),2) AS NoteMoyenne
FROM DonnerAvis
GROUP BY IDElément
HAVING AVG(Note) > 3.5;

-- 10. Nombre total de contenu par type
SELECT TypeContenu, COUNT(*) AS NbContenus
FROM Contenu
GROUP BY TypeContenu;

-- 11. Détails des commandes avec nom du client et du produit
SELECT CL.NomClient, CL.PrénomClient, P.NomProduit, C.DateCommande, C.Montant
FROM Commande C
JOIN Client CL ON C.IDClient = CL.IDClient
JOIN Contenir CT ON CT.IDCommande = C.IDCommande
JOIN Produit P ON P.RefProduit = CT.RefProduit;

-- 12. Liste des produits et de leurs accessoires
SELECT P.NomProduit AS Produit, A.NomAccessoire, A.TypeAccessoire
FROM Produit P
JOIN Compléter_accessoire_ A ON P.RefProduit = A.RefProduit;

-- 13. Liste des contenus et des artistes associés
SELECT Co.TitreContenu, A.NomArtiste
FROM Contenu Co
JOIN Lier L ON Co.IDContenu = L.IDContenu
JOIN Artiste A ON A.IDartiste = L.IDartiste;

-- 14. Liste des clients avec leurs abonnements et services associés
SELECT C.NomClient, C.PrénomClient, S.NomService, A.PrixAbonnement
FROM Souscrire SC
JOIN Client C ON C.IDClient = SC.IDClient
JOIN Service S ON S.RefService = SC.RefService
JOIN Abonnement A ON A.IDAbonnement = SC.IDAbonnement;

-- 15. Liste des commandes et livraisons associées (jointure externe)
SELECT C.IDCommande, C.DateCommande, L.StatutLivraison
FROM Commande C
LEFT JOIN Livraison L ON C.IDCommande = L.IDCommande;


-- 16. Clients ayant commandé un produit d’un certain type (ordinateur)
SELECT c.IDClient, c.NomClient, c.PrénomClient
FROM Client c
WHERE EXISTS (
  SELECT cmd.IDCommande
  FROM Commande cmd
  JOIN Contenir co ON cmd.IDCommande = co.IDCommande
  JOIN Produit p ON p.RefProduit = co.RefProduit
  WHERE cmd.IDClient = c.IDClient
  AND p.Catégorie = 'Ordinateur'
);

-- 17. Produits ayant reçu une note supérieure à 4
SELECT NomElement
FROM ElémentNotable
WHERE IDElément IN (
    SELECT IDElément FROM DonnerAvis WHERE Note > 4
);

-- 18. Services ayant plus d’abonnements que la moyenne de tous les services
SELECT RefService, COUNT(*) AS NbAbonnements
FROM Souscrire
GROUP BY RefService
HAVING COUNT(*) > (
    SELECT AVG(Nb) FROM (
        SELECT COUNT(*) AS Nb FROM Souscrire GROUP BY RefService
    ) AS MoyenneServices
);

-- 19. Contenus non liés à un artiste
SELECT TitreContenu
FROM Contenu
WHERE IDContenu NOT IN (SELECT IDContenu FROM Lier);

-- 20. Produits plus chers que tous les produits de la catégorie "Accessoire"
SELECT NomProduit, PrixProduit
FROM Produit
WHERE PrixProduit > ALL (
    SELECT PrixProduit FROM Produit WHERE Catégorie = 'Accessoire'
);










