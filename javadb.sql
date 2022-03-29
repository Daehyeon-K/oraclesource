-- member 테이블 생성
-- id(숫자, 8자리)PK
-- name(가변문자열, 20) NN
-- addr(가변문자열, 50) NN
-- email(가변문자열, 30) NN
-- age(숫자, 3자리)

-- 제약사항에 이름 붙이면
--CREATE TABLE member(
--    id number(8) CONSTRAINT memberconst_id_pk PRIMARY KEY,
--    name varchar2(20) CONSTRAINT memberconst_name_nn NOT NULL,
--    addr varchar2(50) CONSTRAINT memberconst_addr_nn NOT NULL,
--    email varchar2(30) CONSTRAINT memberconst_email_nn NOT NULL,
--    age number(3));

-- 제약사항에 이름 안붙이면  
CREATE TABLE member(
    id number(8) PRIMARY KEY,
    name varchar2(20) NOT NULL,
    addr varchar2(50) NOT NULL,
    email varchar2(30) NOT NULL,
    age number(3));
    
SELECT * FROM member;

DELETE FROM member where id=20160348;

COMMIT;

CREATE SEQUENCE member_seq;
