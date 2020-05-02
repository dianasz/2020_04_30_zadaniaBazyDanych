-- Tabele do zadania
CREATE TABLE dzial (
  id_dzial INT NOT NULL primary key,
  nazwa_dzialu VARCHAR(45),
  manager VARCHAR(100) NULL);
 
CREATE TABLE pracownik (
  id_pracownik INT NOT NULL primary key,
  imie VARCHAR(45) NOT NULL,
  nazwisko VARCHAR(45) NOT NULL,
  data_urodzenia DATETIME NOT NULL,
  plec VARCHAR(45) NOT NULL);
  
  CREATE TABLE zatrudnienie (
  id_pracownik INT NULL,
  id_dzial INT NULL,
  stanowisko VARCHAR(45) NULL,
  wynagrodzenie DOUBLE NULL,
  data_rozpoczecia DATETIME not NULL,
  data_zakonczenia DATETIME NULL,
  CONSTRAINT id_dzial
    FOREIGN KEY (id_dzial)
    REFERENCES dzial (id_dzial),
  CONSTRAINT id_pracownik
    FOREIGN KEY (id_pracownik)
    REFERENCES pracownik (id_pracownik));

-- Inserty
insert into dzial (id_dzial, nazwa_dzialu, manager) values (1, 'IT', 'Jan Programujący');    
insert into dzial (id_dzial, nazwa_dzialu, manager) values (2, 'HR', 'Janina Zarządzająca');    
insert into dzial (id_dzial, nazwa_dzialu, manager) values (3, 'Support', 'Piotr Wspierający');

insert into pracownik (id_pracownik, imie, nazwisko, data_urodzenia, plec) 
values (10009, 'Patryk', 'Pomidor', '1992-05-01', 'mężczyzna');
insert into pracownik (id_pracownik, imie, nazwisko, data_urodzenia, plec) 
values (10010, 'Renia', 'Rzodkiewka', '1990-05-17', 'kobieta');
insert into pracownik (id_pracownik, imie, nazwisko, data_urodzenia, plec) 
values (10011, 'Czesiek', 'Czosnek', '1990-05-17', 'mężczyzna');
insert into pracownik (id_pracownik, imie, nazwisko, data_urodzenia, plec) 
values (10012, 'Olimpia', 'Ogórek', '1987-12-01', 'kobieta');
insert into pracownik (id_pracownik, imie, nazwisko, data_urodzenia, plec) 
values (10013, 'Zosia', 'Ziemniak', '1970-12-01', 'kobieta');

insert into zatrudnienie (id_pracownik, id_dzial, stanowisko, wynagrodzenie, data_rozpoczecia, data_zakonczenia)
values (10009, 1, 'Developer', 7800, '2016-01-01', '2018-07-31');
insert into zatrudnienie (id_pracownik, id_dzial, stanowisko, wynagrodzenie, data_rozpoczecia, data_zakonczenia)
values (10009, 1, 'Senior Developer', 9800, '2018-08-01', null);
insert into zatrudnienie (id_pracownik, id_dzial, stanowisko, wynagrodzenie, data_rozpoczecia, data_zakonczenia)
values (10010, 2, 'Payment Specialist', 6200, '2018-08-01', '2019-08-31');
insert into zatrudnienie (id_pracownik, id_dzial, stanowisko, wynagrodzenie, data_rozpoczecia, data_zakonczenia)
values (10011, 3, 'Junior Support Specialist', 6900, '2018-08-01', null);
insert into zatrudnienie (id_pracownik, id_dzial, stanowisko, wynagrodzenie, data_rozpoczecia, data_zakonczenia)
values (10012, 1, 'Test Engineer', 7500, '2016-08-01', null);
insert into zatrudnienie (id_pracownik, id_dzial, stanowisko, wynagrodzenie, data_rozpoczecia, data_zakonczenia)
values (10013, 2, 'Senior Test Engineer', 8900, '1989-08-01', null);


-- SQL #4 - Zapytania do przykładowej bazy danych

-- 1. Pobierz zatrudnionych w roku 1990 i później
select p.id_pracownik, p.imie, p.nazwisko, z.data_rozpoczecia 
from pracownik p
join zatrudnienie z
on p.id_pracownik=z.id_pracownik
where z.data_rozpoczecia>='1990-01-01'
order by p.id_pracownik


-- 2. Ile kobiet pracowało do tej pory w firmie?
select * from pracownik where plec='kobieta' order by id_pracownik


-- 3. Pobierz imię, nazwisko oraz nazwę działu pracownika
select distinct p.imie, p.nazwisko, d.nazwa_dzialu from pracownik p
join zatrudnienie z
on p.id_pracownik = z.id_pracownik
join dzial d
on d.id_dzial=z.id_dzial
order by p.id_pracownik


-- 4. Wyświetl imię, nazwisko i datę urodzenia najmłodszej kobiety
select imie, nazwisko, data_urodzenia, datediff(current_date, data_urodzenia) as Najmlodszy from pracownik
where plec='kobieta' 
and datediff(current_date, data_urodzenia) = (select min(datediff(current_date, data_urodzenia)) from pracownik where plec='kobieta');


-- 5. Wyświetl pracownika o numerze 10009 z wszystkimi dotychczasowymi stanowiskami pracy
select p.id_pracownik, p.imie, p.nazwisko, z.stanowisko, z.data_rozpoczecia, z.data_zakonczenia from pracownik p
join zatrudnienie z
on p.id_pracownik = z.id_pracownik
where p.id_pracownik=10009
order by z.data_rozpoczecia;


-- 6. Wyświetl pracowników z aktualnymi stanowiskami pracy
select p.id_pracownik, p.imie, p.nazwisko, z.stanowisko, z.data_rozpoczecia, z.data_zakonczenia from pracownik p
join zatrudnienie z
on p.id_pracownik = z.id_pracownik
where z.data_zakonczenia is null
order by p.id_pracownik, z.data_rozpoczecia;


-- 7. Wyświetl najlepiej zarabiającego pracownika
select p.id_pracownik, p.imie, p.nazwisko, z.stanowisko, z.wynagrodzenie from pracownik p
join zatrudnienie z
on p.id_pracownik = z.id_pracownik
where z.data_zakonczenia is null
and wynagrodzenie=(select max(wynagrodzenie) from zatrudnienie where data_zakonczenia is null)
order by p.id_pracownik, z.data_rozpoczecia;


-- 8. Wyświetl najlepiej i najgorzej zarabiających pracowników
select p.id_pracownik, p.imie, p.nazwisko, z.stanowisko, z.wynagrodzenie from pracownik p
join zatrudnienie z
on p.id_pracownik = z.id_pracownik
where z.data_zakonczenia is null
and wynagrodzenie in ((select max(wynagrodzenie) from zatrudnienie where data_zakonczenia is null), (select min(wynagrodzenie) from zatrudnienie where data_zakonczenia is null))
order by p.id_pracownik, z.data_rozpoczecia;


-- 9. Wyświetl imię i nazwisko pracownika oraz imię i nazwisko managera jego działu
select p.imie, p.nazwisko, d.nazwa_dzialu, d.manager from pracownik p
join zatrudnienie z
on p.id_pracownik = z.id_pracownik
join dzial d
on d.id_dzial=z.id_dzial
where z.data_zakonczenia is null
order by d.nazwa_dzialu, p.id_pracownik;


-- 10. Wyświetl wszystkie stanowiska w firmie. Usuń powtórzenia.
select distinct stanowisko from zatrudnienie order by stanowisko;






    
