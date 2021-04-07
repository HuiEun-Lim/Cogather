
/* Drop Tables */

DROP TABLE authority CASCADE CONSTRAINTS;
DROP TABLE comments CASCADE CONSTRAINTS;
DROP TABLE content CASCADE CONSTRAINTS;
DROP TABLE memberstudy CASCADE CONSTRAINTS;
DROP TABLE reservation CASCADE CONSTRAINTS;
DROP TABLE members CASCADE CONSTRAINTS;
DROP TABLE seats CASCADE CONSTRAINTS;
DROP TABLE studygroup CASCADE CONSTRAINTS;

DROP SEQUENCE authority_seq;


CREATE SEQUENCE comments_seq;
CREATE SEQUENCE content_seq;
CREATE SEQUENCE reservation_seq;
CREATE SEQUENCE studygroup_seq;


/* Create Tables */
/*권한*/
CREATE TABLE authority
(
	auth varchar2(20) NOT NULL, /*권한명*/
	ID varchar2(20) NOT NULL,/*회원ID*/
	PRIMARY KEY (auth, ID)
);

/*댓글*/
CREATE TABLE comments
(
	cm_uid number NOT NULL,/*댓글고유번호*/
	ID varchar2(20) NOT NULL,/*회원ID*/
	ct_uid number NOT NULL,/*게시글 고유번호*/
	reply clob NOT NULL,/*댓글 내용*/
	regdate date DEFAULT SYSDATE,/*등록날짜*/
	PRIMARY KEY (cm_uid)
);

/*스터디 그룹 게시글*/
CREATE TABLE content
(
	ct_uid number NOT NULL, /*게시글 고유번호*/
	ID varchar2(20) NOT NULL,/*게시글 제목*/
	sg_id number NOT NULL,/*회원ID*/
	ct_title varchar2(40) NOT NULL,/*게시글 제목*/
	ct_content clob,/*게시글 내용*/
	regdate date DEFAULT SYSDATE,/*둥록날짜*/
	PRIMARY KEY (ct_uid)
);

SELECT * FROM CONTENT;
/*회원*/
CREATE TABLE members
(
	ID varchar2(20) NOT NULL,/*회원id*/
	name varchar2(20) NOT NULL,/*이름*/
	pw varchar2(40) NOT NULL,/*비밀번호*/
	phone varchar2(15) NOT NULL,/*전화번호*/
	email varchar2(40),/*이메일*/
	pimg_url varchar2(30),/*프로필 이미지*/
	tag varchar2(50),/*관심주제*/
	PRIMARY KEY (ID)
); 
/* */

SELECT * FROM members;

/*개인 스터디 관리*/
CREATE TABLE memberstudy
(
	ID varchar2(20) NOT NULL,/*회원id*/
	sg_id number NOT NULL,/*스터디그룹 고유번호*/
	acctime date DEFAULT SYSDATE,/*오늘 공부시간*/
	curtime date DEFAULT SYSDATE,/*누적공부시간*/
	g_auth varchar2(20) NOT NULL,/*게시글 고유번호*/
	att_date date DEFAULT SYSDATE,/*참여날짜*/
	PRIMARY KEY (ID, sg_id)
);

SELECT * FROM memberstudy;
/*예약*/
CREATE TABLE reservation
(
	res_id number NOT NULL,/*예약번호*/
	ID varchar2(20) NOT NULL,/*회원id*/
	seat_id varchar2(20) NOT NULL,/*시설번호*/
	start_date date NOT NULL,/*예약시작날짜*/
	end_date date NOT NULL,/*예약종료날짜*/
	payment varchar2(30),/*결제방법*/
	PRIMARY KEY (res_id)
);
SELECT * FROM (
SELECT ROWNUM AS RNUM, T.* FROM
(SELECT * FROM studygroup ORDER BY sg_id DESC)T) 
WHERE RNUM >=1 AND RNUM < 3;



SELECT * FROM reservation;

/*좌석*/
CREATE TABLE seats
(
	seat_id varchar2(20) NOT NULL,/*시설명*/
	seat_price number DEFAULT 0,/*시설가격*/
	PRIMARY KEY (seat_id)
);

SELECT * FROM  seats;

/*스터디 그룹*/
CREATE TABLE studygroup
(
	sg_id number NOT NULL,/*스터디그룹고유번호*/
	sg_name varchar2(20) NOT NULL,/*스터디그룹이름*/
	sg_info clob,/*스터디그룹정보*/
	sg_max number,/*스터디그룹제한인원수*/
	sg_regdate date DEFAULT SYSDATE,/*스터디그룹생성날짜*/
	sg_tag varchar2(20),/*스터디주제*/
	kko_url varchar2(100),/*카톡방 주소*/
	file_name varchar2(100),/*썸네일*/
	PRIMARY KEY (sg_id)
);



SELECT file_name  FROM studygroup;
SELECT * FROM STUDYGROUP ORDER BY sg_id;
 /*스터디 그룹 이미지 파일*/ 
CREATE TABLE studygroup_file
(
	sgf_id NUMBER NOT NULL,   /*파일 번호*/
	sgf_org_file_name varchar2(100) NOT NULL, /*원본 파일 이름*/
	sgf_stored_file_name varchar2(100) NOT NULL, /*변경된 파일 이름*/
	sg_id NUMBER NOT NULL,/*스터디그룹고유번호*/
	sgf_file_size NUMBER,  /*파일 크기*/
	PRIMARY KEY (sgf_id)  
);
/*not null 없앴다.*/
ALTER TABLE STUDYGROUP_FILE MODIFY sgf_id NULL;
ALTER TABLE STUDYGROUP_FILE MODIFY sgf_org_file_name NULL;
ALTER TABLE STUDYGROUP_FILE MODIFY sgf_stored_file_name NULL;
ALTER TABLE STUDYGROUP_FILE MODIFY sg_id NULL;
CREATE SEQUENCE studygroup_file_seq;

INSERT INTO studygroup_file VALUES
(studygroup_file_seq.nextval, 'aaa', 'aaa',160,1000);


SELECT * FROM studygroup_file;
SELECT * FROM studygroup_file;

DROP TABLE studygroup_file CASCADE CONSTRAINTS;

ALTER TABLE studygroup_file
	ADD FOREIGN KEY (sg_id)
	REFERENCES studygroup (sg_id)
	ON DELETE CASCADE
;

CREATE SEQUENCE studygroup_file_seq;
SELECT * FROM studygroup;

INSERT INTO studygroup VALUES
(studygroup_seq.nextval, 'aaa', '안녕하세요', 2, sysdate, 'aaa','https://open.kakao.com/o/szYZxz5c','group571b230b-10a6-4ebb-bfa5-7a2600eaf771.png');

INSERT INTO studygroup VALUES
(studygroup_seq.nextval, 'bbb', '안녕하세요', 4, sysdate, 'aaa','https://open.kakao.com/o/szYZxz5c');

INSERT INTO studygroup VALUES
(studygroup_seq.nextval, '수학', '안녕하세요', 4, sysdate, 'aaa','https://open.kakao.com/o/szYZxz5c');

INSERT INTO studygroup VALUES
(studygroup_seq.nextval, '수학', '안녕하세요', 4, sysdate, '수학','https://open.kakao.com/o/szYZxz5c');


INSERT INTO studygroup VALUES
(studygroup_seq.nextval, '임시데이터', '안녕하세요', 4, sysdate, '임시데이터','https://open.kakao.com/o/szYZxz5c');

SELECT COUNT(*) FROM studygroup;
SELECT sg_id,sg_name FROM studygroup ORDER by sg_id DESC;

SELECT * FROM studygroup WHERE ROWNUM<=2 ORDER by sg_id DESC; /*상위 데이터 3개 조회*/

SELECT * FROM studygroup;

SELECT * FROM (
	SELECT ROWNUM AS RNUM, T.* FROM (SELECT * FROM studygroup ORDER BY sg_id DESC)T) 
	WHERE RNUM >=1 AND RNUM < 3;
/*studygroupfile은 관계 없앴다.*/
/* Create Foreign Keys */

ALTER TABLE comments
	ADD FOREIGN KEY (ct_uid)
	REFERENCES content (ct_uid)
;


ALTER TABLE authority
	ADD FOREIGN KEY (ID)
	REFERENCES members (ID) ON DELETE SET NULL
;


ALTER TABLE comments
	ADD FOREIGN KEY (ID)
	REFERENCES members (ID) ON DELETE SET NULL
;


ALTER TABLE content
	ADD FOREIGN KEY (ID)
	REFERENCES members (ID) ON DELETE SET NULL
;


ALTER TABLE memberstudy
	ADD FOREIGN KEY (ID)
	REFERENCES members (ID) ON DELETE SET NULL
;


ALTER TABLE reservation
	ADD FOREIGN KEY (ID)
	REFERENCES members (ID) ON DELETE SET NULL
;


ALTER TABLE reservation
	ADD FOREIGN KEY (seat_id)
	REFERENCES seats (seat_id)
;


ALTER TABLE content
	ADD FOREIGN KEY (sg_id)
	REFERENCES studygroup (sg_id) ON DELETE SET NULL
;


ALTER TABLE memberstudy
	ADD FOREIGN KEY (sg_id)
	REFERENCES studygroup (sg_id) ON DELETE SET NULL
;



