<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
	<%
		// int num = Integer.parseInt(request.getParameter("num"));
		// out.print(num);
		
		
		String userid = (String)session.getAttribute("id");
		out.print("넘어온 아이디 ");
		out.print(userid);
		
		// 서블릿 테스트
		
		// NewsBoardBean bBean = dao.getNewsBoard(num);
		
	%>
	
		<Form action="FindAction.do" method="post">
		<button>눌러</button>>

	</Form>