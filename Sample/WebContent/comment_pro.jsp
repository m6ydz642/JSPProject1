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
	<jsp:useBean id="cb" class="board.CommentDTO" /> <!-- �ڹ��ڵ� �Ⱦ��� �±׷� bean ��������  -->
	<jsp:setProperty property="*" name="cb" />

<%
	String num = request.getParameter("ref"); // ����ۼ��� ��ۿ��� �߰��Ǿ��ִ� ref�� num������ �޾ƿ�
											  // ref = num �̸�, num 10���� �� �ش��ϴ� ���� ref 10��  
											  // �� num�� 10���̶�� �ۿ� �ش��ϴ� ��� ref�� 10�̶�� ��
											  // ref�� num(�۹�ȣ) �� ���ƾ� �Ѵٴ� ��
	// ������ ��ȣ���ٰ� ref����, ���ų� �ٸ��� ���̶� ����̶� ���� ��
	
	String pageNum = request.getParameter("page"); // page num�� �޾ƿ�

	CommentDAO cdao = new CommentDAO(); // ��� ��ü ����
	cdao.insertComment(cb); // ��۳��� ��ü�� �����ؼ� �߰� 
	
	// response.sendRedirect("comment.jsp?commentNum=");

%>

<!-- ��� ���� ���ΰ�ħ, ��� �ۼ��� �ٷ� ���ΰ�ħ ó�� -->
	<meta http-equiv="Refresh" content="0; url=content.jsp?num=<%=num%>&pageNum=<%=pageNum%>">
</body>
</html>