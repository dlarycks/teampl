---------------------- ���θ��� ���̺� ----------------------
-- tbl_member
-- ȸ����ȣ, ���̵�, ���, �̸�, ����(null���), ��ȭ��ȣ, �̸���, �ּ�1(null���), �ּ�2(null���), ������(default), ����Ʈ(default)
-- ȸ����ȣ�� 10000�ڸ� (10001~)
create table tbl_member(
    member_no number(10) primary key,
    member_id varchar2(100) unique not null,
    member_pw varchar2(100) not null,
    member_name varchar2(200) not null,
    member_birth varchar2(50),
    member_pno varchar2(50) not null,
    member_email varchar2(100) not null,
    member_addr1 varchar2(150),
    member_addr2 varchar2(300),
    member_regdate timestamp default sysdate,
    member_point number default 0
);
insert into tbl_member (member_no, member_id, member_pw, member_name, member_pno, member_email)
    values ((10000 + seq_member_no.nextval), 'hong', '1234', 'ȫ�浿', '010-2222-2222', 'hong@gmail.com');
insert into tbl_member (member_no, member_id, member_pw, member_name, member_pno, member_email)
    values ((10000 + seq_member_no.nextval), 'lee', '5678', '�̼���', '010-3333-3333', 'lee@gmail.com');
commit;
    -- ȸ�����Կ� ������
    create sequence seq_member_no;
    select seq_member_no.nextval from dual;
    

-- tbl_product
-- ��ǰ��ȣ, ��ǰ�̸�, ��ǰ�׸�, ��ǰ����, ������, �����
create table tbl_product(
    product_no number primary key,
    product_name varchar2(300) not null,
    product_category varchar2(100) not null,
    product_price number not null,
    product_manufacturer varchar2(500) not null,
    product_releasedate timestamp not null
);
insert into tbl_product values (100001, '�ھ�13���� i9-13900K', 'cpu', 785300, 'intel', sysdate);
insert into tbl_product values (200001, 'Z790 AORUS ELITE', 'mb', 365000, 'gigabyte', sysdate);
insert into tbl_product values (300001, '�Ｚ DDR5 32GB PC5-44800 2��', 'ram', 197800, '�Ｚ����', sysdate);
insert into tbl_product values (400001, 'GeForce RTX 3060 GAMING TWIN Edge OC D6 12GB LHR', 'vga', 428000, 'zotac', sysdate);
insert into tbl_product values (500001, 'MAXWELL BARON 800W 80PLUS BRONZE �÷�(ATX/800W)', 'power', 87000, '�ƽ�����Ʈ', sysdate);
insert into tbl_product values (600001, 'DLX21 RGB MESH ��ȭ���� ��', 'case', 98000, 'darkflash', sysdate);
insert into tbl_product values (700001, 'Gold P31 M.2 NVMe 2280', 'ssd', 785300, 'sk', sysdate);
commit;


-- tbl_product_img
-- ��ǰ��ȣ(fk), �̹��� ���
create table tbl_product_img(
    product_no number references tbl_product(product_no),
    product_imgsrc varchar2(1000)
);


-- tbl_order
-- �ֹ���ȣ, �ֹ�����(��ٶ� �ؽ�Ʈ..), ���ֹ�����
create table tbl_order(
    order_no number primary key,
    order_content varchar2(1000) not null,
    order_price number not null
);
insert into tbl_order
values(
seq_order_no.nextval,
'CPU �ھ�13���� i9-13900K, 
���κ��� Z790 AORUS ELITE, 
�޸� �Ｚ DDR5 32GB PC5-44800 2��,
�׷���ī�� GeForce RTX 3060 GAMING TWIN Edge OC D6 12GB LHR,
SSD Gold P31 M.2 NVMe 2280,
���̽� DLX21 RGB MESH ��ȭ���� ��,
�Ŀ� MAXWELL BARON 800W 80PLUS BRONZE �÷�(ATX/800W)',
2220000);
commit;
     -- �ֹ���ȣ�� ������
    create sequence seq_order_no;
    select seq_order_no.nextval from dual;


-- tbl_order_detail
-- �ֹ���ȣ, ȸ����ȣ, ��ǰ�׸� ��ǰ��ȣ 7��
-- �ֹ���ȣ�� tbl_order�� �ֹ���ȣ ����
-- ȸ����ȣ�� tbl_member�� ȸ����ȣ ����
-- ��ǰ��ȣ�� tbl_product�� ��ǰ��ȣ ����
create table tbl_order_detail(
    order_no number not null references tbl_order(order_no),
    member_no number(10) references tbl_member(member_no),
    order_cpu number references tbl_product(product_no),
    order_mb number references tbl_product(product_no),
    order_ram number references tbl_product(product_no),
    order_vga number references tbl_product(product_no),
    order_power number references tbl_product(product_no),
    order_case number references tbl_product(product_no),
    order_ssd number references tbl_product(product_no)
);
insert into tbl_order_detail
values (1, 10001, 100001, 200001, 300001, 400001, 500001, 600001, 700001);
commit;


---------------------- Ŀ�´�Ƽ�� ���̺� ----------------------
-- tbl_board
-- �۹�ȣ, �ۼ���, �ۺз�, ������, �۳���, �ۼ�����
create table tbl_board(
    board_no number(8) primary key,
    member_id varchar2(100) not null references tbl_member(member_id),
    board_type varchar2(20) not null,
    board_title varchar2(300) not null,
    board_content varchar2(3000) not null,
    board_regdate timestamp default sysdate
);
insert into tbl_board (board_no, member_id, board_type, board_title, board_content)
values (seq_board_no.nextval, 'hong', '����', '�ȳ��ϼ���', '����1');

     -- �� ������
    create sequence seq_board_no;
    select seq_board_no.nextval from dual;

-- tbl_board_img
-- �۹�ȣ(fk), �̹������
create table tbl_board_img(
    board_no number(8) references tbl_board(board_no),
    board_imgsrc varchar2(1000)
);

-- tbl_reply
-- ��۹�ȣ, �۹�ȣ(fk), ���̵�(fk), ��۳���, ����ۼ�����,
--  ��۱׷�(������ �ƴ϶�� ��۹�ȣ�� ����), ������(���۸��� �þ), ����(�鿩����)
create table tbl_reply (
    reply_no number(10) primary key,
    board_no number(8) not null references tbl_board(board_no),
    member_id varchar2(100) not null references tbl_member(member_id),
    reply_content varchar2(2000) not null,
    reply_regdate timestamp default sysdate,
    reply_group number(10) not null,
    reply_seq number(2) default 0,
    reply_level number(2) default 0
);

    -- ��� ������
    create sequence seq_reply_no;

insert into tbl_reply(reply_no, board_no, member_id, reply_content, reply_group)
    values(seq_reply_no.nextval, 1, 'hong', 'ù��° ���', seq_reply_no.currval);
insert into tbl_reply(reply_no, board_no, member_id, reply_content, reply_group)
    values(seq_reply_no.nextval, 1, 'lee', '�ι�° ���', seq_reply_no.currval); 