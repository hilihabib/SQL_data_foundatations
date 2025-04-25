-- ==============================================
-- Script : 01_clients_table.sql
-- Description : Création, manipulation de base,
-- jointures et index sur une table 'Clients'
-- ==============================================

-- 1. Création de la table Clients
CREATE TABLE Clients (
    ID INT PRIMARY KEY,
    Nom VARCHAR(100),
    Email VARCHAR(100)
);

-- 2. Insertion d'un client
INSERT INTO Clients (ID, Nom, Email)
VALUES (1, 'Alex', 'alex@example.com');

-- 3. Sélection de toutes les données
SELECT * FROM Clients;

-- 4. Mise à jour de l'email du client avec ID = 1
UPDATE Clients
SET Email = 'alex_new@example.com'
WHERE ID = 1;

-- 5. Suppression du client avec ID = 1
DELETE FROM Clients
WHERE ID = 1;

-- 6. Sélection partielle des colonnes (Nom, Email)
SELECT Nom, Email FROM Clients;

-- 7. Sélection des 10 premiers enregistrements
SELECT Nom, Email FROM Clients
LIMIT 10;

-- 8. Création d'une table Commandes pour jointure
CREATE TABLE Commandes (
    ID INT PRIMARY KEY,
    Client_ID INT,
    Montant DECIMAL(10,2),
    FOREIGN KEY (Client_ID) REFERENCES Clients(ID)
);

-- 9. Jointure entre Clients et Commandes
SELECT c.Nom, o.Montant
FROM Clients AS c
INNER JOIN Commandes AS o ON c.ID = o.Client_ID;

-- 10. Création d'un index simple
CREATE INDEX idx_nom_sur_clients ON Clients(Nom);

-- 11. Suppression de l'index
DROP INDEX idx_nom_sur_clients;

-- 12. Analyse d'une requête avec EXPLAIN
EXPLAIN SELECT Nom, Email FROM Clients;
