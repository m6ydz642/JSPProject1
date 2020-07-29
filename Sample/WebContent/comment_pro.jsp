<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
    <%@page import="board.CommentDAO"%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
</head>
<body>
<%
	request.setCharacterEncoding("utf-8");
%>
	<jsp:useBean id="cb" class="board.CommentDTO" /> <!-- 자바코드 안쓰고 태그로 bean 가져오기  -->
	<jsp:setProperty property="*" name="cb" />

<%
	String num = request.getParameter("ref"); // 댓글작성시 댓글에서 추가되어있던 ref를 num값으로 받아옴
											  // ref = num 이면, num 10번에 에 해당하는 글은 ref 10임  
											  // 즉 num이 10번이라면 글에 해당하는 댓글 ref도 10이라는 말
											  // ref랑 num(글번호) 랑 같아야 한다는 함
	// 페이지 번호에다가 ref씌움, 없거나 다르면 글이랑 댓글이랑 따로 놈
	
	String pageNum = request.getParameter("page"); // page num값 받아옴

	CommentDAO cdao = new CommentDAO(); // 댓글 객체 생성
	cdao.insertComment(cb); // 댓글내용 객체로 전달해서 추가 
	
	// response.sendRedirect("comment.jsp?commentNum=");

%>

<!-- 댓글 정보 새로고침, 댓글 작성후 바로 새로고침 처리 -->
	<meta http-equiv="Refresh" content="0; url=content.jsp?num=<%=num%>&pageNum=<%=pageNum%>">
</body>
</html>