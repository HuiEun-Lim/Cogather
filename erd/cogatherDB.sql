
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
DROP SEQUENCE comments_seq;
DROP SEQUENCE content_seq;
DROP SEQUENCE reservation_seq;
DROP SEQUENCE studygroup_seq;

CREATE SEQUENCE comments_seq;
CREATE SEQUENCE content_seq;
CREATE SEQUENCE reservation_seq;
CREATE SEQUENCE studygroup_seq;


/* Create Tables */
/*권한*/
CREATE TABLE authority
(
	auth varchar2(20) DEFAULT 'ROLE_USER' NOT NULL, /*권한명*/
	ID varchar2(20) NOT NULL,/*회원ID*/
	PRIMARY KEY (auth, ID),
	CONSTRAINT ROLECK CHECK(auth IN ('ROLE_USER' , 'ROLE_ADMIN')) 
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

INSERT INTO members
(ID, name, pw, phone, email) 
VALUES 
('t1', 'test', '123', '01012341234', 'a@gmail.com');

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

SELECT * FROM reservation;


/*좌석*/
CREATE TABLE seats
(
	seat_id varchar2(20) NOT NULL,/*시설명*/
	seat_price number DEFAULT 0,/*시설가격*/
	PRIMARY KEY (seat_id)
);

INSERT INTO seats
(seat_id, SEAT_PRICE) 
VALUES 
('room08',4000);


SELECT * FROM seats;

/*스터디 그룹*/
CREATE TABLE studygroup
(
	sg_id number NOT NULL,/*스터디그룹고유번호*/
	sg_name varchar2(50) NOT NULL,/*스터디그룹이름*/
	sg_info clob,/*스터디그룹정보*/
	sg_max number,/*스터디그룹제한인원수*/
	sg_regdate date DEFAULT SYSDATE,/*스터디그룹생성날짜*/
	sg_tag varchar2(50),/*스터디주제*/
	kko_url varchar2(40),/*카톡방 주소*/
	PRIMARY KEY (sg_id)
);
SELECT * FROM studygroup;


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



