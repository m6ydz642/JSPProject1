<%@page import="board.BoardBean"%>
<%@page import="board.BoardDAO"%>
<%@page import="member.MemberBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%> 
<jsp:useBean id ="bBean" class="board.BoardBean"/>
<jsp:setProperty property="*" name="bBean"/> <!-- 이걸로 값이 안넘어감 ㅡ.ㅡ -->

<jsp:useBean id ="mBean" class="member.MemberBean"/>
<%-- <jsp:setProperty property="*" name="mBean"/> <!-- 이걸로 값이 안넘어감 ㅡ.ㅡ --> --%>
<%
	request.setCharacterEncoding("UTF-8");
   //response.setContentType("text/html;charset=UTF-8");
   
	String userid = (String) session.getAttribute("userid");
	int num = Integer.parseInt(request.getParameter("num"));
	String content = request.getParameter("content");
	String subject = request.getParameter("subject");
// 	BoardBean bBean = new BoardBean();
	
 	bBean.setContent(content);
 	bBean.setUserid(bBean.getContent());
 	bBean.getContent();
 	
 	out.print("넘어온 아이디  : " +userid +  "<br>");
 	out.print("넘어온 제목 : " + subject +  "<br>");
 	out.print("넘어온 내용 : " +bBean.getContent()  +  "<br>");
 	// out.print("넘어온 내용 : " +bBean.getContent()  +  "<br>");
 	
 	BoardDAO bdao = new BoardDAO();
	bBean.setUserid(userid); // 로그인이 되어있는 세션값 아이디를 보드에 UserId에 전달

							// 위에 태그가 안먹음 ㅡ.ㅡ 

	bdao.updateBoard(bBean);
 	int check = bdao.updateBoard(bBean);

 	 if(check==1) {
 %>
 <script>
 	alert("수정되었습니다");
 	location.href="Board.jsp";
 
 </script>
 <%		
 	}else{
%>
 		 <script>
 	 	alert("본인의 글을 수정하려는게 맞나요?");
 	 	
		history.back();
 	 </script>
<% 		
 	}
%>  