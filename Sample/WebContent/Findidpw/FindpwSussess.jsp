<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-2.2.1.js"></script>
</head>
<body>

<%
request.setCharacterEncoding("UTF-8");
if(request.getAttribute("userpasswd") != null) { // 액션에서 받아온 에트리 뷰트값 가져오기
	// 틀리면 무조건 null을 반환하기 때문에 널로 비교 가능 %>

<p>귀하의 임시비밀번호는 <font color="green"> <%= request.getAttribute("userpasswd")%> </font>입니다</p>
<%}else{ %>
	<p> 귀하의 패스워드를 확인 할 수 없습니다 <br> <font color="red"> 아이디와 이메일 주소 </font>를 확인해 주세요</p>
	<button onclick="history.back(-1);">뒤로가기</button>
<%
}
%>

	<script>
	// 비밀번호 표시부분에서 새로고침 방지 소스 
	// f5키같은 특정키만 다 막음 (함수 여러번 호출 방지)
	// 윈도우는 기본키가 F5키인데 맥북은 Command + R 키가 새로고침이라 맥북은 뚫림 
		function noEvent() {
			if (event.keyCode == 116 || event.keyCode == 9) {
				alert('으~~~딜 새로고침을 하려고');
				return false;
			} else if (event.ctrlKey
					&& (event.keyCode = 78 || event.keyCode == 82)) {
				return false;
			}
		}
		document.onkeydown = noEvent;
	</script>
</body>
</html>