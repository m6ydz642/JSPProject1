<%@page import="member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<% 
String email =  request.getParameter("email");
MemberDAO dao = new MemberDAO();


boolean emailcheck = dao.emailcheck(email); 
System.out.println("�Է¹��� ���� " + email);
if (emailcheck == false) {
	emailcheck=false;
	out.print("�Է¹��� ������ �ߺ��˴ϴ� ");
}else{
	emailcheck=true;
	out.print("�Է¹��� ������  ��밡�� �մϴ� ");
}





%>