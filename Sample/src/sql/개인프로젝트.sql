grant all privileges on Sample.* to jspid@'localhost' identified by 'jsppass';
/*관리자로 부터 Sample databases 권한 받기*/
 use Sample;

 show databases;
---------------------------------------------------------------------- 
 create table board(
num int primary key auto_increment, /*글번호*/
name varchar(20),  	/*사용자 이름*/
passwd varchar(20), /* 글작성시 비밀번호 */
subject varchar(50), /* 제목*/
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
address varchar(30),
reg_date datetime not null, -- 시스템시간으로
primary key (id, userid)
);
/*멤버 테이블*/

create table newsboard(
id int auto_increment primary key,
userid varchar(12),
userpasswd varchar(12) not null,
username varchar(20) not null,
contentpasswd varchar(20), /* 글작성시 비밀번호 */
subject varchar(500), /* 제목*/
content varchar(2000), /*내용*/
re_ref int,  /*그룹번호*/
re_seq int, /*글순서*/
readcount int, /*조회수*/
date datetime
);

use sample;
/*뉴스 보드테이블*/
drop table newsboard;

select * from newsboard;

insert into member(userid,userpasswd,name,gender,address,phone,reg_date)
values('test',1234,'name','man','busan',0101234,now());

show tables;
select * from member;
select * from board;
select * from member where userid = 'good';

