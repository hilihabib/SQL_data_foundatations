-- ==============================================
-- Script : 03_procedures_fonctions.sql
-- Description : Création de procédures stockées
-- et fonctions SQL (scalaire et table)
-- ==============================================

-- 1. Ajout d'une colonne "Poste" à la table Employes
ALTER TABLE Employes ADD Poste VARCHAR(50);

-- 2. Création d'une procédure stockée pour ajouter un employé
DELIMITER //

CREATE PROCEDURE AjouterEmploye (
    IN p_nom VARCHAR(50),
    IN p_salaire DECIMAL(10,2),
    IN p_poste VARCHAR(50)
)
BEGIN
    INSERT INTO Employes (Nom, Salaire, Poste)
    VALUES (p_nom, p_salaire, p_poste);
END //

DELIMITER ;

-- 3. Utilisation de la procédure
CALL AjouterEmploye('Fatou', 54000.00, 'Data Analyst');

-- 4. Création d'une fonction scalaire pour calculer l'âge à partir de la date de naissance
-- (Ajout préalable d'une colonne DateNaissance si nécessaire)
ALTER TABLE Employes ADD DateNaissance DATE;

DELIMITER //

CREATE FUNCTION CalculerAge (p_date_naissance DATE)
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE v_age INT;
    SET v_age = TIMESTAMPDIFF(YEAR, p_date_naissance, CURDATE());

    IF (MONTH(p_date_naissance) > MONTH(CURDATE())) OR 
       (MONTH(p_date_naissance) = MONTH(CURDATE()) AND DAY(p_date_naissance) > DAY(CURDATE())) THEN
        SET v_age = v_age - 1;
    END IF;

    RETURN v_age;
END //

DELIMITER ;

-- 5. Utilisation de la fonction scalaire
SELECT Nom, CalculerAge(DateNaissance) AS Age
FROM Employes
WHERE DateNaissance IS NOT NULL;

-- 6. Création d'une fonction retournant une table : employés avec salaire au-dessus de la moyenne
DELIMITER //

CREATE FUNCTION EmployesSalaireAuDessusMoyenne ()
RETURNS TABLE
RETURN
    SELECT Nom, Salaire
    FROM Employes
    WHERE Salaire > (SELECT AVG(Salaire) FROM Employes);

-- 7. Utilisation
SELECT * FROM EmployesSalaireAuDessusMoyenne();
