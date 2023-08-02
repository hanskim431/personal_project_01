------------------------------------------------------------------------------------
--                                  테이블 삭제
------------------------------------------------------------------------------------

-- 계정
DROP TABLE TBL_MEMBER; -- 계정
DROP TABLE TBL_MEMBER_DEL; -- 삭제 계정
DROP TABLE TBL_MEMBER_AUTH; -- 계정 권한
DROP TABLE TBL_MEMBER_IMAGE; -- 계정 이미지

-- 게시글
DROP TABLE TBL_BOARD; -- 게시글
DROP TABLE TBL_BOARD_DEL; -- 삭제 게시글
DROP TABLE TBL_BOARD_LIKE; -- 게시글 좋아요
-- 댓글
DROP TABLE TBL_REPLY; -- 댓글
DROP TABLE TBL_REPLY_LIKE; -- 댓글 좋아요

-- 첨부 파일
DROP TABLE TBL_ATTACH; -- 첨부파일

------------------------------------------------------------------------------------
--                                  테이블 생성
------------------------------------------------------------------------------------

-----------------------------------
--            계정                      
-----------------------------------
CREATE TABLE TBL_MEMBER( -- 계정
    MEMBERID VARCHAR2(100) PRIMARY KEY, -- 아이디
    MEMBERPWD VARCHAR2(200) NOT NULL, -- 비밀번호
    MEMBERNAME VARCHAR2(100) NOT NULL, -- 이름
    EMAIL VARCHAR2(200) NOT NULL, -- 이메일
    REGDATE DATE default SYSDATE, -- 가입일
    ADDRESS VARCHAR2(200) -- 주소
);

CREATE TABLE TBL_MEMBER_DEL( -- 삭제 계정
    MEMBERID VARCHAR2(100) PRIMARY KEY, -- 아이디
    MEMBERNAME VARCHAR2(100) NOT NULL, -- 이름
    EMAIL VARCHAR2(200) NOT NULL, -- 이메일
    REGDATE DATE default SYSDATE, -- 가입일
    DELDATE DATE default SYSDATE, -- 삭제일
    ADDRESS VARCHAR2(200) -- 주소
);

CREATE TABLE TBL_MEMBER_AUTH( -- 계정 권한
    MEMBERID VARCHAR2(100) PRIMARY KEY, -- 아이디
    AUTH NUMBER(10) NOT NULL, -- 권한
    ENABLE NUMBER(10) NOT NULL -- 계정상태
);

CREATE TABLE TBL_MEMBER_IMAGE( -- 첨부파일 테이블
    UUID VARCHAR2(100) PRIMARY KEY, -- 파일 아이디
    BNO NUMBER(10) NOT NULL, -- 글 번호
    UPLOADPATH VARCHAR2(200), -- 파일 경로
    FILETYPE CHAR(1) NOT NULL, -- 파일 형식
    FILENAME VARCHAR2(100) NOT NULL, -- 파일 이름
    REGDATE DATE default SYSDATE, -- 등록일
    STATUS NUMBER -- 상태
);

-----------------------------------
--            게시글                      
-----------------------------------
CREATE TABLE TBL_BOARD( -- 게시글
    BNO NUMBER(10) PRIMARY KEY, -- 글 번호    
    TITLE VARCHAR2(200) NOT NULL, -- 글 제목
    CONTENT VARCHAR2(2000), -- 글 내용
    WRITER VARCHAR2(100) NOT NULL, -- 작성자
    BOARDTYPE VARCHAR2(100) NOT NULL, -- 카테고리
    REGDATE DATE default SYSDATE, -- 작성일
    UPDATEDATE DATE default SYSDATE, -- 수정일
    STATUS VARCHAR2(100) NOT NULL, -- 상태
    REPLYCNT NUMBER, -- 댓글 수
    LIKEHIT NUMBER -- 좋아요 수
);

CREATE TABLE TBL_BOARD_DEL( -- 삭제 게시글
    BNO NUMBER(10) PRIMARY KEY, -- 글 번호
    TITLE VARCHAR2(200) NOT NULL, -- 글 제목 
    CONTENT VARCHAR2(2000), -- 글 내용
    WRITER VARCHAR2(100) NOT NULL, -- 작성자
    BOARDTYPE VARCHAR2(100) NOT NULL, -- 카테고리
    REGDATE DATE NOT NULL, -- 작성일
    UPDATEDATE DATE, -- 수정일
    STATUS VARCHAR2(100) NOT NULL, -- 상태
    REPLYCNT NUMBER, -- 댓글 수
    LIKEHIT NUMBER -- 좋아요 수
);

CREATE TABLE TBL_BOARD_LIKE( -- 게시글 좋아요 테이블
    BNO NUMBER(10) PRIMARY KEY, -- 글 번호
    MEMBERID VARCHAR2(100) -- 아이디
);

-----------------------------------
--            댓글
-----------------------------------
CREATE TABLE TBL_REPLY( -- 댓글 테이블
    RNO NUMBER(10) PRIMARY KEY, -- 댓글 번호
    BNO NUMBER(10) NOT NULL, -- 글 번호
    REPLY VARCHAR2(1000), -- 댓글 내용
    REPLYER VARCHAR2(50) NOT NULL, -- 작성자
    REGDATE DATE default SYSDATE, -- 작성일
    UPDATEDATE DATE default SYSDATE, -- 수정일
    STATUS NUMBER NOT NULL, -- 댓글 상태
    LIKEHIT NUMBER -- 좋아요 수
);

CREATE TABLE TBL_REPLY_LIKE( -- 게시글 좋아요 테이블
    BNO NUMBER(10) PRIMARY KEY, -- 글 번호
    MEMBERID VARCHAR2(100) -- 아이디
);

-----------------------------------
--            첨부파일
-----------------------------------
CREATE TABLE TBL_ATTACH( -- 첨부파일 테이블
    UUID VARCHAR2(100) PRIMARY KEY, -- 파일 아이디
    BNO NUMBER(10) NOT NULL, -- 글 번호
    UPLOADPATH VARCHAR2(200), -- 파일 경로
    FILETYPE CHAR(1) NOT NULL, -- 파일 형식
    FILENAME VARCHAR2(100) NOT NULL, -- 파일 이름
    REGDATE DATE, -- 등록일
    STATUS NUMBER -- 상태
);


------------------------------------------------------------------------------------
--                                  임시 데이터 삽입
------------------------------------------------------------------------------------
INSERT INTO TBL_MEMBER 
    (MEMBERID,MEMBERPWD,MEMBERNAME,EMAIL,REGDATE)
    VALUES ('admin','1111','관리자','admin@test.com',SYSDATE);

INSERT INTO TBL_MEMBER_DEL
    (MEMBERID,MEMBERNAME,EMAIL,REGDATE,DELDATE)
    VALUES ('sampledel','삭제계정','sampledel@test.com',SYSDATE,SYSDATE);

------------------------------------------------------------------------------------
--                                  데이터 확인
------------------------------------------------------------------------------------

-- 계정
SELECT * FROM TBL_MEMBER; -- 계정
SELECT * FROM TBL_MEMBER_DEL; -- 삭제 계정
SELECT * FROM TBL_MEMBER_AUTH; -- 계정 권한
SELECT * FROM TBL_MEMBER_IMAGE; -- 계정 이미지

-- 게시글
SELECT * FROM TBL_BOARD; -- 게시글
SELECT * FROM TBL_BOARD_DEL; -- 삭제 게시글
SELECT * FROM TBL_BOARD_LIKE; -- 게시글 좋아요
-- 댓글
SELECT * FROM TBL_REPLY; -- 댓글
SELECT * FROM TBL_REPLY_LIKE; -- 댓글 좋아요

-- 첨부 파일
SELECT * FROM TBL_ATTACH; -- 첨부파일


    