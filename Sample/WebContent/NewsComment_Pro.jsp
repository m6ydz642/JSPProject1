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
	<jsp:useBean id="cb" class="newsboard.NewsCommentBean" /> <!-- �ڹ��ڵ� �Ⱦ��� �±׷� bean ��������  -->
	<jsp:setProperty property="*" name="cb" />

<%
String userid = (String) session.getAttribute("userid");
if (userid == null) // �α��� ���ϸ�
	response.sendRedirect("Login.jsp"); // �ٷ� �α������� �ȳ�, �Ա���
	
	String num = request.getParameter("ref"); // ����ۼ��� ���� ��������� 
	// ������ ��ȣ���ٰ� �׷��ȣ�� ���� (�� num�̶� �׷��̶� ���� ���߱� ���ؼ�), ������ ����ۿ� ����� ���� Ȩ�������� ��
	
	String pageNum = request.getParameter("page"); // page num�� �޾ƿ�

	NewsCommentDAO cdao = new NewsCommentDAO(); // ��� ��ü ����
	cdao.insertNewsComment(cb); // ��۳��� ��ü�� �����ؼ� �߰� 
	
	// response.sendRedirect("comment.jsp?commentNum=");

%>

<!-- ��� ���� ���ΰ�ħ -->
	<meta http-equiv="Refresh" content="0; url=NewsContent.jsp?num=<%=num%>&pageNum=<%=pageNum%>">
</body>
</html>