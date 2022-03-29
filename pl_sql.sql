-- PL/SQL
-- SQL 만으로는 구현이 어렵거나 불가능한 작업들 수행 위해 제공하는 프로그래밍 언어

-- 키워드
-- DECLARE (선언부) : 변수, 상수, 커서 등을 선언 (선언부는 선택)
-- BEGIN (실행부) : 조건문, 반복문, SELECT, DML(CRUD), 함수 등을 정의 (실행부는 필수)
-- EXCEPTION (예외처리부) : 오류(예외상황) 해결 (예외처리부는 선택)

-- 실행 결과를 화면에 출력해달라는 것
SET SERVEROUTPUT ON;

-- HELLO 출력
BEGIN
    DBMS_OUTPUT.PUT_LINE('Hello! PL/SQL');
END;
/

DECLARE
    -- 변수선언
    V_EMPNO NUMBER(4) := 7788;
    V_ENAME VARCHAR2(10);
BEGIN
    V_ENAME := 'SCOTT';
    DBMS_OUTPUT.PUT_LINE('V_EMPNO : '||V_EMPNO);
    DBMS_OUTPUT.PUT_LINE('V_ENAME : '||V_ENAME);
END;
/
-- 슬래시를 해줘야 종료가 됨

DECLARE
    -- 상수선언
    V_TAX CONSTANT NUMBER(1) := 3;
BEGIN
    DBMS_OUTPUT.PUT_LINE('V_TAX : '||V_TAX);
END;
/

-- 변수의 기본값 지정
DECLARE
    V_DEPTNO NUMBER(2) DEFAULT 10;
BEGIN
    DBMS_OUTPUT.PUT_LINE('V_DEPTNO : '||V_DEPTNO);
END;
/

-- NOT NULL 지정
DECLARE
    V_DEPTNO NUMBER(2) NOT NULL := 10; -- 여기 NULL 주면 당연히 복잡한 에러 남
--    V_DEPTNO NUMBER(2) NOT NULL DEFAULT 20; -- 이것도 됨
BEGIN
    DBMS_OUTPUT.PUT_LINE('V_DEPTNO : '||V_DEPTNO);
END;
/

-- IF 조건문
-- IF ~ THEN
-- IF ~ THEN ~ ELSE
-- IF ~ THEN ~ ELSIF

-- V_NUMBER 변수 선언하고 13값 할당 뒤 해당변수 홀짝 출력
DECLARE
    V_NUMBER NUMBER NOT NULL :=14;
BEGIN
    IF MOD(V_NUMBER,2) = 1 THEN DBMS_OUTPUT.PUT_LINE('V_NUMBER는 홀수');
    ELSE DBMS_OUTPUT.PUT_LINE('V_NUMBER는 짝수');
    END IF;
END;
/

-- V_NUMBER 변수 선언하고 성적
DECLARE
    V_NUMBER NUMBER NOT NULL :=87;
BEGIN
    IF V_NUMBER >= 90 THEN DBMS_OUTPUT.PUT_LINE('A 학점');
    ELSIF V_NUMBER >=80 THEN DBMS_OUTPUT.PUT_LINE('B 학점');
    ELSIF V_NUMBER >=70 THEN DBMS_OUTPUT.PUT_LINE('C 학점');
    ELSIF V_NUMBER >=60 THEN DBMS_OUTPUT.PUT_LINE('D 학점');
    ELSE DBMS_OUTPUT.PUT_LINE('F 학점');
    END IF;
END;
/

-- CASE ~ WITH
DECLARE
    V_SCORE NUMBER := 77;
BEGIN
    CASE TRUNC(V_SCORE/10)
        WHEN 10 THEN DBMS_OUTPUT.PUT_LINE('A 학점');
        WHEN 9 THEN DBMS_OUTPUT.PUT_LINE('B 학점');
        WHEN 8 THEN DBMS_OUTPUT.PUT_LINE('C 학점');
        WHEN 7 THEN DBMS_OUTPUT.PUT_LINE('D 학점');
        ELSE DBMS_OUTPUT.PUT_LINE('F 학점');
    END CASE;
END;
/
    
-- 반복문
-- LOOP ~ END LOOP
-- WHILE LOOP ~ END LOOP
-- FOR LOOP
-- Cursor FOR LOOP

-- LOOP ~ END LOOP
DECLARE
    V_DEPTNO NUMBER := 0;
BEGIN
    LOOP
        DBMS_OUTPUT.PUT_LINE('현재 V_DEPTNO : '||V_DEPTNO);
        V_DEPTNO := V_DEPTNO+1;
        EXIT WHEN V_DEPTNO > 4;
    END LOOP;
END;
/

-- WHILE LOOP ~ END LOOP
DECLARE
    V_DEPTNO NUMBER := 0;
BEGIN
    WHILE V_DEPTNO < 4 LOOP
        DBMS_OUTPUT.PUT_LINE('현재 V_DEPTNO : '||V_DEPTNO);
        V_DEPTNO := V_DEPTNO+1;
    END LOOP;
END;
/

-- FOR LOOP
-- 시작값..종료값 : 반복문을 통해 시작값에서 종료값을 출력
BEGIN
    FOR i IN 0..4 LOOP
        DBMS_OUTPUT.PUT_LINE('현재 i : '||i);
    END LOOP;
END;
/

-- FOR LOOP 거꾸로
BEGIN
    FOR i IN REVERSE 0..4 LOOP
        DBMS_OUTPUT.PUT_LINE('현재 i : '||i);
    END LOOP;
END;
/

-- 숫자 1~10 홀수만 출력
BEGIN FOR i IN 1..10 LOOP
    IF MOD(i,2)=1 THEN DBMS_OUTPUT.PUT_LINE('현재 i : '||i); END IF;
    END LOOP;
END;
/

-- 변수 타입 선언 시 특정 테이블의 컬럼 값 참조
DECLARE
    v_deptno dept.deptno%TYPE := 50;
BEGIN
    DBMS_OUTPUT.PUT_LINE('V_DEPTNO : '||v_deptno);
END;
/

-- 변수 타입 선언 시 특정 테이블의 하나의 컬럼이 아닌 행 구조 전체 참조
DECLARE
    v_dept_row dept%ROWTYPE; -- 행 타입으로 참조하는 것
BEGIN
    SELECT deptno, dname, loc INTO v_dept_row -- SELECT INTO가 일종의 커서 이용한 거. 바로 집어넣는 거.
    FROM dept
    WHERE deptno=40;
    DBMS_OUTPUT.PUT_LINE('DEPTNO : '||v_dept_row.deptno);
    DBMS_OUTPUT.PUT_LINE('DNAME : '||v_dept_row.dname);
    DBMS_OUTPUT.PUT_LINE('LOC : '||v_dept_row.loc);
END;
/

-- Cursor FOR LOOP
-- 커서(CURSOR) : SELECT, DELETE, UPDATE, INSERT 등의 SQL문 실행 시 해당 SQL문 처리하는 정보를 저장한 메모리 공간

-- SELECT INTO 방식 : 결과값이 하나일 때 사용 가능
-- 결과값이 몇 개인지 알 수 없다면 : 커서를 사용해야 함

-- 1) 명시적 커서
-- 커서 선언 : DECLARE
-- 커서 열기 : OPEN
-- 커서에서 읽어온 데이터 사용 : FETCH
-- 커서 닫기 : CLOSE

DECLARE
    -- 커서 데이터를 입력할 변수 선언
    V_DEPT_ROW DEPT%ROWTYPE;
    
    -- 명시적 커서 선언
    CURSOR c1 IS
        SELECT DEPTNO, DNAME, LOC
        FROM DEPT
        WHERE DEPTNO = 40;
BEGIN
    -- 커서 열기
    OPEN c1;
    
    -- 읽어온 데이터 사용
    FETCH c1 INTO V_DEPT_ROW;
    
    -- 출력
    DBMS_OUTPUT.PUT_LINE('DEPTNO : '||v_dept_row.deptno);
    DBMS_OUTPUT.PUT_LINE('DNAME : '||v_dept_row.dname);
    DBMS_OUTPUT.PUT_LINE('LOC : '||v_dept_row.loc);
    
    -- 커서 닫기
    CLOSE c1;
END;
/

-- 여러 행이 조회되는 경우 (커서와 반복문 함께)
DECLARE
    -- 커서 데이터를 입력할 변수 선언
    V_DEPT_ROW DEPT%ROWTYPE;
    
    -- 명시적 커서 선언
    CURSOR c1 IS
        SELECT DEPTNO, DNAME, LOC
        FROM DEPT;
BEGIN
    -- 커서 열기
    OPEN c1;
    
    LOOP
        -- 읽어온 데이터 사용
        FETCH c1 INTO V_DEPT_ROW;
        
        -- 커서에서 더이상 읽어올 행이 없을 때
        EXIT WHEN c1%NOTFOUND;
    
        -- 출력
        DBMS_OUTPUT.PUT_LINE('DEPTNO : '||v_dept_row.deptno);
        DBMS_OUTPUT.PUT_LINE('DNAME : '||v_dept_row.dname);
        DBMS_OUTPUT.PUT_LINE('LOC : '||v_dept_row.loc);
    END LOOP;
    
    -- 커서 닫기
    CLOSE c1;
END;
/

-- CURSOR FOR ~ LOOP
DECLARE
    -- 명시적 커서 선언
    CURSOR c1 IS
        SELECT DEPTNO, DNAME, LOC
        FROM DEPT;
BEGIN
    -- 위에 해야 했던 부분 다 알아서 해주는 것
    -- 자동 OPEN, FETCH, CLOSE
    FOR c1_rec IN c1 LOOP
        DBMS_OUTPUT.PUT_LINE('DEPTNO : '||c1_rec.deptno
        || ' DNAME : '||c1_rec.dname
        || ' LOC : '||c1_rec.loc);
    END LOOP;
END;
/

-- 가져올 것 명시한 CURSOR FOR LOOP
DECLARE
    -- 사용자가 입력한 부서 번호를 저장하는 변수 선언
    v_deptno DEPT.DEPTNO%TYPE;
    
    -- 명시적 커서 선언
    CURSOR c1 (p_deptno DEPT.DEPTNO%TYPE) IS
        SELECT DEPTNO, DNAME, LOC
        FROM DEPT
        WHERE deptno = p_deptno;
BEGIN
    -- input_deptno에 부서번호 입력받고 v_deptno에 대입
    v_deptno := &input_deptno;
    
    -- 자동 OPEN, FETCH, CLOSE
    FOR c1_rec IN c1(v_deptno) LOOP
        DBMS_OUTPUT.PUT_LINE('DEPTNO : '||c1_rec.deptno
        || ' DNAME : '||c1_rec.dname
        || ' LOC : '||c1_rec.loc);
    END LOOP;
END;
/

-- 2) 묵시적 커서 : 커서 선언 없이
-- SELECT ~ INTO, DML(UPDATE/DELETE/INSERT)이 묵시적 커서
-- 사용 가능한 속성이 정해져 있음 (아래 SQL% 애들)
-- SQL%ROWCOUNT : 묵시적 커서 안에 추출된 행이 있으면 행의 수를 출력
-- SQL%FOUND : 묵시적 커서 안에 추출된 행이 있으면 TRUE, 없으면 FALSE
-- SQL%ISOPEN : 자동으로 SQL문을 실행한 후 CLOSE 되기 때문에 항상 FALSE
-- SQL%NOTFOUND : 커서 안에 추출된 행이 있으면 TRUE, 없으면 FALSE
BEGIN
    UPDATE dept_temp SET dname = 'DATABASE' WHERE deptno = 60;
    
    DBMS_OUTPUT.PUT_LINE('갱신된 행의 수 : ' || SQL%ROWCOUNT);
    
    IF SQL%FOUND THEN 
        DBMS_OUTPUT.PUT_LINE('갱신 대상 행 존재 여부 : TRUE');
    ELSE
        DBMS_OUTPUT.PUT_LINE('갱신 대상 행 존재 여부 : FALSE');
    END IF;
    
    IF SQL%ISOPEN THEN 
        DBMS_OUTPUT.PUT_LINE('커서의 OPEN 여부 : TRUE');
    ELSE
        DBMS_OUTPUT.PUT_LINE('커서의 OPEN 여부 : FALSE');
    END IF;
END;
/

-- 저장 서브프로그램 (이름지정, 저장, 저장할 때 한 번 컴파일, 공유해서 사용 가능, 다른 응용프로그램에서 호출 가능)
-- 1. 저장 프로시저 : SQL문에서는 사용 불가
-- 2. 저장 함수 : SQL문에서 사용 가능
-- 3. 트리거 : 특정 상황이 발생할 때 자동으로 연달아 수행할 기능 구현하는 데에 사용
-- 4. 패키지 : 저장 서브프로그램을 그룹화

-- 저장 프로시저 (파라미터 없는 경우)
CREATE PROCEDURE pro_noparam
IS
    v_empno NUMBER(4) := 7788;
    v_ename VARCHAR2(10);
BEGIN
    v_ename := 'SCOTT';
    DBMS_OUTPUT.PUT_LINE('v_empno : ' || V_EMPNO);
    DBMS_OUTPUT.PUT_LINE('v_ename : ' || v_ename);
END;
/
-- 프로시저 실행
EXECUTE pro_noparam;

-- 다른 PL\SQL 블록에서 프로시저 실행 가능


-- 저장 프로시저 (파라미터 있는 경우)
CREATE OR REPLACE PROCEDURE pro_param_in -- 중복 시 변경
    (
    param1 IN NUMBER, -- IN 은 기본값이라 생략 가능
    param2 NUMBER,
    param3 NUMBER:= 3, -- 디폴트 값 설정
    param4 NUMBER DEFAULT 4 -- 디폴트 값 설정
    )
IS
BEGIN
    DBMS_OUTPUT.PUT_LINE('param1 : ' || param1);
    DBMS_OUTPUT.PUT_LINE('param2 : ' || param2);
    DBMS_OUTPUT.PUT_LINE('param3 : ' || param3);
    DBMS_OUTPUT.PUT_LINE('param4 : ' || param4);
END;
/
EXECUTE pro_param_in(1, 2);
EXECUTE pro_param_in(5, 6, 7, 8);

CREATE OR REPLACE PROCEDURE pro_param_out
    (
    in_empno IN emp.empno%TYPE,
    out_ename OUT emp.ename%TYPE,
    out_sal OUT emp.sal%TYPE
    )
IS
BEGIN
    SELECT ename, sal INTO out_ename, out_sal
    FROM emp
    WHERE empno = in_empno;
END;
/

DECLARE
    v_ename emp.ename%TYPE;
    v_sal emp.sal%TYPE;
BEGIN
    pro_param_out(7369,v_ename,v_sal); -- 여기서 사용하고 받는 것
    dbms_output.put_line('ename : ' || v_ename);
    dbms_output.put_line('sal : ' || v_sal);
END;
/

-- IN, OUT 모드
CREATE OR REPLACE PROCEDURE pro_param_in_out
    (
    in_out_no IN OUT NUMBER
    )
IS
BEGIN
    in_out_no := in_out_no * 2;
END;
/

DECLARE
    no NUMBER;
BEGIN
    no := 5;
    pro_param_in_out(no);
    dbms_output.put_line('no : '|| no);
END;
/


-- 트리거
-- DML 트리거
-- CREATE OR REPLACE TRIGGER 트리거이름
-- BEFORE | AFTER 지정
-- INSERT | UPDATE | DELETE ON 테이블 이름
-- DECLARE 가능
-- BEGIN ~ END;/

CREATE TABLE emp_trg AS SELECT * FROM emp;

-- emp_trg에 INSERT(혹은 UPDATE, DELETE) 시키기. 이때 주말에 발생하면 ERROR 발생 시킬 것
CREATE OR REPLACE TRIGGER emp_trg_weekend
BEFORE
INSERT OR UPDATE OR DELETE ON emp_trg
BEGIN
    -- 주말인지 판단
    IF TO_CHAR(sysdate, 'DY') IN ('토', '일') THEN
        IF INSERTING THEN 
            raise_application_error(-30000, '주말 사원정보 추가 불가'); -- -30000은 임의로 지은 에러코드
        ELSIF UPDATING THEN
            raise_application_error(-30001, '주말 사원정보 수정 불가');
        ELSIF DELETING THEN
            raise_application_error(-30002, '주말 사원정보 삭제 불가');
        ELSE
            raise_application_error(-30003, '주말 사원정보 변경 불가');
            END IF;
    END IF;
END;
/

UPDATE emp_trg
SET sal=3500
WHERE empno=7369;

DELETE FROM emp_trg
WHERE empno=7369;

-- 트리거 - 로그를 통해 저장
CREATE TABLE emp_trg_log(
    TABLENAME VARCHAR2(20), -- DML이 수행된 테이블 이름
    DML_TUPE VARCHAR2(10),  -- DML 명령어 종류
    EMPNO NUMBER(4),        -- DML 대상이 된 사원 번호
    USER_NAME VARCHAR2(30), -- DML을 수행한 USER 명
    CHANGE_DATE DATE);      -- DML 시도 날짜
    
CREATE OR REPLACE TRIGGER emp_trg_weekend_log
AFTER
INSERT OR UPDATE OR DELETE ON emp_trg
FOR EACH ROW -- 영향받는 모든 행 각각 여러번 실행
BEGIN
    -- 주말인지 판단
        IF INSERTING THEN 
            INSERT INTO emp_trg_log
            VALUES('EMP_TRG', 'INSERT', :new.empno, SYS_CONTEXT('USERENV', 'SESSION_USER'),sysdate);
            
        ELSIF UPDATING THEN
            INSERT INTO emp_trg_log
            VALUES('EMP_TRG', 'UPDATE', :old.empno, SYS_CONTEXT('USERENV', 'SESSION_USER'),sysdate);
            
        ELSIF DELETING THEN
            INSERT INTO emp_trg_log
            VALUES('EMP_TRG', 'DELETE', :old.empno, SYS_CONTEXT('USERENV', 'SESSION_USER'),sysdate);
         END IF;
END;
/
UPDATE emp_trg
SET sal=3500
WHERE empno=7369;

INSERT INTO emp_trg
VALUES(9999, 'TEST_TMP', 'CLERK', 7788, '2018-03-03', 1200, NULL,20);

COMMIT;

SELECT * FROM emp_trg_log;