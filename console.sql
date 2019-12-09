DROP TABLE Ausleihen;
DROP TABLE Vorbestellungen;
DROP TABLE Person_Fuehrerscheinklasse;
DROP TABLE Kunden;
DROP TABLE Fahrzeuge;
DROP TABLE FahrzeugTypen;
DROP TABLE Fuehrerscheinklassen;
DROP TABLE Hersteller;
DROP TABLE FahrzeugArten;

DROP SEQUENCE FAHRZEUG_SEQ;
DROP SEQUENCE FAHRZEUGTYP_SEQ;
DROP SEQUENCE FAHRZEUGART_SEQ;
DROP SEQUENCE HERSTELLER_SEQ;
DROP SEQUENCE KUNDE_SEQ;
DROP SEQUENCE VORBESTELLUNG_SEQ;

-- Ausgefuehlt
CREATE TABLE FahrzeugArten(
    Art_ID INTEGER PRIMARY KEY,
    Art_Bezeichner VARCHAR(15)
);

-- Ausgefuehlt
CREATE TABLE FahrzeugTypen(
    Typ_ID INTEGER PRIMARY KEY,
    Art_ID INTEGER,
    HID INTEGER,
    Typ_Bezeichner VARCHAR(15),
    Anzahl_Sitze INTEGER,
    Anzahl_Tueren INTEGER,
    zul_Gesamtgewicht INTEGER,
    zul_hoechstgeschw INTEGER
);
-- Ausgefuehlt
CREATE TABLE HERSTELLER(
    HID INTEGER PRIMARY KEY,
    Hersteller_Name VARCHAR(15),
    Adresse VARCHAR(15)
);

-- Ausgefuehlt
CREATE TABLE Fahrzeuge(
    KFZ_NR INTEGER PRIMARY KEY,
    Typ_ID INTEGER,
    Preis_pro_Tag INTEGER,
    Nummernschild VARCHAR(15),
    gelaufene_KM INTEGER,
    naechste_HU DATE,
    naechste_ASU DATE,
    Farbe VARCHAR(15),
    Klimaanlage VARCHAR(15),
    angemeldet_am DATE,
    abgemeldet_am DATE
);

-- Ausgefuehlt
CREATE TABLE Fuehrerscheinklassen(
    KlassenKennung VARCHAR(15) PRIMARY KEY,
    Klassenbezeichnung VARCHAR(15),
    Beschreibung VARCHAR(25)
);

-- Ausgefuehlt
CREATE TABLE Vorbestellungen(
    VID INTEGER PRIMARY KEY,
    PID INTEGER,
    KFZ_NR INTEGER,
    von DATE,
    bis DATE
--     CHECK ( von < bis )

);
--
-- Ausgefuehlt
CREATE TABLE Kunden(
    PID INTEGER PRIMARY KEY ,
    Name VARCHAR(15),
    Strasse VARCHAR(15),
    Ort VARCHAR(15),
    PLZ INTEGER,
    Kontonummer INTEGER,
    BLZ INTEGER
);

-- Ausgefuehlt
CREATE TABLE Ausleihen(
    von DATE,
    bis DATE,
    KFZ_NR INTEGER,
    PID INTEGER,
    PRIMARY KEY (von, bis, KFZ_NR, PID),
    VID INTEGER

);
CREATE TABLE Person_Fuehrerscheinklasse(
    KlassenKennung VARCHAR(45),
    seit DATE,
    PID INTEGER,
    PRIMARY KEY (KlassenKennung, seit, PID),
    Bemerkungen VARCHAR(50)
);


-- ALTER TABLE FahrzeugTypen ADD CONSTRAINT fk_FahrzeugArten FOREIGN KEY (Art_ID) REFERENCES FAHRZEUGARTEN(Art_ID) ON DELETE CASCADE ;
ALTER TABLE FahrzeugTypen ADD CONSTRAINT fk_FahrzeugArten FOREIGN KEY (Art_ID) REFERENCES FAHRZEUGARTEN(Art_ID) ON DELETE SET NULL ;
ALTER TABLE FahrzeugTypen ADD CONSTRAINT fk_Hersteller FOREIGN KEY (HID) REFERENCES Hersteller(HID) ON DELETE CASCADE ;
ALTER TABLE Fahrzeuge ADD CONSTRAINT fk_FahrzeugTypen FOREIGN KEY (Typ_ID) REFERENCES FahrzeugTypen(Typ_ID) ON DELETE CASCADE;
--     ALTER TABLE Vorbestellungen ADD CONSTRAINT fk_Kunden FOREIGN KEY (PID) REFERENCES Kunden(PID) ON DELETE SET NULL ;
    ALTER TABLE Vorbestellungen ADD CONSTRAINT fk_Kunden FOREIGN KEY (PID) REFERENCES Kunden(PID) ON DELETE CASCADE ;
ALTER TABLE Vorbestellungen ADD CONSTRAINT fk_Fahrzeuge FOREIGN KEY (KFZ_NR) REFERENCES Fahrzeuge(KFZ_NR) ON DELETE CASCADE ;
ALTER TABLE Ausleihen ADD CONSTRAINT fk_Fahrzeuge_Ausleihe FOREIGN KEY (KFZ_NR) REFERENCES Fahrzeuge(KFZ_NR) ON DELETE CASCADE ;
--     ALTER TABLE Ausleihen ADD CONSTRAINT fk_Kunde FOREIGN KEY (PID) REFERENCES Kunden(PID) ON DELETE SET NULL ;
    ALTER TABLE Ausleihen ADD CONSTRAINT fk_Kunde FOREIGN KEY (PID) REFERENCES Kunden(PID) ON DELETE CASCADE ;
    ALTER TABLE Ausleihen ADD CONSTRAINT fk_Vorbestellungen FOREIGN KEY (VID) REFERENCES Vorbestellungen(VID) ON DELETE CASCADE ;
--     ALTER TABLE Ausleihen ADD CONSTRAINT fk_Vorbestellungen FOREIGN KEY (VID) REFERENCES Vorbestellungen(VID) ON DELETE SET NULL ;
ALTER TABLE Person_Fuehrerscheinklasse ADD CONSTRAINT fk_Fuehrerscheinklassen FOREIGN KEY (KlassenKennung) REFERENCES Fuehrerscheinklassen(KlassenKennung) ON DELETE CASCADE ;
--     ALTER TABLE Person_Fuehrerscheinklasse ADD CONSTRAINT fk_Kunden_PID FOREIGN KEY (PID) REFERENCES Kunden(PID) ON DELETE SET NULL ;
    ALTER TABLE Person_Fuehrerscheinklasse ADD CONSTRAINT fk_Kunden_PID FOREIGN KEY (PID) REFERENCES Kunden(PID) ON DELETE CASCADE ;

CREATE SEQUENCE FAHRZEUG_SEQ MINVALUE 0 START WITH 1 INCREMENT BY 1 CACHE 20;
CREATE SEQUENCE FAHRZEUGTYP_SEQ MINVALUE 0 START WITH 1 INCREMENT BY 1 CACHE 20;
CREATE SEQUENCE FAHRZEUGART_SEQ MINVALUE 0 START WITH 1 INCREMENT BY 1 CACHE 20;
CREATE SEQUENCE HERSTELLER_SEQ MINVALUE 0 START WITH 1 INCREMENT BY 1 CACHE 20;
CREATE SEQUENCE KUNDE_SEQ MINVALUE 0 START WITH 1 INCREMENT BY 1 CACHE 20;
CREATE SEQUENCE VORBESTELLUNG_SEQ MINVALUE 0 START WITH 1 INCREMENT BY 1 CACHE 20;


INSERT INTO HERSTELLER(hid, hersteller_name, adresse) VALUES (HERSTELLER_SEQ.nextval,'Audi','Ingelheim');
INSERT INTO HERSTELLER(hid, hersteller_name, adresse) VALUES (HERSTELLER_SEQ.nextval,'Merceds Benz','Stuttgart');
INSERT INTO HERSTELLER(hid, hersteller_name, adresse) VALUES (HERSTELLER_SEQ.nextval,'VW','Wolfsburg');
INSERT INTO HERSTELLER(hid, hersteller_name, adresse) VALUES (HERSTELLER_SEQ.nextval,'Ford','Köln');
INSERT INTO HERSTELLER(hid, hersteller_name, adresse) VALUES (HERSTELLER_SEQ.nextval,'Opel','Rüsselsheim');
-- INSERT INTO HERSTELLER(hid, hersteller_name, adresse) VALUES (HERSTELLER_SEQ.nextval,'lada','Arbat 17');
-- INSERT INTO HERSTELLER(hid, hersteller_name, adresse) VALUES (HERSTELLER_SEQ.nextval,'lada','Arbat 17');
-- INSERT INTO HERSTELLER(hid, hersteller_name, adresse) VALUES (HERSTELLER_SEQ.nextval,'lada','Arbat 17');

INSERT INTO KUNDEN(PID, Name, Strasse, Ort, PLZ, Kontonummer, BLZ) VALUES (KUNDE_SEQ.nextval, 'Name1', 'Strasse1', 'Ort1', 1, 11, 111);
INSERT INTO KUNDEN(PID, Name, Strasse, Ort, PLZ, Kontonummer, BLZ) VALUES (KUNDE_SEQ.nextval, 'Name2', 'Strasse2', 'Ort2', 2, 22, 222);
INSERT INTO KUNDEN(PID, Name, Strasse, Ort, PLZ, Kontonummer, BLZ) VALUES (KUNDE_SEQ.nextval, 'Name3', 'Strasse3', 'Ort3', 3, 33, 333);

INSERT INTO FAHRZEUGARTEN(Art_ID, Art_Bezeichner) VALUES (FAHRZEUGART_SEQ.nextval, 'Limousine');
INSERT INTO FAHRZEUGARTEN(Art_ID, Art_Bezeichner) VALUES (FAHRZEUGART_SEQ.nextval, 'Cabrio');
INSERT INTO FAHRZEUGARTEN(Art_ID, Art_Bezeichner) VALUES (FAHRZEUGART_SEQ.nextval, 'Combi');
INSERT INTO FAHRZEUGARTEN(Art_ID, Art_Bezeichner) VALUES (FAHRZEUGART_SEQ.nextval, 'KRAD');
INSERT INTO FAHRZEUGARTEN(Art_ID, Art_Bezeichner) VALUES (FAHRZEUGART_SEQ.nextval, 'Leichtkrad');
INSERT INTO FAHRZEUGARTEN(Art_ID, Art_Bezeichner) VALUES (FAHRZEUGART_SEQ.nextval, 'LKW');

INSERT INTO FAHRZEUGTYPEN(Typ_ID, Art_ID, HID, Typ_Bezeichner, Anzahl_Sitze, Anzahl_Tueren, zul_Gesamtgewicht, zul_hoechstgeschw)
    VALUES (FAHRZEUGTYP_SEQ.nextval, 3, 1, 'A4 Avant', 5, 5, 1500, 205);
INSERT INTO FAHRZEUGTYPEN(Typ_ID, Art_ID, HID, Typ_Bezeichner, Anzahl_Sitze, Anzahl_Tueren, zul_Gesamtgewicht, zul_hoechstgeschw)
    VALUES (FAHRZEUGTYP_SEQ.nextval, 2, 2, 'SLK 200', 4, 2, 1200, 225);
INSERT INTO FAHRZEUGTYPEN(Typ_ID, Art_ID, HID, Typ_Bezeichner, Anzahl_Sitze, Anzahl_Tueren, zul_Gesamtgewicht, zul_hoechstgeschw)
    VALUES (FAHRZEUGTYP_SEQ.nextval, 1, 1, 'A3', 5, 3, 1100, 198);
INSERT INTO FAHRZEUGTYPEN(Typ_ID, Art_ID, HID, Typ_Bezeichner, Anzahl_Sitze, Anzahl_Tueren, zul_Gesamtgewicht, zul_hoechstgeschw)
    VALUES (FAHRZEUGTYP_SEQ.nextval, 1, 3, 'Golf', 5, 3, 1150, 202);
INSERT INTO FAHRZEUGTYPEN(Typ_ID, Art_ID, HID, Typ_Bezeichner, Anzahl_Sitze, Anzahl_Tueren, zul_Gesamtgewicht, zul_hoechstgeschw)
    VALUES (FAHRZEUGTYP_SEQ.nextval, 1, 4, 'Focus', 5, 3, 1080, 185);


INSERT INTO FAHRZEUGE(KFZ_NR, Typ_ID, Preis_pro_Tag, Nummernschild, gelaufene_KM, naechste_HU, naechste_ASU, Farbe, Klimaanlage, angemeldet_am, abgemeldet_am)
    VALUES (1296833, 1, 98, 'GM-AL 455', 123450, SYSDATE+100, SYSDATE+100, 'silber', 'JA. Automatisch', SYSDATE-10, NULL );
INSERT INTO FAHRZEUGE(KFZ_NR, Typ_ID, Preis_pro_Tag, Nummernschild, gelaufene_KM, naechste_HU, naechste_ASU, Farbe, Klimaanlage, angemeldet_am, abgemeldet_am)
    VALUES (2334556, 2, 139, 'GM-HG 34', 160000, SYSDATE+120, SYSDATE+120, 'silber', 'JA. Automatish', SYSDATE-90, NULL );
INSERT INTO FAHRZEUGE(KFZ_NR, Typ_ID, Preis_pro_Tag, Nummernschild, gelaufene_KM, naechste_HU, naechste_ASU, Farbe, Klimaanlage, angemeldet_am, abgemeldet_am)
    VALUES (9998767, 3, 56, 'RS-JK 980', 120000, SYSDATE-30, SYSDATE-30, 'gelb', 'JA. Manuel', SYSDATE-160, SYSDATE );
INSERT INTO FAHRZEUGE(KFZ_NR, Typ_ID, Preis_pro_Tag, Nummernschild, gelaufene_KM, naechste_HU, naechste_ASU, Farbe, Klimaanlage, angemeldet_am, abgemeldet_am)
    VALUES (4567673, 4, 37, 'K-LM 2344', 135000, SYSDATE+55, SYSDATE+55, 'blau', 'NEIN', SYSDATE-200, NULL );
INSERT INTO FAHRZEUGE(KFZ_NR, Typ_ID, Preis_pro_Tag, Nummernschild, gelaufene_KM, naechste_HU, naechste_ASU, Farbe, Klimaanlage, angemeldet_am, abgemeldet_am)
    VALUES (8968585, 5, 39, 'GM-LO 780', 89000, SYSDATE+10, SYSDATE+10, 'rot', 'NEIN', SYSDATE-300, NULL );
INSERT INTO FAHRZEUGE(KFZ_NR, Typ_ID, Preis_pro_Tag, Nummernschild, gelaufene_KM, naechste_HU, naechste_ASU, Farbe, Klimaanlage, angemeldet_am, abgemeldet_am)
    VALUES (5696833, 1, 108, 'GM-LB 155', 123450, SYSDATE+100, SYSDATE+100, 'silber', 'JA. Automatisch', SYSDATE-10, NULL );
INSERT INTO FAHRZEUGE(KFZ_NR, Typ_ID, Preis_pro_Tag, Nummernschild, gelaufene_KM, naechste_HU, naechste_ASU, Farbe, Klimaanlage, angemeldet_am, abgemeldet_am)
    VALUES (7834556, 2, 119, 'GL-HF 324', 160000, SYSDATE+120, SYSDATE+120, 'silber', 'JA. Manuel', SYSDATE-90, NULL );
INSERT INTO FAHRZEUGE(KFZ_NR, Typ_ID, Preis_pro_Tag, Nummernschild, gelaufene_KM, naechste_HU, naechste_ASU, Farbe, Klimaanlage, angemeldet_am, abgemeldet_am)
    VALUES (4498767, 3, 66, 'RS-ID 850', 120000, SYSDATE-30, SYSDATE-30, 'gelb', 'JA. Manuel', SYSDATE-160, SYSDATE );
INSERT INTO FAHRZEUGE(KFZ_NR, Typ_ID, Preis_pro_Tag, Nummernschild, gelaufene_KM, naechste_HU, naechste_ASU, Farbe, Klimaanlage, angemeldet_am, abgemeldet_am)
    VALUES (2367673, 4, 57, 'K-DT 1244', 135000, SYSDATE+55, SYSDATE+55, 'blau', 'NEIN', SYSDATE-200, NULL );
INSERT INTO FAHRZEUGE(KFZ_NR, Typ_ID, Preis_pro_Tag, Nummernschild, gelaufene_KM, naechste_HU, naechste_ASU, Farbe, Klimaanlage, angemeldet_am, abgemeldet_am)
    VALUES (4568585, 5, 59, 'GL-LR 180', 89000, SYSDATE+10, SYSDATE+10, 'rot', 'NEIN', SYSDATE-300, NULL );


INSERT INTO VORBESTELLUNGEN(VID, PID, KFZ_NR, von, bis) VALUES (VORBESTELLUNG_SEQ.nextval, 1, 1, '01.01.2001', '02.01.2001');
INSERT INTO VORBESTELLUNGEN(VID, PID, KFZ_NR, von, bis) VALUES (VORBESTELLUNG_SEQ.nextval, 2, 2, '02.02.2002', '03.02.2002');
INSERT INTO VORBESTELLUNGEN(VID, PID, KFZ_NR, von, bis) VALUES (VORBESTELLUNG_SEQ.nextval, 3, 3, '03.03.2003', '04.03.2003');


INSERT INTO AUSLEIHEN(von, bis, KFZ_NR, PID, VID) VALUES ('01.01.2001', '02.01.2001', 1, 1, 1);
INSERT INTO AUSLEIHEN(von, bis, KFZ_NR, PID, VID) VALUES ('02.02.2002', '03.02.2002', 2, 2, 2);
INSERT INTO AUSLEIHEN(von, bis, KFZ_NR, PID, VID) VALUES ('03.03.2003', '04.03.2003', 3, 3, 3);

INSERT INTO FUEHRERSCHEINKLASSEN(KlassenKennung, Klassenbezeichnung, Beschreibung) VALUES ('A1', 'A1', 'Leichtkrafträder');
INSERT INTO FUEHRERSCHEINKLASSEN(KlassenKennung, Klassenbezeichnung, Beschreibung) VALUES ('A', 'A', 'Motorrad');
INSERT INTO FUEHRERSCHEINKLASSEN(KlassenKennung, Klassenbezeichnung, Beschreibung) VALUES ('M', 'M', 'Mofa');
INSERT INTO FUEHRERSCHEINKLASSEN(KlassenKennung, Klassenbezeichnung, Beschreibung) VALUES ('T', 'T', 'Traktor');
INSERT INTO FUEHRERSCHEINKLASSEN(KlassenKennung, Klassenbezeichnung, Beschreibung) VALUES ('C1', 'C1', 'Klein-LKW');
INSERT INTO FUEHRERSCHEINKLASSEN(KlassenKennung, Klassenbezeichnung, Beschreibung) VALUES ('C', 'C', 'Gross-LKW');
INSERT INTO FUEHRERSCHEINKLASSEN(KlassenKennung, Klassenbezeichnung, Beschreibung) VALUES ('B', 'B', 'PKW');
INSERT INTO FUEHRERSCHEINKLASSEN(KlassenKennung, Klassenbezeichnung, Beschreibung) VALUES ('BE', 'BE', 'PKW mit Anhänger');

INSERT INTO PERSON_FUEHRERSCHEINKLASSE(KlassenKennung, seit, PID, Bemerkungen) VALUES ('A', '01.01.2001', 1, 'Person A');

-- INSERT INTO PERSON_FUEHRERSCHEINKLASSE(KlassenKennung, seit, PID, Bemerkungen) VALUES ('B', '02.02.2002', 2, 'Person B');

INSERT INTO PERSON_FUEHRERSCHEINKLASSE(KlassenKennung, seit, PID, Bemerkungen) VALUES ('A1', '03.03.2003', 2, 'Person C');
INSERT INTO PERSON_FUEHRERSCHEINKLASSE(KlassenKennung, seit, PID, Bemerkungen) VALUES ('A', '03.03.2003', 2, 'Person C');
INSERT INTO PERSON_FUEHRERSCHEINKLASSE(KlassenKennung, seit, PID, Bemerkungen) VALUES ('M', '03.03.2003', 2, 'Person C');
INSERT INTO PERSON_FUEHRERSCHEINKLASSE(KlassenKennung, seit, PID, Bemerkungen) VALUES ('T', '03.03.2003', 2, 'Person C');
INSERT INTO PERSON_FUEHRERSCHEINKLASSE(KlassenKennung, seit, PID, Bemerkungen) VALUES ('C1', '03.03.2003', 2, 'Person C');
INSERT INTO PERSON_FUEHRERSCHEINKLASSE(KlassenKennung, seit, PID, Bemerkungen) VALUES ('C', '03.03.2003', 2, 'Person C');
INSERT INTO PERSON_FUEHRERSCHEINKLASSE(KlassenKennung, seit, PID, Bemerkungen) VALUES ('B', '03.03.2003', 2, 'Person C');
INSERT INTO PERSON_FUEHRERSCHEINKLASSE(KlassenKennung, seit, PID, Bemerkungen) VALUES ('BE', '03.03.2003', 2, 'Person C');

INSERT INTO PERSON_FUEHRERSCHEINKLASSE(KlassenKennung, seit, PID, Bemerkungen) VALUES ('A1', '03.03.2003', 3, 'Person C');
INSERT INTO PERSON_FUEHRERSCHEINKLASSE(KlassenKennung, seit, PID, Bemerkungen) VALUES ('A', '03.03.2003', 3, 'Person C');
INSERT INTO PERSON_FUEHRERSCHEINKLASSE(KlassenKennung, seit, PID, Bemerkungen) VALUES ('M', '03.03.2003', 3, 'Person C');
INSERT INTO PERSON_FUEHRERSCHEINKLASSE(KlassenKennung, seit, PID, Bemerkungen) VALUES ('T', '03.03.2003', 3, 'Person C');
INSERT INTO PERSON_FUEHRERSCHEINKLASSE(KlassenKennung, seit, PID, Bemerkungen) VALUES ('C1', '03.03.2003', 3, 'Person C');
INSERT INTO PERSON_FUEHRERSCHEINKLASSE(KlassenKennung, seit, PID, Bemerkungen) VALUES ('C', '03.03.2003', 3, 'Person C');
INSERT INTO PERSON_FUEHRERSCHEINKLASSE(KlassenKennung, seit, PID, Bemerkungen) VALUES ('B', '03.03.2003', 3, 'Person C');
INSERT INTO PERSON_FUEHRERSCHEINKLASSE(KlassenKennung, seit, PID, Bemerkungen) VALUES ('BE', '03.03.2003', 3, 'Person C');

COMMIT;

CREATE INDEX Ausleihen_Index ON Ausleihen(bis);

                                    -- AUFGABE 1.A oder B
ALTER TABLE HERSTELLER ADD CONSTRAINT hersteller_check CHECK ( HID IS NOT NULL );

                                    -- AUFGABE 1.C
-- DELETE FROM AUSLEIHEN WHERE PID=1;
-- DELETE FROM VORBESTELLUNGEN WHERE PID = 1;
-- DELETE FROM PERSON_FUEHRERSCHEINKLASSE WHERE PID = 1;

                                    -- AUFGABE 1.D
-- DELETE FROM AUSLEIHEN WHERE VID = 2;

                                    -- AUFGABE 1.E
-- DELETE FROM FAHRZEUGTYPEN WHERE Typ_ID = 1;
-- DELETE FROM FAHRZEUGTYPEN WHERE HID = 3;
-- SELECT * FROM FAHRZEUGTYPEN;

                                    -- AUFGABE 1.F
-- SELECT * FROM FUEHRERSCHEINKLASSEN WHERE KlassenKennung = UPPER('a1') ;

                                    -- AUFGABE 1.G
-- ALTER TABLE VORBESTELLUNGEN ADD CONSTRAINT check_date CHECK ( von <= bis );

                                    -- AUFGABE 1.H UNKLAR


-- ALTER TABLE AUSLEIHEN ADD CONSTRAINT date_chq CHECK ( von > bis);
-- ALTER TABLE AUSLEIHEN ADD CONSTRAINT check_ausleihe_vorbestellung CHECK ( von > (SELECT bis FROM Vorbestellungen WHERE VID=(SELECT MAX(VID) FROM Vorbestellungen)));


INSERT INTO HERSTELLER(hid, hersteller_name, adresse) VALUES (HERSTELLER_SEQ.nextval,'Auto 4','Stutgart');
INSERT INTO KUNDEN(PID, Name, Strasse, Ort, PLZ, Kontonummer, BLZ) VALUES (KUNDE_SEQ.nextval, 'Name 4', 'Strasse 4', 'Ort 4', 4, 44, 444);
INSERT INTO FAHRZEUGARTEN(Art_ID, Art_Bezeichner) VALUES (FAHRZEUGART_SEQ.nextval, 'Gelendwagen');
INSERT INTO FAHRZEUGTYPEN(Typ_ID, Art_ID, HID, Typ_Bezeichner, Anzahl_Sitze, Anzahl_Tueren, zul_Gesamtgewicht, zul_hoechstgeschw)
    VALUES (FAHRZEUGTYP_SEQ.nextval, 4, 4, 'Typ 4', 4, 4, 4000, 4400);
INSERT INTO FAHRZEUGE(KFZ_NR, Typ_ID, Preis_pro_Tag, Nummernschild, gelaufene_KM, naechste_HU, naechste_ASU, Farbe, Klimaanlage, angemeldet_am, abgemeldet_am)
    VALUES (FAHRZEUG_SEQ.nextval, 4, 400, 44444, 444, '04.01.2001', '05.01.2001', 'Schwarz', 'Ja', '', '05.01.2001' );
INSERT INTO VORBESTELLUNGEN(VID, PID, KFZ_NR, von, bis) VALUES (VORBESTELLUNG_SEQ.nextval, 4, 4, '08.01.2001', '09.01.2001');
INSERT INTO AUSLEIHEN(von, bis, KFZ_NR, PID, VID) VALUES ('06.01.2001', '07.01.2001', 4, 4, 4);


                                    -- AUFGABE 2.A
SELECT KFZ_NR, Nummernschild, Typ_Bezeichner, Anzahl_Tueren FROM FAHRZEUGE, FAHRZEUGTYPEN WHERE angemeldet_am IS NOT NULL AND Anzahl_Tueren > 2;

                                    -- AUFGABE 2.B UNKLAR


                                    -- AUFGABE 2.C
SELECT KFZ_NR, Nummernschild FROM FAHRZEUGE, FAHRZEUGTYPEN WHERE angemeldet_am IS NULL;

                                    -- AUFGABE 2.D
SELECT Kunden.PID, Kunden.Name, COUNT(*) over ()
FROM Kunden
INNER JOIN Person_Fuehrerscheinklasse on Person_Fuehrerscheinklasse.PID = Kunden.PID
WHERE KlassenKennung IN ('A1', 'A', 'M', 'T', 'C1', 'C', 'B', 'BE' )
GROUP BY Kunden.PID, Kunden.Name HAVING COUNT(Kunden.PID) = 8;




-- SELECT * FROM KUNDEN;
-- SELECT * FROM AUSLEIHEN;
-- SELECT * FROM VORBESTELLUNGEN;
-- SELECT * FROM PERSON_FUEHRERSCHEINKLASSE;
-- SELECT * FROM Vorbestellungen where VID=(SELECT MAX(VID) FROM Vorbestellungen);



