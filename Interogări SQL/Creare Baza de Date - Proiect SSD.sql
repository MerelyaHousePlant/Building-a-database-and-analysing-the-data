DROP TABLE Sucursale
DROP TABLE Functii
DROP TABLE Angajati
DROP TABLE Infrastructuri_Servicii
DROP TABLE Achizitii
DROP TABLE Furnizori

Create Table Sucursale
(
  id_sucursala int identity(1,1) primary key,
  denumire_sucursala varchar(250)
);

select * from Sucursale

Create Table Functii
(
	id_functie int identity(1,1) primary key,
	denumire_functie varchar(250),
	salariu_baza_brut_min int,
	salariu_baza_brut_max int,
	tip_functie varchar(250)
);

select * from functii


Create Table Angajati
(
	id_angajat int identity(1,1) primary key,
	gender VARCHAR(250) CHECK (gender IN ('M', 'F')),
	nume varchar(250),
	prenume varchar(250),
	email varchar(250),
	telefon CHAR(10),
    CONSTRAINT chk_telefon CHECK (telefon not like '%[^0-9]%'),
	id_sucursala int,
	CONSTRAINT FK_angajati_sucursale FOREIGN KEY (id_sucursala)
    REFERENCES Sucursale (id_sucursala),
	id_functie int,
	CONSTRAINT FK_angajati_functii FOREIGN KEY (id_functie)
    REFERENCES Functii (id_functie),
	salariu int
);

select * from Angajati 
where prenume NOT LIKE '%?%' AND nume NOT LIKE '%?%'

Create Table Infrastructuri_Servicii
(
   id_infrastructura int identity(1,1) primary key,
   denumire_infrastructura varchar(250),
   adresa varchar(250),
   data_valabilitate date,
   informatii_generale varchar(5000),
   conditii_acces varchar(5000),
   id_sucursala int,
   constraint FK_infrastructuri_sucursale foreign key (id_sucursala)
   references Sucursale (id_sucursala)
);

Create Table Furnizori
(
	id_furnizor int identity(1,1) primary key,
	denumire_furnizor varchar(250),
)

select * from Furnizori

Create Table Achizitii
(
	id_achizitie int identity(1,1) primary key,
	id_sucursala int,
	constraint FK_achizitii_sucursale foreign key (id_sucursala)
	references Sucursale (id_sucursala),
	data_achizitie date,
	data_finalizare date,
	obiect varchar(MAX),
	valoare float,
	durata_zile int,
	tip_procedura varchar(MAX),
	id_furnizor int,
	constraint FK_achizitii_furnizori foreign key (id_furnizor)
	references Furnizori (id_furnizor),
	stadiu_executie DECIMAL(5, 2)
)

select * from Achizitii

TRUNCATE TABLE ACHIZITII

TRUNCATE TABLE Angajati

DROP TABLE Achizitii

DBCC CHECKIDENT ('Achizitii', NORESEED);
DBCC CHECKIDENT ('Achizitii', RESEED, 1);
GO

select * from functii

SELECT ROUND(salariu_baza_brut_max +  ((salariu_baza_brut_max-salariu_baza_brut_min) * RAND()),0) as salariu_brut
                     FROM functii
					 WHERE id_functie=1
                  

				  select count(id_achizitie)
				  from achizitii
				  group by id_sucursala


				  select * from achizitii

UPDATE achizitii
SET durata_zile = DATEDIFF(day, data_achizitie, data_finalizare);

delete from achizitii
where durata_zile < 0