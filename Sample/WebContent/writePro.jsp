<%@page import="member.MemberBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<jsp:useBean id="dao" class="board.BoardDAO"/>
<jsp:useBean id="bean" class="board.BoardBean"/>
    
        
<jsp:useBean id="memdao" class="member.MemberDAO"/>
<jsp:useBean id="membean" class="member.MemberBean"/> 
    
 <%
	request.setCharacterEncoding("UTF-8");
 	// 값 확인 
 	String subject = request.getParameter("subject");
	String userid = (String) session.getAttribute("userid"); // 이전에 로그인된 세션값 
 	String content = request.getParameter("content"); // write.jsp에서 작성한 내용 name값으로 받아오기 
 	String dbuserid = request.getParameter("userid");
 	String pageNum = request.getParameter("pageNum");
 	
 /**********************************************************/
 // 자료 값 테스트용 
	out.print("넘어온 아이디  : " +userid +  "<br>");
 	out.print("넘어온 제목 : " + subject +  "<br>");
 	out.print("넘어온 내용 : " +content  +  "<br>");
 	/**********************************************************/	
//  	 if (userid == null) {
//      	out.print("허가되지 않은 접근입니다 으~~~딜 ^^ ");
//     }
 //////////////////////////////////	
 	 bean.setContent(content); // 세터에게 내용 전달
 	 bean.setSubject(subject); // 세터에게 제목 전달
 	 bean.setUserid(userid); // 로그인이 되어있는 세션값 아이디를 보드에 UserId에 전달 
//////////////////////////////////	 
 	 dao.insertContent(bean);


 	 
 %>
<meta http-equiv="Refresh" content="0; url=Board.jsp?&pageNum=<%=pageNum%>">

