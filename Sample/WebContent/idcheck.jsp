<%@page import="member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<% 
String userid = request.getParameter("userid");

MemberDAO dao = new MemberDAO();

System.out.println("idcheck ������ = �Է¹��� ���̵�"+ userid);
int check = dao.idcheck(userid); 

if (check == 1) {
	check=1;
	out.print("���̵� �ߺ��˴ϴ� ");
}else{
	check=0;
	out.print("��밡�� �մϴ� ");
}





%>