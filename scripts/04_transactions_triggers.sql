-- ==============================================
-- Script : 04_transactions_triggers.sql
-- Description : Transactions sécurisées et triggers
-- pour audit automatique sur les mises à jour
-- ==============================================

-- 1. Création de la table Comptes
CREATE TABLE Comptes (
    Numero_Compte VARCHAR(20) PRIMARY KEY,
    Solde DECIMAL(10,2)
);

-- 2. Insertion de deux comptes
INSERT INTO Comptes (Numero_Compte, Solde) VALUES
('123456', 1000.00),
('654321', 500.00);

-- 3. Transfert sécurisé entre deux comptes avec transaction
START TRANSACTION;

UPDATE Comptes
SET Solde = Solde - 100
WHERE Numero_Compte = '123456';

UPDATE Comptes
SET Solde = Solde + 100
WHERE Numero_Compte = '654321';

-- Contrôle d'erreur : pour les systèmes supportant @@ERROR ou équivalent
-- (à adapter selon le SGBD : SQL Server, MySQL, PostgreSQL...)
-- Ici version générique :
-- COMMIT si tout va bien, sinon ROLLBACK
-- Simulé manuellement ici

COMMIT;

-- 4. Création d'une table d’audit pour le suivi des modifications
CREATE TABLE AuditEmployes (
    EmployeID INT,
    AncienSalaire DECIMAL(10,2),
    NouveauSalaire DECIMAL(10,2),
    DateModification DATETIME,
    UtilisateurModif VARCHAR(100)
);

-- 5. Création d'un trigger d’audit sur mise à jour de salaire
DELIMITER //

CREATE TRIGGER trgAuditSalaire
AFTER UPDATE ON Employes
FOR EACH ROW
BEGIN
    IF OLD.Salaire <> NEW.Salaire THEN
        INSERT INTO AuditEmployes (EmployeID, AncienSalaire, NouveauSalaire, DateModification, UtilisateurModif)
        VALUES (
            NEW.ID,
            OLD.Salaire,
            NEW.Salaire,
            NOW(),
            CURRENT_USER()
        );
    END IF;
END //

DELIMITER ;

-- 6. Mise à jour d’un salaire pour déclencher le trigger
UPDATE Employes
SET Salaire = Salaire + 1000
WHERE Nom = 'Alex';

-- 7. Consultation de la table d’audit
SELECT * FROM AuditEmployes;
