-- dept테이블 정보(부서정보-부서번호, 부서명, 위치)
DESC DEPT;

-- 사원정보(사원번호, 사원명, 직책, 직속상관의 사원번호, 입사일, 급여, 추가수당, 부서번호)
DESC EMP;

-- 급여구간(등급, 최저급여, 최고급여)
DESC salgrade;


-- 조회(SELECT) : 실무에서 가장 많이 사용
-- SELECT 조회하고 싶은 열 이름 나열
-- FROM 조회할 테이블 명

SELECT deptno FROM dept;

SELECT deptno, dname FROM dept;

SELECT * FROM dept;

SELECT * FROM emp;

SELECT empno, ename, deptno FROM emp;
-- 중복 데이터 제거하고 뽑기 : DISTINCT
SELECT 
    DISTINCT deptno
    FROM emp;

SELECT 
    DISTINCT job, deptno -- 이건 같이 나오는 deptno가 값이 서로 달라서 job 중복 제거가 잘 안되는거
    FROM emp;
    
    
-- ALAIS(별칭)
-- AS 별칭 : AS 키워드는 생략 가능
SELECT 
    ename AS 사원명,
    sal 급여,
    comm AS "추가 수당", 
    sal*12+comm AS 연봉
    FROM emp;
    
    
-- SELECT: 기본적으로 무작위 선택을 의미
-- 원하는 순서대로 출력 데이터 정렬: ORDER BY (실무에선 시간 많이 잡아먹어 피하긴 함)
-- ORDER BY 정렬할열이름 [정렬옵션]

-- emp 테이블에서 ename, sal 조회할 때 sal 내림차순 조회
SELECT ename, sal FROM emp ORDER BY sal DESC;

-- emp 테이블에서 ename, sal 조회할 때 sal 오름차순 조회
SELECT ename, sal FROM emp ORDER BY sal; -- 기본 정렬옵션이 오름차순 (명시할 땐 ASC)

-- emp 테이블의 전체 열을 조회, 부서번호는 오름차순, 부서번호 안에선 급여 내림차 순
SELECT * FROM emp ORDER BY deptno ASC, sal DESC;


-- 특정 조건 기준으로 데이터 조회
-- SELECT ~ FROM ~ WHERE 기준
SELECT * FROM emp WHERE deptno = 30;

-- 사원번호가 7782인 사원 조회
SELECT * FROM emp WHERE empno = 7782;

-- 부서번호가 30이고, 사원직책이 SALESMAN인 사원 조회
-- 문자열 표현: 무조건 홑따옴표
-- 다중 조건 AND, OR 가능
-- 'salesman'하면 안나옴. 값의 대소문자는 구분
SELECT * FROM emp WHERE deptno = 30 AND job = 'SALESMAN';

-- 사원번호가 7499이고 부서번호가 30인 사원 조회
SELECT * FROM emp WHERE empno = 7499 AND deptno = 30;

-- 부서번호가 30 이거나 사원직책이 CLERK인 사원 조회
SELECT * FROM emp WHERE deptno = 30 OR job = 'CLERK';


-- 연산자
-- 산술연산자 (+, -, *, /)
SELECT * FROM emp WHERE sal * 12 = 36000;

-- 비교연산자 (<, >, <=, >=)
SELECT * FROM emp WHERE sal >= 3000;

-- ENAME이 'F' 이상인 사원 조회
-- 문자도 대소비교 연산자 사용해서 비교 가능하다 (사원이름 첫 문자를 비교)
SELECT * FROM emp WHERE ename>='F';

-- 급여가 2500 이상이고, 직업이 ANALYST인 사원 조회
SELECT * FROM emp WHERE sal>=2500 AND job='ANALYST';

-- 직무가 MANAGER이거나 SALESMAN이거나 CLERK인 사원 조회
SELECT * FROM emp WHERE job='MANAGER' OR job='SALESMAN' OR job='CLERK';

-- 등가비교연산자 (같다: =, 같지 않다: !=, <>, ^=)
-- 급여가 3000이 아닌 사원 조회
SELECT * FROM emp WHERE sal!=3000;
SELECT * FROM emp WHERE sal<>3000;
SELECT * FROM emp WHERE sal^=3000;

-- 논리부정연산자 : NOT
SELECT * FROM emp WHERE NOT sal=3000;

-- IN 연산자 : = 의 의미와 같음
SELECT * FROM emp WHERE job IN ('MANAGER', 'SALESMAN', 'CLERK');

-- IN을 사용해서 부서번호 10번, 20번인 사원 조회
SELECT * FROM emp WHERE deptno IN (10, 20);

-- job이 'MANAGER' 아니고, 'SALESMAN' 아니고, 'CLERK'도 아닌 사원 조회
SELECT * FROM emp WHERE job!='MANAGER' OR job<>'SALESMAN' OR job^='CLERK';

-- job이 'MANAGER' 아니고, 'SALESMAN' 아니고, 'CLERK'도 아닌 사원 조회 (IN + NOT)
SELECT * FROM emp WHERE job NOT IN ('MANAGER', 'SALESMAN', 'CLERK');

-- BETWEEN A AND B 연산자
-- 급여가 2000이상 3000이하 등
SELECT * FROM emp WHERE sal BETWEEN 2000 AND 3000;

-- 급여가 2000이상 3000이하가 아닌
SELECT * FROM emp WHERE sal NOT BETWEEN 2000 AND 3000;

-- LIKE 연산자와 와일드 카드 
-- 와일드 카드 => 외우기
-- _ : 어떤 값이든 상관 없이 단 한 개의 문자 데이터
-- % : 길이와 상관 없이 모든 문자 데이터
-- 사원 이름이 S로 시작하는 사원 정보
SELECT * FROM emp WHERE ename LIKE 'S%';

-- 사원 이름의 두번째 글자가 L인 사원 정보
SELECT * FROM emp WHERE ename LIKE '_L%';

-- 사원 이름에 AM이 들어있는 사원 정보
SELECT * FROM emp WHERE ename LIKE '%AM%';

-- 사원 이름에 AM이 들어있지 않은 사원 정보
SELECT * FROM emp WHERE ename NOT LIKE '%AM%';

-- 집합 연산자
-- union(합집합), minus(차집합), intersect (교집합)

-- deptno = 10 or deptno = 20 사원 union 사용해서
-- column 명이 일치해야 함
-- union은 중복값 제거
SELECT * FROM emp WHERE deptno = 10 UNION SELECT * FROM emp WHERE deptno = 20;

-- union all은 중복값까지 모두 뽑는 것
SELECT * FROM emp WHERE deptno = 10 UNION ALL SELECT * FROM emp WHERE deptno = 10;
-- 중복 제거하면
SELECT * FROM emp WHERE deptno = 10 UNION SELECT * FROM emp WHERE deptno = 10;

-- minus
SELECT * FROM emp MINUS SELECT * FROM emp WHERE deptno = 20;

-- intersect
SELECT * FROM emp INTERSECT SELECT * FROM emp WHERE deptno = 20;

-- [문제] 사원이름 S로 끝나는 사원 데이터 출력
SELECT * FROM emp WHERE ename LIKE '%S';

-- [문제] 30번 부서에 근무하는 사원 중 직책 SALESMAN인 사원의 사번 이름 직책 급여 부서번호
SELECT empno, ename, job, sal, deptno FROM emp WHERE deptno=30 AND job='SALESMAN';

-- [문제] 20번 30번 부서에 근무하는 사원 중 급여 2000초과 사원 집합 연산자 쓰는거 안쓰는 거 두개로
-- 사번 이름 직책 급여 부서번호
SELECT empno, ename, job, sal, deptno FROM emp WHERE deptno IN (20, 30) AND sal>2000;
SELECT empno, ename, job, sal, deptno FROM emp WHERE deptno=20
UNION SELECT empno, ename, job, sal, deptno FROM emp WHERE deptno=30
INTERSECT SELECT empno, ename, job, sal, deptno FROM emp WHERE sal > 2000;

-- [문제] NOT BETWEEN A AND B 연산자 쓰지 않고 급여 열 값이 2000이상 3000이하 범위 이외의 값을가진 데이터만 출력하도록 
SELECT * FROM emp WHERE sal<2000 AND sal>3000;

-- [문제] 사원 이름에 E 포함된 30번 부서 사원 중 급여 1000~2000 사이 아닌 사원 이름, 사번, 급여, 부서번호
SELECT empno, ename, job, sal, deptno FROM emp WHERE (sal NOT BETWEEN 1000 AND 2000) AND (ename LIKE '%E%');

-- [문제] 추가수당 없고 상급자 있고 직책 MANAGER, CLERK인 사원 중 이름 두번째 글자가 L이 아닌 사원 정보 출력
SELECT * FROM emp WHERE (comm IS NULL) AND (mgr IS NOT NULL) AND (job IN ('MANAGER', 'CLERK')) AND (ename NOT LIKE '_L%');



-- 오라클 함수

-- 대소문자 변경 : UPPER(), LOWER(), INITCAP()
SELECT ename, LOWER(ename), INITCAP(ename), UPPER(ename) FROM emp;

-- 문자열 길이 : LENGTH, LENGTHB
SELECT LENGTH('한글'), LENGTHB('한글')
FROM dual; -- 이건 임시 테이블로, sys가 소유하는 테이블. 임시 연산이나 함수 결과값 확인 용도
SELECT ename, length(ename) FROM emp;

-- [실습] 직책 이름 6자 이상인 사원
SELECT * FROM emp WHERE length(job)>=6;

-- 문자열 추출 : substr(원본데이터, 시작위치, 추출길이-이건옵션)
SELECT job, substr(job, 1, 2), substr(job, 3, 2), substr(job, 5) FROM emp;

-- [문제] emp 테이블의 모든 사원 이름 세번째 글자부터 끝까지 출력
-- ename, 추출 문자열
SELECT ename, substr(ename, 3) FROM emp;

-- 문자열 데이터 안에서 특정 문자 위치 찾기 : INSTR(문자열 데이터, 위치 찾으려는 부분 문자, 시작 위치, 몇번째로 찾아지는 건지)
SELECT INSTR('HELLO ORACLE!', 'L') AS instr1,
INSTR('HELLO ORACLE!', 'L', 5) AS instr2,
INSTR('HELLO ORACLE!', 'L', 1, 2) AS instr3
FROM dual;

-- 사원이름에 S 있는 사원
SELECT * FROM emp WHERE INSTR(ename, 'S')>0;

-- 특정 문자 다른 문자로 변경: REPLACE(원본 문자열, 찾는 문자, 바꿀 문자)
SELECT '010-1234-5678', REPLACE('010-1234-5678', '-', ' ') AS replace1 FROM dual;
SELECT '010-1234-5678', REPLACE('010-1234-5678', '-') AS replace1 FROM dual; -- 바꿀 문자 안주면 그냥 제거

-- 문자열 연결 : CONCAT(문자열1, 문자열2) => 한 번에 두개씩만 됨
SELECT CONCAT(empno, ename) FROM emp;
SELECT CONCAT(empno, CONCAT(' : ', ename)) FROM emp;

-- 더욱 자주 쓰이는 문자열 연결 : ||
SELECT empno||ename FROM emp;
SELECT empno||' : '||ename FROM emp;

-- 문자열 양측, 좌측, 우측 특정 문자열 제거 (아무것도 안주면 공백 제거) 함수 : TRIM(), LTRIM(), RTRIM()
SELECT '   이것이     ', TRIM('   이것이     '), LTRIM('   이것이     '), RTRIM('   이것이     ') FROM dual;


-- 숫자함수
-- round() : 반올림
-- trunc() : 버림
-- ceil() : 지정된 숫자보다 큰 정수 중 가장 작은 정수
-- floor() : 지정된 숫자보다 작은 정수 중 가장 큰 정수
-- mod() : 나머지

-- round() : 반올림
SELECT round(1234.5678) as round, round(1234.5678, 0) as round1, round(1234.5678, 1) as round2, round(1234.5678,2) as round3
, round(1234.5678,-1) as round4, round(1234.5678,-2) as round5 FROM dual;

-- trunc() : 버림
SELECT trunc(1234.5678) as trunc, trunc(1234.5678, 0) as trunc1, trunc(1234.5678, 1) as trunc2, trunc(1234.5678,2) as trunc3
, trunc(1234.5678,-1) as trunc4, trunc(1234.5678,-2) as trunc5 FROM dual;

-- ceil() : 지정된 숫자보다 큰 정수 중 가장 작은 정수
SELECT ceil(3.14), floor(3.14), ceil(-3.14), floor(-3.14) from dual;

-- mod() : 나머지
SELECT mod(15,6), mod(10,2), mod(11,2) from dual;


-- 날짜 함수 : 연산이 가능함
-- sysdate(제일 많이 쓸 것), current_date, current_timestamp

SELECT sysdate, current_date, current_timestamp FROM dual;

SELECT sysdate as now, sysdate-1 as yesterday, sysdate+1 as tomorrow FROM dual;

-- add_months() : 몇 개월 이후 날짜 구하기
SELECT sysdate, add_months(sysdate, 3) FROM dual;

-- 입사 20주년이 되는 사원들 조회
SELECT empno, ename, hiredate, add_months(hiredate, 240) FROM emp;

-- 현재 날짜 기준, 입사가 45년 미만인 사원 조회
SELECT empno, ename, hiredate FROM emp WHERE add_months(hiredate, 540)>sysdate;

-- months_between(날짜1, 날짜2) : 두 날짜 데이터 간의 날짜 차이 개월 수로 출력
SELECT empno, ename, hiredate, sysdate, months_between(hiredate, sysdate) as months1, months_between(sysdate, hiredate) as months2,
trunc(months_between(sysdate, hiredate)) as month3 FROM emp;

-- next_day() : 특정 날짜를 기준으로 돌아오는 요일의 날짜 출력
-- last_day() : 특정 날짜가 속한 달의 마지막 날짜 출력
SELECT sysdate, next_day(sysdate, '월요일'), last_day(sysdate) FROM dual;


-- 형 변환 함수
SELECT empno, ename, empno+'500' from emp where ename='SMITH';

DESC emp; -- 보면, 오라클은 숫자 자료형에 문자를 더해주기도 함 자바나 파이썬은 에러 나는데 이렇게 알아서 연산해주는 언어들 있음
-- 이런 자동 형 변환 및 연산 방법을 배워볼 것

SELECT empno, ename, 'abcd'+empno from emp where ename='SMITH'; -- 이거는 안됨 자동 형변환 안됨

-- TO_CHAR() : 숫자, 날짜 데이터를 문자 데이터로 변환
-- TO_NUMBER() : 문자 데이터를 숫자 데이터로 변환
-- TO_DATE() : 문자 데이터를 날짜 데이터로 변환

-- TO_CHAR() : 숫자, 날짜 데이터를 문자 데이터로 변환
SELECT TO_CHAR(sysdate, 'YYYY/MM/DD HH24:MI:SS') as 현재날짜 FROM dual;

SELECT TO_CHAR(sysdate, 'MM') as MM, TO_CHAR(sysdate, 'MON') as MON, TO_CHAR(sysdate, 'MONTH') as MONTH,
TO_CHAR(sysdate, 'DD') as DD, TO_CHAR(sysdate, 'DY') as DY, TO_CHAR(sysdate, 'DAY') as DAY FROM dual;

SELECT TO_CHAR(sysdate, 'HH24:MI:SS') as HH24MISS, TO_CHAR(sysdate, 'HH24:MI:SS AM') as HH24MISS_AM,
TO_CHAR(sysdate, 'HH:MI:SS P.M.') as HHMISS_PM, TO_CHAR(sysdate, 'HH:MI:SS') as HHMISS FROM dual;

-- TO_NUMBER() : 문자 데이터를 숫자 데이터로 변환
SELECT 1300 - '1500', '1300' + 1500 FROM dual;
SELECT '1,300' + '1,500' FROM dual; -- 콤마 들어가면 숫자 계산으론 에러
SELECT TO_NUMBER('1,300', '999,999') + TO_NUMBER('1,500', '999,999') FROM dual; -- 9는 숫자 한 자리 의미

SELECT sal, to_char(sal, '$999,999') as sal_$ FROM emp; -- 문자에서도 가능

-- TO_DATE() : 문자 데이터를 날짜 데이터로 변환
SELECT to_date('2022-03-22') AS date1 ,
to_date('2022-03-22', 'YYYY-MM-DD') AS date2,
to_date('20220322', 'YYYY-MM-DD') AS date3 FROM dual; -- 이것도 포맷 알아서 잘 맞춰서 뽑아줌
DESC emp;

-- 1981년 6월 1일 이후에 입사한 사원 정보 조회
SELECT * FROM emp WHERE hiredate > to_date('19810601', 'YYYY-MM-DD');

-- nvl(널값 열, 널인 경우 사용할 값)
SELECT empno, ename, sal, nvl(comm, 0), sal+nvl(comm, 0) from emp; -- nvl 2가 존재
-- nvl2는 널값이 영인지 아닌지 확인 기능이 추가됨 (널값 열, 널이 아닌 경우 경우 사용할 값)
SELECT empno, ename, sal, nvl2(comm, 'O', 'X'), sal+nvl2(comm, sal*12+comm, sal*12) from emp;

-- DECODE 함수와 CASE문
-- decode(대상이 될 열 혹은 데이터 , 조건 1, 조건 1과 일치 시 반환할 결과, 조건 2, 조건 2과 일치 시 반환할 결과, 조건 1~ 조건 n 까지 만족 안할 때 반환할 결과)
-- job_is에 따라 비율 다르게 준 다음 연산
SELECT empno, ename, job, sal, decode(job, 'MANAGER', sal*1.1, 'SALESMAN', sal*1.05, 'ANALYST', sal, sal *1.03)
AS upsal FROM emp;

SELECT empno, ename, job, sal, case job when 'MANAGER' then sal*1.1 when 'SALESMAN' then sal*1.05 when 'ANALYST' then sal else sal*1.03 end
AS upsal FROM emp;

SELECT empno, ename, job, sal, case when comm is null then '해당사항 없음' when comm=0 then '수당없음' when comm>0 then '수당 : '||comm end
AS comm_text FROM emp;

-- [실습1] emp 테이블에서 월 평균 근무일 수 21.5일, 하루 평균 8시간 근무
-- 하루 급여(DAY_PAY), 시급(TIME_PAY)
-- 하루 급여는 소수 셋째 자리에서 버림, 시급은 소수 둘째 자리에서 반올림
SELECT empno, ename, sal, trunc(sal/21.5, 2) as DAY_PAY, round(sal/21.5/8, 1) as TIME_PAY FROM emp;

-- [실습2] emp 테이블에서 입사일 기준으로 3개월이 지난 후 첫 월요일에 정직원이 됨
-- 정직원이 된 날짜 구하기
-- 추가 수당을 조회할 때 null인 경우는 N/A로 출력
SELECT empno, ename, hiredate, TO_CHAR(next_day(add_months(hiredate, 3), '월요일'), 'YYYY-MM-DD') as r_job, nvl(TO_CHAR(comm), 'N/A') AS COMM FROM emp;

-- [실습3] emp 테이블의 mgr 기준으로 출력
-- mgr 존재하지 않으면 0000
-- mgr 75인 경우 5555
-- mgr 76인 경우 6666
-- mgr 77인 경우 7777
-- mgr 78인 경우 8888
-- 그 외 원래대로
SELECT empno, ename, mgr,
CASE when TO_CHAR(mgr) is null then '0000' when mgr LIKE '75%' then '5555' when mgr LIKE '76%' then '6666'
when mgr LIKE '77%' then '7777' when mgr LIKE '78%' then '8888' else to_char(mgr) end as chg_mgr FROM emp;

-- 추가수당 합계
SELECT sum(comm), count(comm), max(comm), min(comm), avg(comm) FROM emp;

SELECT sum(sal), count(sal), max(sal), min(sal), avg(sal) FROM emp;

SELECT sum(DISTINCT sal), count(DISTINCT sal), max(DISTINCT sal), min(DISTINCT sal), avg(DISTINCT sal) FROM emp;

-- emp 테이블의 사원 수 출력
SELECT COUNT(comm) FROM emp; -- null 있을 수 있으니
SELECT COUNT(*) FROM emp; -- 이게 나음
SELECT COUNT(*) FROM emp WHERE deptno=30; -- 30번 부서 사원 수

-- 급여의 최대값
SELECT max(sal) FROM emp;

-- 급여의 최소값
SELECT min(sal) FROM emp;

-- 20번 부서 제일 오래된 입사일 사원
SELECT min(hiredate) FROM emp WHERE deptno=20;

-- 20번 부서 제일 최근 입사일 사원
SELECT max(hiredate) FROM emp WHERE deptno=20;

-- 30번 부서 평균 급여
SELECT round(avg(sal)) FROM emp WHERE deptno=30;

-- 부서별 평균 급여 출력
SELECT deptno, avg(sal) FROM emp; -- 이대로는 안됨 => group by

-- 부서별 평균 급여 출력 해결
SELECT deptno, avg(sal) FROM emp GROUP BY deptno;
-- GROUP BY : 결과값을 원하는 열로 묶어 출력

-- 부서별, 직책별 급여 평균 출력
SELECT deptno, job, avg(sal) FROM emp GROUP BY deptno, job ORDER BY deptno, job;

-- 대표적인 GROUP BY 실수
SELECT ename, deptno, avg(sal) FROM emp GROUP BY deptno;
-- 그룹을 잡은 컬럼 외에는 SELECT절에 들어올 수 없다.

-- GROUP BY ~ HAVING : 그룹을 잡을 때 조건을 주는 경우
-- 각 부서의 직책별 평균 급여를 구하되, 평균 급여가 2000이상인 그룹만 출력
SELECT deptno, job, round(avg(sal)) FROM emp GROUP BY deptno, job HAVING avg(sal)>=2000 ORDER BY deptno, job;

-- emp 테이블의 부서별 직책의 평균 급여가 500이상인 사원들의 부서번호, 직책
-- 평균급여 출력
SELECT deptno, job, round(avg(sal)) FROM emp GROUP BY deptno, job HAVING avg(sal)>=500 ORDER BY deptno, job;

SELECT deptno, job, round(avg(sal)) FROM emp WHERE avg(sal)>=500 GROUP BY deptno, job; -- 에러남. 즉, 이렇게 WHERE절에 다중행 함수 쓰면 GROUP BY 같이 못씀

-- WHERE Phrase with GROUP BY
SELECT deptno, job, AVG(sal)    -- 5번째로 실행
FROM emp                        -- 1번째로 실행
WHERE sal<=3000                 -- 2번째로 실행
GROUP BY deptno, job            -- 3번째로 실행
HAVING AVG(sal)>=2000           -- 4번째로 실행
ORDER BY deptno, job;           -- 6번째로 실행

-- [실습1] 부서별 평균급여, 최고급여, 최저급여, 사원수 출력. 평균급여에 소수점 제외
SELECT deptno, round(avg(sal)) as avg_sal, max(sal) as max_sal, min(sal) as min_sal, count(empno) FROM emp GROUP BY deptno;

-- [실습2] 같은 직책에 종사하는 사원이 3명 이사인 직책과 사원수
SELECT job, count(*) FROM emp GROUP BY job HAVING count(*)>=3;

-- [실습3] 사원들 입사연도 기준 부서별로 몇명 입사
SELECT to_char(hiredate, 'YYYY'), deptno, count(hiredate)  FROM emp GROUP BY TO_CHAR(hiredate,'YYYY'), deptno;


-- JOIN
-- 데이터가 여러 개의 테이블에 나뉘어 저장되었을 때 두 테이블 합쳐서 결과 내는
 
SELECT * FROM emp;

SELECT * FROM dept;

-- 1) 내부조인(등가조인): 일치하는 칼럼 기준으로 값 가져오기
SELECT e.empno, e.ename, e.deptno, dname, loc FROM emp e, dept d WHERE e.deptno = d.deptno; -- column ambiguously defined

-- 내부 조인 표준 구문 (INNER 생략 가능)
SELECT e.empno, e.ename, e.deptno, dname, loc FROM emp e inner join dept d on e.deptno = d.deptno;

-- 부서번호가 일치하는 사원들 정보 출력
-- 급여가 3000 이상인 사원들만
SELECT e.empno, e.ename, e.deptno, dname, loc FROM emp e inner join dept d on e.deptno=d.deptno and sal>=3000;

-- 부서번호가 일치하는 사원들 정보 출력
-- 급여가 2500 이하이고, 사원번호가 9999 이하인 사원들만
SELECT e.empno, e.ename, e.deptno, d.dname, d.loc FROM emp e, dept d where e.deptno=d.deptno and sal<=2500 and e.empno<=9999;
SELECT e.empno, e.ename, e.deptno, d.dname, d.loc FROM emp e inner join dept d on e.deptno=d.deptno and sal<=2500 and e.empno<=9999;

-- emp, salgrade 조인 (범위와의 조인 - 위의 등가조인과는 다른 비등가조인)
select * from salgrade;

SELECT empno, ename, job, sal, comm, deptno, grade
FROM emp e JOIN salgrade s ON e.sal BETWEEN s.losal AND s.hisal;

-- 자기 자신 테이블 조인: 셀프조인
SELECT e1.empno, e1.ename, e1.mgr, e2.empno as mgr_empno, e2.ename as mgr_ename
FROM emp e1 JOIN emp e2 ON e1.mgr = e2.empno;

-- Outer Join (외부조인 - 좌측, 우측, 양측) => 좌측 우측 결과 달라짐
SELECT e1.empno, e1.ename, e1.mgr, e2.empno as mgr_empno, e2.ename as mgr_ename
FROM emp e1 RIGHT OUTER JOIN emp e2 ON e1.mgr = e2.empno;

-- [문제] 각 부서별 평균급여, 최대급여, 최소급여, 사원수 출력
-- 부서코드, 부서명도 같이
SELECT round(avg(sal)), max(sal), min(sal), count(*), d.deptno, dname
FROM dept d INNER JOIN emp e ON e.deptno=d.deptno GROUP BY d.deptno, dname;


-- [문제] 모든 부서정보와 사원 정보를 출력 (부서번호 오름차순, 사원번호 오름차순)
-- 부서번호, 부서명, 사원번호, 사원명, 직책, 급여
SELECT d.deptno, dname, empno, ename, job, sal
FROM dept d LEFT OUTER JOIN emp e ON e.deptno=d.deptno;

-- 세 개의 테이블 조인 (차례대로 쭉쭉)
SELECT e1.empno, e2.empno, e3.empno
FROM emp e1 join emp e2 on e1.empno = e2.empno JOIN emp e3 ON e2.empno = e3.empno;

-- [실습]
SELECT d.deptno, d.dname, e1.empno, e1.ename, e1.mgr, e1.sal, e1.deptno as deptno_1, s.losal, s.hisal, s.grade, e2.empno as mgr_empno, e2.ename as mgr_ename
FROM dept d LEFT OUTER JOIN emp e1 on d.deptno = e1.deptno 
LEFT OUTER JOIN salgrade s ON e1.sal BETWEEN s.losal and s.hisal 
LEFT OUTER JOIN emp e2 ON e1.mgr = e2.empno;


-- 서브쿼리 : 쿼리문 안에 또다른 쿼리문 존재
-- SELECT 조회할 열 FROM 테이블 명 WHERE 조건식 (SELECT 조회할 열 FROM 테이블 명 WHERE 조건식)
-- WHERE절 FROM절 SELECT절 모두 올 수 있음

-- JONES 사원의 급여보다 높은 급여를 받는 사원 조회
SELECT * FROM emp WHERE sal > (SELECT sal FROM emp WHERE ename='JONES'); -- 비교가 들어갈 땐 비교할 칼럼이 똑같아야 함

-- ALLEN 사원의 추가수당보다 많은 추가수당을 받는 사원정보
SELECT * FROM emp WHERE comm > (SELECT comm FROM emp WHERE ename='ALLEN');

-- 'WARD'보다 빨리 입사한 사원 정보 조회
SELECT * FROM emp WHERE hiredate > (SELECT hiredate FROM emp WHERE ename='WARD');

-- 위 처럼 실행 결과가 하나로 나오는 단일행 서브쿼리 사용 연산자
-- >, <, >=, <=, =, <>, ~=, !=

-- 20번 부서에 속한 사원 중 전체 사원의 평균 급여보다 높은 급여 받는 사원정보, 소속부서
SELECT e.*, d.* FROM emp e JOIN dept d ON e.deptno = d.deptno WHERE e.deptno=20 AND e.sal > (SELECT AVG(sal) FROM emp);


-- 실행 결과가 여러개로 나오는 다중행 서브쿼리 사용 연산자
-- IN, ANY(SOME), ALL, EXISTS

-- IN : 메인쿼리의 데이터가 서브쿼리 결과 중 하나라도 일치한 데이터가 있으면 TRUE
-- 각 부서별 최고 급여와 동일한 급여를 받는 사원 정보 출력
SELECT * FROM emp WHERE sal IN (SELECT MAX(sal) FROM emp GROUP BY deptno);

-- ANY(SOME) : 서브쿼리가 반환한 여러 결과값 중 메인쿼리의 조건식 중 하나라도 TRUE라면 조건식을 TRUE로 반환
-- IN == =ANY : 둘이 같음. 근데 같은지를 볼 때는 IN을 많이 쓰긴 함. 간편하니까 ANY는 대소비교에 많이 씀
SELECT * FROM emp WHERE sal = ANY (SELECT MAX(sal) FROM emp GROUP BY deptno);

-- 각 부서별 최고 급여보다 작은 급여를 받는 사원 정보 출력
SELECT * FROM emp WHERE sal < ANY (SELECT MAX(sal) FROM emp GROUP BY deptno);

-- 30번 부서 사원들의 최소 급여보다 많은 급여를 받는 사원 정보 출력 (min 없이)
-- -> 어차피 ANY 쓰던 그것들 중 맞는 거 하나 만족하면 다 나오니까 최대 최소 자동으로 적용 되는 형식
SELECT * FROM emp WHERE sal > any(SELECT distinct sal FROM emp WHERE deptno=30);

-- 30번 부서 사원들의 최소 급여보다 적은 급여를 받는 사원 정보 출력 (min 없이)
-- ALL : 서브쿼리가 반환한 여러 결과 값을 메인쿼리의 조건식이 모두 TRUE라면 조건식을 TRUE로 반환
SELECT * FROM emp WHERE sal < ALL (SELECT distinct sal FROM emp WHERE deptno=30);

-- 다중열 서브쿼리
-- 자신의 부서 내에서 최고 연봉과 동일한 급여를 받는 사원 출력
SELECT * FROM emp WHERE (deptno, sal) IN (SELECT deptno, max(sal) FROM emp GROUP BY deptno);

-- FROM 절에 사용하는 서브쿼리 (인라인뷰)
SELECT e10.empno, e10.ename, e10.deptno, d.dname, d.loc
FROM (SELECT * FROM emp WHERE deptno = 10) e10, (SELECT * FROM dept) d -- 사용할 테이블을 제한해서 가져옴
WHERE e10.deptno = d.deptno;

-- [문제] 10번 부서에 근무하는 사원 중 30번 부서에는 존재하지 않는 직책을 가진 사원정보, 부서정보 출력 (NOT IN)
SELECT e.*, d.* FROM emp e join dept d ON e.deptno=d.deptno
WHERE e.deptno = 10
AND e.job NOT IN (SELECT job FROM emp WHERE deptno=30);

-- [문제] 직책이 SALESMAN인 사람들의 최고급여보다 높은 급여를 받는 사원들의 사원정보, 급여 등급 정보를 출력 (MAX 사용)
-- empno, ename, sal, grade 출력
SELECT empno, ename, sal, grade FROM emp e JOIN salgrade s ON e.sal BETWEEN s.losal AND s.hisal WHERE e.sal > (SELECT MAX(sal)FROM emp WHERE job = 'SALESMAN');

-- [문제] 직책이 SALESMAN인 사람들의 최고급여보다 높은 급여를 받는 사원들의 사원정보, 급여 등급 정보를 출력 (MAX 미사용)
-- empno, ename, sal, grade 출력
SELECT empno, ename, sal, grade FROM emp e JOIN salgrade s ON e.sal BETWEEN s.losal AND s.hisal WHERE e.sal > ALL (SELECT sal FROM emp WHERE job = 'SALESMAN');



-- DML (데이터 조작어 : 삽입, 삭제, 수정)
-- commit(커밋) : DB에 최종 반영
-- rollback(롤백) : 지금 반영될 걸 취소

-- dept 테이블의 데이터를 추출하여 dept_temp 테이블 생성
CREATE TABLE dept_temp as SELECT * FROM dept;

-- insert(삽입)
-- insert into 테이블명(열이름...)
-- values(데이터...)

-- 문자, 날짜 데이터는 '' 사용
insert into dept_temp(deptno, dname, loc)
values (50, 'DATABASE', 'SEOUL');

insert into dept_temp -- 이렇게 여기 생략도 가능
values (60, 'NETWORK', 'BUSAN');

insert into dept_temp -- 생략 조건 : 여기는 에러 뜸
values (70, 'INTRANET'); -- 여기서 들어오는 값의 수가 다 맞아야 생략 가능

insert into dept_temp(deptno, dname)
values (70, 'INTRANET');

insert into dept_temp -- insert가 안됨
values (800, 'NETWORK', 'BUSAN'); -- SQL에서는 테이블 생성 시 데이터 받을 범위 명시
-- (ORA-01438: value larger than specified precision allowed for this column)

insert into dept_temp
values (80, 'NETWORK', null); -- 이렇게 null 명시도 가능

SELECT * FROM dept_temp;

-- emp 테이블의 구조만 복사해서 빈 emp_temp 테이블 생성
CREATE TABLE emp_temp as SELECT * FROM emp WHERE 1<>1;

INSERT INTO emp_temp(empno, ename, job, mgr, hiredate, sal, comm, deptno) --> 여기서의 순서는 크게 상관 없음. 아래에서 순서 같이 잘만 맞춰주면 됨
VALUES (9999, '권대현', 'ANALYST', null, '2021-01-05', 5000, 1000, 10);

INSERT INTO emp_temp(empno, ename, job, mgr, hiredate, sal, comm, deptno)
VALUES (8888, '홍길동', 'MANAGER', 9999, sysdate, 4000, 500, 20);

-- emp 테이블의 사원 중 부서번호가 20번인 사원들을 emp_temp에 추가
INSERT INTO emp_temp(empno, ename, job, mgr, hiredate, sal, comm, deptno)
SELECT empno, ename, job, mgr, hiredate, sal, comm, deptno FROM emp WHERE deptno=20;

-- emp 테이블에서 salgrade 테이블을 참조하여 등급이 1인 사원을
-- emp_temp에 추가하고 싶을때
INSERT INTO emp_temp(empno, ename, job, mgr, hiredate, sal, comm, deptno)
SELECT empno, ename, job, mgr, hiredate, sal, comm, deptno
FROM emp e join salgrade s on e.sal BETWEEN s.losal AND s.hisal WHERE s.grade=1;


-- 수정 (UPDATE)
-- UPDATE 테이블명 SET 변경할열 = 값, 변경할열 = 값
-- WHERE절은 선택

-- loc를 전부 서울로 변경
UPDATE dept_temp SET loc = 'SEOUL'; -- 이렇게 WHERE 없으면 모두 변경

-- deptno가 50인 경우에 loc 부산으로 변경
UPDATE dept_temp SET loc = 'BUSAN' WHERE deptno=50;

-- emp_temp 사원 중 sal 3000 이하인 사원만 comm 300으로 수정
UPDATE emp_temp SET comm = 300 WHERE sal<=3000;

-- UPDATE 구문에서의 서브쿼리
-- dept 테이블에서 부서번호 40번인 부서명과 지역 추출
-- dept_temp에 추가

UPDATE dept_temp SET (dname, loc) = (SELECT dname, loc FROM dept WHERE deptno=40);

-- dname이 operations인 부서번호 추출
-- 추출된 부서번호와 일치하는 부서번호의 지역을 'SEOUL'로 변경
UPDATE dept_temp SET loc = 'SEOUL' WHERE deptno = (SELECT deptno FROM dept WHERE dname = 'OPERATIONS');

SELECT * FROM dept_temp;

-- DELETE : 삭제
-- DELETE [FROM은 와도되고 안와도 됨] [WHERE도 와도되고 안와도됨]
SELECT * FROM emp_temp;

-- job이 ANALYST인 사원 삭제
DELETE FROM emp_temp WHERE job = 'ANALYST';

DELETE emp_temp;

-- DELETE 구문에서의 서브쿼리
-- emp_temp에서 급여등급이 3이고 20번 부서의 사원만 삭제
DELETE FROM emp_temp WHERE empno_temp = (SELECT EMPNO FROM EMP_TEMP e join SALGRADE s on e.sal BETWEEN e.sal and e.sal);
SEL sal = 1500;
WHERE empno = 17000;



-- [실습1]
CREATE TABLE exam_emp as SELECT * FROM emp;
CREATE TABLE exam_dept as SELECT * FROM dept;
CREATE TABLE exam_salgrade as SELECT * FROM salgrade;

-- [실습2]
INSERT INTO exam_emp(empno, ename, job, mgr, hiredate, sal, comm, deptno)
VALUES (7201, 'TEST_USER1', 'MANAGER', 7788, '2016-01-02', 4500, NULL, 50);
INSERT INTO exam_emp(empno, ename, job, mgr, hiredate, sal, comm, deptno)
VALUES (7202, 'TEST_USER2', 'CLERK', 7201, '2016-02-21', 1800, NULL, 50);
INSERT INTO exam_emp(empno, ename, job, mgr, hiredate, sal, comm, deptno)
VALUES (7203, 'TEST_USER3', 'ANALYST', 7201, '2016-04-11', 3400, NULL, 60);
INSERT INTO exam_emp(empno, ename, job, mgr, hiredate, sal, comm, deptno)
VALUES (7204, 'TEST_USER4', 'SALESMAN', 7201, '2016-05-31', 2700, 300, 60);
INSERT INTO exam_emp(empno, ename, job, mgr, hiredate, sal, comm, deptno)
VALUES (7205, 'TEST_USER5', 'CLERK', 7201, '2016-07-20', 2600, NULL, 70);
INSERT INTO exam_emp(empno, ename, job, mgr, hiredate, sal, comm, deptno)
VALUES (7206, 'TEST_USER6', 'CLERK', 7201, '2016-09-08', 2600, NULL, 70);
INSERT INTO exam_emp(empno, ename, job, mgr, hiredate, sal, comm, deptno)
VALUES (7207, 'TEST_USER7', 'LECTURER', 7201, '2016-10-28', 2300, NULL, 80);
INSERT INTO exam_emp(empno, ename, job, mgr, hiredate, sal, comm, deptno)
VALUES (7208, 'TEST_USER8', 'STUDENT', 7201, '2018-03-09', 1200, NULL, 80);

-- [실습3]
UPDATE exam_emp
SET deptno = 70
WHERE sal > (SELECT avg(sal) from exam_emp WHERE deptno=50);

-- [실습4]
UPDATE exam_emp
SET sal = sal*1.1, deptno=80
WHERE hiredate > (SELECT min(hiredate) FROM exam_emp WHERE deptno=60);

-- [실습5]
DELETE FROM exam_emp WHERE sal IN (SELECT e.sal FROM exam_emp e join exam_salgrade s ON e.sal BETWEEN s.losal AND s.hisal WHERE s.grade=5);

select * from exam_emp;

rollback;
commit;


-- 트랜잭션 : 관계형DB에서 하나의 작업 또는 밀접하게 관련된 작업수행을 위해 나눌 수 없는 최소 수행 단위

CREATE TABLE dept_tcl AS SELECT * FROM dept;
SELECT * FROM dept_tcl;

-- 트랜잭션과 관련있는 명령어
INSERT INTO dept_tcl VALUES(50, 'DATABASE', 'SEOUL');
UPDATE dept_tcl SET loc='BUSAN' WHERE deptno = 40;
DELETE FROM dept_tcl WHERE dname='RESEARCH';
-------- 여기까지 하나의 트랜잭션이라 가정 --------
-- 한 번에 커밋 혹은 롤백해야 함.

ROLLBACK;

COMMIT;

-- 세션 개념을 추가
-- 세션(session) : 어떤 활동을 위한 시간이나 기간
-- DB 세션 : DB 접속부터 여러 작업 수행하고 접속 종료 까지

DELETE FROM dept_tcl WHERE deptno=50;
SELECT * FROM dept_tcl;
COMMIT;

UPDATE dept_tcl SET loc='SEOUL'
WHERE deptno = 30;
SELECT * FROM dept_tcl;
COMMIT;


-- DDL (데이터 정의어) : 객체(클래스 아니고 테이블, 시퀀스 인덱스 등) 생성(CREATE), 변경(ALTER), 삭제(DROP)

-- 테이블 생성
-- CREATE TABLE 테이블명(열이름 자료형, 열이름 자료형 반복);
-- 테이블명 규칙
-- 문자로 시작/ 숫자시작 X
-- 적당한 길이
-- 같은 사용자 소유의 테이블명 중복불가
-- 영문(한글 가능), 특수문자 가능($, #, _)
-- SQL 키워드는 테이블명, 열이름으로 사용 불가

-- 자료형
-- 문자 : 
-- CHAR(n) - 고정길이 n(바이트) ex name char(10) =>3자리 써도 10 (한글이면 세글자, 영어 열글자)
-- VARCHAR2(n) - 가변길이(var 들어가면 거의 다) ex) name varchar2(10) =>3자리 쓰면 3으로
-- NCHAR(n)  - 고정길이(유니코드 지원) ex) name nchar(10) => 한글/영어 모두 10개 문자
-- NVARCHAR(n) - 가변길이(유니코드 지원)
-- 대부분 VARCHAR2 쓰고 한글 써도 이걸로 공간 크게 잡아서 사용

-- 숫자 : 
-- NUMBER(숫자1, 숫자2) : 숫자1=자릿수, 숫자2=소숫점 자릿수 ex) empno number(4) : 숫자로 4자리 허용 / price number(7,2) : 숫자로 7자리 허용, 소수점 들어오면 2자리
-- job number 처럼 안주고 끝낼수도 있음. 이건 저장 데이터 크기에 맞춰 자동 조절
-- 주로 압도적으로 이걸 많이 써서 이것만 알아도 될 듯

-- 날짜 : 
-- DATE : 년, 월, 일, 시, 분, 초 // 이 타입 많이 쓸 것
-- TIMESTAMP : 년, 월, 일, 시, 분, 초 + 밀리초 입력 가능

-- 구조 설계
CREATE TABLE emp_ddl(empno NUMBER(4),ename VARCHAR2(10),job VARCHAR2(9),mgr NUMBER(4),hiredate DATE,sal NUMBER(7,2),comm NUMBER(7,2),deptno NUMBER(2));

DROP table emp_ddl;

-- 다른 테이블 구조 이용해 데이터 포함 생성
CREATE TABLE emp_ddl AS SELECT * FROM emp;

-- 다른 테이블 구조만 이용해 생성
CREATE TABLE emp_ddl1 AS SELECT * FROM emp WHERE 1<>1;


-- 테이블 변경 : ALTER
SELECT * FROM emp_ddl;

-- 열(컬럼) 추가: ADD
ALTER TABLE emp_ddl ADD hp VARCHAR2(20); => 자료형 잊지 말고 적기

-- 열(컬럼) 이름 변경: RENAME
ALTER TABLE emp_ddl RENAME COLUMN hp to tel;

-- 열 자료형 변경: MODIFY
ALTER TABLE emp_ddl MODIFY empno NUMBER(5);

DESC emp_ddl;

ALTER TABLE emp_ddl MODIFY empno NUMBER(3); -- 변경이 무조건 되는 건 아님. 데이터 삽입되어 있을 때는 데이터의 길이와 맞지 않으면 변경 불가

-- 열 삭제: DROP COLUMN
ALTER TABLE emp_ddl DROP COLUMN tel;

-- 테이블 명 변경: RENAME (열 이름 변경과 다르게 앞쪽에 옴)
RENAME emp_ddl TO emp_rename;

-- 테이블 삭제: DROP
DROP TABLE emp_rename;

-- [실습] emp_hw 테이블 작성
CREATE TABLE emp_hw(id CHAR(8), name VARCHAR2(10), addr VARCHAR2(50), nation CHAR(4), email VARCHAR2(50), age NUMBER(7,2));
-- CREATE TABLE emp_hw(id CHAR(8), name NVARCHAR2(10), addr NVARCHAR2(50), nation NCHAR(4), email VARCHAR2(50), age NUMBER(7,2);

DESC emp_hw;

-- [실습] emp_hw 테이블 변경
ALTER TABLE emp_hw ADD bigo VARCHAR2(20);
ALTER TABLE emp_hw MODIFY bigo VARCHAR2(30);
ALTER TABLE emp_hw RENAME COLUMN bigo TO remark;


-- 제약조건 (테이블의 특정 열에 지정)
-- 입력, 수정, 삭제 영향을 주는 부분 => 데이터의 무결성(정확성, 일관성) 유지
-- 1) NOT NULL : 지정한 열에 NULL을 허용하지 않음
-- 2) UNIQUE : 지정한 열이 유일한 값을 가져야 함 (NULL 제외)
-- 3) PRIMARY KEY : 지정한 열이 유일값이며 NULL이 아님 (하나만 지정)
-- 4) FOREIGN KEY : 다른 테이블의 열을 참조하여 존재하는 값만 입력 가능
-- 5) CHECK : 설정한 조건식을 만족하는 데이터만 입력 가능

-- NOT NULL 제약조건
CREATE TABLE table_notnull(login_id VARCHAR2(20) NOT NULL, login_pwd VARCHAR2(20) NOT NULL, tel VARCHAR2(20));

INSERT INTO table_notnull(login_id, login_pwd, tel) VALUES('test_id_01', null, '010-1234-5678'); -- cannot insert NULL into
INSERT INTO table_notnull(login_id, tel) VALUES('test_id_01', '010-1234-5678'); -- cannot insert NULL into
INSERT INTO table_notnull(login_id, login_pwd) VALUES('test_id_01', '12345');

UPDATE table_notnull SET login_pwd = NULL WHERE login_id = 'test_id_01'; -- cannot update

-- scott가 사용한 모든 제약조건 확인
SELECT * FROM user_constraints;

-- 제약조건명 지정
CREATE TABLE table_notnull2(login_id VARCHAR2(20) CONSTRAINT tblnn2_lgnid_nn NOT NULL, login_pwd VARCHAR2(20)CONSTRAINT tblnn2_lgnpwd_nn NOT NULL, tel VARCHAR2(20));

-- table_notnull tel 컬럼에 NOT NULL 제약조건 추가
DESC table_notnull;
SELECT * FROM table_notnull;
ALTER TABLE table_notnull MODIFY(tel NOT NULL); -- 이미 null 들어가있어서 못바꾼다는거

UPDATE table_notnull SET tel='010-1234-5678' WHERE login_id = 'test_id_01';
ALTER TABLE table_notnull MODIFY(tel NOT NULL); -- 이제 가능

-- 제약조건 이름 변경
ALTER TABLE table_notnull2 RENAME CONSTRAINT tblnn2_lgnid_nn TO tblnn2_id_nn;

-- 제약조건 삭제
ALTER TABLE table_notnull2 DROP CONSTRAINT tblnn2_id_nn;


-- UNIQUE 제약조건
CREATE TABLE table_unique(login_id VARCHAR2(20) UNIQUE, login_pwd VARCHAR2(20) NOT NULL, tel VARCHAR2(20));
DESC table_unique;

INSERT INTO table_unique(login_id, login_pwd, tel) VALUES('test_id_01', '12345', '010-1234-5678');
INSERT INTO table_unique(login_id, login_pwd, tel) VALUES(null, '54321', '010-9876-5432'); -- unique constraint violated

-- UNIQUE 제약조건 이름 지정
CREATE TABLE table_unique2(login_id VARCHAR2(20) CONSTRAINT tblunq2_lgnid_unq UNIQUE, login_pwd VARCHAR2(20) CONSTRAINT tblunq2_lgnpwd_nn NOT NULL, tel VARCHAR2(20));
DESC table_unique2;

-- table_unique2에 tel unique 제약조건 추가
ALTER TABLE table_unique2 MODIFY(tel unique);
SELECT * FROM user_constraints;


-- PRIMARY KEY 제약조건 : NOT NULL + UNIQUE (각 행 식별 용도)
CREATE TABLE table_pk(login_id VARCHAR2(20) PRIMARY KEY, login_pwd VARCHAR2(20) NOT NULL, tel VARCHAR2(20));
DESC table_pk;

INSERT INTO table_pk VALUES('test_01', 'pw01', '010-1234-5678');
INSERT INTO table_pk VALUES('test_01', 'pw01', '010-1234-5678'); -- unique constraint violated

CREATE TABLE table_pk2(login_id VARCHAR2(20) CONSTRAINT tblpk2_lgnid_pk PRIMARY KEY, login_pwd VARCHAR2(20) CONSTRAINT tblpk2_lgnpwd_nn NOT NULL, tel VARCHAR2(20));

-- 다른 방식의 제약조건 지정
CREATE TABLE table_com(col1 VARCHAR2(20), col2 VARCHAR2(20), PRIMARY KEY(col1), CONSTRAINT tblcon_unq unique(col2));


-- FOREIGN KEY 제약조건
CREATE TABLE dept_fk(deptno NUMBER(2) CONSTRAINT deptfk_deptno_pk PRIMARY KEY, dname VARCHAR2(20), loc VARCHAR2(13));
CREATE TABLE emp_fk(empno NUMBER(4) CONSTRAINT empfk_empno_pk PRIMARY KEY, ename VARCHAR2(10), deptno NUMBER(2) CONSTRAINT empfk_deptno_fk REFERENCES dept_fk(deptno));

INSERT INTO emp_fk(empno, ename, deptno) VALUES(7899, 'hong', 20); -- parent key not found // 외래키는 부모자식개념. 부모는 외래키 원래 열 가진 쪽
-- 외래키 삽입
-- 부모테이블에 데이터가 먼저 삽입되어야함
-- 그러고 자식테이블에 데이터 삽입
INSERT INTO dept_fk VALUES(10, 'DATABASE', 'SEOUL');
INSERT INTO emp_fk(empno, ename, deptno) VALUES(7899, 'hong', 10);

DELETE FROM dept_fk WHERE deptno=10; -- child record found // 부모 날라간다는 거. 그래서 제거는 자식 제거 이후 부모 제거
-- 외래키 삭제
-- 자식테이블에 해당하는 데이터 삭제
-- 부모테이블에 해당하는 데이터 삭제
DELETE FROM emp_fk WHERE deptno=10;
DELETE FROM dept_fk WHERE deptno=10;

-- 부모 없애면 알아서 자식도 없어지게 하거나, 다른 부모로 대체하는 방법은 없을까? 있음.
-- 부모 데이터 삭제 시 참조하고 있는 데이터도 함께 삭제
-- 부모 데이터 삭제 시 참조하고 있는 데이터를 null로 수정

-- ON DELETE CASCADE : 열 데이터 삭제 시 참조 데이터 함께 삭제 (자식 테이블 만드는 것 끝에)
CREATE TABLE dept_fk2(deptno NUMBER(2) CONSTRAINT deptfk2_deptno_pk PRIMARY KEY, dname VARCHAR2(20), loc VARCHAR2(13));
CREATE TABLE emp_fk2(empno NUMBER(4) CONSTRAINT empfk2_empno_pk PRIMARY KEY, ename VARCHAR2(10), deptno NUMBER(2) CONSTRAINT empfk2_deptno_fk REFERENCES dept_fk2(deptno) ON DELETE CASCADE);
INSERT INTO dept_fk2 VALUES(10, 'DATABASE', 'SEOUL');
INSERT INTO emp_fk2(empno, ename, deptno) VALUES(7899, 'hong', 10);
DELETE FROM dept_fk2 WHERE deptno=10; -- ON DELETE CASCADE 하니까 됨

SELECT * FROM emp_fk2;

-- ON DELETE SET NULL : 열 데이터 삭제 시 참조 데이터를 NULL로 수정 (자식 테이블 만드는 것 끝에)
CREATE TABLE dept_fk3(deptno NUMBER(2) CONSTRAINT deptfk3_deptno_pk PRIMARY KEY, dname VARCHAR2(20), loc VARCHAR2(13));
CREATE TABLE emp_fk3(empno NUMBER(4) CONSTRAINT empfk3_empno_pk PRIMARY KEY, ename VARCHAR2(10), deptno NUMBER(2) CONSTRAINT empfk3_deptno_fk REFERENCES dept_fk3(deptno) ON DELETE SET NULL);
INSERT INTO dept_fk3 VALUES(10, 'DATABASE', 'SEOUL');
INSERT INTO emp_fk3(empno, ename, deptno) VALUES(7899, 'hong', 10);
DELETE FROM dept_fk3 WHERE deptno=10; -- ON DELETE SET NULL 하니까 됨

SELECT * FROM emp_fk3;

-- CHECK 제약조건
CREATE TABLE tbl_check(login_id varchar2(20) constraint tblck_lgnid_pk primary key, login_pwd varchar2(20) constraint tblck_lgnpwd_ck check (length(login_pwd)>3), tel varchar2(20));

INSERT INTO tbl_check Values('test_id1', '123', '010-1234-5678'); -- check constraint violated
INSERT INTO tbl_check Values('test_id1', '1234', '010-1234-5678');

-- 기본값 지정 : default

CREATE TABLE tbl_default(login_id varchar2(20) constraint tbl_lgnid_pk primary key, login_pwd varchar2(20) default '1234', tel varchar2(20));

INSERT INTO tbl_default VALUES ('test_id1', null, '010-1234-5678');

select * from tbl_default;

INSERT INTO tbl_default(login_id, tel) values('test_id2', '010-1234-5678');


-- [실습1]
CREATE TABLE dept_const(deptno number(2) CONSTRAINT deptconst_deptno_pk PRIMARY KEY, dname VARCHAR2(14) CONSTRAINT deptconst_dname_unq UNIQUE, loc VARCHAR2(13) CONSTRAINT deptconst_loc_nn NOT NULL);

-- 제약 뒤로 빼면 아래와 같은 방식
--CREATE TABLE dept_const(deptno number(2), dname VARCHAR2(14), loc VARCHAR2(13), 
--CONSTRAINT deptconst_deptno_pk PRIMARY KEY(deptno),
--constraint deptconst_dname_unq unique(dname),
--CONSTRAINT deptconst_loc_nn NOT NULL(loc));

-- [실습2]
CREATE TABLE emp_const(
    empno number(2) constraint empconst_empno_pk primary key,
    ename varchar2(10) constraint empconst_ename_nn not null,
    job varchar2(9),
    tel varchar2(20) constraint empconst_tel_unq unique,
    hiredate date,
    sal number(7,2) constraint empconst_sal_chk check(sal BETWEEN 1000 AND 9999),
    comm number(7,2),
    deptno number(2) constraint empconst_deptno_fk references dept_const(deptno));
    
    
-- 시퀀스(sequence) : 규칙에 따라 순번을 생성
CREATE SEQUENCE dept_seq; -- 이런 기본적 형태는 그냥 1씩 증가.

CREATE TABLE dept_sequence AS SELECT * FROM dept WHERE 1<>1;

SELECT * FROM dept_sequence;

INSERT INTO dept_sequence(deptno, dname, loc)
VALUES(dept_seq.nextval, 'DATABASE', 'SEOUL'); -- seq.nextval로 쭉 사용.

-- 가장 마지막으로 생성된 시퀀스 확인
SELECT dept_seq.currval FROM dual;

DROP SEQUENCE dept_seq;


CREATE SEQUENCE dept_seq
INCREMENT BY 10 -- 시퀀스에서 생성할 번호의 증가값
START WITH 10 -- 시퀀스에서 생성할 번호의 시작값
MAXVALUE 90 -- 여기 닿으면 이 이상 초과하는 추가 시 에러 뜸 // 시퀀스에서 생성할 번호의 최대값
MINVALUE 0 -- 시퀀스에서 생성할 번호의 최솟값
NOCYCLE -- MAX값 찍으면 더 추가 못하게. CYCLE 걸리면 반복 가능해짐 // 시퀀스에서 생성한 번호가 최대값에 도달할 경우 다시 시작할 것인가 여부 (CYCLE / NOCYCLE)
CACHE 2; -- 시퀀스가 생성할 번호를 메모리에 미리 할당해 놓은 수를 지정

INSERT INTO dept_sequence(deptno, dname, loc)
VALUES(dept_seq.nextval, 'DATABASE', 'SEOUL');

SELECT * FROM dept_sequence;

-- 시퀀스 수정
ALTER SEQUENCE dept_seq INCREMENT BY 3 MAXVALUE 99 CYCLE;


-- 뷰(view) : 가상 테이블
--            하나 이상의 테이블을 조회하는 SELECT문을 저장한 객체
--            편리성 : SELECT문의 복잡도 완화
--            보안성 : 테이블의 특정 열을 노출하고 싶지 않은 경우

-- 뷰 생성
CREATE VIEW vm_emp20 AS (SELECT empno, ename, job, deptno FROM emp WHERE deptno=20); -- missing expression

-- INSERT
INSERT INTO vm_emp20(empno, ename, job, deptno)
VALUES(8000, 'TEST', 'MANAGER', 20);
SELECT * FROM vm_emp20;

-- 뷰와 원본테이블 연결 여부 => 연결되어 있음
-- 기본 모양으로 만들어서 인서트 델리트 등등이 열려 있어서 이렇게 된 것이라 보면 됨.
SELECT * FROM emp;

-- 생성된 뷰들의 속성 확인하기
SELECT * FROM USER_UPDATABLE_COLUMNS
WHERE TABLE_NAME = 'VM_EMP20';


-- 뷰 생성 시 원본 데이터 수정 불가하게 작성
-- WITH READ ONLY : 뷰의 열람 (읽기 전용)
CREATE VIEW vm_emp_read AS SELECT empno, ename, job FROM emp WITH read only;

SELECT * FROM USER_UPDATABLE_COLUMNS
WHERE TABLE_NAME = 'VM_EMP_READ';

INSERT INTO vm_emp_read(empno, ename, job)
VALUES(8001, 'TEST', 'MANAGER'); -- cannot perform a DML operation on a read-only view
-- 아예 에러가 뜨면서 막히는 것

-- 뷰 삭제
DROP VIEW vm_emp20;


-- 인덱스 (index) : 빠른 검색을 위한 것
-- 인덱스 사용 여부에 따라 Table Full Scan, Index Scan이 나뉨

-- scott가 가진 인덱스 확인 : 우리가 만든 테이블들도 따로 지정 안해줘도 PK 잡으면서 인덱스도 알아서 잡힘
SELECT * FROM user_indexes; -- pk, unique로 설정된 값은 인덱스로 사용됨

-- 인덱스 생성
-- CREATE INDEX 인덱스명 ON 테이블명(열이름1 ASC, 열이름2 DESC,.....)
CREATE INDEX idx_emp_sal ON emp(sal);

-- 인덱스가 설정된 COLUMN 조회
SELECT * FROM user_ind_columns;

SELECT * FROM emp WHERE deptno=20; -- 어떤 칼럼을 인덱스로 잡을지도 중요. 잘 안되면 FULL SCAN이 나을수도 있으니

-- 인덱스 삭제
DROP INDEX idx_emp_sal;








