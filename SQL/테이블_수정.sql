/* 실습 테이블 */
/*
학생(student) : 학번, 이름, 주소,학년,학부, 전공, 패스워드
과목(course) : 과목번호, 분반, 과목명, 학점
교수(professor) : 교수번호, 교수이름, 전공, 학과, 패스워드
등록(enroll) : 학번, 과목번호, 분반, 등록시기, 등록학기, 성적
강의(teach) : 교수번호, 과목번호, 분반, 강의시기, 교시, 장소, 수강최대인원
상담(consult) : 교수번호, 학생번호, 상담시기, 상담시간
*/

CREATE TABLE enroll
(
    s_id	     VARCHAR2(10),
    c_id	     VARCHAR2(10),
    c_id_no    NUMBER(1),
    e_year      NUMBER(4),
    e_semester    NUMBER(1),
    e_score    NUMBER(3),
    CONSTRAINT e_pk PRIMARY KEY (s_id, c_id, c_id_no, e_year, e_semester),
    CONSTRAINT e_c_id_fk FOREIGN KEY (c_id, c_id_no) REFERENCES  course (c_id, c_id_no)
);

INSERT INTO enroll VALUES ( '20011234', 'C100', 3, 2020, 1, null);
INSERT INTO enroll VALUES ( '20011234', 'C200', 3, 2020, 1, null);
INSERT INTO enroll VALUES ( '20011234', 'C300', 3, 2020, 1, null);
INSERT INTO enroll VALUES ( '20011234', 'C400', 3, 2020, 1, null);
INSERT INTO enroll VALUES ( '20011234', 'C500', 3, 2020, 1, null);
INSERT INTO enroll VALUES ( '20011234', 'C600', 3, 2019, 2, 76);
INSERT INTO enroll VALUES ( '20011234', 'C700', 3, 2019, 2, 57);
INSERT INTO enroll VALUES ( '20011235', 'C100', 3, 2019, 2, 60);
INSERT INTO enroll VALUES ( '20011235', 'C200', 3, 2020, 1, null);
INSERT INTO enroll VALUES ( '20011235', 'C300', 3, 2019, 2, 78);
INSERT INTO enroll VALUES ( '20011235', 'C400', 3, 2019, 2, 85);
INSERT INTO enroll VALUES ( '20011235', 'C500', 3, 2019, 2, 97);
INSERT INTO enroll VALUES ( '20011235', 'C600', 3, 2019, 2, 65);
INSERT INTO enroll VALUES ( '20011235', 'C700', 3, 2019, 2, 86);
INSERT INTO enroll VALUES ( '20011235', 'C900', 3, 2020, 1, null);
INSERT INTO enroll VALUES ( '20011236', 'C100', 3, 2019, 2, 67);
INSERT INTO enroll VALUES ( '20011236', 'C200', 3, 2020, 1, null);
INSERT INTO enroll VALUES ( '20011236', 'C300', 3, 2019, 2, 95);
INSERT INTO enroll VALUES ( '20011236', 'C400', 3, 2020, 1, null);
INSERT INTO enroll VALUES ( '20011236', 'C500', 3, 2019, 2, 77);
INSERT INTO enroll VALUES ( '20011236', 'C600', 3, 2019, 2, 91);
INSERT INTO enroll VALUES ( '20011236', 'C700', 3, 2019, 2, 68);
INSERT INTO enroll VALUES ( '20011236', 'C900', 3, 2020, 1, null);
INSERT INTO enroll VALUES ( '20011237', 'C100', 3, 2019, 2, 45);
INSERT INTO enroll VALUES ( '20011237', 'C200', 3, 2020, 1, null);
INSERT INTO enroll VALUES ( '20011237', 'C300', 3, 2019, 2, 77);
INSERT INTO enroll VALUES ( '20011237', 'C400', 3, 2020, 1, null);
INSERT INTO enroll VALUES ( '20011237', 'C500', 3, 2019, 2, 88);
INSERT INTO enroll VALUES ( '20011237', 'C600', 3, 2019, 2, 69);
INSERT INTO enroll VALUES ( '20011237', 'C700', 3, 2019, 2, 94);
INSERT INTO enroll VALUES ( '20011237', 'C900', 3, 2020, 1, null);
INSERT INTO enroll VALUES ( '20021245', 'C100', 3, 2019, 2, 75);
INSERT INTO enroll VALUES ( '20021245', 'C200', 3, 2019, 2, 45);
INSERT INTO enroll VALUES ( '20011245', 'C900', 3, 2020, 1, null);
INSERT INTO enroll VALUES ( '20021246', 'C100', 3, 2019, 2, 91);
INSERT INTO enroll VALUES ( '20021246', 'C200', 3, 2019, 2, 78);
INSERT INTO enroll VALUES ( '20011246', 'C900', 3, 2020, 1, null);
INSERT INTO enroll VALUES ( '20021247', 'C100', 3, 2019, 2, 87);
INSERT INTO enroll VALUES ( '20021247', 'C200', 3, 2019, 2, 64);
INSERT INTO enroll VALUES ( '20012454', 'C100', 3, 2019, 2, 67);
INSERT INTO enroll VALUES ( '20012454', 'C200', 3, 2020, 1, null);
INSERT INTO enroll VALUES ( '20012454', 'M100', 3, 2019, 2, 57);
INSERT INTO enroll VALUES ( '20012454', 'M200', 3, 2020, 1, null);
INSERT INTO enroll VALUES ( '20012454', 'M300', 3, 2020, 1, null);
INSERT INTO enroll VALUES ( '20012454', 'M400', 3, 2020, 1, null);
INSERT INTO enroll VALUES ( '20012454', 'M500', 3, 2019, 2, 89);
INSERT INTO enroll VALUES ( '20012456', 'C100', 3, 2019, 2, 96);
INSERT INTO enroll VALUES ( '20012456', 'C200', 3, 2020, 1, null);
INSERT INTO enroll VALUES ( '20012456', 'M100', 3, 2019, 2, 63);
INSERT INTO enroll VALUES ( '20012456', 'M200', 3, 2020, 1, null);
INSERT INTO enroll VALUES ( '20012456', 'M300', 3, 2020, 1, null);
INSERT INTO enroll VALUES ( '20012456', 'M400', 3, 2020, 1, null);
INSERT INTO enroll VALUES ( '20012456', 'M500', 3, 2019, 2, 81);

CREATE TABLE consult
(
    p_id	   VARCHAR2(10),
    s_id	   VARCHAR2(10),
    co_year NUMBER(4),
    co_semester NUMBER(4),
    co_time    NUMBER(1),
    CONSTRAINT co_pk PRIMARY KEY (p_id, s_id, co_year, co_semester),
    CONSTRAINT co_p_id_fk FOREIGN KEY (p_id) REFERENCES  professor(p_id),
    CONSTRAINT co_s_id_fk FOREIGN KEY (s_id) REFERENCES student(s_id)
 );

INSERT INTO consult VALUES ('CS4584', '20011234', 2019, 2, 3) ;
INSERT INTO consult VALUES ('MM4572','20011234',2019,2, 6);
INSERT INTO consult VALUES ('MM4571','20011235',2019,2,7);
INSERT INTO consult VALUES ('CS4582','20011235',2019,2,5);

COMMIT;