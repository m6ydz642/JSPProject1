<%@page import="member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<% 
String email =  request.getParameter("email");
MemberDAO dao = new MemberDAO();


boolean emailcheck = dao.emailcheck(email); 
System.out.println("입력받은 메일 " + email);
if (emailcheck == false) {
	emailcheck=false;
	out.print("입력받은 메일이 중복됩니다 ");
}else{
	emailcheck=true;
	out.print("입력받은 메일이  사용가능 합니다 ");
}





%>