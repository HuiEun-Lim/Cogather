
/* Drop Tables */

DROP TABLE authority CASCADE CONSTRAINTS;
DROP TABLE comments CASCADE CONSTRAINTS;
DROP TABLE content CASCADE CONSTRAINTS;
DROP TABLE content_file CASCADE CONSTRAINTS;
DROP TABLE memberstudy CASCADE CONSTRAINTS;
DROP TABLE reservation CASCADE CONSTRAINTS;
DROP TABLE members CASCADE CONSTRAINTS;
DROP TABLE seats CASCADE CONSTRAINTS;
DROP TABLE studygroup CASCADE CONSTRAINTS;
DROP TABLE studygroup_file CASCADE CONSTRAINTS;
-- sequnce 생성
CREATE SEQUENCE comments_seq;
CREATE SEQUENCE content_seq;
CREATE SEQUENCE reservation_seq;
CREATE SEQUENCE studygroup_seq;
CREATE SEQUENCE studygroup_file_seq;
CREATE SEQUENCE content_file_seq;
-- sequnce 드롭
DROP SEQUENCE content_file_seq;
DROP SEQUENCE comments_seq;
DROP SEQUENCE content_seq;
DROP SEQUENCE reservation_seq;
DROP SEQUENCE studygroup_seq;
DROP SEQUENCE studygroup_file_seq;
/* Create Tables */
/*권한*/
CREATE TABLE authority
(
	auth varchar2(20) DEFAULT 'ROLE_USER' NOT NULL, /*권한명*/
	ID varchar2(100) NOT NULL,/*회원ID*/
	PRIMARY KEY (auth, ID),
	CONSTRAINT ROLECK CHECK(auth IN ('ROLE_USER' , 'ROLE_ADMIN')) 
);

--SELECT * FROM AUTHORITY;

/*댓글*/
CREATE TABLE comments /* on delete set null 시 해당 ID가 not null 이면 삭제시 문제 발생됨 */
(
	cm_uid number NOT NULL,/*댓글고유번호*/
	ID varchar2(100),/*회원ID*/
	ct_uid number NOT NULL,/*게시글 고유번호*/
	reply clob ,/*댓글 내용*/
	regdate date DEFAULT SYSDATE,/*등록날짜*/
	PRIMARY KEY (cm_uid)
);

--SELECT a.ct_uid ct_uid,COUNT(C.CT_UID) cnt
--FROM 
--(SELECT *
--	FROM 
--		(SELECT ROWNUM AS RNUM, T.* FROM 
--			(SELECT * FROM CONTENT 
--			WHERE SG_ID = 21
--			ORDER BY ct_uid DESC 
--			) T
--		) 
--	WHERE 
--		RNUM >= 1 AND RNUM < (1 + 10)
--) a LEFT JOIN COMMENTS c ON a.CT_UID = c.CT_UID
--GROUP BY a.CT_UID
--;

--SELECT * 
--FROM COMMENTS
--WHERE ct_uid = 20
--ORDER BY CM_UID DESC
--;
--
--INSERT INTO COMMENTS (CM_UID, ID, CT_UID, REPLY)
--VALUES (comments_seq.nextval, 'id1', '20','노잼쓰' )
--;
--UPDATE COMMENTS 
--SET REPLY = '정말인가요?', REGDATE = SYSDATE
--WHERE CM_UID = 1 AND ID = 'id1';
--
--DELETE FROM COMMENTS
--WHERE CM_UID = 1;

/*스터디 그룹 게시글*/
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
/* 스터디 그룹 게시글 파일 테이블 */
CREATE TABLE content_file
(
	cf_id NUMBER NOT NULL,
	cf_source varchar2(500) NOT NULL,
	cf_file varchar2(500) NOT NULL,
	ct_uid NUMBER NOT NULL,
	PRIMARY KEY (cf_id)
)
;
--SELECT * FROM content_file;
--
--INSERT INTO content(ct_uid,id,sg_id,ct_title,ct_content)
--VALUES (content_seq.nextval, 'id1', 21, '변명중에서도 가장 어리석고 못난 별명은 -시간이 없어서- 이다','변명중에서도 가장 어리석고 못난 별명은 -시간이 없어서- 이다');
--
--INSERT INTO content(ct_uid,id,sg_id,ct_title,ct_content)
--VALUES (content_seq.nextval, 'id2', 21, '모두가 비슷한 생각을 한다는 것은 아무도 생각하고 있지 않다는 말이다.', '모두가 비슷한 생각을 한다는 것은 아무도 생각하고 있지 않다는 말이다.' );
--
--INSERT INTO content(ct_uid,id,sg_id,ct_title,ct_content)
--VALUES (content_seq.nextval, 'id3', 21, '인간이 불행한 이유는 자신이 행복하다는 사실을 모르기 때문이다. 단지 그 뿐이다.', '인간이 불행한 이유는 자신이 행복하다는 사실을 모르기 때문이다. 단지 그 뿐이다.' );
--
--SELECT * FROM CONTENT;
--
--SELECT * 
--FROM (SELECT * 
--FROM content
--WHERE id = 'id1'
--ORDER BY ct_uid DESC)
--WHERE ROWNUM <=1;
--
--SELECT
--		ct_uid ,id,sg_id ,ct_title ,ct_content, ct_viewcnt,regdate
--	FROM 
--		(SELECT ROWNUM AS RNUM, T.* FROM 
--			(SELECT * FROM CONTENT 
--			WHERE SG_ID = 21
--			ORDER BY ct_uid DESC 
--			) T
--		) 
--	WHERE 
--		RNUM >= 1 AND RNUM < (1 + 10);
--	
--SELECT count(*) FROM CONTENT
--		WHERE SG_ID = 21
--
--UPDATE CONTENT
--SET CT_TITLE = '에이시발', CT_CONTENT = '왜 안되는데'
--WHERE CT_UID = 22 AND ID = 'id1' AND SG_ID = 21; 		

--DELETE FROM CONTENT WHERE SG_ID = 4 AND ct_uid= 18;
--SELECT * FROM CONTENT_FILE ;
--DELETE FROM CONTENT_FILE WHERE CF_ID = 2;
/*회원*/
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
--SELECT * FROM members;

--SELECT * 
--FROM MEMBERS
--WHERE ID IN 
--(SELECT ID FROM COMMENTS WHERE CT_UID = 10)
--;
--
--
--UPDATE members SET PIMG_URL = 'img/member/default.jpg'
--WHERE id = 'id1';
--
--UPDATE members SET PIMG_URL = 'img/member/default.jpg'
--WHERE id = 'id2';
--
--INSERT INTO members (ID, NAME, PW, PHONE, EMAIL, PIMG_URL, TAG)
--VALUES 
--('id2', 'name2', 'pw2','010-xxxx-xxxx','oooooooo@naver.com', 'img/member/img1','1,2,4');
--
--INSERT INTO members (ID, NAME, PW, PHONE, EMAIL, PIMG_URL, TAG)
--VALUES 
--('id3', 'name3', 'pw3','010-xxxx-xxxx','oooooooo@naver.com', 'img/member/img1','1,2,4');
--
--SELECT * FROM members;
--SELECT id "id", name name, pw pw, phone phone, email email, pimg_url pimg_url, tag tag
--FROM members;
/*개인 스터디 관리*/
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
--DELETE FROM MEMBERSTUDY WHERE sg_id =389;
--SELECT * FROM MEMBERSTUDY
--
--SELECT * FROM MEMBERSTUDY;
--아이디  스터디 그룹 조회 
--SELECT MEMBERSTUDY.ID, STUDYGROUP.SG_ID,STUDYGROUP.sg_name,STUDYGROUP.sg_info,STUDYGROUP.sg_max,STUDYGROUP.sg_tag,STUDYGROUP.kko_url,STUDYGROUP.sg_regdate,STUDYGROUP.file_name
--FROM MEMBERSTUDY , STUDYGROUP
--WHERE MEMBERSTUDY.sg_id = studygroup.sg_id AND STUDYGROUP.sg_id=392; 
---- 방생성자 방 생성
--INSERT INTO memberstudy (ID, sg_id, g_auth)
--VALUES 
--('qwer', 4, 'captain');
--INSERT INTO memberstudy (ID, sg_id, g_auth)
--VALUES 
--('asd', 21, 'crew');
----
--UPDATE MEMBERSTUDY SET enstatus = 'out' WHERE id ='qwer' AND sg_id = 21;
DELETE FROM MEMBERSTUDY WHERE sg_id =405;
DELETE FROM STUDYGROUP WHERE sg_id =435;

--SELECT * FROM MEMBERSTUDY
--방 접속자 숫자 
--SELECT * FROM MEMBERSTUDY ORDER BY sg_id asc;
--SELECT count(ID)
--	FROM MEMBERSTUDY
--	WHERE SG_ID = 441 and (g_auth = 'captain' OR g_auth = 'crew');
----아이디  스터디 그룹 조회 
--SELECT memberstudy.g_auth, memberstudy.id, studygroup.sg_id,studygroup.sg_name,studygroup.sg_info,studygroup.sg_max,studygroup.sg_tag,studygroup.kko_url,studygroup.sg_regdate,studygroup.file_name
--FROM MEMBERSTUDY,studygroup
--WHERE memberstudy.sg_id = studygroup.sg_id AND studygroup.sg_id = 404 AND memberstudy.G_AUTH='captain'; 
------ 방생성자 방 생성
--INSERT INTO memberstudy (ID, sg_id, g_auth)
--VALUES 
--('qwer', 4, 'captain');
--
----
--SELECT * FROM MEMBERSTUDY;
--UPDATE MEMBERSTUDY  SET g_auth='common' WHERE sg_id=405 AND id='kisunghoon11';

--
---- 참가자 참여 허락
--INSERT INTO memberstudy (ID, sg_id, g_auth)
--VALUES 
--('id2', 21, 'crew');
--INSERT INTO memberstudy (ID, sg_id, g_auth)
--VALUES 
--('id3', 21, 'crew');
--
--INSERT INTO memberstudy (ID, sg_id, g_auth)
--VALUES 
--('id4', 3, 'crew');
--INSERT INTO memberstudy (ID, sg_id, g_auth)
--VALUES 
--('id5', 4, 'crew');
--
--INSERT INTO memberstudy (ID, sg_id, g_auth)
--VALUES 
--('id3', 2,'common');
--
--INSERT INTO memberstudy (ID, sg_id, g_auth)
--VALUES 
--('id3', 333,'common');
--
--SELECT * FROM memberstudy;
--
--SELECT * FROM MEMBERSTUDY m JOIN STUDYGROUP st ON m.SG_ID = st.SG_ID;
--UPDATE MEMBERSTUDY  SET g_auth='captain' WHERE sg_id=333; /*권한 수정*/
--
--SELECT ID id, SG_ID sg_id, ACCTIME acctime, CURTIME curtime, G_AUTH g_auth, ATT_DATE att_date
--FROM MEMBERSTUDY
--WHERE SG_ID = 336
--;
--UPDATE MEMBERSTUDY SET ACCTIME = NULL WHERE ID = 'asd';
--UPDATE MEMBERSTUDY SET ACCTIME = NULL WHERE ID = 'id2';
--UPDATE MEMBERSTUDY SET ACCTIME = NULL WHERE ID = 'id3';
--
--SELECT m.ID ,m.EMAIL, m.NAME, m.PIMG_URL, m.TAG , ms.ENSTATUS
--	FROM MEMBERSTUDY ms JOIN MEMBERS m ON ms.ID = m.ID 
--	WHERE SG_ID = 1 and (g_auth = 'captain' or g_auth = 'crew')
--	;
--
--SELECT ID id, SG_ID sg_id, ACCTIME acctime, CURTIME curtime, G_AUTH g_auth, ATT_DATE att_date
--	FROM MEMBERSTUDY
--	WHERE SG_ID = 336 and g_auth = 'crew' or g_auth='captain';
--
--SELECT m.ID id ,m.EMAIL email, m.NAME name, m.PIMG_URL pimg_url, m.TAG tag 
--	FROM MEMBERSTUDY ms JOIN MEMBERS m ON ms.ID = m.ID 
--	WHERE SG_ID = 336 and (g_auth = 'captain' or g_auth = 'crew');
--	
--SELECT m.ID id ,m.EMAIL email, m.NAME name, m.PIMG_URL pimg_url, m.TAG tag 
--	FROM MEMBERSTUDY ms JOIN MEMBERS m ON ms.ID = m.ID 
--	WHERE SG_ID =336 and (g_auth = 'common');	
--	
--SELECT ACCTIME 
--FROM MEMBERSTUDY
--WHERE SG_ID = 1 AND ID = 'id1' AND (g_auth = 'captain' or g_auth = 'crew')
--;
--
--UPDATE MEMBERSTUDY SET ENSTATUS = 'in', ENTIME = SYSDATE 
--	WHERE SG_ID = 1 AND ID = 'id2' AND (G_AUTH = 'crew' OR G_AUTH = 'captain')
--
--SELECT COUNT(*) FROM studygroup WHERE sg_tag LIKE '%토익';
/*예약*/
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
--SELECT * FROM (
--SELECT ROWNUM AS RNUM, T.* FROM
--(SELECT * FROM studygroup ORDER BY sg_id DESC)T) 
--WHERE RNUM >=1 AND RNUM < 3;
--
--
--
--SELECT * FROM reservation;

/*좌석*/
CREATE TABLE seats
(
	seat_id varchar2(20) NOT NULL,/*시설명*/
	seat_price number DEFAULT 0,/*시설가격*/
	PRIMARY KEY (seat_id)
);

--INSERT INTO seats
--(seat_id, SEAT_PRICE) 
--VALUES ('room08',4000);
--
--
--SELECT * FROM seats;

/*스터디 그룹*/
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


--SELECT * FROM STUDYGROUP ORDER BY sg_id;
 /*스터디 그룹 이미지 파일*/ 
CREATE TABLE studygroup_file
(
	sgf_id NUMBER ,   /*파일 번호*/
	sgf_org_file_name varchar2(100), /*원본 파일 이름*/
	sgf_stored_file_name varchar2(100), /*변경된 파일 이름*/
	sg_id NUMBER ,/*스터디그룹고유번호*/
	sgf_file_size NUMBER,  /*파일 크기*/
	PRIMARY KEY (sgf_id)  
);
--/*not null 없앴다.*/
--ALTER TABLE STUDYGROUP_FILE MODIFY sgf_id NULL;
--ALTER TABLE STUDYGROUP_FILE MODIFY sgf_org_file_name NULL;
--ALTER TABLE STUDYGROUP_FILE MODIFY sgf_stored_file_name NULL;
--ALTER TABLE STUDYGROUP_FILE MODIFY sg_id NULL;


--INSERT INTO studygroup_file VALUES
--(studygroup_file_seq.nextval, 'aaa', 'aaa',160,1000);
--
--
SELECT * FROM studygroup_file;
--SELECT * FROM studygroup_file;

--SELECT * FROM studygroup;
---- study group dummy insert test
--INSERT INTO studygroup VALUES
--(studygroup_seq.nextval, 'aaa', '안녕하세요', 2, sysdate, 'aaa','https://open.kakao.com/o/szYZxz5c','group571b230b-10a6-4ebb-bfa5-7a2600eaf771.png');
--
--INSERT INTO studygroup VALUES
--(studygroup_seq.nextval, 'bbb', '안녕하세요', 4, sysdate, 'aaa','https://open.kakao.com/o/szYZxz5c');
--
--INSERT INTO studygroup VALUES
--(studygroup_seq.nextval, '수학', '안녕하세요', 4, sysdate, 'aaa','https://open.kakao.com/o/szYZxz5c');
--
--INSERT INTO studygroup VALUES
--(studygroup_seq.nextval, '수학', '안녕하세요', 4, sysdate, '수학','https://open.kakao.com/o/szYZxz5c');
--
--INSERT INTO studygroup VALUES
--(studygroup_seq.nextval, '임시데이터', '안녕하세요', 4, sysdate, '임시데이터','https://open.kakao.com/o/szYZxz5c');
--
--SELECT COUNT(*) FROM studygroup;
--SELECT sg_id,sg_name FROM studygroup ORDER by sg_id DESC;
--
--SELECT * FROM studygroup WHERE ROWNUM<=2 ORDER by sg_id DESC; /*상위 데이터 3개 조회*/
--
--SELECT * FROM studygroup;
--
--
--
--SELECT * FROM studygroup;
--SELECT sg_id id, sg_name name, sg_info info, sg_max max, sg_regdate regdate, sg_tag tag, kko_url kko_url
--		FROM studygroup
--		where sg_id = 1;
--
--SELECT * FROM (
--	SELECT ROWNUM AS RNUM, T.* FROM (SELECT * FROM studygroup ORDER BY sg_id DESC)T) 
--	WHERE RNUM >=1 AND RNUM < 3;
/*studygroupfile은 관계 없앴다.*/
/* Create Foreign Keys */

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

--DELETE FROM AUTHORITY;
--DELETE FROM MEMBERS;
--
SELECT m.*, a.auth
FROM MEMBERS m, AUTHORITY a
WHERE m.id = a.id;

SELECT sg.sg_name FROM memberstudy ms, studygroup sg  WHERE ms.sg_id = sg.sg_id AND ms.ID = 'user8';