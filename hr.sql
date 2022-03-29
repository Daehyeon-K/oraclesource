-- hr(오라클 연습용 계정)
-- scott가 가지고 있는 정보의 원본

-- [문제1] employees 테이블 전체 내용 조회
SELECT * FROM employees;

-- [문제2] employees 테이블의 first_name, last_name, job_id 조회
SELECT first_name, last_name, job_id FROM employees;

-- [문제3] employees 테이블의 모든 열 조회
-- employee_id: empno, manager_id: mgr, department_id: deptno 별칭 붙여서 조회
-- 조회할 때 부서번호 기준 내림차순 정렬, 부서번호 같으면 사원 이름(First_name) 기준 오름차순 정렬
SELECT 
    employee_id empno,
    manager_id mgr,
    department_id deptno,
    first_name,
    last_name,
    email,
    phone_number,
    hire_date,
    job_id,
    salary,
    commission_pct
    FROM employees
    ORDER BY deptno DESC, first_name ASC;
    
-- [문제4] 사원번호가 176인 사원의 last_name과 deptno 조회
SELECT last_name, department_id deptno FROM employees WHERE employee_id = 176;

-- [문제5] 연봉이 12,000 이상 되는 직원들의 last_name과 salary 조회
SELECT last_name, salary FROM employees WHERE salary>=12000;

-- [문제6] 연봉이 5000 ~ 12000 범위 사이가 아닌 사원들 조회
SELECT * FROM employees WHERE salary<5000 OR salary>12000;

-- [문제7] 20번 혹은 50번 부서에서 근무하는 모든 사원들의 last_name 및 department_id 조회
-- 이후 last_name의 오름차순, department_id의 오름차순 정렬
SELECT last_name, department_id FROM employees WHERE department_id IN (20, 50) ORDER BY last_name, department_id;

-- [문제8] 커미션을 받는 모든 사원들의 last_name, salary, commission_pct를 조회한다
-- 연봉의 내림차순, commission_pct의 내림차순 정렬
SELECT last_name, salary, commission_pct FROM employees WHERE commission_pct IS NOT NULL ORDER BY salary DESC, commission_pct DESC; -- IS NOT NULL 사용
SELECT last_name, salary, commission_pct FROM employees WHERE commission_pct>0 ORDER BY salary DESC, commission_pct DESC; -- 일반 비교 연산자 사용

-- [문제9] 연봉이 2500, 3500, 7000이 아니며, 직업이 SA_REP, ST_CLERK인 사원 조회
-- 전체 정보 조회
SELECT * FROM employees WHERE salary NOT IN (2500, 3500, 7000) AND job_id IN('SA_REP', 'ST_CLERK');

-- [문제10] '2008-02-20' ~ '2008-05-01' 사이에 고용된 사원들의 last_name, employee_id, hire_date
-- 조회, hire_date의 내림차순으로 정렬
-- '08/02/20' 대신 '2008-02-20' 해도 됨
SELECT last_name, employee_id, hire_date FROM employees WHERE hire_date>='08/02/20' AND hire_date<='08/05/01' ORDER BY hire_date DESC;
-- BETWEEN A AND B 사용
SELECT last_name, employee_id, hire_date FROM employees WHERE hire_date BETWEEN '08/02/20' AND '08/05/01' ORDER BY hire_date DESC;


-- [문제11] '2004'년도에 고용된 모든 사람들의 last_name, hire_date를 조회하여
-- 입사일 기준으로 오름차순 정렬
SELECT last_name, hire_date FROM employees WHERE hire_date>='04/01/01' AND hire_date<='04/12/31' ORDER BY hire_date;
-- BETWEEN A AND B 사용
SELECT last_name, hire_date FROM employees WHERE hire_date BETWEEN '04/01/01' AND '04/12/31' ORDER BY hire_date;

-- [문제12] '2004'년도에 고용된 모든 사람들의 last_name, hire_date를 조회하여
-- 입사일 기준으로 오름차순 정렬, Like 와일드카드 사용
SELECT last_name, hire_date FROM employees WHERE hire_date LIKE '04%'ORDER BY hire_date;

-- [문제13] last_name에 u가 포함되는 사원들 사번, last_name 조회
SELECT employee_id, last_name FROM employees WHERE last_name LIKE '%u%';

-- [문제14] last_name의 4번째 글자가 a인 사원들의 사번 및 last_name 조회
SELECT employee_id, last_name FROM employees WHERE last_name LIKE '___a%';

-- [문제15] last_name에 a 혹은 e가 들어있는 사원들의 last_name 조회 후
-- last_name 오름차순 출력
SELECT last_name FROM employees WHERE last_name LIKE IN ('%a%', '%e%') ORDER BY last_name;

-- [문제16] last_name에 a 와 e가 들어있는 사원들의 last_name 조회 후
-- last_name 오름차순 출력
SELECT last_name FROM employees WHERE last_name LIKE '%a%' AND last_name00 LIKE '%e%' ORDER BY last_name;

-- [문제17] 매니저 없는 사원들 last_name 조회 
SELECT last_name, job_id FROM employees WHERE manager_id IS NULL;

-- [문제18] ST_CLERK인 job_id를 가진 사원이 없는 부서 id 조회
-- 단 부서번호 NULL인 값 제외
SELECT department_id FROM employees WHERE job_id not in ('ST_CLERK') AND department_id IS NOT NULL;

-- [문제 19] commission_pct가 null이 아닌 사원들 중 commission = salart * commssion_pct 구해
-- employee_id, first_name, job_id 와 함께 출력
SELECT employee_id, first_name, job_id, salary * commission_pct AS commission
FROM employees
WHERE commission_pct IS NOT NULL;

-- [문제] first_name이 Curtis인 사람의 first_name, last_name, phone_number, job_id 조회
-- 단, job_id의 결과는 소문자로 출력하기
SELECT first_name, last_name, phone_number, LOWER(job_id) as job_id FROM employees WHERE first_name='Curtis';

-- [문제] 부서번호가 60, 70, 80, 90인 사원들의 employee_id, first_name, last_name, department_id
-- job_id 조회하기. 단, job_id가 IT_PROG인 사원의 경우 프로그래머로 변경하여 출력
SELECT employee_id, first_name, last_name, department_id, REPLACE(job_id, 'IT_PROG', 'PROGRAMMER') FROM employees WHERE department_id IN (60, 70, 80, 90);

-- [문제] job_id가 AD_PRES, PU_CLERK인 사원들의 employee_id, first_name, last_name, deparment_id
-- job_id 조회하기, 단 사원명은 first_name과 last_name을 연결하여 출력
SELECT employee_id, first_name||' '||last_name as employee_name, department_id, job_id FROM employees WHERE job_id IN ('AD_PRES', 'PU_CLERK');


-- [실습4]
SELECT last_name, salary, case when salary BETWEEN 0 and 1999 then 0 when salary BETWEEN 2000 and 3999 then 0.09
when salary BETWEEN 4000 and 5999 then 0.2 when salary BETWEEN 6000 and 7999 then 0.3 when salary BETWEEN 8000 and 9999 then 0.4
when salary BETWEEN 10000 and 11999 then 0.42 when salary BETWEEN 12000 and 13999 then 0.44 else 0.45 end AS tax_rate FROM employees where department_id='80';
-- decode 활용하기

-- [문제] 회사 내 최대 연봉 및 최소 연봉 차 출력
SELECT max(salary)-min(salary) FROM employees;

-- [문제] 매니저 근무자의 총 수
SELECT count(DISTINCT manager_id) FROM employees;

-- [문제] 부서별 직원 수 구해서 부서번호 오름차순 출력
SELECT department_id, count(employee_id) FROM employees GROUP BY department_id ORDER BY department_id;

-- [문제] 부서별 급여의 평균 연봉 부서번호별 오름차순 출력
SELECT department_id, round(AVG(salary)) FROM employees GROUP BY department_id ORDER BY department_id;

-- [문제] 동일 직업 사원의 수 출력
SELECT job_id, count(*) FROM employees GROUP BY job_id;


-- [실습] 자신의 담당 매니저의 고용일보다 빠른 입사자 찾기 (employees 셀프 조인)
SELECT e1.last_name, e1.hire_date, e2.last_name as mgr_last_name, e2.hire_date as mgr_hire_date
FROM employees e1 JOIN employees e2 ON e1.manager_id=e2.employee_id AND e1.hire_date < e2.hire_date; -- AND 대신 WHERE이 나을수도

-- [실습] 도시 이름이 T로 시작하는 지역에 사는 사원들의 사번, last_name, department_id, city
-- 출력 (employees, departments, locations 테이블 조인)
SELECT e.employee_id, e.last_name, d.department_id, l.city
FROM employees e JOIN departments d ON e.department_id = d.department_id
JOIN locations l ON d.location_id = l.location_id AND l.CITY LIKE 'T%';

-- [실습] 위치 ID가 1700인 사원들의 employee_id, last_name, department_id, salary
-- 출력 (employees, departments 조인)
SELECT e.employee_id, e.last_name, d.department_id, e.salary, d.location_id
FROM employees e JOIN departments d ON e.department_id = d.department_id AND d.location_id=1700;

-- [실습] 각 부서별 평균 연봉(소수점 2자리까지), 사원 수 조회
-- department_name, location_id, sal_avg, cnt 출력
-- (employees, departments 조인)
SELECT d.department_name, d.location_id, ROUND(AVG(salary), 2) AS sal_avg, COUNT(employee_id) AS cnt
FROM employees e JOIN departments d ON e.department_id = d.department_id GROUP BY d.department_name, d.location_id;

-- [실습] Executive 부서에 근무하는 모든 사원들의 department_id, last_name, job_id 출력
-- (employees, departments 조인)
SELECT d.department_id, e.last_name, e.job_id,d.department_name 
FROM employees e JOIN departments d ON e.department_id = d.department_id AND d.department_name='Executive';

-- [실습] 기존의 직업을 여전히 가지고 있는 사원들의 employee_id, job_id 출력
-- (employees, job_history 내부 조인)
SELECT e.employee_id, e.job_id, j.job_id as previous_job_id
FROM employees e JOIN job_history j ON e.employee_id = j.employee_id AND e.job_id = j.job_id;

-- [실습] 각 사원별 소속 부서에서 자신보다 늦게 고용되었으나 보다 많은 연봉을 받는 사원의
-- department_id, last_name, salary, hire_date 출력
-- (employee 셀프 조인)
SELECT distinct e2.department_id, e1.last_name, e1.salary, e1.hire_date, e2.last_name, e2.salary, e2.hire_date
FROM employees e1 JOIN employees e2 ON e1.department_id = e2.department_id AND e1.hire_date < e2.hire_date AND e1.salary < e2.salary;

-- index
CREATE TABLE indextbl AS SELECT DISTINCT first_name, last_name, hire_date FROM employees;
SELECT * FROM indextbl;
SELECT * FROM indextbl WHERE first_name='Jack'; -- WHERE저 첨부터 끝까지 FULL 스캔? 아마 계획 설명을 보면 인덱스를 이용해 스캔 종류가 달라진다는 느낌

CREATE INDEX idx_indextbl_firstname on indextbl(first_name);




