show USER;
ALTER SESSION SET TIME_ZONE = 'Asia/Seoul';
ALTER DATABASE SET TIME_ZONE = '+09:00';
CREATE USER cogather IDENTIFIED BY 1234;
GRANT connect, resource, create view, create procedure, select any table to cogather;
CONNECT cogather/1234;
show USER;

CREATE TABLE authority
(
	auth varchar2(20) DEFAULT 'ROLE_USER' NOT NULL, /*권한명*/
	ID varchar2(100) NOT NULL,/*회원ID*/
	PRIMARY KEY (auth, ID),
	CONSTRAINT ROLECK CHECK(auth IN ('ROLE_USER' , 'ROLE_ADMIN')) 
);
CREATE TABLE comments /* on delete set null 시 해당 ID가 not null 이면 삭제시 문제 발생됨 */
(
	cm_uid number NOT NULL,/*댓글고유번호*/
	ID varchar2(100),/*회원ID*/
	ct_uid number NOT NULL,/*게시글 고유번호*/
	reply clob ,/*댓글 내용*/
	regdate date DEFAULT SYSDATE,/*등록날짜*/
	PRIMARY KEY (cm_uid)
);
CREATE TABLE content
(
	ct_uid number NOT NULL, /*게시글 고유번호*/
	ID varchar2(100),/*회원ID*/
	sg_id number NOT NULL, /*스터디방번호*/
	ct_title varchar2(500) DEFAULT ' ',/*게시글 제목*/
	ct_content clob,/*게시글 내용*/
	ct_viewcnt integer DEFAULT 0, /* 조회수 */
	regdate date DEFAULT SYSDATE,/*둥록날짜*/
	PRIMARY KEY (ct_uid)
);
CREATE TABLE content_file
(
	cf_id NUMBER NOT NULL,
	cf_source varchar2(500) NOT NULL,
	cf_file varchar2(500) NOT NULL,
	ct_uid NUMBER NOT NULL,
	PRIMARY KEY (cf_id)
)
;
CREATE TABLE members
(
	ID varchar2(100) NOT NULL,/*회원id*/
	name varchar2(100) NOT NULL,/*이름*/
	pw varchar2(100) NOT NULL,/*비밀번호*/
	phone varchar2(15),/*전화번호*/
	email varchar2(40),/*이메일*/
	pimg_url varchar2(200) DEFAULT 'img/member/default.jpg',/*프로필 이미지*/
	tag varchar2(50),/*관심주제*/
	enabled char(1) DEFAULT 1,
	PRIMARY KEY (ID)
);
CREATE TABLE memberstudy
(
	ID varchar2(100),/*회원id*/
	sg_id number,/*스터디그룹 고유번호*/
	acctime date,/*오늘 공부시간*/
	curtime date,/*누적공부시간*/
	g_auth varchar2(20) DEFAULT 'common',/*스터디 권한*/
	att_date date DEFAULT SYSDATE,/*스터디참여날짜*/
	entime date, /*방 입장 시간*/
	enstatus varchar(10) DEFAULT 'out', /* 방 입장 여부 */
	PRIMARY KEY (ID, sg_id),
	CONSTRAINT GAUTH_CHECK CHECK(g_auth IN ('captain', 'crew', 'common')),
	CONSTRAINT ENSTATUS_CHECK CHECK(enstatus IN ('in', 'out'))
);


CREATE TABLE reservation
(
	res_id number NOT NULL,/*예약번호*/
	ID varchar2(100) NOT NULL,/*회원id*/
	seat_id varchar2(20) NOT NULL,/*시설번호*/
	start_date date NOT NULL,/*예약시작날짜*/
	end_date date NOT NULL,/*예약종료날짜*/
	payment varchar2(30),/*결제방법*/
	PRIMARY KEY (res_id)
);
CREATE TABLE seats
(
	seat_id varchar2(20) NOT NULL,/*시설명*/
	seat_price number DEFAULT 0,/*시설가격*/
	PRIMARY KEY (seat_id)
);

CREATE TABLE studygroup
(
	sg_id number NOT NULL,/*스터디그룹고유번호*/
	sg_name varchar2(300) NOT NULL,/*스터디그룹이름*/
	sg_info clob,/*스터디그룹정보*/
	sg_max number,/*스터디그룹제한인원수*/
	sg_regdate date DEFAULT SYSDATE,/*스터디그룹생성날짜*/
	sg_tag varchar2(60),/*스터디주제*/
	kko_url varchar2(300),/*카톡방 주소*/
	file_name varchar2(300),/*썸네일*/
	PRIMARY KEY (sg_id)
);
CREATE TABLE studygroup_file
(
	sgf_id NUMBER ,   /*파일 번호*/
	sgf_org_file_name varchar2(100), /*원본 파일 이름*/
	sgf_stored_file_name varchar2(100), /*변경된 파일 이름*/
	sg_id NUMBER ,/*스터디그룹고유번호*/
	sgf_file_size NUMBER,  /*파일 크기*/
	PRIMARY KEY (sgf_id)  
);
ALTER TABLE content_file
	ADD FOREIGN KEY (ct_uid)
	REFERENCES content (ct_uid)
	ON DELETE CASCADE -- 참조하는 부모가 삭제되면 같이 삭제되도록
;
ALTER TABLE comments
	ADD FOREIGN KEY (ct_uid)
	REFERENCES content (ct_uid)
	ON DELETE CASCADE
;
ALTER TABLE comments
	ADD FOREIGN KEY (ID)
	REFERENCES members (ID) ON DELETE SET NULL
;
ALTER TABLE authority
	ADD FOREIGN KEY (ID)
	REFERENCES members (ID) ON DELETE SET NULL
;
ALTER TABLE content
	ADD FOREIGN KEY (ID)
	REFERENCES members (ID) ON DELETE SET NULL
;
ALTER TABLE memberstudy
	ADD FOREIGN KEY (ID)
	REFERENCES members (ID) ON DELETE CASCADE;
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
	REFERENCES studygroup (sg_id) ON DELETE Cascade;
;
CREATE SEQUENCE comments_seq;
CREATE SEQUENCE content_seq;
CREATE SEQUENCE reservation_seq;
CREATE SEQUENCE studygroup_seq;
CREATE SEQUENCE studygroup_file_seq;
CREATE SEQUENCE content_file_seq;

INSERT INTO SEATS(seat_id, seat_price) VALUES ('seat1', 1600);
INSERT INTO SEATS(seat_id, seat_price) VALUES ('seat2', 1600);
INSERT INTO SEATS(seat_id, seat_price) VALUES ('seat3', 1600);
INSERT INTO SEATS(seat_id, seat_price) VALUES ('seat4', 1600);
INSERT INTO SEATS(seat_id, seat_price) VALUES ('seat5', 1600);
INSERT INTO SEATS(seat_id, seat_price) VALUES ('seat6', 1600);
INSERT INTO SEATS(seat_id, seat_price) VALUES ('seat7', 1600);
INSERT INTO SEATS(seat_id, seat_price) VALUES ('seat8', 1600);
INSERT INTO SEATS(seat_id, seat_price) VALUES ('seat9', 1600);
INSERT INTO SEATS(seat_id, seat_price) VALUES ('seat10', 1600);

INSERT INTO SEATS(seat_id, seat_price) VALUES ('seat11', 1600);
INSERT INTO SEATS(seat_id, seat_price) VALUES ('seat12', 1600);
INSERT INTO SEATS(seat_id, seat_price) VALUES ('seat13', 1600);
INSERT INTO SEATS(seat_id, seat_price) VALUES ('seat14', 1600);
INSERT INTO SEATS(seat_id, seat_price) VALUES ('seat15', 1600);
INSERT INTO SEATS(seat_id, seat_price) VALUES ('seat16', 1600);
INSERT INTO SEATS(seat_id, seat_price) VALUES ('seat17', 1600);
INSERT INTO SEATS(seat_id, seat_price) VALUES ('seat18', 1600);
INSERT INTO SEATS(seat_id, seat_price) VALUES ('seat19', 1600);
INSERT INTO SEATS(seat_id, seat_price) VALUES ('seat20', 1600);

INSERT INTO SEATS(seat_id, seat_price) VALUES ('seat21', 1600);
INSERT INTO SEATS(seat_id, seat_price) VALUES ('seat22', 1600);
INSERT INTO SEATS(seat_id, seat_price) VALUES ('seat23', 1600);
INSERT INTO SEATS(seat_id, seat_price) VALUES ('seat24', 1600);

INSERT INTO SEATS(seat_id, seat_price) VALUES ('room1', 4000);
INSERT INTO SEATS(seat_id, seat_price) VALUES ('room2', 4000);
INSERT INTO SEATS(seat_id, seat_price) VALUES ('room3', 4000);
INSERT INTO SEATS(seat_id, seat_price) VALUES ('room4', 4000);
INSERT INTO SEATS(seat_id, seat_price) VALUES ('room5', 4000);
INSERT INTO SEATS(seat_id, seat_price) VALUES ('room6', 4000);
INSERT INTO SEATS(seat_id, seat_price) VALUES ('room7', 4000);
INSERT INTO SEATS(seat_id, seat_price) VALUES ('room8', 4000);

INSERT INTO MEMBERS(id, pw, name) VALUES ('user1','pw1','user1');
INSERT INTO authority (id, auth) VALUES ('user1','ROLE_USER');

INSERT INTO MEMBERS(id, pw, name) VALUES ('user2','pw2','user2');
INSERT INTO authority (id, auth) VALUES ('user2','ROLE_USER');

INSERT INTO MEMBERS(id, pw, name) VALUES ('admin1','pw1','admin1');
INSERT INTO authority (id, auth) VALUES ('admin1','ROLE_ADMIN');