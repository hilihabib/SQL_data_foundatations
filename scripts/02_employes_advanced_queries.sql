-- ==============================================
-- Script : 02_employes_advanced_queries.sql
-- Description : Requêtes avancées avec sous-requêtes
-- et vues appliquées à la table Employes
-- ==============================================

-- 1. Création de la table Employes
CREATE TABLE Employes (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    Nom VARCHAR(50),
    Salaire DECIMAL(10, 2)
);

-- 2. Insertion de quelques employés
INSERT INTO Employes (Nom, Salaire) VALUES 
('Alex', 50000),
('Samira', 62000),
('Julien', 47000),
('Mehdi', 70000);

-- 3. Sélection des employés ayant un salaire supérieur à la moyenne (sous-requête)
SELECT Nom, Salaire
FROM Employes
WHERE Salaire > (
    SELECT AVG(Salaire)
    FROM Employes
);

-- 4. Création d’une vue : EmployesHauts
CREATE VIEW EmployesHauts AS
SELECT Nom, Salaire
FROM Employes
WHERE Salaire > (
    SELECT AVG(Salaire)
    FROM Employes
);

-- 5. Utilisation de la vue
SELECT * FROM EmployesHauts;

-- 6. Exemple de mise à jour via la vue (à condition qu’elle soit modifiable)
-- ATTENTION : certaines bases ne permettent pas ce type d'UPDATE sur vue non indexée
UPDATE EmployesHauts
SET Salaire = Salaire * 1.10
WHERE Nom = 'Alex';
