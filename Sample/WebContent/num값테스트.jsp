<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
	<%
		// int num = Integer.parseInt(request.getParameter("num"));
		// out.print(num);
		
		
		String userid = (String)session.getAttribute("id");
		out.print("�Ѿ�� ���̵� ");
		out.print(userid);
		
		// ���� �׽�Ʈ
		
		// NewsBoardBean bBean = dao.getNewsBoard(num);
		
	%>
	
		<Form action="FindAction.do" method="post">
		<button>����</button>>

	</Form>