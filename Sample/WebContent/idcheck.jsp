<%@page import="member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<% 
String userid = request.getParameter("userid");

MemberDAO dao = new MemberDAO();

System.out.println("idcheck 페이지 = 입력받은 아이디"+ userid);
int check = dao.idcheck(userid); 

if (check == 1) {
	check=1;
	out.print("아이디가 중복됩니다 ");
}else{
	check=0;
	out.print("사용가능 합니다 ");
}





%>