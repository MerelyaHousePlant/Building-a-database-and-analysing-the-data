select distinct tip_procedura
FROM Achizitii

UPDATE ACHIZITII
SET tip_procedura = 'Achizitie directa'
WHERE LOWER(tip_procedura) LIKE '%direct%' OR LOWER(tip_procedura) = 'ad';

UPDATE ACHIZITII
SET tip_procedura = 'BRM'
WHERE LOWER(tip_procedura) LIKE '%brm%'

UPDATE ACHIZITII
SET tip_procedura = 'Cerere de oferta'
WHERE LOWER(tip_procedura) LIKE '%cerere de%' OR LOWER(tip_procedura) LIKE 'co%';

UPDATE ACHIZITII
SET tip_procedura = 'Licitatie deschisa'
WHERE LOWER(tip_procedura) LIKE '%licita%' OR LOWER(tip_procedura) LIKE 'ld%';

Update Achizitii
SET tip_procedura = 'Negociere'
WHERE LOWER(tip_procedura) LIKE 'n%';

Update Achizitii
SET tip_procedura = 'Procedura Simpla'
WHERE LOWER(tip_procedura) LIKE 'p%';

select distinct tip_procedura
FROM Achizitii