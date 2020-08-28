CREATE OR REPLACE procedure ST2017112142.InsertEnroll2(sStudentId IN VARCHAR2,sCourseId IN VARCHAR2, nCourseIdNo IN NUMBER, result OUT VARCHAR2)

IS

too_many_sumCourseUnit EXCEPTION;

/* 이번 학기 수강신청에서 이미 선택한 경우 */
too_many_courses EXCEPTION; 

/* 지난학기에 수강했고, 점수가 70점 이상인 경우 */
already_enrolled EXCEPTION;

too_many_students EXCEPTION;

duplicate_time EXCEPTION;

nYear NUMBER;

nSemester NUMBER;

nSumCourseUnit NUMBER;

nCourseUnit NUMBER;

nCnt NUMBER;

nTeachMax NUMBER;

/* 중복되는 시간 찾기 위한 커서 */

CURSOR enroll_list IS

select count(*)

into nCnt

from (select t_time

from teach

where t_year=nYear and t_semester=nSemester and

c_id=sCourseId and c_id_no=nCourseIdNo

INTERSECT

select t.t_time

from teach t, enroll e

where e.s_id=sStudentId and e.e_year=nYear

and e.e_semester=nSemester and t.t_year=nYear

and t.t_semester=nSemester and e.c_id=t.c_id

and e.c_id_no=t.c_id_no);

BEGIN

result:=' ';

DBMS_OUTPUT.put_line('#');

DBMS_OUTPUT.put_line(sStudentId||'님이 과목번호' || sCourseId|| ', 분반'|| TO_CHAR(nCourseIdNo)||'의 수강등록을 요청하였습니다.');

nYear:=Date2EnrollYear(SYSDATE);

nSemester:=Date2EnrollSemester(SYSDATE);

 

SELECT SUM(c.c_unit)

into nSumCourseUnit

from course c, enroll e

where e.s_id=sStudentId and e.e_year=nYear and e.e_semester=nSemester and

e.c_id=c.c_id and e.c_id_no=c.c_id_no;

 

select c_unit

into nCourseUnit

from course

where c_id=sCourseId and c_id_no=nCourseIdNo;

 

if(nSumCourseUnit+nCourseUnit>18) then

raise too_many_sumCourseUnit;

end if;

 
/* 이번 학기 수강신청에서 이미 선택한 경우 */
select count(*)
into nCnt
from enroll
where s_id=sStudentId and c_id=sCourseId and e_year=nYear and e_Semester=nSemester;

if(nCnt>0) then
raise too_many_courses;
end if;

/* 지난학기에 수강했고, 점수가 70점 이상인 경우 */
select count(*)
into nCnt
from enroll
where c_id=sCourseId and s_id=sStudentId and e_score>=70;
if(nCnt>0) then
raise already_enrolled;
end if;

/* 수강정원이 초과한 경우 */
select t_max
into nTeachMax
from teach
where t_year=nYear and t_semester=nSemester and c_id=sCourseId
and c_id_no=nCourseIdNo;

select count(*)
into nCnt
from enroll
where e_year=nYear and e_semester=nSemester
and c_id=sCourseId and c_id_no=nCourseIdNo;

if(nCnt>=nTeachMax) then
raise too_many_students;
end if;

OPEN enroll_list;
FETCH enroll_list into nCnt;
CLOSE enroll_list;

if(nCnt>0) then
raise duplicate_time;
end if;

 
insert into enroll(S_ID,C_ID,C_ID_NO,E_YEAR,E_SEMESTER)
values(sStudentId, sCourseId, nCourseIdNo, nYear, nSemester);
commit;
result:='수강신청 등록이 완료되었습니다.';

EXCEPTION
when too_many_sumCourseUnit then
result:='최대학점을 초과하였습니다';

when too_many_courses then
result:='이미 등록된 과목을 신청하였습니다.';

when already_enrolled then
result:='재수강이 불가능합니다.';

when too_many_students then
result:='수강신청 인원이 초과되어 등록이 불가능 합니다';

when duplicate_time then
result:='이미 등록된 과목 중 중복되는 시간이 존재합니다';

when others then
rollback;

result:=SQLCODE;

END;
/