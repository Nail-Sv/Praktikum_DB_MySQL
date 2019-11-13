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
-- DROP SEQUENCE FSCHEINE_SEQ;
DROP SEQUENCE VORBESTELLUNG_SEQ;

--

CREATE TABLE FahrzeugArten(
    Art_ID INTEGER PRIMARY KEY,
    Art_Bezeichner VARCHAR(15)
);


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

CREATE TABLE Hersteller(
    HID INTEGER PRIMARY KEY,
    Hersteller_Name VARCHAR(15),
    Adresse VARCHAR(15)
);

CREATE TABLE Fahrzeuge(
    KFZ_NR INTEGER PRIMARY KEY,
    Typ_ID INTEGER,
    Preis_pro_Tag INTEGER,
    Nummernschild INTEGER,
    gelaufene_KM INTEGER,
    naechste_HU DATE,
    naechste_ASU DATE,
    Farbe VARCHAR(15),
    Klimaanlage VARCHAR(15),
    angemeldet_am DATE,
    abgemeldet_am DATE
);

CREATE TABLE Fuehrerscheinklassen(
    KlassenKennung VARCHAR(15) PRIMARY KEY,
    Klassenbezeichnung VARCHAR(15),
    Beschreibung VARCHAR(15)
);

CREATE TABLE Vorbestellungen(
    VID INTEGER PRIMARY KEY,
    PID INTEGER,
    KFZ_NR INTEGER,
    von DATE,
    bis DATE
);

CREATE TABLE Kunden(
    PID INTEGER PRIMARY KEY ,
    Name VARCHAR(15),
    Strasse VARCHAR(15),
    Ort VARCHAR(15),
    PLZ INTEGER,
    Kontonummer INTEGER,
    BLZ INTEGER
);

CREATE TABLE Person_Fuehrerscheinklasse(
    KlassenKennung VARCHAR(15),
    seit DATE,
    PID INTEGER,
    PRIMARY KEY (KlassenKennung, seit, PID),
    Bemerkungen VARCHAR(50)
);

CREATE TABLE Ausleihen(
    von DATE,
    bis DATE,
    KFZ_NR INTEGER,
    PID INTEGER,
    PRIMARY KEY (von, bis, KFZ_NR, PID),
    VID INTEGER

);

ALTER TABLE FahrzeugTypen ADD CONSTRAINT fk_FahrzeugArten FOREIGN KEY (Art_ID) REFERENCES FAHRZEUGARTEN(Art_ID) ON DELETE CASCADE ;
ALTER TABLE FahrzeugTypen ADD CONSTRAINT fk_Hersteller FOREIGN KEY (HID) REFERENCES Hersteller(HID) ON DELETE CASCADE ;
ALTER TABLE Fahrzeuge ADD CONSTRAINT fk_FahrzeugTypen FOREIGN KEY (Typ_ID) REFERENCES FahrzeugTypen(Typ_ID) ON DELETE CASCADE;
    ALTER TABLE Vorbestellungen ADD CONSTRAINT fk_Kunden FOREIGN KEY (PID) REFERENCES Kunden(PID) ON DELETE SET NULL ;
ALTER TABLE Vorbestellungen ADD CONSTRAINT fk_Fahrzeuge FOREIGN KEY (KFZ_NR) REFERENCES Fahrzeuge(KFZ_NR) ON DELETE CASCADE ;
ALTER TABLE Ausleihen ADD CONSTRAINT fk_Fahrzeuge_Ausleihe FOREIGN KEY (KFZ_NR) REFERENCES Fahrzeuge(KFZ_NR) ON DELETE CASCADE ;
    ALTER TABLE Ausleihen ADD CONSTRAINT fk_Kunde FOREIGN KEY (PID) REFERENCES Kunden(PID) ON DELETE SET NULL ;
    ALTER TABLE Ausleihen ADD CONSTRAINT fk_Vorbestellungen FOREIGN KEY (VID) REFERENCES Vorbestellungen(VID) ON DELETE SET NULL ;
ALTER TABLE Person_Fuehrerscheinklasse ADD CONSTRAINT fk_Fuehrerscheinklassen FOREIGN KEY (KlassenKennung) REFERENCES Fuehrerscheinklassen(KlassenKennung) ON DELETE CASCADE ;
    ALTER TABLE Person_Fuehrerscheinklasse ADD CONSTRAINT fk_Kunden_PID FOREIGN KEY (PID) REFERENCES Kunden(PID) ON DELETE SET NULL ;

CREATE SEQUENCE FAHRZEUG_SEQ;
CREATE SEQUENCE FAHRZEUGTYP_SEQ;
CREATE SEQUENCE FAHRZEUGART_SEQ;
CREATE SEQUENCE HERSTELLER_SEQ;
CREATE SEQUENCE KUNDE_SEQ;
-- CREATE SEQUENCE FSCHEINE_SEQ;
CREATE SEQUENCE VORBESTELLUNG_SEQ;


INSERT INTO HERSTELLER(hid, hersteller_name, adresse) VALUES (HERSTELLER_SEQ.nextval,'lada','Arbat 17');
INSERT INTO HERSTELLER(hid, hersteller_name, adresse) VALUES (HERSTELLER_SEQ.nextval,'vaz','Arbat 17555');
INSERT INTO HERSTELLER(hid, hersteller_name, adresse) VALUES (HERSTELLER_SEQ.nextval,'lada','Arbat 17');
INSERT INTO HERSTELLER(hid, hersteller_name, adresse) VALUES (HERSTELLER_SEQ.nextval,'lada','Arbat 17');
INSERT INTO HERSTELLER(hid, hersteller_name, adresse) VALUES (HERSTELLER_SEQ.nextval,'lada','Arbat 17');
INSERT INTO HERSTELLER(hid, hersteller_name, adresse) VALUES (HERSTELLER_SEQ.nextval,'lada','Arbat 17');
INSERT INTO HERSTELLER(hid, hersteller_name, adresse) VALUES (HERSTELLER_SEQ.nextval,'lada','Arbat 17');
INSERT INTO HERSTELLER(hid, hersteller_name, adresse) VALUES (HERSTELLER_SEQ.nextval,'lada','Arbat 17');
SELECT *FROM HERSTELLER;

CREATE INDEX Ausleihen_Index ON Ausleihen(bis)


