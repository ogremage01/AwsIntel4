------------------2025.01.15------------------

--모든 테이블 지우기

SELECT *
FROM TAB;

SELECT 'DROP TABLE ' || TABLE_NAME|| ';'
FROM USER_TABLES;


----

SELECT *
FROM EMP, DEPT;

SELECT *
FROM EMP, DEPT
WHERE EMP.DEPTNO = DEPT.DEPTNO;

--테이블 별칭
SELECT EMPNO, SAL, DNAME, LOC, E.HIREDATE, E.MGR
FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO;


SELECT *
FROM SALGRADE;

DESC SALGRADE;

--비동등 조인
--1. 오라클만 사용가능하여 잘 안씀
SELECT ENAME, SAL, GRADE 등급
FROM EMP E, SALGRADE SG
WHERE SAL BETWEEN LOSAL AND HISAL;

--2. 표준식
SELECT ENAME, SAL, GRADE 등급
FROM EMP E, SALGRADE SG
WHERE E.SAL >= SG.LOSAL
AND E.SAL <= SG.HISAL;


--새로운 테이블 생성
CREATE TABLE PLAYER_HEIGHT_GRADE(
    GRADE NUMBER,
    LO_HEIGHT NUMBER(3),
    HI_HEIGHT NUMBER(3)
);

INSERT INTO PLAYER_HEIGHT_GRADE
VALUE (GRADE, LO_HEIGHT, HI_HEIGHT)
VALUES(1, 160, 169);


INSERT INTO PLAYER_HEIGHT_GRADE
VALUE (GRADE, LO_HEIGHT, HI_HEIGHT)
VALUES(2, 170, 179);


INSERT INTO PLAYER_HEIGHT_GRADE
VALUE (GRADE, LO_HEIGHT, HI_HEIGHT)
VALUES(3, 180, 189);


INSERT INTO PLAYER_HEIGHT_GRADE
VALUE (GRADE, LO_HEIGHT, HI_HEIGHT)
VALUES(4, 190, 199);

SELECT *
FROM PLAYER_HEIGHT_GRADE;
COMMIT;

----
--축구 선수들의 키 등급을 구하시오
--선수번호 팀ID 팀명 선수명 HEIGHT 키등급
--                       165  1등급

SELECT *
FROM PLAYER_HEIGHT_GRADE;
SELECT *
FROM PLAYER;
SELECT *
FROM TEAM;

--(다중테이블 JOIN)
SELECT PLAYER_ID 선수번호, T.TEAM_ID 팀ID, TEAM_NAME 팀명, PLAYER_NAME 선수명,  HEIGHT, GRADE 키등급
FROM TEAM T, PLAYER P, PLAYER_HEIGHT_GRADE PHE
WHERE P.TEAM_ID = T.TEAM_ID
AND P.HEIGHT >= PHE.LO_HEIGHT
AND P.HEIGHT <= PHE.HI_HEIGHT;

--문제 수정됨
--선수번호 선수명 HEIGHT 키등급
--               165  1등급
SELECT PLAYER_ID 선수번호, PLAYER_NAME 선수명, HEIGHT, GRADE 키등급
FROM PLAYER P, PLAYER_HEIGHT_GRADE PHE
WHERE P.HEIGHT >= PHE.LO_HEIGHT
AND P.HEIGHT <= PHE.HI_HEIGHT ;

------
--1
--조인을 사용하여 뉴욕에서 근무하는 사원의 이름과 급여를 출력하시오
--단 급여가 높은 순으로 출력
--ENAME   SAL
SELECT *
FROM EMP;
SELECT *
FROM DEPT;

SELECT ENAME, SAL
FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO
AND D.LOC = 'NEW YORK'
ORDER BY SAL DESC;
--2
--선수들 중 골키퍼인 선수들을
--BACK 넘버가 낮은 번호가 먼저 출력하되
--연고지(REGION_NAME)을 출력하시오
--선수명 백넘버 연고지 팀명
SELECT *
FROM PLAYER;
SELECT *
FROM TEAM;

SELECT PLAYER_NAME 선수명, BACK_NO 백넘버, REGION_NAME 연고지, TEAM_NAME 팀명
FROM PLAYER P, TEAM T
WHERE P.TEAM_ID = T.TEAM_ID
AND POSITION = 'GK'
ORDER BY BACK_NO;

--3
--사원의 급여등급과 부서명을 조회하는 SQL문을 작성하시오
--단, 부서명 글자가 느린 순으로 출력
--ENAME   DNAME   GRADE
SELECT *
FROM EMP;
SELECT *
FROM DEPT;
SELECT *
FROM SALGRADE;

SELECT ENAME, DNAME, GRADE
FROM DEPT D, EMP E, SALGRADE SG
WHERE E.DEPTNO = D.DEPTNO
AND E.SAL >= SG.LOSAL
AND E.SAL <= SG.HISAL
ORDER BY DNAME DESC;

-------------------self join

SELECT *
FROM EMP;

SELECT ENAME, MGR
FROM EMP;

SELECT EMPLOYEE.ENAME ||'의 매니저(상사)는'|| MANAGER.ENAME || '이다'
FROM EMP EMPLOYEE, EMP MANAGER
WHERE EMPLOYEE.MGR = MANAGER.EMPNO;


--1
--상사가 KING인 사원들의 이름과 직급을 출력하시오
--이름이 빠른 순으로 정렬
--ENAME   JOB

SELECT *
FROM EMP
WHERE MGR = 7839
ORDER BY ENAME;

--내풀이
SELECT EMPLOYEE.ENAME, EMPLOYEE.JOB
FROM EMP EMPLOYEE, EMP MANAGER
WHERE EMPLOYEE.MGR = 7839
AND MANAGER.ENAME = 'KING'
ORDER BY EMPLOYEE.ENAME;
--수정
SELECT EMPLOYEE.ENAME, EMPLOYEE.JOB
FROM EMP EMPLOYEE, EMP MANAGER
WHERE EMPLOYEE.MGR = MANAGER.EMPNO
AND MANAGER.ENAME = 'KING'
ORDER BY EMPLOYEE.ENAME;


--2
--SMITH와 동일한 근무지에서 근무하는 사원의 이름을
--출력하시오
--SMITH   동료이름
SELECT *
FROM DEPT;

SELECT *
FROM EMP;

--내풀이
SELECT SMITH.ENAME SMITH, EMPLOYEE.ENAME 동료이름
FROM EMP SMITH, EMP EMPLOYEE
WHERE EMPLOYEE.DEPTNO = 20
AND SMITH.ENAME = 'SMITH'
AND EMPLOYEE.ENAME <> 'SMITH';
--수정
SELECT EMPLOYEE.ENAME SMITH, COLLEAGUE.ENAME 동료이름
FROM EMP EMPLOYEE, EMP COLLEAGUE
WHERE EMPLOYEE.DEPTNO = COLLEAGUE.DEPTNO
AND EMPLOYEE.ENAME <> COLLEAGUE.ENAME
AND EMPLOYEE.ENAME = 'SMITH';


-------------------OUTER JOIN(외부 조인)

--각 사원들의 부서 정보를 출력하시오
--단, 부서정보가 없으면 사원을 출력하지 않는다
SELECT E.ENAME, D.DEPTNO, D.DNAME
FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO
ORDER BY D.DEPTNO;

--각 사원들의 부서 정보를 출력하시오
--단, 부서정보가 없으면 사원을 출력하지 않으며 모든 부서 정보를 출력한다
SELECT E.ENAME, D.DEPTNO, D.DNAME
FROM EMP E, DEPT D
WHERE E.DEPTNO(+) = D.DEPTNO
ORDER BY D.DEPTNO;

--각 사원들의 부서 정보를 출력하시오
--단, 부서정보가 없는 사원도 출력한다 > 모든 사원 정보 조회
SELECT E.ENAME, D.DEPTNO, D.DNAME
FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO(+)
ORDER BY D.DEPTNO;

--------------
--1
--사원과 상사 정보 출력
--'FORD의 매니저는 JONES 입니다.' 와 같이 출력을 하는데
--모든 사원의 상사 정보를 출력하되 상사가 없는 직원의 경우
--'KING의 매니저는 없다 입니다.'
--컬럼명
--나와 상사 정보
SELECT *
FROM EMP;

SELECT EMPLOYEE.ENAME ||'의 매니저는 '|| NVL(MANAGER.ENAME, '없다') ||'입니다.' "나와 상사 정보"
FROM EMP EMPLOYEE, EMP MANAGER
WHERE EMPLOYEE.MGR = MANAGER.EMPNO(+);

---------------
--일반 조인(JOIN)
SELECT *
FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO
AND E.ENAME = 'SMITH';

--안시 표준 조인(ANSI JOIN)
SELECT *
FROM EMP E INNER JOIN DEPT D
ON E.DEPTNO = D.DEPTNO
WHERE E.ENAME = 'SMITH';
---------------
--직급이 MANAGER인 사원의 이름, 부서명을 출력
--EMPNO   ENAME   부서테이블의 모든 컬럼명

SELECT E.EMPNO, E.ENAME, D.*
FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO
AND E.JOB = 'MANAGER';


SELECT E.EMPNO, E.ENAME, D.*
FROM EMP E INNER JOIN DEPT D
ON E.DEPTNO = D.DEPTNO
WHERE E.JOB = 'MANAGER';

---------------
--크로스 조인 CROSSS JOIN
SELECT E.*, D.*
FROM EMP E CROSS JOIN DEPT D;
--더미데이터 만들어 과부하 테스트 할때 사용
---------------

--안시 표준 조인으로 다중 테이블 조인하기--
SELECT *
FROM EMP E INNER JOIN DEPT D 
ON E.DEPTNO = D.DEPTNO
JOIN EMP M
ON E.MGR = M.EMPNO
WHERE E.ENAME = 'SMITH';
--이건 일반
SELECT *
FROM EMP E, DEPT D, EMP M 
WHERE E.DEPTNO = D.DEPTNO
AND E.MGR = M.EMPNO
AND E.ENAME = 'SMITH';


--1
--ACCOUNTING 부서 소속 사원의 이름과 입사일을 출력
--ENAME, HIREDATE
--   1981/06/09 00시00분00초
--   1982/01/23 00시00분00초 같은 형식으로
SELECT *
FROM EMP;
SELECT *
FROM DEPT;

SELECT E.ENAME, TO_CHAR(E.HIREDATE,'YYYY/MM/DD HH24"시"MI"분"SS"초"') HIREDATE
FROM EMP E JOIN DEPT D
ON E.DEPTNO = D.DEPTNO
WHERE D.DNAME = 'ACCOUNTING';

--2
--BLAKE의 부하직원들을 조회하되
--경력이 높은 순으로 조회하시오
--상사이름     부하직원번호   부하이름   HIREDATE    부서번호   부서명
SELECT *
FROM EMP;
SELECT *
FROM DEPT;

--일반
SELECT E.ENAME 상사이름, UND.EMPNO 부하직원번호, UND.ENAME 부하이름, UND.HIREDATE, D.DEPTNO 부서번호, D.DNAME 부서명
FROM EMP E, DEPT D, EMP UND
WHERE E.DEPTNO = D.DEPTNO
AND E.EMPNO = UND.MGR
AND E.ENAME = 'BLAKE'
ORDER BY HIREDATE ;

--표준
SELECT E.ENAME 상사이름, UND.EMPNO 부하직원번호, UND.ENAME 부하이름, UND.HIREDATE, D.DEPTNO 부서번호, D.DNAME 부서명
FROM EMP E JOIN DEPT D
ON E.DEPTNO = D.DEPTNO
JOIN EMP UND
ON E.EMPNO = UND.MGR
WHERE E.ENAME = 'BLAKE'
ORDER BY HIREDATE ;


--3
--팀 테이블과 구장 테이블을 활용하여 전용구장의 정보를 
--팀의 정보와 함께 출력하시오
--많은 사람이 모일 수 있는 경기장 순으로 정렬
--REGION_NAME   팀명      경기장ID  경기장명         좌석수
--전북      현대모터스   D03   전주월드컵경기장   28,000

SELECT *
FROM TEAM;
SELECT *
FROM STADIUM;

--일반
SELECT T.REGION_NAME, T.TEAM_NAME 팀명, S.STADIUM_ID 경기장ID, S.STADIUM_NAME 경기장명, S.SEAT_COUNT 좌석수
FROM STADIUM S, TEAM T
WHERE S.STADIUM_ID = T.STADIUM_ID
ORDER BY S.SEAT_COUNT DESC;

--표준
SELECT T.REGION_NAME, T.TEAM_NAME 팀명, S.STADIUM_ID 경기장ID, S.STADIUM_NAME 경기장명, S.SEAT_COUNT 좌석수
FROM STADIUM S JOIN TEAM T
ON S.STADIUM_ID = T.STADIUM_ID
ORDER BY S.SEAT_COUNT DESC;

--4
--선수들 별로 홈그라운드 경기장이 어디인지 조회하시오
--선수번호     선수명   포지션   연고지     팀명   구장명   

SELECT *
FROM PLAYER;

SELECT *
FROM TEAM;

SELECT *
FROM STADIUM;

--일반
SELECT PLAYER_ID 선수번호, PLAYER_NAME 선수명, POSITION 포지션, REGION_NAME 연고지, TEAM_NAME 팀명, STADIUM_NAME 구장명
FROM STADIUM S,TEAM T, PLAYER P
WHERE S.STADIUM_ID = T.STADIUM_ID
AND T.TEAM_ID = P.TEAM_ID;
--표준
SELECT PLAYER_ID 선수번호, PLAYER_NAME 선수명, POSITION 포지션, REGION_NAME 연고지, TEAM_NAME 팀명, STADIUM_NAME 구장명
FROM STADIUM S JOIN TEAM T
ON S.STADIUM_ID = T.STADIUM_ID
JOIN PLAYER P
ON T.TEAM_ID = P.TEAM_ID;


--5
--사원의 부서명을 조회하되 RESEARCH부서를 R&D로 출력하고
--조회되지 않는 모든 부서명이 출력되도록 하시오
--사원번호를 내림차순으로 정렬
--사원번호   사원명   DEPTNO   DNAME      LOC
--                 10   ACCOUNTING   
--                 20   R&D      
--                 30   MARKETING
--이런 느낌으로 12명 정보와 40번 부서 정보 출력

SELECT EMPNO 사원번호, ENAME 사원명, D.DEPTNO, DNAME, LOC
FROM EMP E RIGHT OUTER JOIN DEPT D
ON E.DEPTNO = D.DEPTNO
ORDER BY EMPNO DESC;



--6
--사원의 새로운 부서발령 장소를 작성하시오
--아래의 결과를 보고 동일하게 구현하시오
--EMPNO   DEPTNO      DNAME         LOC
--7782      10      ACCOUNTING   ACCOUNTING
--7934      10      ACCOUNTING   ACCOUNTING
--7902      20      RESEARCH   R&D
--7369      20      RESEARCH   R&D
--7566      20      RESEARCH   R&D
--7900      30      SALES      MARKTING
--7844      30      SALES      MARKTING
--7654      30      SALES      MARKTING
--7499      30      SALES      MARKTING
--7698      30      SALES      MARKTING

SELECT EMPNO, D.DEPTNO, DNAME, LOC
FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO
ORDER BY D.DNAME;


--7
--각 팀의 이름과 경기장명을 출력하되 팀ID가 빠른 순으로 정렬하시오
--TEAM_ID      팀명      경기장명   

--일반
SELECT TEAM_ID, TEAM_NAME 팀명, STADIUM_NAME 경기장명
FROM TEAM T, STADIUM S
WHERE T.STADIUM_ID = S.STADIUM_ID
ORDER BY T.TEAM_ID ;
--표준
SELECT TEAM_ID, TEAM_NAME 팀명, STADIUM_NAME 경기장명
FROM TEAM T JOIN STADIUM S
ON T.STADIUM_ID = S.STADIUM_ID
ORDER BY T.TEAM_ID ;


--8
--포지션이 없는 선수별 연고지명, 팀명, 구장명을 출력한다
--선수이름이 사전순으로 빠른 순으로 정렬한다.
--선수명      포지션      연고지명      팀명      구장명
SELECT *
FROM PLAYER;
SELECT *
FROM TEAM;
SELECT *
FROM STADIUM;

--일반
SELECT PLAYER_NAME 선수명, POSITION 포지션, REGION_NAME 연고지명, TEAM_NAME 팀명, STADIUM_NAME 구장명
FROM PLAYER P, TEAM T, STADIUM S
WHERE P.TEAM_ID = T.TEAM_ID
AND T.STADIUM_ID = S.STADIUM_ID
AND P.POSITION IS NULL
ORDER BY P.PLAYER_NAME;

--표준
SELECT PLAYER_NAME 선수명, POSITION 포지션, REGION_NAME 연고지명, TEAM_NAME 팀명, STADIUM_NAME 구장명
FROM PLAYER P JOIN TEAM T 
ON P.TEAM_ID = T.TEAM_ID
JOIN STADIUM S
ON T.STADIUM_ID = S.STADIUM_ID
AND P.POSITION IS NULL
ORDER BY P.PLAYER_NAME;


--9
--홈팀이 없는 경기장의 정보만 출력하시오
--NULL로 나오는 값은 전부 공백으로 표기하시오
--경기장명      경기장ID      좌석수   홈팀ID   팀명

SELECT *
FROM TEAM;

SELECT *
FROM STADIUM;

SELECT STADIUM_NAME 경기장명, S.STADIUM_ID 경기장ID, SEAT_COUNT 좌석수, HOMETEAM_ID 홈팀ID, TEAM_NAME 팀명
FROM STADIUM S, TEAM T;

--10
--홈팀이 3점 이하 차이로 패배한 경기의 경기장 이름, 일정, 홈팀 원정팀 명 정보를 출력하시오
--경기날짜는 2012-07-14와 같은 형태로 출력하시오
-- 
--경기장명   경기장ID      경기날짜   홈팀명   상대팀명      홈팀_SCORE   상대팀_SCORE

SELECT STADIUM_NAME 경기장명, STADIUM_ID 경기장ID









