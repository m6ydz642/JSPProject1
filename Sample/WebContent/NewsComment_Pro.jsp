<%@page import="newsboard.NewsCommentDAO"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
    <%@page import="newsboard.NewsBoardBean"%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
</head>
<body>
<%
	request.setCharacterEncoding("utf-8");
%>
	<jsp:useBean id="cb" class="newsboard.NewsCommentBean" /> <!-- 자바코드 안쓰고 태그로 bean 가져오기  -->
	<jsp:setProperty property="*" name="cb" />

<%
String userid = (String) session.getAttribute("userid");
if (userid == null) // 로그인 안하면
	response.sendRedirect("Login.jsp"); // 바로 로그인으로 안내, 입구컷
	
	String num = request.getParameter("ref"); // 댓글작성시 현재 어느글인지 
	// 페이지 번호에다가 그룹번호를 씌움 (글 num이랑 그룹이랑 같이 맞추기 위해서), 없으면 어느글에 댓글을 쓸지 홈페이지가 모름
	
	String pageNum = request.getParameter("page"); // page num값 받아옴

	NewsCommentDAO cdao = new NewsCommentDAO(); // 댓글 객체 생성
	cdao.insertNewsComment(cb); // 댓글내용 객체로 전달해서 추가 
	
	// response.sendRedirect("comment.jsp?commentNum=");

%>

<!-- 댓글 정보 새로고침 -->
	<meta http-equiv="Refresh" content="0; url=NewsContent.jsp?num=<%=num%>&pageNum=<%=pageNum%>">
</body>
</html>