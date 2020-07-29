<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%

request.setCharacterEncoding("UTF-8");
if(request.getAttribute("userid") != null) { // 틀리면 무조건 null을 반환하기 때문에 널로 비교 가능 %>

<p>귀하의 아이디는 <font color="green"> <%= request.getAttribute("userid")%> </font>입니다</p>
<%}else{ %>
	<p> 귀하의 아이디를 확인 할 수 없습니다 <br> <font color="red"> 이름과 이메일 주소 </font>를 확인해 주세요</p>
	<button onclick="history.back(-1);">뒤로가기</button>
<%
}
%>
</body>
</html>