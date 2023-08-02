---------------------- 쇼핑몰용 테이블 ----------------------
-- tbl_member
-- 회원번호, 아이디, 비번, 이름, 생일(null허용), 전화번호, 이메일, 주소1(null허용), 주소2(null허용), 가입일(default), 포인트(default)
-- 회원번호는 10000자리 (10001~)
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
    values ((10000 + seq_member_no.nextval), 'hong', '1234', '홍길동', '010-2222-2222', 'hong@gmail.com');
insert into tbl_member (member_no, member_id, member_pw, member_name, member_pno, member_email)
    values ((10000 + seq_member_no.nextval), 'lee', '5678', '이순신', '010-3333-3333', 'lee@gmail.com');
commit;
    -- 회원가입용 시퀀스
    create sequence seq_member_no;
    select seq_member_no.nextval from dual;
    

-- tbl_product
-- 상품번호, 상품이름, 상품항목, 상품가격, 제조사, 출시일
create table tbl_product(
    product_no number primary key,
    product_name varchar2(300) not null,
    product_category varchar2(100) not null,
    product_price number not null,
    product_manufacturer varchar2(500) not null,
    product_releasedate timestamp not null
);
insert into tbl_product values (100001, '코어13세대 i9-13900K', 'cpu', 785300, 'intel', sysdate);
insert into tbl_product values (200001, 'Z790 AORUS ELITE', 'mb', 365000, 'gigabyte', sysdate);
insert into tbl_product values (300001, '삼성 DDR5 32GB PC5-44800 2개', 'ram', 197800, '삼성전자', sysdate);
insert into tbl_product values (400001, 'GeForce RTX 3060 GAMING TWIN Edge OC D6 12GB LHR', 'vga', 428000, 'zotac', sysdate);
insert into tbl_product values (500001, 'MAXWELL BARON 800W 80PLUS BRONZE 플랫(ATX/800W)', 'power', 87000, '맥스엘리트', sysdate);
insert into tbl_product values (600001, 'DLX21 RGB MESH 강화유리 블랙', 'case', 98000, 'darkflash', sysdate);
insert into tbl_product values (700001, 'Gold P31 M.2 NVMe 2280', 'ssd', 785300, 'sk', sysdate);
commit;


-- tbl_product_img
-- 상품번호(fk), 이미지 경로
create table tbl_product_img(
    product_no number references tbl_product(product_no),
    product_imgsrc varchar2(1000)
);


-- tbl_order
-- 주문번호, 주문내역(길다란 텍스트..), 총주문가격
create table tbl_order(
    order_no number primary key,
    order_content varchar2(1000) not null,
    order_price number not null
);
insert into tbl_order
values(
seq_order_no.nextval,
'CPU 코어13세대 i9-13900K, 
메인보드 Z790 AORUS ELITE, 
메모리 삼성 DDR5 32GB PC5-44800 2개,
그래픽카드 GeForce RTX 3060 GAMING TWIN Edge OC D6 12GB LHR,
SSD Gold P31 M.2 NVMe 2280,
케이스 DLX21 RGB MESH 강화유리 블랙,
파워 MAXWELL BARON 800W 80PLUS BRONZE 플랫(ATX/800W)',
2220000);
commit;
     -- 주문번호용 시퀀스
    create sequence seq_order_no;
    select seq_order_no.nextval from dual;


-- tbl_order_detail
-- 주문번호, 회원번호, 상품항목별 상품번호 7개
-- 주문번호는 tbl_order의 주문번호 참조
-- 회원번호는 tbl_member의 회원번호 참조
-- 상품번호는 tbl_product의 상품번호 참조
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


---------------------- 커뮤니티용 테이블 ----------------------
-- tbl_board
-- 글번호, 작성자, 글분류, 글제목, 글내용, 작성일자
create table tbl_board(
    board_no number(8) primary key,
    member_id varchar2(100) not null references tbl_member(member_id),
    board_type varchar2(20) not null,
    board_title varchar2(300) not null,
    board_content varchar2(3000) not null,
    board_regdate timestamp default sysdate
);
alter table tbl_board
add board_viewcount number(6) default 0;

insert into tbl_board (board_no, member_id, board_type, board_title, board_content)
values (seq_board_no.nextval, 'hong', '정보', '안녕하세요', '내용1');

     -- 글 시퀀스
    create sequence seq_board_no;
    select seq_board_no.nextval from dual;

-- tbl_board_like
-- 아이디(fk), 글번호(fk)
create table tbl_board_like(
    member_id varchar2(100) not null references tbl_member(member_id),
    board_no number(8) references tbl_board(board_no)
);
insert into tbl_board_like
values('hong', 1);
insert into tbl_board_like
values ('lee', 1);

-- tbl_board_img
-- 글번호(fk), 이미지경로
create table tbl_board_img(
    board_no number(8) references tbl_board(board_no),
    board_imgsrc varchar2(1000)
);

-- tbl_reply
-- 댓글번호, 글번호(fk), 아이디(fk), 댓글내용, 댓글작성일자,
--  댓글그룹(대댓글이 아니라면 댓글번호와 같음), 시퀀스(대댓글마다 늘어남), 레벨(들여쓰기)
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

    -- 댓글 시퀀스
    create sequence seq_reply_no;

insert into tbl_reply(reply_no, board_no, member_id, reply_content, reply_group)
    values(seq_reply_no.nextval, 1, 'hong', '첫번째 댓글', seq_reply_no.currval);
insert into tbl_reply(reply_no, board_no, member_id, reply_content, reply_group)
    values(seq_reply_no.nextval, 1, 'lee', '두번째 댓글', seq_reply_no.currval);
    commit;