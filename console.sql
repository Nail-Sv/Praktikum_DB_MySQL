DROP TABLE Fahrzeug_Fuehrerscheinklasse CASCADE CONSTRAINTS;
DROP TABLE Person_Fuehrerscheinklasse CASCADE CONSTRAINTS;
DROP TABLE Fuehrerscheinklassen CASCADE CONSTRAINTS;
DROP TABLE Ausleihen CASCADE CONSTRAINTS;
DROP TABLE Vorbestellungen CASCADE CONSTRAINTS;
DROP TABLE Fahrzeuge CASCADE CONSTRAINTS;
DROP TABLE FahrzeugTypen CASCADE CONSTRAINTS;
DROP TABLE Hersteller CASCADE CONSTRAINTS;
DROP TABLE Kunden CASCADE CONSTRAINTS;
DROP TABLE FahrzeugArten CASCADE CONSTRAINTS;

DROP VIEW Nichtausleihen_V;
DROP VIEW Ausleihen_V;

DROP SEQUENCE vorb_seq;


CREATE TABLE Fahrzeug_Fuehrerscheinklasse (
       Typ_ID               	NUMBER(9) NOT NULL,
       KlassenKennung       	VARCHAR2(2) NOT NULL
);

ALTER TABLE Fahrzeug_Fuehrerscheinklasse
       ADD  ( CONSTRAINT XPKFahrzeug_Fuehrerscheinklass PRIMARY KEY (
              Typ_ID, KlassenKennung) ) ;


CREATE TABLE Person_Fuehrerscheinklasse (
       KlassenKennung       VARCHAR2(2) NOT NULL,
       PID                          NUMBER(9) NOT NULL,
       seit                          DATE NOT NULL,
       Bemerkungen          VARCHAR2(2000) NULL
);


ALTER TABLE Person_Fuehrerscheinklasse
       ADD  ( CONSTRAINT XPKPerson_Fuehrerscheinklasse PRIMARY KEY (
KlassenKennung, seit, PID) ) ;



CREATE TABLE Fuehrerscheinklassen (
       KlassenKennung         VARCHAR2(2) NOT NULL,
       Klassenbezeichnung   VARCHAR2(50) NOT NULL,
       Beschreibung             VARCHAR2(2000) NULL
);


ALTER TABLE Fuehrerscheinklassen
       ADD  ( CONSTRAINT XPKFuehrerscheinklassen PRIMARY KEY (
              KlassenKennung) ) ;



CREATE TABLE Ausleihen (
       von                  DATE NOT NULL,
       bis                   DATE NOT NULL,
       KFZ_NR           NUMBER(9) NOT NULL,
       PID                  NUMBER(9) NOT NULL,
       VID                  NUMBER(9) NULL,
       CONSTRAINT Vorb_Datum14        CHECK (von <= bis)
);

ALTER TABLE Ausleihen
       ADD  ( CONSTRAINT XPKAusleihen PRIMARY KEY (von, bis, KFZ_NR,
              PID) ) ;



CREATE TABLE Vorbestellungen (
       VID                  NUMBER(9) NOT NULL,
       PID                  NUMBER(9) NOT NULL,
       KFZ_NR           NUMBER(9) NOT NULL,
       von                  DATE NOT NULL,
       bis                  DATE NOT NULL,
       CONSTRAINT Vorb_Datum15   CHECK (von <= bis)
);


ALTER TABLE Vorbestellungen
       ADD  ( CONSTRAINT XPKVorbestellungen PRIMARY KEY (VID) ) ;



CREATE TABLE Fahrzeuge (
       KFZ_NR               	NUMBER(9) NOT NULL,
       Typ_ID               	NUMBER(9) NOT NULL,
       Preis_pro_Tag       	NUMBER(6,2) NOT NULL
                                   	CONSTRAINT preis_grenze7
                                          CHECK (preis_pro_tag >= 0),
       gelaufene_KM         	NUMBER(7) NULL
                                   	CONSTRAINT km_grenze7
                                          CHECK (gelaufene_km >= 0),
       Nummernschild       	 VARCHAR2(20) NOT NULL,
       naechste_HU          	DATE NOT NULL,
       naechste_ASU         	DATE NOT NULL,
       Farbe                	VARCHAR2(20) NULL
                                   	CONSTRAINT farbwahl9
                                          	CHECK (UPPER(farbe) IN ('ROT','GELB','WEISS','SCHWARZ','BLAU','GRUEN','SILBER','BRAUN')),
       Klimaanlage          	VARCHAR2(20) NULL,
       angemeldet_am        	DATE NOT NULL,
       abgemeldet_am        	DATE NULL,
       CONSTRAINT hu_grenze7     CHECK (naechste_HU  < abgemeldet_am AND naechste_HU  > angemeldet_am),
       CONSTRAINT asu_grenze12   CHECK (naechste_ASU < abgemeldet_am AND naechste_ASU > angemeldet_am)
);

ALTER TABLE Fahrzeuge
       ADD  ( CONSTRAINT XPKFahrzeuge PRIMARY KEY (KFZ_NR) ) ;



CREATE TABLE FahrzeugTypen (
       Typ_ID               	NUMBER(9) NOT NULL,
       Art_ID               	NUMBER(9) NOT NULL,
       HID                  	NUMBER(9) NOT NULL,
       Typ_Bezeichner       	VARCHAR2(20) NOT NULL,
       Anzahl_Sitze         	NUMBER(3) NULL,
       Anzahl_Tueren         	NUMBER(2) NULL,
       zul_Gesamtgewicht    	NUMBER(8,2) NOT NULL,
       zul_hoechstgeschw    	NUMBER(3) NOT NULL
);


ALTER TABLE FahrzeugTypen
       ADD  ( CONSTRAINT XPKFahrzeugTypen PRIMARY KEY (Typ_ID) ) ;



CREATE TABLE Hersteller (
       HID                  	NUMBER(9) NOT NULL,
       Hersteller_Name      	VARCHAR2(20) NOT NULL,
       Adresse              	VARCHAR2(20) NOT NULL
);


ALTER TABLE Hersteller
       ADD  ( CONSTRAINT XPKHersteller PRIMARY KEY (HID) ) ;




CREATE TABLE FahrzeugArten (
       Art_ID               	NUMBER(9) NOT NULL,
       Art_Bezeichner       	VARCHAR2(20) NOT NULL
);


ALTER TABLE FahrzeugArten
       ADD  ( CONSTRAINT XPKFahrzeugArten PRIMARY KEY (Art_ID) ) ;



CREATE TABLE Kunden (
       PID                  NUMBER(9) NOT NULL,
       Name               VARCHAR2(50) NOT NULL,
       Strasse            VARCHAR2(50) NOT NULL,
       Ort                   VARCHAR2(50) NOT NULL,
       PLZ                  NUMBER(8) NOT NULL,
       Kontonummer   NUMBER(12) NULL,
       BLZ                  NUMBER(8) NULL
);


ALTER TABLE Kunden
       ADD  ( CONSTRAINT XPKKunden PRIMARY KEY (PID) ) ;


--- Foreign Keys

ALTER TABLE Fahrzeug_Fuehrerscheinklasse
       ADD  ( CONSTRAINT R_23
              FOREIGN KEY (KlassenKennung)
                             REFERENCES Fuehrerscheinklassen ) ;


ALTER TABLE Fahrzeug_Fuehrerscheinklasse
       ADD  ( CONSTRAINT R_22
              FOREIGN KEY (Typ_ID)
                             REFERENCES FahrzeugTypen ) ;


ALTER TABLE Person_Fuehrerscheinklasse
       ADD  ( CONSTRAINT hat_gemacht
              FOREIGN KEY (PID)
                             REFERENCES Kunden ) ;


ALTER TABLE Person_Fuehrerscheinklasse
       ADD  ( CONSTRAINT wurde_gemacht
              FOREIGN KEY (KlassenKennung)
                             REFERENCES Fuehrerscheinklassen ) ;

ALTER TABLE Ausleihen
       ADD  ( CONSTRAINT leiht_aus
              FOREIGN KEY (PID)
                             REFERENCES Kunden ) ;


ALTER TABLE Ausleihen
       ADD  ( CONSTRAINT wird_ausgeliehen
              FOREIGN KEY (KFZ_NR)
                             REFERENCES Fahrzeuge ) ;


ALTER TABLE Vorbestellungen
       ADD  ( CONSTRAINT bestellt_vor
              FOREIGN KEY (PID)
                             REFERENCES Kunden ) ;


ALTER TABLE Vorbestellungen
       ADD  ( CONSTRAINT wird_vorbestellt
              FOREIGN KEY (KFZ_NR)
                             REFERENCES Fahrzeuge ) ;


ALTER TABLE Fahrzeuge
       ADD  ( CONSTRAINT typ_gilt_fuer
              FOREIGN KEY (Typ_ID)
                             REFERENCES FahrzeugTypen ) ;


ALTER TABLE FahrzeugTypen
       ADD  ( CONSTRAINT art_gilt_fuer
              FOREIGN KEY (Art_ID)
                             REFERENCES FahrzeugArten ) ;


ALTER TABLE FahrzeugTypen
       ADD  ( CONSTRAINT bietet_an
              FOREIGN KEY (HID)
                             REFERENCES Hersteller ) ;


---3) Benutzersichten-----------------------------------------------------------------------------------------------------


CREATE OR REPLACE VIEW Nichtausleihen_V AS
       SELECT FahrzeugTypen.Typ_Bezeichner, Fahrzeuge.Nummernschild
       FROM Fahrzeuge, FahrzeugTypen
       WHERE          fahrzeuge.typ_id = fahrzeugtypen.typ_id
AND fahrzeuge.kfz_nr NOT IN (SELECT DISTINCT kfz_nr FROM ausleihen
                             UNION
                             SELECT DISTINCT kfz_nr FROM vorbestellungen)
;


CREATE OR REPLACE VIEW Ausleihen_V AS
       SELECT Kunden.PLZ, Kunden.Ort, FahrzeugArten.Art_Bezeichner, FahrzeugTypen.Typ_Bezeichner, Kunden.Name, Vorbestellungen.VID
       FROM Ausleihen, Kunden, Fahrzeuge, FahrzeugArten, FahrzeugTypen, Vorbestellungen
       WHERE ausleihen.kfz_nr       = fahrzeuge.kfz_nr
       AND fahrzeuge.typ_id         = fahrzeugtypen.typ_id
       AND fahrzeugarten.art_id     = fahrzeugtypen.art_id
       AND ausleihen.pid            = kunden.pid
       AND ausleihen.vid            = vorbestellungen.vid (+)
;

------- 4) Sequenz und Zweitschlüssel------------------------------------------------------


CREATE INDEX XIF12Ausleihen ON Ausleihen
(
       KFZ_NR                         ASC
);

CREATE INDEX XIF14Ausleihen ON Ausleihen
(
       PID                            ASC
);

CREATE INDEX XIF16Ausleihen ON Ausleihen
(
       VID                            ASC
);

--  Datenbestand

INSERT INTO fahrzeugarten VALUES (1,'Limousine');
INSERT INTO fahrzeugarten VALUES (2,'Cabrio');
INSERT INTO fahrzeugarten VALUES (3,'Combi');
INSERT INTO fahrzeugarten VALUES (4,'KRAD');
INSERT INTO fahrzeugarten VALUES (5,'Leichtkrad');
INSERT INTO fahrzeugarten VALUES (6,'LKW');
COMMIT;

INSERT INTO hersteller VALUES (1,'Audi','Ingelheim');
INSERT INTO hersteller VALUES (2,'Merceds Benz','Stuttgart');
INSERT INTO hersteller VALUES (3,'VW','Wolfsburg');
INSERT INTO hersteller VALUES (4,'Ford','K�ln');
INSERT INTO hersteller VALUES (5,'Opel','R�sselsheim');
COMMIT;

INSERT INTO fahrzeugtypen VALUES (1,3,1,'A4 Avant',5,5,1500,205);
INSERT INTO fahrzeugtypen VALUES (2,2,2,'SLK 200',4,2,1200,225);
INSERT INTO fahrzeugtypen VALUES (3,1,1,'A3',5,3,1100,198);
INSERT INTO fahrzeugtypen VALUES (4,1,3,'Golf',5,3,1150,202);
INSERT INTO fahrzeugtypen VALUES (5,1,4,'Focus',5,3,1080,185);
INSERT INTO fahrzeugtypen VALUES (6,3,4,'Vektra',5,3,1996,200);
COMMIT;

INSERT INTO fuehrerscheinklassen VALUES ('A1','Leichtkraftr�der',NULL);
INSERT INTO fuehrerscheinklassen VALUES ('A','Motorr�der',NULL);
INSERT INTO fuehrerscheinklassen VALUES ('M','Mofa','bla');
INSERT INTO fuehrerscheinklassen VALUES ('C1','Klein-LKW',NULL);
INSERT INTO fuehrerscheinklassen VALUES ('C','Gross-LKW',NULL);
INSERT INTO fuehrerscheinklassen VALUES ('B','PKW','blupp');
INSERT INTO fuehrerscheinklassen VALUES ('BE','PKW mit Anh�nger',NULL);
COMMIT;

INSERT INTO Fahrzeug_Fuehrerscheinklasse VALUES (1,'B');
INSERT INTO Fahrzeug_Fuehrerscheinklasse VALUES (2,'B');
INSERT INTO Fahrzeug_Fuehrerscheinklasse VALUES (3,'B');
INSERT INTO Fahrzeug_Fuehrerscheinklasse VALUES (4,'B');
INSERT INTO Fahrzeug_Fuehrerscheinklasse VALUES (5,'B');
INSERT INTO Fahrzeug_Fuehrerscheinklasse VALUES (1,'BE');
INSERT INTO Fahrzeug_Fuehrerscheinklasse VALUES (2,'BE');
INSERT INTO Fahrzeug_Fuehrerscheinklasse VALUES (3,'BE');
INSERT INTO Fahrzeug_Fuehrerscheinklasse VALUES (4,'BE');
INSERT INTO Fahrzeug_Fuehrerscheinklasse VALUES (5,'BE');
INSERT INTO Fahrzeug_Fuehrerscheinklasse VALUES (6,'C');
INSERT INTO Fahrzeug_Fuehrerscheinklasse VALUES (6,'C1');
COMMIT;

INSERT INTO kunden VALUES (1,'A.Meier, Hugo','Bremsweg 13','Braushausen',36909,01245780,37010050);
INSERT INTO kunden VALUES (2,'B.Müller, Erna','Kriechspur 67','Kruvlingen',43677,0167894,27726699);
INSERT INTO kunden VALUES (3,'C.Schmidchen, Anton','Tempoweg 122','Fahrten',19556,09744223,7654321);
INSERT INTO kunden VALUES (4,'D.Bäcker, Emma','Fahrgasse 43','Stoppheim',45889,0987655,1234567);
INSERT INTO kunden VALUES (5,'D.Bäcker, Hugo','Fahrgasse 43','Stoppheim',45889,NULL, NULL);
COMMIT;

-- INSERT INTO person_fuehrerscheinklasse VALUES ('B', 1,SYSDATE-100,NULL);
-- INSERT INTO person_fuehrerscheinklasse VALUES ('B', 2,SYSDATE-200,NULL);
-- INSERT INTO person_fuehrerscheinklasse VALUES ('B', 4,SYSDATE-400,NULL);
-- INSERT INTO person_fuehrerscheinklasse VALUES ('A', 1,SYSDATE-100,NULL);
-- INSERT INTO person_fuehrerscheinklasse VALUES ('A', 2,SYSDATE-150,NULL);
-- INSERT INTO person_fuehrerscheinklasse VALUES ('BE',2,SYSDATE-300,NULL);
-- INSERT INTO person_fuehrerscheinklasse VALUES ('B', 3,SYSDATE-300,NULL);
-- INSERT INTO person_fuehrerscheinklasse VALUES ('BE',3,SYSDATE-200,NULL);
-- INSERT INTO person_fuehrerscheinklasse VALUES ('A1',3,SYSDATE-250,NULL);
-- INSERT INTO person_fuehrerscheinklasse VALUES ('A', 3,SYSDATE-250,NULL);
-- INSERT INTO person_fuehrerscheinklasse VALUES ('C1',3,SYSDATE-250,NULL);
-- INSERT INTO person_fuehrerscheinklasse VALUES ('C', 3,SYSDATE-250,NULL);
-- INSERT INTO person_fuehrerscheinklasse VALUES ('M', 3,SYSDATE-500,NULL);
-- COMMIT;
-- hier andere Daten aus der Excel Tabelle
INSERT INTO person_fuehrerscheinklasse VALUES ('B',	1,	SYSDATE-100,    NULL);
INSERT INTO person_fuehrerscheinklasse VALUES ('B',	2,	SYSDATE-200,	NULL);
INSERT INTO person_fuehrerscheinklasse VALUES ('B',	3,	SYSDATE-300,	NULL);
INSERT INTO person_fuehrerscheinklasse VALUES ('B',	4,	SYSDATE-400,	NULL);
INSERT INTO person_fuehrerscheinklasse VALUES ('A',	1,	SYSDATE-100,	NULL);
INSERT INTO person_fuehrerscheinklasse VALUES ('A',	2,	SYSDATE-150,	NULL);
INSERT INTO person_fuehrerscheinklasse VALUES ('BE', 2,	SYSDATE-300,	NULL);
INSERT INTO person_fuehrerscheinklasse VALUES ('BE', 3,	SYSDATE-250,	NULL);
INSERT INTO person_fuehrerscheinklasse VALUES ('A1', 2,	SYSDATE-100,	NULL);
INSERT INTO person_fuehrerscheinklasse VALUES ('M',	 2,	SYSDATE-200,	NULL);
INSERT INTO person_fuehrerscheinklasse VALUES ('C',  2,	SYSDATE-300,	NULL);
INSERT INTO person_fuehrerscheinklasse VALUES ('C1', 2,	SYSDATE-400,	NULL);
INSERT INTO person_fuehrerscheinklasse VALUES ('A1', 5,	SYSDATE-100,	NULL);
INSERT INTO person_fuehrerscheinklasse VALUES ('A',  5,	SYSDATE-150,    NULL);
INSERT INTO person_fuehrerscheinklasse VALUES ('M',  5,	SYSDATE-300,    NULL);
INSERT INTO person_fuehrerscheinklasse VALUES ('C1', 5,	SYSDATE-250,    NULL);
INSERT INTO person_fuehrerscheinklasse VALUES ('C',  5,	SYSDATE-100,    NULL);
INSERT INTO person_fuehrerscheinklasse VALUES ('B',  5,	SYSDATE-200,    NULL);
INSERT INTO person_fuehrerscheinklasse VALUES ('BE', 5, SYSDATE-300,   NULL);
COMMIT;




INSERT INTO fahrzeuge VALUES (1296833,1,98,123450,'GM-AL 455',SYSDATE+100,SYSDATE+100,'silber','JA. Automatisch',SYSDATE-10,NULL);
INSERT INTO fahrzeuge VALUES (2334556,2,139,160000,'GM-HG 34',SYSDATE+120,SYSDATE+120,'silber','JA. Automatisch',SYSDATE-90,NULL);
INSERT INTO fahrzeuge VALUES (9998767,3,56,152000,'GM-JK 980',SYSDATE-30,SYSDATE-30,'gelb','JA. Manuell',SYSDATE-160,SYSDATE);
INSERT INTO fahrzeuge VALUES (4567673,4,37,135000,'K-LM 2344',SYSDATE+55,SYSDATE+55,'blau','NEIN',SYSDATE-200,NULL);
INSERT INTO fahrzeuge VALUES (8968585,5,39,189000,'GM-LO 780',SYSDATE+10,SYSDATE+10,'rot','NEIN',SYSDATE-300,NULL);
INSERT INTO fahrzeuge VALUES (5696833,1,108,123450,'GM-LB 155',SYSDATE+100,SYSDATE+100,'silber','JA. Automatisch',SYSDATE-10,NULL);
INSERT INTO fahrzeuge VALUES (7834556,2,119,160000,'GL-HF 324',SYSDATE+120,SYSDATE+120,'silber','JA. Automatisch',SYSDATE-90,NULL);
INSERT INTO fahrzeuge VALUES (4498767,3,66,120000,'RS-ID 850',SYSDATE-30,SYSDATE-30,'gelb','JA. Manuell',SYSDATE-160,SYSDATE);
INSERT INTO fahrzeuge VALUES (2367673,4,57,135000,'K-DT 1244',SYSDATE+55,SYSDATE+55,'blau','NEIN',SYSDATE-200,NULL);
INSERT INTO fahrzeuge VALUES (4568585,5,59,089000,'GL-LR 180',SYSDATE+10,SYSDATE+10,'rot','NEIN',SYSDATE-300,NULL);
COMMIT;

CREATE SEQUENCE vorb_seq;

INSERT INTO vorbestellungen VALUES (vorb_seq.nextval,1,2334556,SYSDATE-52,SYSDATE-50);
INSERT INTO vorbestellungen VALUES (vorb_seq.nextval,2,9998767,SYSDATE-30,SYSDATE-29);
INSERT INTO vorbestellungen VALUES (vorb_seq.nextval,3,1296833,SYSDATE-12,SYSDATE-12);
INSERT INTO vorbestellungen VALUES (vorb_seq.nextval,4,8968585,SYSDATE-3,SYSDATE+5);
INSERT INTO vorbestellungen VALUES (vorb_seq.nextval,3,1296833,SYSDATE-1,SYSDATE+2);
INSERT INTO vorbestellungen VALUES (vorb_seq.nextval,1,7834556,SYSDATE+3,SYSDATE+7);
INSERT INTO vorbestellungen VALUES (vorb_seq.nextval,2,2334556,SYSDATE+10,SYSDATE+13);
INSERT INTO vorbestellungen VALUES (vorb_seq.nextval,3,5696833,SYSDATE+11,SYSDATE+12);
INSERT INTO vorbestellungen VALUES (vorb_seq.nextval,4,4567673,SYSDATE+20,SYSDATE+21);
INSERT INTO vorbestellungen VALUES (vorb_seq.nextval,2,7834556,SYSDATE+22,SYSDATE+22);
INSERT INTO vorbestellungen VALUES (vorb_seq.nextval,1,4498767,SYSDATE,SYSDATE+1);
INSERT INTO vorbestellungen VALUES (vorb_seq.nextval,2,2367673,SYSDATE,SYSDATE+2);
COMMIT;


INSERT INTO ausleihen VALUES (SYSDATE-52,SYSDATE-49,2334556,1,1);
INSERT INTO ausleihen VALUES (SYSDATE-30,SYSDATE-29,9998767,2,2);
INSERT INTO ausleihen VALUES (SYSDATE-14,SYSDATE-12,4498767,1,NULL);
INSERT INTO ausleihen VALUES (SYSDATE-19,SYSDATE-17,4498767,3,NULL);
INSERT INTO ausleihen VALUES (SYSDATE-16,SYSDATE-16,7834556,2,NULL);
INSERT INTO ausleihen VALUES (SYSDATE-12,SYSDATE-12,1296833,3,3);
INSERT INTO ausleihen VALUES (SYSDATE-1,SYSDATE+3,1296833,3,5);
INSERT INTO ausleihen VALUES (SYSDATE-13,SYSDATE-11,8968585,2,NULL);
INSERT INTO ausleihen VALUES (SYSDATE-3,SYSDATE+4,8968585,4,4);
INSERT INTO ausleihen VALUES (SYSDATE-8,SYSDATE-5,2367673,1,NULL);
INSERT INTO ausleihen VALUES (SYSDATE,SYSDATE+1,4498767,1,11);
INSERT INTO ausleihen VALUES (SYSDATE,SYSDATE+2,2367673,2,12);
INSERT INTO ausleihen VALUES (SYSDATE,SYSDATE+3,7834556,3,NULL);
INSERT INTO ausleihen VALUES (SYSDATE,SYSDATE+2,5696833,4,NULL);
INSERT INTO ausleihen VALUES (SYSDATE,SYSDATE+1,1296833,1,NULL);
COMMIT;


-- AUFGABE 2.a
/*
 Zeigen Sie alle Fahrzeuge an, die jemals ausgeliehen oder vorbestellt wurden mit deren KFZ-Nr und Nummernschild
 */
SELECT KFZ_NR, NUMMERNSCHILD FROM FAHRZEUGE NATURAL JOIN (SELECT KFZ_NR FROM VORBESTELLUNGEN UNION SELECT KFZ_NR FROM AUSLEIHEN);

-- AUFGABE 2.b
/*
 Gibt es Fahrzeuge, die noch nie ausgeliehen wurden? (Anzeige: KFZ_NR, Nummernschild)
Lösen Sie diese Aufgabe auf zwei verschiedenen Wegen. Einmal entsprechend dem obigen Opera-
torbaum und je einmal mit NOT IN und NOT EXISTS und einmal mit einem der OUTER JOIN- Operatoren!
 */
SELECT KFZ_NR, NUMMERNSCHILD FROM FAHRZEUGE NATURAL JOIN (SELECT KFZ_NR FROM FAHRZEUGE MINUS SELECT KFZ_NR FROM AUSLEIHEN);

-- NOT IN
SELECT KFZ_NR, NUMMERNSCHILD FROM FAHRZEUGE WHERE KFZ_NR NOT IN (SELECT DISTINCT KFZ_NR FROM AUSLEIHEN);

-- NOT EXISTS
SELECT KFZ_NR, NUMMERNSCHILD FROM FAHRZEUGE WHERE NOT EXISTS (SELECT * FROM AUSLEIHEN WHERE Ausleihen.KFZ_NR = Fahrzeuge.KFZ_NR);

-- OUTER JOIN ??????????????????
SELECT Fahrzeuge.KFZ_NR, Fahrzeuge.NUMMERNSCHILD FROM FAHRZEUGE
LEFT JOIN AUSLEIHEN on (Ausleihen.KFZ_NR = Fahrzeuge.KFZ_NR);


-- AUFGABE 2.c DISTINCT da ein Auto 2 mal wiederholt
/*
 Welche Fahrzeuge, die schon mal vorbestellt wurden bzw. sind, haben mehr als zwei Türen?
 Geben Sie die KFZ_NR, das Nummernschild und den Typ_Bezeichner sowie die Anzahl der Türen aus!
 */

SELECT DISTINCT KFZ_NR, NUMMERNSCHILD, Typ_Bezeichner, Anzahl_Tueren
FROM (FAHRZEUGE NATURAL JOIN  VORBESTELLUNGEN)
NATURAL JOIN (SELECT * FROM FAHRZEUGTYPEN WHERE Anzahl_Tueren > 2);

-- AUFGABE 2.d
/*
 Welche Kunden (Anzeige: Pid, Name, Strasse, PLZ, Ort) haben alle Führerscheinklassen, die in der Tabelle Führerscheinklassen erfasst sind?
 */

SELECT a.PID, a.Name, a.Strasse, a.PLZ, a.Ort FROM KUNDEN a
WHERE NOT EXISTS( SELECT t.KlassenKennung FROM FUEHRERSCHEINKLASSEN t
WHERE NOT EXISTS(SELECT b.PID, b.KlassenKennung FROM PERSON_FUEHRERSCHEINKLASSE b WHERE a.PID = b.PID AND t.KlassenKennung = b.KLASSENKENNUNG));

SELECT DISTINCT PID, Name, Strasse, PLZ, Ort FROM KUNDEN NATURAL JOIN FUEHRERSCHEINKLASSEN
WHERE NOT EXISTS( SELECT t.KlassenKennung FROM FUEHRERSCHEINKLASSEN t
WHERE NOT EXISTS(SELECT b.PID, b.KlassenKennung FROM PERSON_FUEHRERSCHEINKLASSE b WHERE Kunden.PID = b.PID AND t.KlassenKennung = b.KLASSENKENNUNG));

SELECT PID,Name,Strasse,PLZ,Ort FROM Kunden WHERE PID NOT IN(
SELECT DISTINCT PID FROM ( --In der Liste gibt's mehr keine Kunde mit alle Fuehrerscheinklassen
SELECT PID, KlassenKennung FROM Kunden, Fuehrerscheinklassen
MINUS
SELECT PID, KlassenKennung FROM Person_Fuehrerscheinklasse));


-- AUFGABE 3.a
/*
 Welche schon mal ausgeliehenen Limousinen mit als 150.000 gelaufen Kilometern sind in Gummersbach zugelassen (Nummernschild fängt mit GM an)
 und müssen bis zum 1.5.2020 zur HU (Hauptuntersuchung)? Geben Sie die KFZ_NR, das Nummernschild und den Typ_Bezeichner aus!
 */
SELECT f.KFZ_NR, f.Nummernschild, ft.Typ_Bezeichner FROM FAHRZEUGE f, FAHRZEUGTYPEN ft
WHERE f.Typ_ID = ft.Typ_ID
AND ft.Art_ID = 1
AND f.gelaufene_KM > 150000
AND f.Nummernschild LIKE 'GM%'
AND f.naechste_HU < '1.5.2020';

-- AUFGABE 3.b
-- Welche Kunden haben die meisten Fahrzeuge ausgeliehen? (Anzeige: PID und absteigend sortiert den Namen sowie die maximale Anzahl)

SELECT k.PID, k.Name, count(a.PID)
FROM  KUNDEN k, AUSLEIHEN a
WHERE k.PID = a.PID
GROUP BY a.PID, k.Name, k.PID
ORDER BY k.Name ASC;

SELECT k.PID, k.Name, count(a.PID)
FROM  KUNDEN k, AUSLEIHEN a
WHERE k.PID = a.PID
GROUP BY a.PID, k.Name, k.PID
ORDER BY a.PID ASC;

-- AUFGABE 3.c
/*
 Modifizieren Sie die Anfrage 2 a) derart, dass eine dritte Spalte angezeigt wird, die kennzeichnet, ob dieses Fahrzeug vorbestellt (‘V‘)
 oder ausgeliehen (‘A‘) wurde.
 Zu diesem Zweck können Sie die SELECT- Klausel erweitern um eine Spalte mit konstantem Wert, der zugleich ein Name gegeben werden kann:
 SELECT ... , ‘A‘ Status ...
 */

SELECT KFZ_NR, Nummernschild, Status FROM FAHRZEUGE NATURAL JOIN (
SELECT KFZ_NR, 'V' as Status FROM VORBESTELLUNGEN
UNION SELECT KFZ_NR, 'A' as Status FROM AUSLEIHEN);

-- AUFGABE 3.d
/*
 Gibt es Fahrzeuge mit dem gleichen Typ_Bezeichner in der Datenbank? Anders ausgedrückt, kommt ein Typ in der Fahrzeugen mehrfach vor?
 (mehr als zweimal) JA, A4 AVANT von 1233 und 5633
 Es sollen also alle Typ-Bezeichner angezeigt werden, für die es mehrere Fahrzeuge gibt. Anzeige: Typ_Bezeichner, KFZ_Nr.
 Ordnen Sie die Ausgabe nach Typ_Bezeichner absteigend und nach der KFZ_Nr aufsteigend!
 */

SELECT KFZ_NR, Typ_Bezeichner FROM FAHRZEUGE
NATURAL JOIN FAHRZEUGTYPEN
WHERE Typ_Bezeichner IN
(SELECT Typ_Bezeichner FROM FAHRZEUGTYPEN
NATURAL JOIN FAHRZEUGE
GROUP BY Typ_Bezeichner
HAVING (COUNT(Typ_Bezeichner) > 1))
ORDER BY Typ_Bezeichner DESC,
KFZ_NR ASC;

