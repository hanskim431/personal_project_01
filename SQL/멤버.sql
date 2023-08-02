------------------------------------------------------------------------------------
--                                  ���̺� ����
------------------------------------------------------------------------------------

-- ����
DROP TABLE TBL_MEMBER; -- ����
DROP TABLE TBL_MEMBER_DEL; -- ���� ����
DROP TABLE TBL_MEMBER_AUTH; -- ���� ����
DROP TABLE TBL_MEMBER_IMAGE; -- ���� �̹���

-- �Խñ�
DROP TABLE TBL_BOARD; -- �Խñ�
DROP TABLE TBL_BOARD_DEL; -- ���� �Խñ�
DROP TABLE TBL_BOARD_LIKE; -- �Խñ� ���ƿ�
-- ���
DROP TABLE TBL_REPLY; -- ���
DROP TABLE TBL_REPLY_LIKE; -- ��� ���ƿ�

-- ÷�� ����
DROP TABLE TBL_ATTACH; -- ÷������

------------------------------------------------------------------------------------
--                                  ���̺� ����
------------------------------------------------------------------------------------

-----------------------------------
--            ����                      
-----------------------------------
CREATE TABLE TBL_MEMBER( -- ����
    MEMBERID VARCHAR2(100) PRIMARY KEY, -- ���̵�
    MEMBERPWD VARCHAR2(200) NOT NULL, -- ��й�ȣ
    MEMBERNAME VARCHAR2(100) NOT NULL, -- �̸�
    EMAIL VARCHAR2(200) NOT NULL, -- �̸���
    REGDATE DATE default SYSDATE, -- ������
    ADDRESS VARCHAR2(200) -- �ּ�
);

CREATE TABLE TBL_MEMBER_DEL( -- ���� ����
    MEMBERID VARCHAR2(100) PRIMARY KEY, -- ���̵�
    MEMBERNAME VARCHAR2(100) NOT NULL, -- �̸�
    EMAIL VARCHAR2(200) NOT NULL, -- �̸���
    REGDATE DATE default SYSDATE, -- ������
    DELDATE DATE default SYSDATE, -- ������
    ADDRESS VARCHAR2(200) -- �ּ�
);

CREATE TABLE TBL_MEMBER_AUTH( -- ���� ����
    MEMBERID VARCHAR2(100) PRIMARY KEY, -- ���̵�
    AUTH NUMBER(10) NOT NULL, -- ����
    ENABLE NUMBER(10) NOT NULL -- ��������
);

CREATE TABLE TBL_MEMBER_IMAGE( -- ÷������ ���̺�
    UUID VARCHAR2(100) PRIMARY KEY, -- ���� ���̵�
    BNO NUMBER(10) NOT NULL, -- �� ��ȣ
    UPLOADPATH VARCHAR2(200), -- ���� ���
    FILETYPE CHAR(1) NOT NULL, -- ���� ����
    FILENAME VARCHAR2(100) NOT NULL, -- ���� �̸�
    REGDATE DATE default SYSDATE, -- �����
    STATUS NUMBER -- ����
);

-----------------------------------
--            �Խñ�                      
-----------------------------------
CREATE TABLE TBL_BOARD( -- �Խñ�
    BNO NUMBER(10) PRIMARY KEY, -- �� ��ȣ    
    TITLE VARCHAR2(200) NOT NULL, -- �� ����
    CONTENT VARCHAR2(2000), -- �� ����
    WRITER VARCHAR2(100) NOT NULL, -- �ۼ���
    BOARDTYPE VARCHAR2(100) NOT NULL, -- ī�װ�
    REGDATE DATE default SYSDATE, -- �ۼ���
    UPDATEDATE DATE default SYSDATE, -- ������
    STATUS VARCHAR2(100) NOT NULL, -- ����
    REPLYCNT NUMBER, -- ��� ��
    LIKEHIT NUMBER -- ���ƿ� ��
);

CREATE TABLE TBL_BOARD_DEL( -- ���� �Խñ�
    BNO NUMBER(10) PRIMARY KEY, -- �� ��ȣ
    TITLE VARCHAR2(200) NOT NULL, -- �� ���� 
    CONTENT VARCHAR2(2000), -- �� ����
    WRITER VARCHAR2(100) NOT NULL, -- �ۼ���
    BOARDTYPE VARCHAR2(100) NOT NULL, -- ī�װ�
    REGDATE DATE NOT NULL, -- �ۼ���
    UPDATEDATE DATE, -- ������
    STATUS VARCHAR2(100) NOT NULL, -- ����
    REPLYCNT NUMBER, -- ��� ��
    LIKEHIT NUMBER -- ���ƿ� ��
);

CREATE TABLE TBL_BOARD_LIKE( -- �Խñ� ���ƿ� ���̺�
    BNO NUMBER(10) PRIMARY KEY, -- �� ��ȣ
    MEMBERID VARCHAR2(100) -- ���̵�
);

-----------------------------------
--            ���
-----------------------------------
CREATE TABLE TBL_REPLY( -- ��� ���̺�
    RNO NUMBER(10) PRIMARY KEY, -- ��� ��ȣ
    BNO NUMBER(10) NOT NULL, -- �� ��ȣ
    REPLY VARCHAR2(1000), -- ��� ����
    REPLYER VARCHAR2(50) NOT NULL, -- �ۼ���
    REGDATE DATE default SYSDATE, -- �ۼ���
    UPDATEDATE DATE default SYSDATE, -- ������
    STATUS NUMBER NOT NULL, -- ��� ����
    LIKEHIT NUMBER -- ���ƿ� ��
);

CREATE TABLE TBL_REPLY_LIKE( -- �Խñ� ���ƿ� ���̺�
    BNO NUMBER(10) PRIMARY KEY, -- �� ��ȣ
    MEMBERID VARCHAR2(100) -- ���̵�
);

-----------------------------------
--            ÷������
-----------------------------------
CREATE TABLE TBL_ATTACH( -- ÷������ ���̺�
    UUID VARCHAR2(100) PRIMARY KEY, -- ���� ���̵�
    BNO NUMBER(10) NOT NULL, -- �� ��ȣ
    UPLOADPATH VARCHAR2(200), -- ���� ���
    FILETYPE CHAR(1) NOT NULL, -- ���� ����
    FILENAME VARCHAR2(100) NOT NULL, -- ���� �̸�
    REGDATE DATE, -- �����
    STATUS NUMBER -- ����
);


------------------------------------------------------------------------------------
--                                  �ӽ� ������ ����
------------------------------------------------------------------------------------
INSERT INTO TBL_MEMBER 
    (MEMBERID,MEMBERPWD,MEMBERNAME,EMAIL,REGDATE)
    VALUES ('admin','1111','������','admin@test.com',SYSDATE);

INSERT INTO TBL_MEMBER_DEL
    (MEMBERID,MEMBERNAME,EMAIL,REGDATE,DELDATE)
    VALUES ('sampledel','��������','sampledel@test.com',SYSDATE,SYSDATE);

------------------------------------------------------------------------------------
--                                  ������ Ȯ��
------------------------------------------------------------------------------------

-- ����
SELECT * FROM TBL_MEMBER; -- ����
SELECT * FROM TBL_MEMBER_DEL; -- ���� ����
SELECT * FROM TBL_MEMBER_AUTH; -- ���� ����
SELECT * FROM TBL_MEMBER_IMAGE; -- ���� �̹���

-- �Խñ�
SELECT * FROM TBL_BOARD; -- �Խñ�
SELECT * FROM TBL_BOARD_DEL; -- ���� �Խñ�
SELECT * FROM TBL_BOARD_LIKE; -- �Խñ� ���ƿ�
-- ���
SELECT * FROM TBL_REPLY; -- ���
SELECT * FROM TBL_REPLY_LIKE; -- ��� ���ƿ�

-- ÷�� ����
SELECT * FROM TBL_ATTACH; -- ÷������


    