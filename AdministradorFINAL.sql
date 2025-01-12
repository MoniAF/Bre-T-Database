-- TABLESPACES

CREATE TABLESPACE ADMINISTRADOR_TS DATAFILE 'C:\Oracle21CInstall\oradata\ORCLUCR\DB_BRET\ADMINISTRADOR_TS.DBF' SIZE 100M;
CREATE TABLESPACE USER_CONTROL_TS DATAFILE 'C:\Oracle21CInstall\oradata\ORCLUCR\DB_BRET\USER_CONTROL_TS.DBF' SIZE 80M;
CREATE TABLESPACE ACCOUNTING_TS DATAFILE 'C:\Oracle21CInstall\oradata\ORCLUCR\DB_BRET\ACCOUNTING_TS.DBF' SIZE 80M;
CREATE TABLESPACE AUDIT_TS DATAFILE 'C:\Oracle21CInstall\oradata\ORCLUCR\DB_BRET\AUDIT_TS.DBF' SIZE 100M;

--USUARIOS

ALTER SESSION SET "_ORACLE_SCRIPT" = TRUE; 

--**************************************--
CREATE USER ADMIN_BRT IDENTIFIED BY 123456
DEFAULT TABLESPACE ADMINISTRATOR_TS
TEMPORARY TABLESPACE TEMP;

ALTER USER ADMIN_BRT QUOTA UNLIMITED ON ADMINISTRATOR_TS;
GRANT SELECT ON AUDIT_BRT.COMMENTARIES_AUDIT TO ADMIN_BRT;
GRANT SELECT ON AUDIT_BRT.JOBS_AUDIT TO ADMIN_BRT;
GRANT SELECT ON AUDIT_BRT.USERS_AUDIT TO ADMIN_BRT;
GRANT SELECT ON AUDIT_BRT.PROFILES_AUDIT TO ADMIN_BRT;
--**************************************--

--**************************************--
CREATE USER CONTROLDATA_BRT IDENTIFIED BY 123456
DEFAULT TABLESPACE USER_CONTROL_TS
TEMPORARY TABLESPACE TEMP;

ALTER USER CONTROLDATA_BRT QUOTA UNLIMITED ON USER_CONTROL_TS;
GRANT SELECT ON ADMIN_BRT.CATEGORIES TO CONTROLDATA_BRT;
GRANT SELECT ON ADMIN_BRT.JOBS TO CONTROLDATA_BRT;
GRANT SELECT ON ADMIN_BRT.PROFILES TO CONTROLDATA_BRT;
GRANT SELECT ON ADMIN_BRT.TBL_PROFILE_JOBS TO CONTROLDATA_BRT;
--**************************************--

--**************************************--
CREATE USER ACCOUNTANT_BRT IDENTIFIED BY 123456
DEFAULT TABLESPACE ACCOUNTING_TS
TEMPORARY TABLESPACE TEMP;

ALTER USER ACCOUNTANT_BRT QUOTA UNLIMITED ON ACCOUNTING_TS;
GRANT SELECT ON ADMIN_BRT.CATEGORIES TO ACCOUNTANT_BRT;
GRANT SELECT ON ADMIN_BRT.JOBS TO ACCOUNTANT_BRT;
--**************************************--

--**************************************--
CREATE USER TYPIST_BRT IDENTIFIED BY 123456
DEFAULT TABLESPACE USER_CONTROL_TS
TEMPORARY TABLESPACE TEMP;

ALTER USER TYPIST_BRT QUOTA UNLIMITED ON USER_CONTROL_TS;
--**************************************--

--**************************************--
CREATE USER AUDIT_BRT IDENTIFIED BY 123456
DEFAULT TABLESPACE AUDIT_TS
TEMPORARY TABLESPACE TEMP;

ALTER USER AUDIT_BRT QUOTA UNLIMITED ON AUDIT_TS;
GRANT CREATE ANY TRIGGER TO AUDIT_BRT;
--**************************************--

--ROLES Y PERMISOS

--**************************************--
CREATE ROLE ADMIN_DBABRT;
GRANT CONNECT, RESOURCE TO ADMIN_DBABRT;
GRANT ADMIN_DBABRT TO ADMIN_BRT;
--**************************************--

--**************************************--
CREATE ROLE READER_DBABRT;
GRANT CONNECT, RESOURCE TO READER_DBABRT;
GRANT READER_DBABRT TO CONTROLDATA_BRT;
GRANT READER_DBABRT TO ACCOUNTANT_BRT;
GRANT SELECT ON ADMIN_BRT.CATEGORIES TO READER_DBABRT;
GRANT SELECT ON ADMIN_BRT.JOBS TO READER_DBABRT;
GRANT SELECT ON ADMIN_BRT.TBL_PROFILE_JOBS TO READER_DBABRT;
GRANT SELECT ON ADMIN_BRT.PROFILES TO READER_DBABRT;
GRANT SELECT ON ADMIN_BRT.USERS TO READER_DBABRT;
GRANT SELECT ON ADMIN_BRT.COMMENTARIES TO READER_DBABRT;
--**************************************--

--**************************************--
CREATE ROLE TYPIST_DBABRT;
GRANT CONNECT, RESOURCE TO TYPIST_DBABRT;
GRANT TYPIST_DBABRT TO TYPIST_BRT;
GRANT SELECT, INSERT ON ADMIN_BRT.CATEGORIES TO TYPIST_DBABRT;
GRANT SELECT, INSERT ON ADMIN_BRT.JOBS TO TYPIST_DBABRT;
GRANT SELECT, INSERT ON ADMIN_BRT.TBL_PROFILE_JOBS TO TYPIST_DBABRT;
GRANT SELECT, INSERT ON ADMIN_BRT.PROFILES TO TYPIST_DBABRT;
GRANT SELECT, INSERT ON ADMIN_BRT.USERS TO TYPIST_DBABRT;
GRANT SELECT, INSERT ON ADMIN_BRT.COMMENTARIES TO TYPIST_DBABRT;
--**************************************--

--**************************************--
CREATE ROLE AUDITOR_DBABRT;
GRANT CONNECT, RESOURCE TO AUDITOR_DBABRT;
GRANT AUDITOR_DBABRT TO AUDIT_BRT;
GRANT SELECT, INSERT, UPDATE, DELETE ON ADMIN_BRT.USERS TO AUDITOR_DBABRT;
GRANT SELECT, INSERT, UPDATE, DELETE ON ADMIN_BRT.COMMENTARIES TO AUDITOR_DBABRT;
GRANT SELECT, INSERT, UPDATE, DELETE ON ADMIN_BRT.PROFILES TO AUDITOR_DBABRT;
GRANT SELECT, INSERT, UPDATE, DELETE ON ADMIN_BRT.JOBS TO AUDITOR_DBABRT;
--**************************************--

SELECT * FROM ADMIN_BRT.CATEGORIES;
SELECT * FROM ADMIN_BRT.JOBS;
SELECT * FROM ADMIN_BRT.PROFILES;
SELECT * FROM ADMIN_BRT.USERS;
SELECT * FROM ADMIN_BRT.TBL_PROFILE_JOBS;
SELECT * FROM ADMIN_BRT.COMENTARIES;