INSERT INTO Sucursale(denumire_sucursala)
VALUES('Bucuresti')
INSERT INTO Sucursale(denumire_sucursala)
VALUES('Craiova')
INSERT INTO Sucursale(denumire_sucursala)
VALUES('Timisoara')
INSERT INTO Sucursale(denumire_sucursala)
VALUES('Cluj')
INSERT INTO Sucursale(denumire_sucursala)
VALUES('Brasov')
INSERT INTO Sucursale(denumire_sucursala)
VALUES('Iasi')
INSERT INTO Sucursale(denumire_sucursala)
VALUES('Galati')
INSERT INTO Sucursale(denumire_sucursala)
VALUES('Constanta')
select * from Sucursale

ALTER TABLE functii
ADD tip_functie varchar(250);

drop table angajati 

INSERT INTO Functii (denumire_functie, salariu_baza_brut_min, salariu_baza_brut_max, tip_functie)
VALUES
    ('Muncitor necalificat', 3293, 3376, 'muncitor_necalificat'),
    ('Muncitor calificat grad I', 3783, 4308, 'muncitor_calificat'),
    ('Muncitor calificat grad II', 3455, 3855, 'muncitor_calificat'),
    ('Vânzător bilete', 3455, 3520, 'activitate_exploatare'),
    ('Acar', 3520, 3701, 'activitate_exploatare'),
    ('Conductor tren', 3666, 3701, 'activitate_exploatare'),
    ('Informator călători', 3455, 3520, 'activitate_exploatare'),
    ('Magaziner comercial', 3520, 3590, 'activitate_exploatare'),
    ('Manevrant vagoane', 3666, 3855, 'activitate_exploatare'),
    ('Sef tură la comanda personalului de tren', 4532, 4630, 'activitate_exploatare'),
    ('Sef manevră', 3943, 4120, 'activitate_exploatare'),
    ('Casier cf', 3520, 4209, 'activitate_exploatare'),
    ('Casier cf verificator', 4308, 4411, 'activitate_exploatare'),
    ('Sef tren', 3943, 4033, 'activitate_exploatare'),
    ('Mecanic ajutor locomotivă-automotor', 3666, 3701, 'activitate_exploatare'),
    ('Mecanic locomotivă-automotor', 3701, 4507, 'activitate_exploatare'),
    ('Operator manevră în staţii', 4507, 4829, 'activitate_exploatare'),
    ('Operator exploatare comercială', 4033, 4120, 'activitate_exploatare'),
    ('Operator-programator în staţii', 4033, 4308, 'activitate_exploatare'),
    ('Revizor tehnic vagoane', 4209, 4958, 'activitate_exploatare'),
    ('Sef tură', 5075, 5312, 'activitate_exploatare'),
    ('Revizor locomotive-automotoare', 5075, 5312, 'activitate_exploatare'),
    ('Operator', 4411, 5312, 'activitate_exploatare'),
    ('Operator legitimatii calatorie', 4411, 4507, 'activitate_exploatare'),
    ('Instructor', 4724, 5423, 'activitate_exploatare'),
    ('Mecanic instructor', 4724, 5694, 'activitate_exploatare'),
    ('Conductor vagon de dormit şi cuşetă', 3701, 3783, 'activitate_exploatare'),
    ('Şef tură la comanda personalului de servire a vagoanelor restaurant şi de dormit', 4532, 4630, 'activitate_exploatare');

	INSERT INTO Functii (denumire_functie, salariu_baza_brut_min, salariu_baza_brut_max, tip_functie)
VALUES
    ('Lucrător comercial', 3293, 3376, 'circulatia_marfurilor'),
    ('Lucrător gestionar cazare', 3376, 3400, 'circulatia_marfurilor'),
    ('Lucrător gestiune alimentaţie publică', 3293, 3376, 'circulatia_marfurilor');

	INSERT INTO Functii (denumire_functie, salariu_baza_brut_min, salariu_baza_brut_max, tip_functie)
VALUES
    ('Operator calculator electronic', 3855, 3943, 'activitate_informatica');
	

	INSERT INTO Functii (denumire_functie, salariu_baza_brut_min, salariu_baza_brut_max, tip_functie)
VALUES
    ('Sofer', 3783, 3783, 'transport_auto');

	INSERT INTO Functii (denumire_functie, salariu_baza_brut_min, salariu_baza_brut_max, tip_functie)
VALUES
    ('Funcţionar', 3376, 3400, 'functie_executie'),
    ('Sef cabinet', 5423, 5423, 'functie_executie'),
    ('Gestionar materiale', 3666, 3783, 'functie_executie'),
    ('Tehnician, statistician, inspector resurse umane', 3855, 4411, 'functie_executie'),
    ('Contabil', 3590, 4411, 'functie_executie'),
    ('Maistru', 4958, 5196, 'functie_executie'),
    ('Dispecer circulaţie', 4724, 8862, 'functie_executie'),
    ('Inspector de specialitate', 4033, 6264, 'functie_executie'),
    ('Subinginer, inginer colegiu, economist colegiu', 4033, 4614, 'functie_executie'),
    ('Specialist în relaţii publice', 7039, 7943, 'functie_executie'),
    ('Auditor intern', 4949, 8862, 'functie_executie'),
    ('Traducător', 4829, 6670, 'functie_executie'),
    ('Economist, psiholog', 4724, 8862, 'functie_executie'),
    ('Inginer', 4829, 8862, 'functie_executie'),
    ('Specialist resurse umane', 6670, 8862, 'functie_executie'),
    ('Expert achizitii publice', 6670, 8862, 'functie_executie'),
    ('Specialist în domeniul calitatii', 6569, 8862, 'functie_executie'),
    ('Analyst, programator, inginer sistem', 4724, 7406, 'functie_executie'),
    ('Inspector invatamant, sociolog', 4724, 6264, 'functie_executie'),
    ('Consilier juridic', 4724, 8862, 'functie_executie'),
    ('Inspector gestiune', 4033, 5095, 'functie_executie'),
    ('Administrator de sistem', 6670, 7943, 'functie_executie'),
    ('Manager energetic', 8275, 8510, 'functie_executie'),
    ('Asistent director', 8862, 8862, 'functie_executie'),
    ('Revizor regional SC', 6569, 7406, 'functie_executie'),
    ('Instructor regional', 6569, 8147, 'functie_executie'),
    ('Revizor regional ticketing, instructor regional ticketing', 6569, 7406, 'functie_executie'),
    ('Expert relaţii sociale', 8510, 8510, 'functie_executie'),
    ('Instructor central, revizor central SC', 8510, 8862, 'functie_executie'),
    ('Analist sisteme salarizare', 9682, 9682, 'functie_executie'),
    ('Expert economist in gestiunea economica', 9682, 9892, 'functie_executie'),
    ('Consultant in informatica', 9682, 9892, 'functie_executie'),
    ('Responsabil cu protectia datelor cu caracter personal', 8862, 9264, 'functie_executie'),
    ('Sef proiect', 10310, 10310, 'functie_executie');

	INSERT INTO Functii (denumire_functie, salariu_baza_brut_min, salariu_baza_brut_max, tip_functie)
VALUES
    ('Sef agenţie voiaj', 5306, 5306, 'functie_conducere'),
    ('Sef post revizie vagoane, şef punct lucru tracţiune, sef punct comanda personal', 5998, 6141, 'functie_conducere'),
    ('Sef atelier', 5998, 6519, 'functie_conducere'),
    ('Sef secţie administrativă', 7336, 7517, 'functie_conducere'),
    ('Sef birou', 5553, 8671, 'functie_conducere'),
    ('Sef secţie exploatare adjunct', 6229, 6377, 'functie_conducere'),
    ('Sef secţie exploatare', 6377, 6681, 'functie_conducere'),
    ('Sef depou adjunct', 6519, 7564, 'functie_conducere'),
    ('Sef depou', 6878, 9338, 'functie_conducere'),
    ('Sef revizie vagoane adjunct', 6519, 7564, 'functie_conducere'),
    ('Sef revizie vagoane', 6377, 9338, 'functie_conducere'),
    ('Sef staţie adjunct', 6681, 7564, 'functie_conducere'),
    ('Sef statie rezerva', 6377, 6519, 'functie_conducere'),
    ('Sef staţie', 6377, 9338, 'functie_conducere'),
    ('Sef serviciu', 9005, 11517, 'functie_conducere'),
    ('Sef divizie', 10368, 10755, 'functie_conducere'),
    ('Contabil şef', 6519, 11120, 'functie_conducere'),
    ('Sef oficiu', 9005, 11999, 'functie_conducere'),
    ('Sef centru', 10368, 10755, 'functie_conducere'),
    ('Sef centru adjunct', 9338, 9855, 'functie_conducere'),
    ('Manager', 10368, 10368, 'functie_conducere'),
    ('Consilier', 9525, 12850, 'functie_conducere'),
    ('Director adjunct', 13555, 13555, 'functie_conducere'),
    ('Director', 13433, 15950, 'functie_conducere'),
    ('Director general adjunct', 16857, 16857, 'functie_conducere'),
    ('Sef serviciu resurse umane', 11517, 11999, 'functie_conducere'),
    ('Revizor general SC', 15950, 15950, 'functie_conducere'),
    ('Şef oficiu juridic', 15603, 15950, 'functie_conducere');

	select * from functii
	select * from Sucursale
	select denumire_furnizor from furnizori 


	--INSERT INTO Infrastructuri_Servicii(denumire_infrastructura, adresa,data_valabilitate, informatii_generale, conditii_acces, id_sucursala)
	--VALUES
	--('Depoul Bucuresti Călători','Calea Griviței, nr. 347, sector 1
		--Bucuresti','2020','','','')

select * from Achizitii
select * from Sucursale
select dbo.GetFurnizorIdWithPattern('aqua')

TRUNCATE TABLE ACHIZITII

DROP TABLE Achizitii

select * from Achizitii

UPDATE Achizitii
SET durata_zile = DATEDIFF(day, data_achizitie, data_finalizare);

UPDATE achizitii
SET data_achizitie = DATEADD(YEAR, 2000, data_achizitie)
WHERE DATEDIFF(YEAR, data_achizitie, GETDATE()) > 50;


UPDATE Achizitii
SET durata_zile = durata_zile * -1
WHERE durata_zile < 0;

select * from Sucursale
