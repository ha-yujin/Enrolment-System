CREATE OR REPLACE procedure ST2017112142.InsertConsult(sStudentId IN VARCHAR2, pName IN VARCHAR2, tTime IN NUMBER, result OUT VARCHAR2)
IS
/* 이미 이번 학기에 상담한 교수일 경우 */
too_consult_with EXCEPTION;

/* 교수님이 수업이 있을 경우 */
have_course_prof EXCEPTION;

/* 학생이 수업이 있을 경우 */
have_course_stu EXCEPTION;

nYear NUMBER;
nSemester NUMBER;
nCnt NUMBER;
pID VARCHAR2(10);

BEGIN
result:= ' ';
DBMS_OUTPUT.put_line('#');
DBMS_OUTPUT.put_line(sStudentId||'님이 '||pName||'교수님과 '||tTime||'교시 상담을 요청했습니다.');
nYear:=Date2EnrollYear(SYSDATE);
nSemester:=DATE2EnrollSemester(SYSDATE);

/* 이번학기에 상담한 교수님인가? */
SELECT count(*)
into nCnt
from consult c, professor p
where c.p_id=p.p_id and c.s_id=sStudentId and co_year=nYear and co_semester=nSemester and p_name=pName;

if(nCnt>0) then
raise too_consult_with;
end if;

/* 교수님 수업 시간 구하기 */
SELECT count(*)
into nCnt
from PROFESSOR p, TEACH t
where t.p_id=p.p_id and t_year=nYear and t_semester=nSemester and p.p_name=pName and tTime=t_time;

if(nCnt>0) then
raise have_course_prof;
end if;

/* 이번학기에 학생이 수강신청한 시간표 시간 구하기 */
SELECT count(*)
into nCnt
from ENROLL e, TEACH t
where s_id=sStudentId and e_year=nYear and e_semester=nSemester and e_year=t_year and e_semester=t_semester
and e.c_id=t.c_id and e.c_id_no=t.c_id_no and t_time=tTime;

if(nCnt>0) then
raise have_course_stu;
end if;

select p_id
into pID
from professor
where p_name=pName;

insert into CONSULT values(pID, sStudentId, nYear, nSemester, tTime);
commit;
result:='상담 신청이 완료되었습니다.';

EXCEPTION
when have_course_prof then
result:='교수님이 불가능한 시간대입니다.';
when have_course_stu then
result:='이번학기에 수업이 있는 시간입니다.';
when too_consult_with then
result:='이번학기 상담(신청)을 완료했습니다.';
when others then
rollback;
result:=SQLCODE;
END;
/