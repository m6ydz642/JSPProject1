<%@page import="member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<% 


int phone = Integer.parseInt(request.getParameter("phone"));

MemberDAO dao = new MemberDAO();


boolean checkphone = dao.phonecheck(phone); 
System.out.println("�Է¹��� ����ȣ " + phone);
if (checkphone == false) {
	checkphone=false;
	out.print("�޴����� �ߺ��˴ϴ� ");
}else{
	checkphone=true;
	out.print("�޴��� ��ȣ�� ��밡�� �մϴ� ");
}



%>