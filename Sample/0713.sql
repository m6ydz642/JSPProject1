use Sample;

grant all privileges on Sample.* to jspid@'localhost' identified by 'jsppass';
/* 원래 올리면 안되는데 걍 올림 */

/*관리자로 부터 Sample databases 권한 받기*/
 use Sample;

 show databases;
---------------------------------------------------------------------- 
 create table board(
num int primary key auto_increment, /*글번호*/
userid varchar(20),  -- 사용자 아이디
name varchar(20),  	/*사용자 이름*/
passwd varchar(20), /* 글작성시 비밀번호 */
subject varchar(500), /* 제목*/
content varchar(2000),  /*내용*/
re_ref int,  /*그룹번호*/
re_lev int, /*답글용 */
re_seq int, /*글순서*/
readcount int,
date datetime
);
 /*게시판*/
---------------------------------------------------------------------
create table member(
id int auto_increment,
userid varchar(12),
userpasswd varchar(12) not null,
name varchar(20) not null,
gender varchar(5) not null,
phone int(11),
email varchar(20),
address varchar(30), -- 카카오로 검색된 자동 주소
address2 varchar(30), -- 나머지 주소 
reg_date datetime not null, -- 시스템시간으로
primary key (id, userid)
);
/*멤버 테이블*/

create table newsboard(
 num int auto_increment primary key,
userid varchar(12),
/*userpasswd varchar(12) not null,*/
/*username varchar(20) not null,*/
/*contentpasswd varchar(20), /* 글작성시 비밀번호 */
filename varchar(200),
preview varchar(200),
subject varchar(500), /* 제목*/
content varchar(6000), /*내용*/
re_ref int,  /*그룹번호*/
re_seq int, /*글순서*/
readcount int, /*조회수*/

date datetime
);

use sample;
/*뉴스 보드테이블*/


select * from newsboard;

insert into member(userid,userpasswd,name,gender,address,phone,reg_date)
values('test',1234,'name','man','busan',0101234,now());

show tables;
select * from member;
select * from board;
select * from member where userid = 'good';

/* 게시판 댓글 */
 create table comment( 
	num int primary key, /*소스상으로 자동넘기기 되어있음*/
	id varchar(30),
	content varchar(50),
	ref int, /*글 그룹번호임 무조건 맞아야 함*/
	reg_date datetime
);

/*뉴스 댓글*/
 create table newscomment( 
	num int primary key, /*소스상으로 자동넘기기 되어있음*/
	id varchar(30),
	content varchar(50),
	ref int, /*글 그룹번호임 무조건 맞아야 함*/
	reg_date datetime
);
alter table newscomment change content content varchar(500);




select * from newsboard;
select * from newscomment;
select * from comment;
select * from board;
desc board;

/*컬럼 변경*/
alter table newsboard change id num int;

/*아래 money 테이블은 정규화가 안되어있음
money money 해도 money
삽입, 갱신, 삭제 이상 3개가 다 발생하는 테이블
*/
create table money (
num int primary key auto_increment,
회사이름 varchar(50),
대표자 varchar(50), /*moneybean에 넣어야 됨 */
회사개요 varchar(2000),
기수 varchar(50),  /*회사마다 다름 20기,21기 등등*/
보고서종류 varchar(50),  /*몇월부터 몇월 까지*/
범위 varchar(50),  /*몇월부터 몇월 까지*/
종류 varchar(50), /*무슨 보고서 인지 */
구분 varchar(50),/*1분기, ~ 4분기 순인지 1년단위인지*/
/*구분 테이블이 검색 대상*/
매출액 BIGINT,
매출원가 	BIGINT,
판매관리비 BIGINT,
유동자산 BIGINT,
/*유동비율 BIGINT,*/ /*계산 했던걸 다시 써야 해서 필요없음*/
유동부채 BIGINT,
비유동부채 BIGINT,
자본금 BIGINT,
자기자본 BIGINT,
자본총액 BIGINT,
주식발행수 BIGINT,
당기순이익 BIGINT,
시가총액 BIGINT,
부채총계 BIGINT,
자산총계 BIGINT,
자본총계 BIGINT,
re_ref int,  /*그룹번호*/
re_seq int /*글순서*/
);

/*******************************************/



select * from money order by re_ref desc, re_seq limit 0,1;


alter table member add address2 varchar(30);

alter table money add 종류 varchar(30);
alter table money add 보고서종류 varchar(30);
alter table money add 기수 varchar(30);
alter table newsboard add newscategory varchar(20);

SET SQL_SAFE_UPDATES = 0; /*safe모드 끔*/
update member set phone = 0101234, email = 'z', address = 'z', address2 = 'zx' where userid = 'awwsibal';

alter table newsboard add filename varchar(200);
alter table newsboard add filerealname varchar(200);

commit;

use Sample;

create table testmoney (
num int auto_increment,
회사이름 varchar(1000),
종목코드 varchar(1000),
유동자산 Bigint,
유동부채 Bigint,
비유동부채 Bigint
);
select * from test;

insert into test values("test","test");
truncate test;


commit;

select * from money;
select * from test;
select * from member;
desc member;
select * from newsboard;
select * from board;
select * from newscomment;
select * from comment;
select * from money;

truncate newsboard;

/* 검색기능 잠시 확인 */ 
select * from money 
where 회사이름 like '%하%' and 
구분 like '%사업%' 
order by  num;

select * from money  /*퍼센트에 공백을 줘서 전체를 가져오는지 확인*/
where 회사이름 like '%%' and 
구분 like '%%' 
order by  num;

select count(*) from money 
where 회사이름 like '%하%' 
and 구분 like '%사업%';


select * from money 
where 회사이름 like '%하이즈%' and 구분 like '%사업%'
order by re_ref desc, re_seq asc limit  1,1;

select userid from member where name = '123' and email = "1234@baver.com";

use Sample;

select * from member;

alter table member add session int(5); /*세션 항목 추가*/
alter table member add exfire varchar(1); /*유효항목*/


select session, userid from member where userid=123;


select session, userid from member where userid=123;
update member set session = session+1 
where userid = '123';

select * from member;


select * from board;
select * from newsboard order by num desc;

select * from money;
select * from newsboard;

select * from newscomment;
select * from comment;

alter table newsboard change filerealname preview  varchar(200);
alter table newsboard change content content varchar(6000);
select count(*) from newscomment where ref = 1;

select * from money;
show processlist;


select userpasswd from member
where userid = 123 and email="1234@baver.com";

delete from money 
where num between 4
 and 13;
 
 delete from newsboard 
where num between 14
 and 27;

select newscategory from newsboard;

delete from newsboard
where num = 13;

delete board, comment
from board  inner join comment
on comment.ref = board.num
where board.num = 3;



select * from board;
select * from comment;


select * from board where num = 2;


delete board, comment from board  inner join comment on comment.ref = board.num where board.num = 14;


select * from member;

delete from money where num =7;

select * from newsboard;
select * from money;
delete from newsboard where num = 29;

delete from money where num = 7;
