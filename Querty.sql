CREATE TABLE Patient (ID_Patient INTEGER PRIMARY KEY, Patient_Name VARCHAR(50),
                      Patien_Address VARCHAR(50),Patient_City VARCHAR(50), 
                      Patient_State VARCHAR(50), Patient_ZIP INTEGER );
CREATE TABLE Cost_Center (ID_Cost_Center INTEGER PRIMARY KEY,Cost_Name VARCHAR(50));
CREATE TABLE Item (ID_Item_Code INTEGER PRIMARY KEY, Item_Desc VARCHAR(50),Charge DECIMAL,
                   ID_Cost_Center INTEGER,CONSTRAINT FK_ID_Cost_Center FOREIGN KEY(ID_Cost_Center) REFERENCES Cost_Center(ID_Cost_Center));
CREATE TABLE Patient_Bill(ID_Patient_Bill INTEGER PRIMARY KEY,ID_Patient INTEGER,Date_Bill DATE,
                          Date_Admitted DATE, Discharge_Date DATE,Balance_Due DECIMAL, 
                          CONSTRAINT FK_ID_Patient FOREIGN KEY (ID_Patient) REFERENCES Patient(ID_Patient));
CREATE TABLE Patient_Bill_Detail(ID_Patient_Bill_Detail INTEGER PRIMARY KEY,ID_Patient_Bill INTEGER,
                                                                  ID_Item_Code INTEGER,Date_Charged DATE,Charge DECIMAL,
CONSTRAINT FK_ID_Patient_Bill FOREIGN KEY(ID_Patient_Bill) REFERENCES Patient_Bill(ID_Patient_Bill),
                                 CONSTRAINT FK_ID_Item_Code FOREIGN KEY(ID_Item_Code)REFERENCES Item(ID_Item_Code));  
                                 
                                 
                                 
create sequence seq_id_patient start with 100000 increment by 1;
create sequence seq_id_cost start with 100 increment by 10;
create sequence seq_id_item start with 1500 increment by 5;

INSERT INTO PATIENT VALUES (seq_id_patient.NEXTVAL,'Andres Felipe Spitaleta','177-2721 Diam. Street','Tiruppur','Tamil Nadu','413574');
INSERT INTO PATIENT VALUES (seq_id_patient.NEXTVAL,'Adriana Milena Cuervo','853-8710 Metus Rd','La Coruña','Barcelona','44431');
INSERT INTO PATIENT VALUES (seq_id_patient.NEXTVAL,'Juan David Carrasquilla','Ap #479-531 Suspendisse Street','Mysore','Karnataka','37956');
INSERT INTO PATIENT VALUES (seq_id_patient.NEXTVAL,'Stella Cadavid Loaiza','7678 Hendrerit Avenue','Siegendorf','Cindrof','39210');
INSERT INTO PATIENT VALUES (seq_id_patient.NEXTVAL,'Santiago Smith Martinez','3211 Pellentesque Rd','Offenburg','Ortenau','02526');
INSERT INTO PATIENT VALUES (seq_id_patient.NEXTVAL,'Emily Sophia Williams','689-2762 Lorem, Avenue','Minucciano','Toscana','961100');
INSERT INTO PATIENT VALUES (seq_id_patient.NEXTVAL,'Jacob Ethan Patrelly','165-5189 Elit, Avenue','Fallais','Bruselas','03270');
INSERT INTO PATIENT VALUES (seq_id_patient.NEXTVAL,'Madison Madelyn Taylor','129-3144 Curabitur St','San Bernardo','Sevilla','83298895');
INSERT INTO PATIENT VALUES (seq_id_patient.NEXTVAL,'Owen Hunter Thompson','9805 Erat. St','Gölcük','Kocaeli','789748');
INSERT INTO PATIENT VALUES (seq_id_patient.NEXTVAL,'Victoria Kennedy Standford','119-3088 Gravida Road','Upper Hutt','Wellington','58857760');

INSERT INTO COST_CENTER VALUES (seq_id_cost.NEXTVAL,'Room and food');
INSERT INTO ITEM VALUES (seq_id_item.NEXTVAL,'Semi-Pv Room','200,00',seq_id_cost.CURRVAL);
INSERT INTO ITEM VALUES (seq_id_item.NEXTVAL,'Television','15,00',seq_id_cost.CURRVAL);
INSERT INTO COST_CENTER VALUES (seq_id_cost.NEXTVAL,'Laboratory');
INSERT INTO ITEM VALUES (seq_id_item.NEXTVAL,'Glucose','25,00',seq_id_cost.CURRVAL);
INSERT INTO ITEM VALUES (seq_id_item.NEXTVAL,'Culture','20,00',seq_id_cost.CURRVAL);
INSERT INTO COST_CENTER VALUES (seq_id_cost.NEXTVAL,'Radiology');
INSERT INTO ITEM VALUES (seq_id_item.NEXTVAL,'x-ray chest','30,00',seq_id_cost.CURRVAL);
INSERT INTO ITEM VALUES (seq_id_item.NEXTVAL,'x-ray arm','25,00',seq_id_cost.CURRVAL);
INSERT INTO COST_CENTER VALUES (seq_id_cost.NEXTVAL,'Pharmacy');
INSERT INTO ITEM VALUES (seq_id_item.NEXTVAL,'syrups','7,00',seq_id_cost.CURRVAL);
INSERT INTO ITEM VALUES (seq_id_item.NEXTVAL,'pills','9,00',seq_id_cost.CURRVAL);
INSERT INTO ITEM VALUES (seq_id_item.NEXTVAL,'injections','9,00',seq_id_cost.CURRVAL);
INSERT INTO COST_CENTER VALUES (seq_id_cost.NEXTVAL,'Special Services');
INSERT INTO ITEM VALUES (seq_id_item.NEXTVAL,'Pv Room','350,00',seq_id_cost.CURRVAL);
INSERT INTO ITEM VALUES (seq_id_item.NEXTVAL,'permanent companion','150,00',seq_id_cost.CURRVAL);
INSERT INTO ITEM VALUES (seq_id_item.NEXTVAL,'ambulance','450,00',seq_id_cost.CURRVAL);