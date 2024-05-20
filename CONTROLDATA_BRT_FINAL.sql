SELECT * FROM ADMIN_BRT.CATEGORIES;
SELECT * FROM ADMIN_BRT.JOBS;
SELECT * FROM ADMIN_BRT.PROFILES;
SELECT * FROM ADMIN_BRT.USERS;
SELECT * FROM ADMIN_BRT.TBL_PROFILE_JOBS;
SELECT * FROM ADMIN_BRT.COMENTARIES;

--*************************************************************--

--FUNCIONES
--CANTIDAD DE TRABAJOS AL INGRESAR UNA CATEGORIA
CREATE OR REPLACE FUNCTION CANT_JOBS (pCATEGORIA NUMBER)
RETURN NUMBER AS
    VC_JOBS NUMBER := 0;
BEGIN
    SELECT
    COUNT(IDJOB) AS CANT_JOBS
    INTO VC_JOBS
    FROM ADMIN_BRT.JOBS
    INNER JOIN ADMIN_BRT.CATEGORIES ON JOBS.IDCATEGORY = CATEGORIES.IDCATEGORY
    WHERE JOBS.IDCATEGORY = pCATEGORIA;
        
    IF VC_JOBS = 0 THEN
        RETURN -1;
    ELSE
        RETURN VC_JOBS;
    END IF;
END;

SELECT CANT_JOBS(1) AS CANTIDAD_JOBS FROM DUAL;

--*************************************************************--

--RETORNAR LA PROVINCIA CON MAYOR CANTIDAD DE TRABAJOS
CREATE OR REPLACE FUNCTION FN_PROVINCIA_MAYOR_TRABAJOS
RETURN VARCHAR AS

VMAYORPROVINCIA VARCHAR(30) := '';
VCANTIDADTRABAJOS NUMBER :=0;

BEGIN

    SELECT P.PROVINCE, COUNT(J.IDJOB)
    INTO VMAYORPROVINCIA, VCANTIDADTRABAJOS
    FROM ADMIN_BRT.PROFILES P
    INNER JOIN ADMIN_BRT.TBL_PROFILE_JOBS T ON T.IDPROFILE = P.IDPROFILE
    INNER JOIN ADMIN_BRT.JOBS J ON J.IDJOB = T.IDJOB
    GROUP BY P.PROVINCE
    ORDER BY COUNT(J.IDJOB) DESC
    FETCH FIRST 1 ROWS ONLY;
    
    IF VCANTIDADTRABAJOS !=0 THEN
    
        RETURN VMAYORPROVINCIA;
    
    ELSE
    
        RETURN 'Aun no hay provincia donde se haya registrado trabajos';
    
    END IF;

END;

SELECT FN_PROVINCIA_MAYOR_TRABAJOS AS PROVINCIA_CON_MAYOR_CANTIDAD_TRABAJOS FROM DUAL;

--*************************************************************--

--RETORNAR LA PROVINCIA CON MENOR CANTIDAD DE TRABAJOS
CREATE OR REPLACE FUNCTION FN_PROVINCIA_MENOR_TRABAJOS
RETURN VARCHAR AS

VMAYORPROVINCIA VARCHAR(30) := '';
VCANTIDADTRABAJOS NUMBER :=0;

BEGIN

    SELECT P.PROVINCE, COUNT(J.IDJOB)
    INTO VMAYORPROVINCIA, VCANTIDADTRABAJOS
    FROM ADMIN_BRT.PROFILES P
    INNER JOIN ADMIN_BRT.TBL_PROFILE_JOBS T ON T.IDPROFILE = P.IDPROFILE
    INNER JOIN ADMIN_BRT.JOBS J ON J.IDJOB = T.IDJOB
    GROUP BY P.PROVINCE
    ORDER BY COUNT(J.IDJOB) ASC
    FETCH FIRST 1 ROWS ONLY;
    
    IF VCANTIDADTRABAJOS != 0 THEN
    
        RETURN VMAYORPROVINCIA;
    
    ELSE
    
        RETURN 'Aun no hay provincia donde se haya registrado trabajos';
    
    END IF;

END;

SELECT FN_PROVINCIA_MENOR_TRABAJOS AS PROVINCIA_CON_MENOR_CANTIDAD_TRABAJOS FROM DUAL;

--*************************************************************--

--RETORNAR EL TRABAJO CON MAYOR COSTO
CREATE OR REPLACE FUNCTION FN_TRABAJO_MAYOR_COSTO
RETURN VARCHAR2 AS

VMAYORCOSTOTRABAJO VARCHAR2(80) := '';
VCANTIDADTRABAJOS  NUMBER := 0;

BEGIN

    SELECT COUNT(IDJOB)
    INTO VCANTIDADTRABAJOS
    FROM ADMIN_BRT.JOBS;
    
    IF VCANTIDADTRABAJOS != 0 THEN
    
    SELECT NAMEJOB
    INTO VMAYORCOSTOTRABAJO
    FROM ADMIN_BRT.JOBS
    ORDER BY COST DESC
    FETCH FIRST 1 ROWS ONLY;
    
    RETURN VMAYORCOSTOTRABAJO;
    
    ELSE
    
        RETURN 'Aun no hay trabajos registrados';
    
    END IF;

END;

SELECT FN_TRABAJO_MAYOR_COSTO AS TRABAJO_CON_MAYOR_COSTO FROM DUAL;

--*************************************************************--

--RETORNAR EL TRABAJO CON MENOR COSTO
CREATE OR REPLACE FUNCTION FN_TRABAJO_MENOR_COSTO
RETURN VARCHAR2 AS

VMENORCOSTOTRABAJO VARCHAR2(80) := '';
VCANTIDADTRABAJOS  NUMBER := 0;

BEGIN

    SELECT COUNT(IDJOB)
    INTO VCANTIDADTRABAJOS
    FROM ADMIN_BRT.JOBS;
    
    IF VCANTIDADTRABAJOS != 0 THEN
         
    SELECT NAMEJOB
    INTO VMENORCOSTOTRABAJO
    FROM ADMIN_BRT.JOBS
    ORDER BY COST ASC
    FETCH FIRST 1 ROWS ONLY;
    
    RETURN VMENORCOSTOTRABAJO;
    
    ELSE
    
        RETURN 'Aun no hay trabajos registrados';
    
    END IF;

END;

SELECT FN_TRABAJO_MENOR_COSTO AS TRABAJO_CON_MENOR_COSTO FROM DUAL;

--*************************************************************--

--RETORNAR EL TRABAJO CON MAYOR COSTO EN UN A�O ESPECIFICO
CREATE OR REPLACE FUNCTION FN_TRABAJO_MAYOR_COSTO_ANNO(PANNO NUMBER)
RETURN VARCHAR2 AS

VMAYORCOSTOTRABAJOANNO VARCHAR2(80) := '';
VID NUMBER := 0;

BEGIN

    SELECT COUNT(IDJOB)
    INTO VID
    FROM ADMIN_BRT.JOBS
    WHERE TO_CHAR(CREATION_DATE, 'YYYY') = PANNO;
    
    IF VID != 0 THEN
    
    SELECT NAMEJOB
    INTO VMAYORCOSTOTRABAJOANNO
    FROM ADMIN_BRT.JOBS
    WHERE TO_CHAR(CREATION_DATE, 'YYYY') = PANNO
    ORDER BY COST DESC
    FETCH FIRST 1 ROWS ONLY;
    
    RETURN VMAYORCOSTOTRABAJOANNO;
    
    ELSE
    
        RETURN 'En este a�o no se crearon trabajos';
    
    END IF;

END;

SELECT FN_TRABAJO_MAYOR_COSTO_ANNO(2023) AS TRABAJO_CON_MAYOR_COSTO FROM DUAL;

--*************************************************************--

--RETORNAR EL TRABAJO CON MENOR COSTO EN UN A�O ESPECIFICO
CREATE OR REPLACE FUNCTION FN_TRABAJO_MENOR_COSTO_ANNO(PANNO NUMBER)
RETURN VARCHAR2 AS

VMENORCOSTOTRABAJOANNO VARCHAR2(80) := '';
VID NUMBER := 0;

BEGIN

    SELECT COUNT(IDJOB)
    INTO VID
    FROM ADMIN_BRT.JOBS
    WHERE TO_CHAR(CREATION_DATE, 'YYYY') = PANNO;
    
    IF VID != 0 THEN
    
    SELECT NAMEJOB
    INTO VMENORCOSTOTRABAJOANNO
    FROM ADMIN_BRT.JOBS
    WHERE TO_CHAR(CREATION_DATE, 'YYYY') = PANNO
    ORDER BY COST ASC
    FETCH FIRST 1 ROWS ONLY;
    
    RETURN VMENORCOSTOTRABAJOANNO;
    
    ELSE
    
        RETURN 'En este a�o no se crearon trabajos';
    
    END IF;

END;

SELECT FN_TRABAJO_MENOR_COSTO_ANNO(2023) AS TRABAJO_CON_MAYOR_COSTO FROM DUAL;

--*************************************************************--
--PROCEDIMIENTOS
SET SERVEROUTPUT ON;

--MOSTRAR LOS TRABAJOS QUE HAY POR PROVINCIA
CREATE OR REPLACE PROCEDURE JOBS_PROVINCE AS
    CURSOR CPROVINCE IS
        SELECT
        UPPER(PROVINCE) AS P_MAYUS
        FROM ADMIN_BRT.PROFILES
        GROUP BY PROVINCE;
        
    VPROVINCE VARCHAR(30) := '';
    
    CURSOR CDATOS IS
        SELECT
        NAMEJOB, DESCRIPTION
        FROM ADMIN_BRT.JOBS
        INNER JOIN ADMIN_BRT.TBL_PROFILE_JOBS ON JOBS.IDJOB = TBL_PROFILE_JOBS.IDJOB
        INNER JOIN ADMIN_BRT.PROFILES ON TBL_PROFILE_JOBS.IDPROFILE = PROFILES.IDPROFILE
        WHERE UPPER(PROFILES.PROVINCE) = VPROVINCE;
        
    VNAMEJOB VARCHAR2(80) := '';
    VDESCRIPTION VARCHAR2(500) := '';
BEGIN
    FOR i IN CPROVINCE LOOP
        VPROVINCE := i.P_MAYUS;
        DBMS_OUTPUT.PUT_LINE('PROVINCIA:' || VPROVINCE);
        FOR k IN CDATOS LOOP
            VNAMEJOB := k.NAMEJOB;
            VDESCRIPTION := k.DESCRIPTION;
            DBMS_OUTPUT.PUT_LINE('TRABAJO: ' || VNAMEJOB || ', DESCRIPCION: ' || VDESCRIPTION);
        END LOOP;
    END LOOP;
END;

EXECUTE JOBS_PROVINCE;

--*************************************************************--

--CONTAR LOS TRABAJOS QUE HAY POR PROVINCIA
CREATE OR REPLACE PROCEDURE COUNT_JOBS_PROVINCE AS
    CURSOR CPROVINCE IS
        SELECT
        UPPER(PROVINCE) AS P_MAYUS
        FROM ADMIN_BRT.PROFILES
        GROUP BY PROVINCE;
        
    VPROVINCE VARCHAR(30) := '';
    VCANTIDAD NUMBER := 0;
BEGIN
    FOR i IN CPROVINCE LOOP
        VPROVINCE := i.P_MAYUS;
        DBMS_OUTPUT.PUT_LINE('PROVINCIA:' || VPROVINCE);
        
        SELECT
        COUNT(NAMEJOB) AS CJOBS
        INTO VCANTIDAD
        FROM ADMIN_BRT.JOBS
        INNER JOIN ADMIN_BRT.TBL_PROFILE_JOBS ON JOBS.IDJOB = TBL_PROFILE_JOBS.IDJOB
        INNER JOIN ADMIN_BRT.PROFILES ON TBL_PROFILE_JOBS.IDPROFILE = PROFILES.IDPROFILE
        WHERE UPPER(PROFILES.PROVINCE) = VPROVINCE;
        
        DBMS_OUTPUT.PUT_LINE('CANTIDAD DE TRABAJOS: ' || VCANTIDAD );
    END LOOP;
END;

EXECUTE COUNT_JOBS_PROVINCE;

--*************************************************************--

--A�O CON MAYOR CANTIDAD DE TRABAJOS
CREATE OR REPLACE PROCEDURE BIGGEST_JOBS_ANNIO AS
    VANNIO NUMBER := 0;
    VCANTIDAD NUMBER := 0;
BEGIN
    SELECT
    TO_CHAR(CREATION_DATE, 'YYYY') AS VDATE,
    COUNT(IDJOB) AS CJOBS
    INTO VANNIO, VCANTIDAD
    FROM ADMIN_BRT.JOBS
    GROUP BY TO_CHAR(CREATION_DATE, 'YYYY')
    ORDER BY CJOBS DESC
    FETCH FIRST 1 ROWS ONLY;

    DBMS_OUTPUT.PUT_LINE('EL ANNIO CON MAYOR CANTIDAD DE TRABAJOS ES: ' || VANNIO || ', CON UNA CANTIDAD DE: ' || VCANTIDAD);
END;

EXECUTE BIGGEST_JOBS_ANNIO;

--*************************************************************--

--A�O CON MENOR CANTIDAD DE TRABAJOS
CREATE OR REPLACE PROCEDURE LOWEST_JOBS_ANNIO AS
    VANNIO NUMBER := 0;
    VCANTIDAD NUMBER := 0;
BEGIN
    SELECT
    TO_CHAR(CREATION_DATE, 'YYYY') AS VDATE,
    COUNT(IDJOB) AS CJOBS
    INTO VANNIO, VCANTIDAD
    FROM ADMIN_BRT.JOBS
    GROUP BY TO_CHAR(CREATION_DATE, 'YYYY')
    ORDER BY CJOBS ASC
    FETCH FIRST 1 ROWS ONLY;

    DBMS_OUTPUT.PUT_LINE('EL ANNIO CON MENOR CANTIDAD DE TRABAJOS ES: ' || VANNIO || ', CON UNA CANTIDAD DE: ' || VCANTIDAD);
END;

EXECUTE LOWEST_JOBS_ANNIO;

--*************************************************************--

--CANTIDAD DE USUARIOS POR A�O
CREATE OR REPLACE PROCEDURE PR_USUARIOS_POR_ANNO AS
CURSOR CCANTIDADUSUARIOS IS
    SELECT COUNT(IDUSER) AS CANTIDAD, TO_CHAR(CREATION_DATE, 'YYYY') AS ANNO
    FROM ADMIN_BRT.USERS
    GROUP BY TO_CHAR(CREATION_DATE, 'YYYY');
BEGIN
    FOR I IN CCANTIDADUSUARIOS LOOP
        DBMS_OUTPUT.PUT_LINE('En el a�o '|| I.ANNO ||' se registraron ' || I.CANTIDAD || ' usuarios.');
    END LOOP;
END;

EXECUTE PR_USUARIOS_POR_ANNO;

--*************************************************************--