/* --------------성적 조회 관련------------------ */
/* 1. 해당 학생이 수강한 과목들 성적 확인 */
select e.c_id, e.c_id_no, c_name,c_unit, e_year, e_semester, e_score from course c, enroll e 
where e.c_id=c.c_id and e.s_id=session_id and (e_year != nYear and e_semester!=nSemester);



/* --------------교수 상담 관련----------------- */
/* 1. 상담을 신청하기 위해 교수 목록 출력 --> JSP */
select p_name from professor;

/* 2. 학생이 이번 학기에  특정 교수님과의 상담을 신청했는지 확인 --> procedure */
SELECT count(*)
from consult c, professor p
where c.p_id=p.p_id and c.s_id=sStudentId and co_year=nYear and co_semester=nSemester and p_name=pName;

/* 3. 특정 교수님이 이번 학기에 특정 시간대에 강의가 존재하는지 확인 --> procedure */
SELECT count(*)
from PROFESSOR p, TEACH t
where t.p_id=p.p_id and t_year=nYear and t_semester=nSemester and p.p_name=pName and tTime=t_time;

/* 4. 특정 학생이 이번 학기에 특정 시간대에 수업이 존재하는지 확인 --> procedure */
SELECT count(*)
from ENROLL e, TEACH t
where s_id=sStudentId and e_year=nYear and e_semester=nSemester and e_year=t_year and e_semester=t_semester
and e.c_id=t.c_id and e.c_id_no=t.c_id_no and t_time=tTime;

/* 5. 선택한 교수의 교수번호 찾기 --> JSP */
select p_id
from professor
where p_name=pName;

/* 6. 상담 신청 내역 기록 --> procedure */
insert into CONSULT values(pID, sStudentId, nYear, nSemester, tTime);

/* 7. 학생의 상담 신청 내역 출력 --> JSP */
select c.*, p_name from consult c, professor p where p.p_id=c.p_id and s_id='session_id';



/* --------------재수강 관련 -------------------*/
/* 1. 이번학기에 해당 과목을 신청했는지 확인 --> procedure */
select count(*)
from enroll
where s_id=sStudentId and c_id=sCourseId and e_year=nYear and e_Semester=nSemester;

/* 2. 해당 과목을 지난학기에 수강했고, 점수가 70점 이상인지 확인 --> procedure */
select count(*)
from enroll
where c_id=sCourseId and s_id=sStudentId and e_score>=70;