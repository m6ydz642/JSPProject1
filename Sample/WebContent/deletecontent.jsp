<%@page import="board.BoardBean"%>
<%@page import="board.BoardDAO"%>
<%@page import="member.MemberDAO"%>
<%@page import="member.MemberBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% 
request.setCharacterEncoding("UTF-8");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>


<%
	BoardDAO boardDAO = new BoardDAO();
	

	String pageNum = request.getParameter("pageNum");
	System.out.println("delete.jsp 넘어온 pageNum값 " + pageNum);
	int num = Integer.parseInt(request.getParameter("num"));
	System.out.println("delete.jsp 넘어온 num값 " + num);
	String userid = (String) session.getAttribute("userid");
	
	BoardBean bBean = boardDAO.getBoard(num); 
	/* 
		글 삭제시 content처럼 getBoard함수를 사용해서 게시글을 읽은후	
	   다오에서 select 해서 getuserid, num값 등등 
	   전부쿼리해서 객체 단위로 정보 가져옴,
	   그중에 필요한 글작성시 DB에 저장된 userid 값을 가져옴 
	   (글 작성시 들어있는 userid값과 함께)
	*/
	
	String DBName = bBean.getUserid();
	System.out.println("delete.jsp 넘어온 세션 id값 " + userid);
	System.out.println("다오에서 넘어온 DB id값 " + DBName);
	
	if (DBName.equals(userid)) { // 세션으로 넘어온 userid와 DB에 저장된 값 확인
	
	boardDAO.DeleteContent(num); // 삭제 하려는 글 num값 받아와서 전달
%>

<script type="text/javascript">
	alert("삭제 되었습니다.");
	location.href = "Board.jsp?&pageNum=<%=pageNum%>"; // 이전에 있던 페이지로 다시 이동  
</script>

<%}else { 
%>
	<script type="text/javascript">
	alert("본인 글을 지우려는게 맞나요?");
	location.href = "Board.jsp?&pageNum=<%=pageNum%>";
</script>
<%
}
%>
<body>

</body>
</html>