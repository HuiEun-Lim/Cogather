
/* Drop Tables */

DROP TABLE authority CASCADE CONSTRAINTS;
DROP TABLE comments CASCADE CONSTRAINTS;
DROP TABLE content CASCADE CONSTRAINTS;
DROP TABLE memberstudy CASCADE CONSTRAINTS;
DROP TABLE reservation CASCADE CONSTRAINTS;
DROP TABLE members CASCADE CONSTRAINTS;
DROP TABLE seats CASCADE CONSTRAINTS;
DROP TABLE studygroup CASCADE CONSTRAINTS;




/* Create Tables */

CREATE TABLE authority
(
	auth varchar2(20) NOT NULL,
	ID varchar2(20) NOT NULL,
	PRIMARY KEY (auth, ID)
);


CREATE TABLE comments
(
	cm_uid number NOT NULL,
	ID varchar2(20) NOT NULL,
	ct_uid number NOT NULL,
	reply clob NOT NULL,
	regdate date DEFAULT SYSDATE,
	PRIMARY KEY (cm_uid)
);


CREATE TABLE content
(
	ct_uid number NOT NULL,
	ID varchar2(20) NOT NULL,
	sg_id number NOT NULL,
	ct_title varchar2(40) NOT NULL,
	ct_content clob,
	regdate date DEFAULT SYSDATE,
	PRIMARY KEY (ct_uid)
);


CREATE TABLE members
(
	ID varchar2(20) NOT NULL ON DELETE SET NULL,
	name varchar2(20) NOT NULL,
	pw varchar2(40) NOT NULL,
	phone varchar2(15) NOT NULL,
	email varchar2(40),
	pimg_url varchar2(30),
	tag varchar2(50),
	PRIMARY KEY (ID)
);


CREATE TABLE memberstudy
(
	ID varchar2(20) NOT NULL,
	sg_id number NOT NULL,
	acctime date DEFAULT SYSDATE,
	curtime date DEFAULT SYSDATE,
	g_auth varchar2(20) NOT NULL,
	att_date date DEFAULT SYSDATE,
	PRIMARY KEY (ID, sg_id)
);


CREATE TABLE reservation
(
	res_id number NOT NULL,
	ID varchar2(20) NOT NULL,
	seat_id varchar2(20) NOT NULL,
	start_date date NOT NULL,
	end_date date NOT NULL,
	payment varchar2(30),
	PRIMARY KEY (res_id)
);


CREATE TABLE seats
(
	seat_id varchar2(20) NOT NULL,
	seat_price number DEFAULT 0,
	PRIMARY KEY (seat_id)
);


CREATE TABLE studygroup
(
	sg_id number NOT NULL ON DELETE SET NULL,
	sg_name varchar2(50) NOT NULL,
	sg_info clob,
	sg_max number,
	sg_regdate date DEFAULT SYSDATE,
	sg_tag varchar2(50),
	kko_url varchar2(40),
	PRIMARY KEY (sg_id)
);



/* Create Foreign Keys */

ALTER TABLE comments
	ADD FOREIGN KEY (ct_uid)
	REFERENCES content (ct_uid)
;


ALTER TABLE authority
	ADD FOREIGN KEY (ID)
	REFERENCES members (ID)
;


ALTER TABLE comments
	ADD FOREIGN KEY (ID)
	REFERENCES members (ID)
;


ALTER TABLE content
	ADD FOREIGN KEY (ID)
	REFERENCES members (ID)
;


ALTER TABLE memberstudy
	ADD FOREIGN KEY (ID)
	REFERENCES members (ID)
;


ALTER TABLE reservation
	ADD FOREIGN KEY (ID)
	REFERENCES members (ID)
;


ALTER TABLE reservation
	ADD FOREIGN KEY (seat_id)
	REFERENCES seats (seat_id)
;


ALTER TABLE content
	ADD FOREIGN KEY (sg_id)
	REFERENCES studygroup (sg_id)
;


ALTER TABLE memberstudy
	ADD FOREIGN KEY (sg_id)
	REFERENCES studygroup (sg_id)
;



