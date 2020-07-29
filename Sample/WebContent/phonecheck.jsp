<%@page import="member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<% 


int phone = Integer.parseInt(request.getParameter("phone"));

MemberDAO dao = new MemberDAO();


boolean checkphone = dao.phonecheck(phone); 
System.out.println("입력받은 폰번호 " + phone);
if (checkphone == false) {
	checkphone=false;
	out.print("휴대폰이 중복됩니다 ");
}else{
	checkphone=true;
	out.print("휴대폰 번호가 사용가능 합니다 ");
}



%>