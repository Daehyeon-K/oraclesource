-- sql 구문은 대소문자 구분하지 않음(단, 비밀번호는 구별)
-- scott/tiget(X), scott/TIGER(O)

-- hr 사용자의 비밀번호 변경 -> 어드민에게만 있는 권한이라 system에서 한 거

ALTER USER hr IDENTIFIED BY hr
    ACCOUNT UNLOCK; -- 비번 여러번 틀리면 LOCK 되어 버리는데, 그거 UNLOCK하는거
    
    
-- 오라클 DB의 특징
-- 테이블, 인덱스, 뷰 등 여러 객체가 사용자 별로 생성되고 관리 (MYSQL은 DB에 다 들어가는?)
-- 사용자 = 스키마(데이터베이스 구조와 범위)


-- 사용자 생성
-- CREATE USER 아이디 IDENTIFIED BY 비밀번호;
CREATE USER test1 IDENTIFIED BY 12345; -- CMD 돌려보면 --user TEST1 lacks CREATE SESSION privilege; logon denied

-- 즉, 사용자 생성 해도 DB 접근 권한이 바로 생기는 건 아님.


-- 권한 부여 (오라클은 다양한 세부 권한이 나눠져 있음)
-- GRANT CREATE 권한명 TO 사용자;
GRANT CREATE SESSION TO test1;
-- table 생성 권한 부여
GRANT CREATE TABLE TO test1;
-- view 생성 권한 부여
GRANT CREATE VIEW TO scott;


-- 롤 (여러 권한 묶어준 개념)
-- resource : 시퀀즈, table, trigger 등등의 객체 생성할 수 있는 권한들 모여있음
-- connection : create session이 들어가 있음
GRANT resource, connect to test1; -- 대부분의 권한 가지고 있기에 이거 해주면 권한 문제는 거의 없을 것


-- 사용자 비밀번호 변경
ALTER USER test1 IDENTIFIED BY 54321;


-- 사용자 삭제
DROP USER test1;
-- 이미 뭐 만들고 넣고 해서 삭제 안되면 뒤에 CASCADE 넣기 (DROP USER test1 CASCADE;)


-- 수업중에 사용 할 사용자
CREATE USER javadb IDENTIFIED BY 12345;
GRANT resource, connect to javadb;