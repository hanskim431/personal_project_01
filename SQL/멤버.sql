------------------------------------------------------------------------------------
--                                  포트번호 변경
------------------------------------------------------------------------------------
----포트 번호 확인
--SELECT DBMS_XDB.GETHTTPPORT() FROM DUAL;
---- 본 프로젝트는 기본 포트번호 8080으로 진행한다.
--EXEC DBMS_XDB.SETHTTPPORT(8080);
------------------------------------------------------------------------------------
--                                  테이블 삭제
------------------------------------------------------------------------------------
DROP TABLE TBL_MEMBER_AUTH; -- 계정 권한
DROP TABLE TBL_MEMBER_IMAGE; -- 계정 이미지
DROP TABLE TBL_MEMBER_DEL; -- 삭제 계정
DROP TABLE TBL_ATTACH; -- 첨부파일
DROP TABLE PERSISTENT_LOGINS; -- 로그인 정보
DROP TABLE TBL_BOARD_LIKE; -- 게시글 좋아요
DROP TABLE TBL_BOARD_INFO; -- 게시글 정보
DROP TABLE TBL_REPLY_LIKE; -- 댓글 좋아요
DROP TABLE TBL_REPLY; --  댓글
DROP TABLE TBL_BOARD; -- 게시글
DROP TABLE TBL_MEMBER; -- 계정

------------------------------------------------------------------------------------
--                                  테이블 생성
------------------------------------------------------------------------------------

-----------------------------------
--            계정                      
-----------------------------------
CREATE TABLE TBL_MEMBER( -- 계정
    MEMBERID VARCHAR2(100) PRIMARY KEY, -- 아이디
    MEMBERPWD VARCHAR2(200), -- 비밀번호
    MEMBERNAME VARCHAR2(100), -- 이름
    EMAIL VARCHAR2(200) UNIQUE, -- 이메일
    REGDATE DATE default SYSDATE, -- 가입일
    ADDRESS VARCHAR2(200) -- 주소
);

CREATE TABLE TBL_MEMBER_DEL( -- 삭제 계정
    MEMBERID VARCHAR2(100) PRIMARY KEY, -- 아이디
    MEMBERNAME VARCHAR2(100), -- 이름
    EMAIL VARCHAR2(200) UNIQUE, -- 이메일
    REGDATE DATE default SYSDATE, -- 가입일
    DELDATE DATE default SYSDATE, -- 삭제일
    ADDRESS VARCHAR2(200) -- 주소
);

CREATE TABLE TBL_MEMBER_AUTH( -- 계정 권한
    MEMBERID VARCHAR2(100) REFERENCES TBL_MEMBER(MEMBERID), -- 아이디
    AUTH VARCHAR2(100) , -- 권한
    ENABLE VARCHAR2(20) default 'ACTIVE' -- 계정상태
);


CREATE TABLE TBL_MEMBER_IMAGE( -- 멤버 이미지 테이블
    UUID VARCHAR2(100) PRIMARY KEY , -- 파일 아이디
    MEMBERID VARCHAR2(100) REFERENCES TBL_MEMBER(MEMBERID), -- 아이디
    UPLOADPATH VARCHAR2(200), -- 파일 경로
    FILETYPE CHAR(1), -- 파일 형식
    FILENAME VARCHAR2(100), -- 파일 이름
    REGDATE DATE default SYSDATE, -- 등록일
    STATUS NUMBER -- 상태
);

CREATE TABLE PERSISTENT_LOGINS (
    USERNAME VARCHAR2(100) not null, -- 이름
    SERIES VARCHAR2(64) PRIMARY KEY, -- 이름
    TOKEN VARCHAR2(64) not null, -- 이름
    LAST_USED TIMESTAMP not null -- 이름
);

-----------------------------------
--            게시글                      
-----------------------------------
CREATE TABLE TBL_BOARD( -- 게시글
    BNO NUMBER(10), -- 글 번호    
    TITLE VARCHAR2(200), -- 글 제목
    CONTENT VARCHAR2(2000), -- 글 내용
    WRITER VARCHAR2(100) REFERENCES TBL_MEMBER(MEMBERID), -- 작성자
    BOARDTYPE VARCHAR2(100), -- 게시판 형식
    REGDATE DATE default SYSDATE, -- 작성일
    UPDATEDATE DATE default SYSDATE, -- 수정일
    STATUS VARCHAR2(100), -- 상태
    REPLYCNT NUMBER default 0, -- 댓글 수
    LIKEHIT NUMBER default 0-- 좋아요 수
);

ALTER TABLE TBL_BOARD ADD CONSTRAINT PK_BOARD PRIMARY kEY (BNO);

DROP SEQUENCE SEQ_BOARD; -- 게시글 번호 시퀀스
CREATE SEQUENCE SEQ_BOARD; -- 게시글 번호 시퀀스

CREATE TABLE TBL_BOARD_LIKE( -- 게시글 좋아요 테이블
    BNO NUMBER(10) PRIMARY KEY REFERENCES TBL_BOARD(BNO) ON DELETE CASCADE, -- 글 번호
    MEMBERID VARCHAR2(100) REFERENCES TBL_MEMBER(MEMBERID) ON DELETE CASCADE -- 아이디
);

CREATE TABLE TBL_BOARD_INFO( -- 게시글 좋아요 테이블
    BOARDTYPE VARCHAR2(100), -- 게시판 형식
    BOARDNAME VARCHAR2(1000), -- 게시판 이름
    EXPANATION VARCHAR2(2000) -- 게시판 이름
);
-----------------------------------
--            댓글
-----------------------------------
CREATE TABLE TBL_REPLY( -- 댓글 테이블
    RNO NUMBER(10) PRIMARY KEY, -- 댓글 번호
    BNO NUMBER(10) REFERENCES TBL_BOARD(BNO) ON DELETE CASCADE, -- 글 번호
    REPLY VARCHAR2(1000), -- 댓글 내용
    REPLYER VARCHAR2(50) REFERENCES TBL_MEMBER(MEMBERID), -- 작성자
    REGDATE DATE default SYSDATE, -- 작성일
    UPDATEDATE DATE default SYSDATE, -- 수정일
    STATUS VARCHAR2(100), -- 댓글 상태
    LIKEHIT NUMBER default 0 -- 좋아요 수
);

DROP SEQUENCE SEQ_REPLY; -- 게시글 번호 시퀀스
CREATE SEQUENCE SEQ_REPLY; -- 게시글 번호 시퀀스

CREATE TABLE TBL_REPLY_LIKE( -- 게시글 좋아요 테이블
    BNO NUMBER(10) PRIMARY KEY REFERENCES TBL_REPLY(RNO), -- 글 번호
    MEMBERID VARCHAR2(100) REFERENCES TBL_MEMBER(MEMBERID) -- 아이디
);

-----------------------------------
--            첨부파일
-----------------------------------
CREATE TABLE TBL_ATTACH( -- 첨부파일 테이블
    UUID VARCHAR2(200) primary key, -- 파일 아이디
    BNO NUMBER(10) references TBL_BOARD(BNO), -- 글 번호
    UPLOADPATH VARCHAR2(200), -- 파일 경로
    FILETYPE CHAR(1) default 'I', -- 파일 형식
    FILENAME VARCHAR2(100), -- 파일 이름
    REGDATE DATE default sysdate, -- 등록일
    STATUS VARCHAR2(10) default 'VISIBLE' -- 상태
);

------------------------------------------------------------------------------------
--                                  임시 데이터 삽입
------------------------------------------------------------------------------------
-----------------------------------
--            계정 및 계정 권한
-----------------------------------

INSERT INTO TBL_MEMBER 
    (MEMBERID,MEMBERPWD,MEMBERNAME,EMAIL,REGDATE)
    VALUES ('admin1','$2a$10$KQaI.rOOLo2vjNeGoWW03.gi/mHvtrGwHYHbb/BTKZHgCKeHdd0Zy','관리자1','admin1@test.com',SYSDATE); -- 비밀번호 1111
    
INSERT INTO TBL_MEMBER_AUTH VALUES ('admin1','ROLE_ADMIN','ACTIVE');
    
INSERT INTO TBL_MEMBER 
    (MEMBERID,MEMBERPWD,MEMBERNAME,EMAIL,REGDATE)
    VALUES ('admin2','$2a$10$KQaI.rOOLo2vjNeGoWW03.gi/mHvtrGwHYHbb/BTKZHgCKeHdd0Zy','관리자2','admin2@test.com',SYSDATE); -- 비밀번호 1111
    
INSERT INTO TBL_MEMBER_AUTH VALUES ('admin2','ROLE_ADMIN','ACTIVE');

INSERT INTO TBL_MEMBER 
    (MEMBERID,MEMBERPWD,MEMBERNAME,EMAIL,REGDATE)
    VALUES ('member1','$2a$10$KQaI.rOOLo2vjNeGoWW03.gi/mHvtrGwHYHbb/BTKZHgCKeHdd0Zy','사용자1','member1@test.com',SYSDATE); -- 비밀번호 1111

INSERT INTO TBL_MEMBER_AUTH VALUES ('member1','ROLE_MEMBER','ACTIVE');

INSERT INTO TBL_MEMBER 
    (MEMBERID,MEMBERPWD,MEMBERNAME,EMAIL,REGDATE)
    VALUES ('member2','$2a$10$KQaI.rOOLo2vjNeGoWW03.gi/mHvtrGwHYHbb/BTKZHgCKeHdd0Zy','사용자2','member2@test.com',SYSDATE); -- 비밀번호 1111
    
INSERT INTO TBL_MEMBER_AUTH VALUES ('admin2','ROLE_ADMIN','ACTIVE');

INSERT INTO TBL_MEMBER 
    (MEMBERID,MEMBERPWD,MEMBERNAME,EMAIL,REGDATE)
    VALUES ('member3','$2a$10$KQaI.rOOLo2vjNeGoWW03.gi/mHvtrGwHYHbb/BTKZHgCKeHdd0Zy','사용자3','member3@test.com',SYSDATE); -- 비밀번호 1111

INSERT INTO TBL_MEMBER_AUTH VALUES ('member1','ROLE_MEMBER','ACTIVE');

INSERT INTO TBL_MEMBER 
    (MEMBERID,MEMBERPWD,MEMBERNAME,EMAIL,REGDATE)
    VALUES ('member4','$2a$10$KQaI.rOOLo2vjNeGoWW03.gi/mHvtrGwHYHbb/BTKZHgCKeHdd0Zy','사용자4','member4@test.com',SYSDATE); -- 비밀번호 1111

INSERT INTO TBL_MEMBER_AUTH VALUES ('member2','ROLE_MEMBER','ACTIVE');

--INSERT INTO TBL_MEMBER_DEL
--    (MEMBERID,MEMBERNAME,EMAIL,REGDATE,DELDATE)
--    VALUES ('sampledel','삭제계정','sampledel@test.com',SYSDATE,SYSDATE);



-----------------------------------
--            게시판 1
-----------------------------------

--INSERT INTO TBL_BOARD
--    (BNO,TITLE,CONTENT,WRITER,BOARDTYPE,STATUS)
--    VALUES(SEQ_BOARD.NEXTVAL,'게시판1 제목1','게시판 내용1','admin1','board1','VISIBLE');
--    
--INSERT INTO TBL_BOARD
--    (BNO,TITLE,CONTENT,WRITER,BOARDTYPE,STATUS)
--    VALUES(SEQ_BOARD.NEXTVAL,'게시판1 제목2','게시판 내용2','admin1','board1','VISIBLE');
--
--INSERT INTO TBL_BOARD
--    (BNO,TITLE,CONTENT,WRITER,BOARDTYPE,STATUS)
--    VALUES(SEQ_BOARD.NEXTVAL,'게시판1 제목3','게시판 내용3','admin1','board1','HIDDEN');
--
--INSERT INTO TBL_BOARD
--    (BNO,TITLE,CONTENT,WRITER,BOARDTYPE,STATUS)
--    VALUES(SEQ_BOARD.NEXTVAL,'게시판1 제목4','게시판 내용4','admin1','board1','DELETED');
    
-----------------------------------
--            게시판 2
-----------------------------------
--INSERT INTO TBL_BOARD
--    (BNO,TITLE,CONTENT,WRITER,BOARDTYPE,STATUS)
--    VALUES(SEQ_BOARD.NEXTVAL,'게시판2 제목1','게시판 내용1','admin2','board2','VISIBLE');
--    
--INSERT INTO TBL_BOARD
--    (BNO,TITLE,CONTENT,WRITER,BOARDTYPE,STATUS)
--    VALUES(SEQ_BOARD.NEXTVAL,'게시판2 제목2','게시판 내용2','admin2','board2','VISIBLE');
--
--INSERT INTO TBL_BOARD
--    (BNO,TITLE,CONTENT,WRITER,BOARDTYPE,STATUS)
--    VALUES(SEQ_BOARD.NEXTVAL,'게시판2 제목3','게시판 내용3','admin2','board2','HIDDEN');
--
--INSERT INTO TBL_BOARD
--    (BNO,TITLE,CONTENT,WRITER,BOARDTYPE,STATUS)
--    VALUES(SEQ_BOARD.NEXTVAL,'게시판2 제목4','게시판 내용4','admin2','board2','DELETED');
    
-----------------------------------
--            게시판 1 게시글1 댓글
-----------------------------------
--INSERT INTO TBL_REPLY
--    (RNO,BNO,REPLY,REPLYER,STATUS)
--    VALUES(SEQ_REPLY.NEXTVAL,1,'게시글1 댓글1','admin1','VISIBLE');
--    
--INSERT INTO TBL_REPLY
--    (RNO,BNO,REPLY,REPLYER,STATUS)
--    VALUES(SEQ_REPLY.NEXTVAL,1,'게시글1 댓글2','admin1','VISIBLE');  
--    
--INSERT INTO TBL_REPLY
--    (RNO,BNO,REPLY,REPLYER,STATUS)
--    VALUES(SEQ_REPLY.NEXTVAL,1,'게시글1 댓글3','admin1','HIDDEN');  
--    
--INSERT INTO TBL_REPLY
--    (RNO,BNO,REPLY,REPLYER,STATUS)
--    VALUES(SEQ_REPLY.NEXTVAL,1,'게시글1 댓글4','admin1','DELETE');


-----------------------------------
--            게시판 정보
-----------------------------------
INSERT INTO TBL_BOARD_INFO (BOARDTYPE,BOARDNAME,EXPANATION) VALUES ('road','로드 자전거','로드 자전거와 관련된 이야기를 나누는 게시판 입니다.');
INSERT INTO TBL_BOARD_INFO (BOARDTYPE,BOARDNAME,EXPANATION) VALUES ('mtb','산악 자전거','산악 자전거와 관련된 이야기를 나누는 게시판 입니다.');
INSERT INTO TBL_BOARD_INFO (BOARDTYPE,BOARDNAME,EXPANATION) VALUES ('commuter','자전거 출퇴근','자전거 출퇴근와 관련된 이야기를 나누는 게시판 입니다.');
INSERT INTO TBL_BOARD_INFO (BOARDTYPE,BOARDNAME,EXPANATION) VALUES ('touring','자전거 여행','자전거 여행과 관련된 이야기를 나누는 게시판 입니다.');
INSERT INTO TBL_BOARD_INFO (BOARDTYPE,BOARDNAME,EXPANATION) VALUES ('gears','자전거 장비','자전거 장비와 관련된 이야기를 나누는 게시판 입니다.');
INSERT INTO TBL_BOARD_INFO (BOARDTYPE,BOARDNAME,EXPANATION) VALUES ('repair','정비/수리','자전거 정비와 관련된 이야기를 나누는 게시판 입니다.');
INSERT INTO TBL_BOARD_INFO (BOARDTYPE,BOARDNAME,EXPANATION) VALUES ('shop','사고팔기','자전거를 사고, 팔고, 나누는 게시판 입니다.');
INSERT INTO TBL_BOARD_INFO (BOARDTYPE,BOARDNAME,EXPANATION) VALUES ('lost-and-found','분실물센터','자전거 분실•획득, 장비 분실•획득시 서로 알려주는 게시판 입니다.');
    
    
------------------------------------------------------------------------------------
--                                 커밋과 데이터 확인
------------------------------------------------------------------------------------

UPDATE TBL_BOARD B SET REPLYCNT = (SELECT COUNT(RNO) FROM TBL_REPLY R WHERE R.BNO = B.BNO);

COMMIT;

-- 계정
SELECT * FROM TBL_MEMBER; -- 계정
SELECT * FROM TBL_MEMBER_DEL; -- 삭제 계정
SELECT * FROM TBL_MEMBER_AUTH; -- 계정 권한
SELECT * FROM TBL_MEMBER_IMAGE; -- 계정 이미지

SELECT * FROM TBL_MEMBER M LEFT OUTER JOIN TBL_MEMBER_AUTH A ON M.MEMBERID = A.MEMBERID; -- 계정 + 권한

-- 게시글
SELECT * FROM TBL_BOARD; -- 게시글
SELECT * FROM TBL_BOARD_LIKE; -- 게시글 좋아요
SELECT * FROM TBL_BOARD WHERE STATUS = 'VISIBLE';
SELECT * FROM TBL_BOARD WHERE BOARDTYPE = 'board2'; -- 게시글

-- 댓글
SELECT * FROM TBL_REPLY; -- 댓글
SELECT * FROM TBL_REPLY WHERE STATUS = 'VISIBLE'; -- 댓글
SELECT * FROM TBL_REPLY_LIKE; -- 댓글 좋아요

SELECT * FROM TBL_BOARD B LEFT OUTER JOIN TBL_REPLY R ON B.BNO = R.BNO; -- 게시글 + 댓글

-- 첨부 파일
SELECT * FROM TBL_ATTACH; -- 첨부파일

SELECT * FROM TBL_BOARD B LEFT OUTER JOIN TBL_ATTACH A ON B.BNO = A.BNO; -- 게시글 + 첨부파일


SELECT * FROM TBL_BOARD WHERE WRITER = 'admin1' ;

SELECT COUNT(BNO) FROM TBL_BOARD WHERE BNO > 0 ;
