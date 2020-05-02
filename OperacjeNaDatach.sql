-- SQL #3 Operacje na datach

-- 0. Base data from exercise
create table zakupy (
	id int auto_increment primary key,
    nazwa varchar(50) not null,
    producent varchar(50),
    opis varchar(200),
    cena_produktu double
 );
 
 -- 1. Do tabeli zakupy dodaj kolumnę data_zakupu z datą i czasem zakupu
insert into zakupy (id, nazwa, producent, opis, cena_produktu) values (1, 'czekolada mleczna', 'milka', 'truskawkowa', 3.99);
insert into zakupy (id, nazwa, producent, opis, cena_produktu) values (2, 'czekolada mleczna', 'milka', 'malinowa', 3.99);
insert into zakupy (id, nazwa, producent, opis, cena_produktu) values (3, 'czekolada gorzka', 'wesel', 'malinowa', 3.79);
insert into zakupy (id, nazwa, producent, opis, cena_produktu) values (4, 'ptasie mleczko', 'wedel', 'mango shake', 13.99);
insert into zakupy (id, nazwa, producent, opis, cena_produktu) values (5, 'ptasie mleczko', 'wedel', 'truskawkowy shake', 12.99);
insert into zakupy (id, nazwa, producent, opis, cena_produktu) values (6, 'praliny', 'lindt', 'orzechowe', 31.99);

-- 2. Uzupełnij dane w tabeli różnymi datami
alter table zakupy add column data_zakupu datetime;
update zakupy set data_zakupu='2020-04-01 10:00' where id=1;
update zakupy set data_zakupu='2020-04-16 21:00' where id=2;
update zakupy set data_zakupu='2020-05-02 13:00' where id=3;
update zakupy set data_zakupu='2020-04-30 22:00' where id=4;
update zakupy set data_zakupu='2020-04-12 09:30' where id=5;
update zakupy set data_zakupu='2020-03-31 23:00' where id=6;

-- 3. Wyszukaj zakupy zrobione w ciągu pierwszych 15 dni miesiąca
select * from zakupy where data_zakupu>='2020-04-01 00:00' and data_zakupu<='2020-04-15 00:00' order by id;

-- 4. Wyszukaj zakupy zrobione w ciągu ostatnich 30 dni od aktualnej daty
select * from zakupy where datediff(current_date, data_zakupu)<=30 order by id;

-- 5. Wyszukaj zakupy zrobione po godzinie 20:00
select * from zakupy where hour(data_zakupu)>=20 order by id;

-- 6. Wyświetl wszystkie zakupy posortowane w kolejności od zrobionych ostatnio do najstarszych
select * from zakupy order by data_zakupu DESC;

commit;



