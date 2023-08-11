------------------------------------------------------------------------------------
--                                  ��Ʈ��ȣ ����
------------------------------------------------------------------------------------
----��Ʈ ��ȣ Ȯ��
--SELECT DBMS_XDB.GETHTTPPORT() FROM DUAL;
---- �� ������Ʈ�� �⺻ ��Ʈ��ȣ 8080���� �����Ѵ�.
--EXEC DBMS_XDB.SETHTTPPORT(8080);
------------------------------------------------------------------------------------
--                                  ���̺� ����
------------------------------------------------------------------------------------
DROP TABLE TBL_MEMBER_AUTH; -- ���� ����
DROP TABLE TBL_MEMBER_IMAGE; -- ���� �̹���
DROP TABLE TBL_MEMBER_DEL; -- ���� ����
DROP TABLE TBL_ATTACH; -- ÷������
DROP TABLE TBL_BOARD_LIKE; -- �Խñ� ���ƿ�
DROP TABLE TBL_REPLY_LIKE; -- ��� ���ƿ�
DROP TABLE TBL_REPLY; --  ���
DROP TABLE TBL_BOARD; -- �Խñ�
DROP TABLE TBL_MEMBER; -- ����

------------------------------------------------------------------------------------
--                                  ���̺� ����
------------------------------------------------------------------------------------

-----------------------------------
--            ����                      
-----------------------------------
CREATE TABLE TBL_MEMBER( -- ����
    MEMBERID VARCHAR2(100) PRIMARY KEY, -- ���̵�
    MEMBERPWD VARCHAR2(200), -- ��й�ȣ
    MEMBERNAME VARCHAR2(100), -- �̸�
    EMAIL VARCHAR2(200) UNIQUE, -- �̸���
    REGDATE DATE default SYSDATE, -- ������
    ADDRESS VARCHAR2(200) -- �ּ�
);

CREATE TABLE TBL_MEMBER_DEL( -- ���� ����
    MEMBERID VARCHAR2(100) PRIMARY KEY, -- ���̵�
    MEMBERNAME VARCHAR2(100), -- �̸�
    EMAIL VARCHAR2(200) UNIQUE, -- �̸���
    REGDATE DATE default SYSDATE, -- ������
    DELDATE DATE default SYSDATE, -- ������
    ADDRESS VARCHAR2(200) -- �ּ�
);

CREATE TABLE TBL_MEMBER_AUTH( -- ���� ����
    MEMBERID VARCHAR2(100) REFERENCES TBL_MEMBER(MEMBERID), -- ���̵�
    AUTH VARCHAR2(10) , -- ����
    ENABLE VARCHAR2(10)  -- ��������
);


CREATE TABLE TBL_MEMBER_IMAGE( -- ��� �̹��� ���̺�
    UUID VARCHAR2(100) PRIMARY KEY , -- ���� ���̵�
    MEMBERID VARCHAR2(100) REFERENCES TBL_MEMBER(MEMBERID), -- ���̵�
    UPLOADPATH VARCHAR2(200), -- ���� ���
    FILETYPE CHAR(1), -- ���� ����
    FILENAME VARCHAR2(100), -- ���� �̸�
    REGDATE DATE default SYSDATE, -- �����
    STATUS NUMBER -- ����
);

-----------------------------------
--            �Խñ�                      
-----------------------------------
CREATE TABLE TBL_BOARD( -- �Խñ�
    BNO NUMBER(10) PRIMARY KEY, -- �� ��ȣ    
    TITLE VARCHAR2(200), -- �� ����
    CONTENT VARCHAR2(2000), -- �� ����
    WRITER VARCHAR2(100) REFERENCES TBL_MEMBER(MEMBERID), -- �ۼ���
    BOARDTYPE VARCHAR2(100), -- ī�װ�
    REGDATE DATE default SYSDATE, -- �ۼ���
    UPDATEDATE DATE default SYSDATE, -- ������
    STATUS VARCHAR2(100), -- ����
    REPLYCNT NUMBER, -- ��� ��
    LIKEHIT NUMBER -- ���ƿ� ��
);

DROP SEQUENCE SEQ_BOARD; -- �Խñ� ��ȣ ������
CREATE SEQUENCE SEQ_BOARD; -- �Խñ� ��ȣ ������

CREATE TABLE TBL_BOARD_LIKE( -- �Խñ� ���ƿ� ���̺�
    BNO NUMBER(10) PRIMARY KEY REFERENCES TBL_BOARD(BNO), -- �� ��ȣ
    MEMBERID VARCHAR2(100) REFERENCES TBL_MEMBER(MEMBERID) -- ���̵�
);

-----------------------------------
--            ���
-----------------------------------
CREATE TABLE TBL_REPLY( -- ��� ���̺�
    RNO NUMBER(10) PRIMARY KEY, -- ��� ��ȣ
    BNO NUMBER(10) REFERENCES TBL_BOARD(BNO), -- �� ��ȣ
    REPLY VARCHAR2(1000), -- ��� ����
    REPLYER VARCHAR2(50) REFERENCES TBL_MEMBER(MEMBERID), -- �ۼ���
    REGDATE DATE default SYSDATE, -- �ۼ���
    UPDATEDATE DATE default SYSDATE, -- ������
    STATUS VARCHAR2(100), -- ��� ����
    LIKEHIT NUMBER -- ���ƿ� ��
);

DROP SEQUENCE SEQ_REPLY; -- �Խñ� ��ȣ ������
CREATE SEQUENCE SEQ_REPLY; -- �Խñ� ��ȣ ������

CREATE TABLE TBL_REPLY_LIKE( -- �Խñ� ���ƿ� ���̺�
    BNO NUMBER(10) PRIMARY KEY REFERENCES TBL_REPLY(RNO), -- �� ��ȣ
    MEMBERID VARCHAR2(100) REFERENCES TBL_MEMBER(MEMBERID) -- ���̵�
);

-----------------------------------
--            ÷������
-----------------------------------
CREATE TABLE TBL_ATTACH( -- ÷������ ���̺�
    UUID VARCHAR2(100) PRIMARY KEY, -- ���� ���̵�
    BNO NUMBER(10) REFERENCES TBL_BOARD(BNO), -- �� ��ȣ
    UPLOADPATH VARCHAR2(200), -- ���� ���
    FILETYPE CHAR(1), -- ���� ����
    FILENAME VARCHAR2(100), -- ���� �̸�
    REGDATE DATE, -- �����
    STATUS VARCHAR2(10) -- ����
);

------------------------------------------------------------------------------------
--                                  �ӽ� ������ ����
------------------------------------------------------------------------------------
-----------------------------------
--            ����
-----------------------------------

INSERT INTO TBL_MEMBER 
    (MEMBERID,MEMBERPWD,MEMBERNAME,EMAIL,REGDATE)
    VALUES ('admin','1111','������','admin@test.com',SYSDATE);

INSERT INTO TBL_MEMBER_DEL
    (MEMBERID,MEMBERNAME,EMAIL,REGDATE,DELDATE)
    VALUES ('sampledel','��������','sampledel@test.com',SYSDATE,SYSDATE);

-----------------------------------
--            �Խ��� 1
-----------------------------------
INSERT INTO TBL_BOARD
    (BNO,TITLE,CONTENT,WRITER,BOARDTYPE,STATUS)
    VALUES(SEQ_BOARD.NEXTVAL,'�Խ���1 ����1','�Խ��� ����1','admin','BOARD1','VISIBLE');
    
INSERT INTO TBL_BOARD
    (BNO,TITLE,CONTENT,WRITER,BOARDTYPE,STATUS)
    VALUES(SEQ_BOARD.NEXTVAL,'�Խ���1 ����2','�Խ��� ����2','admin','BOARD1','VISIBLE');

INSERT INTO TBL_BOARD
    (BNO,TITLE,CONTENT,WRITER,BOARDTYPE,STATUS)
    VALUES(SEQ_BOARD.NEXTVAL,'�Խ���1 ����3','�Խ��� ����3','admin','BOARD1','HIDDEN');

INSERT INTO TBL_BOARD
    (BNO,TITLE,CONTENT,WRITER,BOARDTYPE,STATUS)
    VALUES(SEQ_BOARD.NEXTVAL,'�Խ���1 ����4','�Խ��� ����4','admin','BOARD1','DELETED');
    
-----------------------------------
--            �Խ��� 2
-----------------------------------
INSERT INTO TBL_BOARD
    (BNO,TITLE,CONTENT,WRITER,BOARDTYPE,STATUS)
    VALUES(SEQ_BOARD.NEXTVAL,'�Խ���2 ����1','�Խ��� ����1','admin','BOARD2','VISIBLE');
    
INSERT INTO TBL_BOARD
    (BNO,TITLE,CONTENT,WRITER,BOARDTYPE,STATUS)
    VALUES(SEQ_BOARD.NEXTVAL,'�Խ���2 ����2','�Խ��� ����2','admin','BOARD2','VISIBLE');

INSERT INTO TBL_BOARD
    (BNO,TITLE,CONTENT,WRITER,BOARDTYPE,STATUS)
    VALUES(SEQ_BOARD.NEXTVAL,'�Խ���2 ����3','�Խ��� ����3','admin','BOARD2','HIDDEN');

INSERT INTO TBL_BOARD
    (BNO,TITLE,CONTENT,WRITER,BOARDTYPE,STATUS)
    VALUES(SEQ_BOARD.NEXTVAL,'�Խ���2 ����4','�Խ��� ����4','admin','BOARD2','DELETED');
    
-----------------------------------
--            �Խ��� 1 �Խñ�1 ���
-----------------------------------
INSERT INTO TBL_REPLY
    (RNO,BNO,REPLY,REPLYER,STATUS)
    VALUES(SEQ_REPLY.NEXTVAL,1,'�Խñ�1 ���1','admin','VISIBLE');
    
INSERT INTO TBL_REPLY
    (RNO,BNO,REPLY,REPLYER,STATUS)
    VALUES(SEQ_REPLY.NEXTVAL,1,'�Խñ�1 ���2','admin','VISIBLE');  
    
INSERT INTO TBL_REPLY
    (RNO,BNO,REPLY,REPLYER,STATUS)
    VALUES(SEQ_REPLY.NEXTVAL,1,'�Խñ�1 ���2','admin','HIDDEN');  
    
INSERT INTO TBL_REPLY
    (RNO,BNO,REPLY,REPLYER,STATUS)
    VALUES(SEQ_REPLY.NEXTVAL,1,'�Խñ�1 ���2','admin','DELETE');
    
------------------------------------------------------------------------------------
--                                 Ŀ�԰� ������ Ȯ��
------------------------------------------------------------------------------------

COMMIT;

-- ����
SELECT * FROM TBL_MEMBER; -- ����
SELECT * FROM TBL_MEMBER_DEL; -- ���� ����
SELECT * FROM TBL_MEMBER_AUTH; -- ���� ����
SELECT * FROM TBL_MEMBER_IMAGE; -- ���� �̹���

-- �Խñ�
SELECT * FROM TBL_BOARD; -- �Խñ�
SELECT * FROM TBL_BOARD_LIKE; -- �Խñ� ���ƿ�
SELECT * FROM TBL_BOARD WHERE STATUS = 'VISIBLE'; -- �Խñ�

-- ���
SELECT * FROM TBL_REPLY; -- ���
SELECT * FROM TBL_REPLY_LIKE; -- ��� ���ƿ�

-- ÷�� ����
SELECT * FROM TBL_ATTACH; -- ÷������
