--------------------------------------------------------
-- Archivo creado  - sábado-noviembre-18-2017   
--------------------------------------------------------
DROP VIEW "JUANDA627"."INFORMATION_BILL";
DROP VIEW "JUANDA627"."INFORMATION_BILL_FUN";
DROP TABLE "JUANDA627"."COST_CENTER";
DROP TABLE "JUANDA627"."ITEM";
DROP TABLE "JUANDA627"."PATIENT";
DROP TABLE "JUANDA627"."PATIENT_BILL";
DROP TABLE "JUANDA627"."PATIENT_BILL_DETAIL";
DROP SEQUENCE "JUANDA627"."ANSWER_SEQ";
DROP SEQUENCE "JUANDA627"."SEQ_ID_COST";
DROP SEQUENCE "JUANDA627"."SEQ_ID_ITEM";
DROP SEQUENCE "JUANDA627"."SEQ_ID_PATIENT";
DROP SEQUENCE "JUANDA627"."SEQ_ID_PATIENT_BILL_DETAIL";
DROP PROCEDURE "JUANDA627"."CHANGE_ITEM_CHARGE";
DROP FUNCTION "JUANDA627"."TOTAL_BALANCE";
DROP FUNCTION "JUANDA627"."TOTAL_NUMBER";
--------------------------------------------------------
--  DDL for View INFORMATION_BILL
--------------------------------------------------------

  CREATE OR REPLACE FORCE VIEW "JUANDA627"."INFORMATION_BILL" ("ID_PATIENT", "PATIENT_NAME", "PATIENT_ADDRESS", "DATE_BILL", "CHARGE", "BALANCE_DUE", "ID_PATIENT_BILL_DETAIL") AS 
  SELECT P.ID_PATIENT,P.PATIENT_NAME, P.PATIENT_ADDRESS, PB.DATE_BILL, PBD.CHARGE, PB.BALANCE_DUE, PBD.ID_PATIENT_BILL_DETAIL
FROM PATIENT P INNER JOIN PATIENT_BILL PB ON P.ID_PATIENT = PB.ID_PATIENT
INNER JOIN PATIENT_BILL_DETAIL PBD ON PB.ID_PATIENT_BILL = PBD.ID_PATIENT_BILL
WHERE PB.BALANCE_DUE = (SELECT MAX(BALANCE_DUE) FROM PATIENT_BILL)
GROUP BY P.ID_PATIENT,P.PATIENT_NAME, P.PATIENT_ADDRESS, PB.DATE_BILL, PBD.CHARGE, PB.BALANCE_DUE, PBD.ID_PATIENT_BILL_DETAIL
;
--------------------------------------------------------
--  DDL for View INFORMATION_BILL_FUN
--------------------------------------------------------

  CREATE OR REPLACE FORCE VIEW "JUANDA627"."INFORMATION_BILL_FUN" ("ID_PATIENT", "PATIENT_NAME", "PATIENT_ADDRESS", "DATE_BILL", "DATE_ADMITTED", "DISCHARGE_DATE", "TOTAL_NUM", "BALANCE_DUE", "CODE_ITEM", "TOTAL_BALANCE", "COSTO") AS 
  SELECT P.ID_PATIENT, P.PATIENT_NAME, P.PATIENT_ADDRESS, PB.DATE_BILL, PB.DATE_ADMITTED, PB.DISCHARGE_DATE
          ,(SELECT TOTAL_NUMBER(100,3500) FROM DUAL) AS TOTAL_NUM, PB.BALANCE_DUE, COUNT(PBD.ID_ITEM_CODE) AS CODE_ITEM,
          (SELECT TOTAL_BALANCE(100,3500) FROM DUAL) AS TOTAL_BALANCE, COUNT(C.ID_COST_CENTER) AS COSTO
    FROM PATIENT_BILL_DETAIL PBD INNER JOIN ITEM I ON PBD.ID_ITEM_CODE = I.ID_ITEM_CODE
       INNER JOIN COST_CENTER C ON I.ID_COST_CENTER = C.ID_COST_CENTER
       INNER JOIN PATIENT_BILL PB ON PB.ID_PATIENT_BILL = PBD.ID_PATIENT_BILL
       INNER JOIN PATIENT P ON P.ID_PATIENT = PB.ID_PATIENT
       WHERE I.ID_COST_CENTER = 100 AND PBD.ID_PATIENT_BILL = 3500
    GROUP BY P.ID_PATIENT, P.PATIENT_NAME, P.PATIENT_ADDRESS, PB.DATE_BILL, PB.DATE_ADMITTED, PB.DISCHARGE_DATE
          ,PB.BALANCE_DUE, PBD.ID_ITEM_CODE,
           C.ID_COST_CENTER
;
--------------------------------------------------------
--  DDL for Table COST_CENTER
--------------------------------------------------------

  CREATE TABLE "JUANDA627"."COST_CENTER" 
   (	"ID_COST_CENTER" NUMBER(*,0), 
	"COST_NAME" VARCHAR2(50 BYTE)
   ) ;
--------------------------------------------------------
--  DDL for Table ITEM
--------------------------------------------------------

  CREATE TABLE "JUANDA627"."ITEM" 
   (	"ID_ITEM_CODE" NUMBER(*,0), 
	"ITEM_DESC" VARCHAR2(50 BYTE), 
	"CHARGE" NUMBER(*,0), 
	"ID_COST_CENTER" NUMBER(*,0), 
	"UNITS_AVAILABLE" NUMBER(*,0)
   ) ;
--------------------------------------------------------
--  DDL for Table PATIENT
--------------------------------------------------------

  CREATE TABLE "JUANDA627"."PATIENT" 
   (	"ID_PATIENT" NUMBER(*,0), 
	"PATIENT_NAME" VARCHAR2(50 BYTE), 
	"PATIENT_ADDRESS" VARCHAR2(50 BYTE), 
	"PATIENT_CITY" VARCHAR2(50 BYTE), 
	"PATIENT_STATE" VARCHAR2(50 BYTE), 
	"PATIENT_ZIP" NUMBER(*,0)
   ) ;
--------------------------------------------------------
--  DDL for Table PATIENT_BILL
--------------------------------------------------------

  CREATE TABLE "JUANDA627"."PATIENT_BILL" 
   (	"ID_PATIENT_BILL" NUMBER(*,0), 
	"ID_PATIENT" NUMBER(*,0), 
	"DATE_BILL" DATE, 
	"DATE_ADMITTED" DATE, 
	"DISCHARGE_DATE" DATE, 
	"BALANCE_DUE" NUMBER(*,0)
   ) ;
--------------------------------------------------------
--  DDL for Table PATIENT_BILL_DETAIL
--------------------------------------------------------

  CREATE TABLE "JUANDA627"."PATIENT_BILL_DETAIL" 
   (	"ID_PATIENT_BILL_DETAIL" NUMBER(*,0), 
	"ID_PATIENT_BILL" NUMBER(*,0), 
	"ID_ITEM_CODE" NUMBER(*,0), 
	"DATE_CHARGED" DATE, 
	"CHARGE" NUMBER(*,0)
   ) ;
--------------------------------------------------------
--  DDL for Sequence ANSWER_SEQ
--------------------------------------------------------

   CREATE SEQUENCE  "JUANDA627"."ANSWER_SEQ"  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 10 START WITH 500 CACHE 20 NOORDER  NOCYCLE ;
--------------------------------------------------------
--  DDL for Sequence SEQ_ID_COST
--------------------------------------------------------

   CREATE SEQUENCE  "JUANDA627"."SEQ_ID_COST"  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 10 START WITH 300 CACHE 20 NOORDER  NOCYCLE ;
--------------------------------------------------------
--  DDL for Sequence SEQ_ID_ITEM
--------------------------------------------------------

   CREATE SEQUENCE  "JUANDA627"."SEQ_ID_ITEM"  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 5 START WITH 1600 CACHE 20 NOORDER  NOCYCLE ;
--------------------------------------------------------
--  DDL for Sequence SEQ_ID_PATIENT
--------------------------------------------------------

   CREATE SEQUENCE  "JUANDA627"."SEQ_ID_PATIENT"  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 100020 CACHE 20 NOORDER  NOCYCLE ;
--------------------------------------------------------
--  DDL for Sequence SEQ_ID_PATIENT_BILL_DETAIL
--------------------------------------------------------

   CREATE SEQUENCE  "JUANDA627"."SEQ_ID_PATIENT_BILL_DETAIL"  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 200000 CACHE 20 NOORDER  NOCYCLE ;
REM INSERTING into JUANDA627.COST_CENTER
SET DEFINE OFF;
Insert into JUANDA627.COST_CENTER (ID_COST_CENTER,COST_NAME) values ('100','Room and Board');
Insert into JUANDA627.COST_CENTER (ID_COST_CENTER,COST_NAME) values ('110','Laboratory');
Insert into JUANDA627.COST_CENTER (ID_COST_CENTER,COST_NAME) values ('120','Radiology');
Insert into JUANDA627.COST_CENTER (ID_COST_CENTER,COST_NAME) values ('130','Pharmacy');
Insert into JUANDA627.COST_CENTER (ID_COST_CENTER,COST_NAME) values ('140','Special Services');
REM INSERTING into JUANDA627.ITEM
SET DEFINE OFF;
Insert into JUANDA627.ITEM (ID_ITEM_CODE,ITEM_DESC,CHARGE,ID_COST_CENTER,UNITS_AVAILABLE) values ('1500','Semi-Pv Room','200','100','62');
Insert into JUANDA627.ITEM (ID_ITEM_CODE,ITEM_DESC,CHARGE,ID_COST_CENTER,UNITS_AVAILABLE) values ('1505','Television','15','100','40');
Insert into JUANDA627.ITEM (ID_ITEM_CODE,ITEM_DESC,CHARGE,ID_COST_CENTER,UNITS_AVAILABLE) values ('1510','Glucose','25','110','43');
Insert into JUANDA627.ITEM (ID_ITEM_CODE,ITEM_DESC,CHARGE,ID_COST_CENTER,UNITS_AVAILABLE) values ('1515','Culture','20','110','37');
Insert into JUANDA627.ITEM (ID_ITEM_CODE,ITEM_DESC,CHARGE,ID_COST_CENTER,UNITS_AVAILABLE) values ('1520','x-ray chest','30','120','52');
Insert into JUANDA627.ITEM (ID_ITEM_CODE,ITEM_DESC,CHARGE,ID_COST_CENTER,UNITS_AVAILABLE) values ('1525','x-ray arm','25','120','39');
Insert into JUANDA627.ITEM (ID_ITEM_CODE,ITEM_DESC,CHARGE,ID_COST_CENTER,UNITS_AVAILABLE) values ('1530','syrups','7','130','82');
Insert into JUANDA627.ITEM (ID_ITEM_CODE,ITEM_DESC,CHARGE,ID_COST_CENTER,UNITS_AVAILABLE) values ('1535','pills','9','130','24');
Insert into JUANDA627.ITEM (ID_ITEM_CODE,ITEM_DESC,CHARGE,ID_COST_CENTER,UNITS_AVAILABLE) values ('1540','injections','9','130','52');
Insert into JUANDA627.ITEM (ID_ITEM_CODE,ITEM_DESC,CHARGE,ID_COST_CENTER,UNITS_AVAILABLE) values ('1545','Pv Room','350','140','71');
Insert into JUANDA627.ITEM (ID_ITEM_CODE,ITEM_DESC,CHARGE,ID_COST_CENTER,UNITS_AVAILABLE) values ('1550','permanent companion','150','140','84');
Insert into JUANDA627.ITEM (ID_ITEM_CODE,ITEM_DESC,CHARGE,ID_COST_CENTER,UNITS_AVAILABLE) values ('1555','ambulance','450','140','33');
REM INSERTING into JUANDA627.PATIENT
SET DEFINE OFF;
Insert into JUANDA627.PATIENT (ID_PATIENT,PATIENT_NAME,PATIENT_ADDRESS,PATIENT_CITY,PATIENT_STATE,PATIENT_ZIP) values ('100000','Andres Felipe Spitaleta','177-2721 Diam. Street','Tiruppur','Tamil Nadu','413574');
Insert into JUANDA627.PATIENT (ID_PATIENT,PATIENT_NAME,PATIENT_ADDRESS,PATIENT_CITY,PATIENT_STATE,PATIENT_ZIP) values ('100001','Adriana Milena Cuervo','853-8710 Metus Rd','La Coruña','Barcelona','44431');
Insert into JUANDA627.PATIENT (ID_PATIENT,PATIENT_NAME,PATIENT_ADDRESS,PATIENT_CITY,PATIENT_STATE,PATIENT_ZIP) values ('100002','Juan David Carrasquilla','Ap #479-531 Suspendisse Street','Mysore','Karnataka','37956');
Insert into JUANDA627.PATIENT (ID_PATIENT,PATIENT_NAME,PATIENT_ADDRESS,PATIENT_CITY,PATIENT_STATE,PATIENT_ZIP) values ('100003','Stella Cadavid Loaiza','7678 Hendrerit Avenue','Siegendorf','Cindrof','39210');
Insert into JUANDA627.PATIENT (ID_PATIENT,PATIENT_NAME,PATIENT_ADDRESS,PATIENT_CITY,PATIENT_STATE,PATIENT_ZIP) values ('100004','Santiago Smith Martinez','3211 Pellentesque Rd','Offenburg','Ortenau','2526');
Insert into JUANDA627.PATIENT (ID_PATIENT,PATIENT_NAME,PATIENT_ADDRESS,PATIENT_CITY,PATIENT_STATE,PATIENT_ZIP) values ('100005','Emily Sophia Williams','689-2762 Lorem, Avenue','Minucciano','Toscana','961100');
Insert into JUANDA627.PATIENT (ID_PATIENT,PATIENT_NAME,PATIENT_ADDRESS,PATIENT_CITY,PATIENT_STATE,PATIENT_ZIP) values ('100006','Jacob Ethan Patrelly','165-5189 Elit, Avenue','Fallais','Bruselas','3270');
Insert into JUANDA627.PATIENT (ID_PATIENT,PATIENT_NAME,PATIENT_ADDRESS,PATIENT_CITY,PATIENT_STATE,PATIENT_ZIP) values ('100007','Madison Madelyn Taylor','129-3144 Curabitur St','San Bernardo','Sevilla','83298895');
Insert into JUANDA627.PATIENT (ID_PATIENT,PATIENT_NAME,PATIENT_ADDRESS,PATIENT_CITY,PATIENT_STATE,PATIENT_ZIP) values ('100008','Owen Hunter Thompson','9805 Erat. St','Gölcük','Kocaeli','789748');
Insert into JUANDA627.PATIENT (ID_PATIENT,PATIENT_NAME,PATIENT_ADDRESS,PATIENT_CITY,PATIENT_STATE,PATIENT_ZIP) values ('100009','Victoria Kennedy Standford','119-3088 Gravida Road','Upper Hutt','Wellington','58857760');
REM INSERTING into JUANDA627.PATIENT_BILL
SET DEFINE OFF;
REM INSERTING into JUANDA627.PATIENT_BILL_DETAIL
SET DEFINE OFF;
REM INSERTING into JUANDA627.INFORMATION_BILL
SET DEFINE OFF;
REM INSERTING into JUANDA627.INFORMATION_BILL_FUN
SET DEFINE OFF;
--------------------------------------------------------
--  DDL for Index SYS_C007090
--------------------------------------------------------

  CREATE UNIQUE INDEX "JUANDA627"."SYS_C007090" ON "JUANDA627"."STUDENTS" ("ID_STUDENT") 
  ;
--------------------------------------------------------
--  DDL for Index SYS_C007091
--------------------------------------------------------

  CREATE UNIQUE INDEX "JUANDA627"."SYS_C007091" ON "JUANDA627"."COURSES" ("ID_COURSES") 
  ;
--------------------------------------------------------
--  DDL for Index SYS_C007092
--------------------------------------------------------

  CREATE UNIQUE INDEX "JUANDA627"."SYS_C007092" ON "JUANDA627"."ATTENDANCE" ("ID_ATTENDANCE") 
  ;
--------------------------------------------------------
--  DDL for Index SYS_C007093
--------------------------------------------------------

  CREATE UNIQUE INDEX "JUANDA627"."SYS_C007093" ON "JUANDA627"."ANSWERS" ("ID_ANSWER") 
  ;
--------------------------------------------------------
--  DDL for Index SYS_C007283
--------------------------------------------------------

  CREATE UNIQUE INDEX "JUANDA627"."SYS_C007283" ON "JUANDA627"."PATIENT" ("ID_PATIENT") 
  ;
--------------------------------------------------------
--  DDL for Index SYS_C007284
--------------------------------------------------------

  CREATE UNIQUE INDEX "JUANDA627"."SYS_C007284" ON "JUANDA627"."COST_CENTER" ("ID_COST_CENTER") 
  ;
--------------------------------------------------------
--  DDL for Index SYS_C007285
--------------------------------------------------------

  CREATE UNIQUE INDEX "JUANDA627"."SYS_C007285" ON "JUANDA627"."ITEM" ("ID_ITEM_CODE") 
  ;
--------------------------------------------------------
--  DDL for Index SYS_C007287
--------------------------------------------------------

  CREATE UNIQUE INDEX "JUANDA627"."SYS_C007287" ON "JUANDA627"."PATIENT_BILL" ("ID_PATIENT_BILL") 
  ;
--------------------------------------------------------
--  DDL for Index SYS_C007289
--------------------------------------------------------

  CREATE UNIQUE INDEX "JUANDA627"."SYS_C007289" ON "JUANDA627"."PATIENT_BILL_DETAIL" ("ID_PATIENT_BILL_DETAIL") 
  ;
--------------------------------------------------------
--  DDL for Trigger TR_UPDATE_STOCK
--------------------------------------------------------

  CREATE OR REPLACE TRIGGER "JUANDA627"."TR_UPDATE_STOCK" 

AFTER INSERT ON PATIENT_BILL_DETAIL
FOR EACH ROW
BEGIN     

UPDATE ITEM SET UNITS_AVAILABLE = UNITS_AVAILABLE - UNITS_AVAILABLE - 1

WHERE  ID_ITEM_CODE = :New.ID_ITEM_CODE;
END;
/
ALTER TRIGGER "JUANDA627"."TR_UPDATE_STOCK" ENABLE;
--------------------------------------------------------
--  DDL for Procedure CHANGE_ITEM_CHARGE
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "JUANDA627"."CHANGE_ITEM_CHARGE" IS
BEGIN
    UPDATE ITEM
    SET CHARGE = (CHARGE*1.02)
    WHERE ID_COST_CENTER IN (SELECT COST_CENTER.ID_COST_CENTER FROM COST_CENTER WHERE COST_NAME = 'Room and board');

    UPDATE ITEM
    SET CHARGE = (CHARGE*1.035)
    WHERE ID_COST_CENTER IN (SELECT COST_CENTER.ID_COST_CENTER FROM COST_CENTER WHERE COST_NAME = 'Laboratory');

    UPDATE ITEM
    SET CHARGE = (CHARGE*1.04)
    WHERE ID_COST_CENTER IN (SELECT COST_CENTER.ID_COST_CENTER FROM COST_CENTER WHERE COST_NAME = 'Radiology');
END;

/
--------------------------------------------------------
--  DDL for Function TOTAL_BALANCE
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "JUANDA627"."TOTAL_BALANCE" (COSTCENTER IN INTEGER, IDBILL IN INTEGER) RETURN INTEGER AS
TOTAL INTEGER := 0;
BEGIN
   SELECT SUM(I.CHARGE)INTO TOTAL FROM PATIENT_BILL_DETAIL PBD INNER JOIN ITEM I ON PBD.ID_ITEM_CODE = I.ID_ITEM_CODE
   INNER JOIN COST_CENTER C ON I.ID_COST_CENTER = C.ID_COST_CENTER
   WHERE I.ID_COST_CENTER = COSTCENTER AND PBD.ID_PATIENT_BILL = IDBILL
   ;
   IF (TOTAL) != 0 THEN
    TOTAL := TOTAL;
   ELSE
    TOTAL := 0;
   END IF;
   RETURN TOTAL;
END;

/
--------------------------------------------------------
--  DDL for Function TOTAL_NUMBER
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "JUANDA627"."TOTAL_NUMBER" (COSTCENTER IN INTEGER, IDBILL IN INTEGER) RETURN INTEGER AS
 TOTAL INTEGER := 0;
BEGIN
   SELECT COUNT(I.ID_ITEM_CODE) INTO TOTAL FROM PATIENT_BILL_DETAIL PBD INNER JOIN ITEM I ON PBD.ID_ITEM_CODE = I.ID_ITEM_CODE
   INNER JOIN COST_CENTER C ON I.ID_COST_CENTER = C.ID_COST_CENTER
   WHERE I.ID_COST_CENTER = COSTCENTER AND PBD.ID_PATIENT_BILL = IDBILL
   ;
   IF (TOTAL) != 0 THEN
    TOTAL := TOTAL;
   ELSE
    TOTAL := 0;
   END IF;
   RETURN TOTAL;
END;

/
--------------------------------------------------------
--  Constraints for Table COST_CENTER
--------------------------------------------------------

  ALTER TABLE "JUANDA627"."COST_CENTER" ADD PRIMARY KEY ("ID_COST_CENTER") ENABLE;
--------------------------------------------------------
--  Constraints for Table ITEM
--------------------------------------------------------

  ALTER TABLE "JUANDA627"."ITEM" ADD PRIMARY KEY ("ID_ITEM_CODE") ENABLE;
--------------------------------------------------------
--  Constraints for Table PATIENT
--------------------------------------------------------

  ALTER TABLE "JUANDA627"."PATIENT" ADD PRIMARY KEY ("ID_PATIENT") ENABLE;
--------------------------------------------------------
--  Constraints for Table PATIENT_BILL
--------------------------------------------------------

  ALTER TABLE "JUANDA627"."PATIENT_BILL" ADD PRIMARY KEY ("ID_PATIENT_BILL") ENABLE;
--------------------------------------------------------
--  Constraints for Table PATIENT_BILL_DETAIL
--------------------------------------------------------

  ALTER TABLE "JUANDA627"."PATIENT_BILL_DETAIL" ADD PRIMARY KEY ("ID_PATIENT_BILL_DETAIL") ENABLE;
--------------------------------------------------------
--  Ref Constraints for Table ITEM
--------------------------------------------------------

  ALTER TABLE "JUANDA627"."ITEM" ADD CONSTRAINT "FK_ID_COST_CENTER" FOREIGN KEY ("ID_COST_CENTER")
	  REFERENCES "JUANDA627"."COST_CENTER" ("ID_COST_CENTER") ENABLE;
--------------------------------------------------------
--  Ref Constraints for Table PATIENT_BILL
--------------------------------------------------------

  ALTER TABLE "JUANDA627"."PATIENT_BILL" ADD CONSTRAINT "FK_ID_PATIENT" FOREIGN KEY ("ID_PATIENT")
	  REFERENCES "JUANDA627"."PATIENT" ("ID_PATIENT") ENABLE;
--------------------------------------------------------
--  Ref Constraints for Table PATIENT_BILL_DETAIL
--------------------------------------------------------

  ALTER TABLE "JUANDA627"."PATIENT_BILL_DETAIL" ADD CONSTRAINT "FK_ID_ITEM_CODE" FOREIGN KEY ("ID_ITEM_CODE")
	  REFERENCES "JUANDA627"."ITEM" ("ID_ITEM_CODE") ENABLE;
  ALTER TABLE "JUANDA627"."PATIENT_BILL_DETAIL" ADD CONSTRAINT "FK_ID_PATIENT_BILL" FOREIGN KEY ("ID_PATIENT_BILL")
	  REFERENCES "JUANDA627"."PATIENT_BILL" ("ID_PATIENT_BILL") ENABLE;
