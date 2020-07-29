<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
<meta charset="UTF-8">
<title>패스워드 확인 페이지 </title>
<jsp:include page="header.jsp" />
<!-- 마이페이지 접속전에 비밀번호 확인용 -->
<!-- 마이페이지 접속전에 비밀번호 확인용 -->
<!-- 마이페이지 접속전에 비밀번호 확인용 -->
<!-- 마이페이지 접속전에 비밀번호 확인용 -->
v
<!-- 마이페이지 접속전에 비밀번호 확인용 -->
</head>
<body>

<form action="MyPage.jsp" method="post" onsubmit="return checkForm();">
<center>
	<table>
		<tr>
			<td class="">
			<label for="check_pass">현재비밀번호를 입력하세요 </label>
				<input type="password" name="mypagecheck" id="mypagecheck" placeholder="현재비밀번호 입력">	
			</td>
		</tr>
	</table>
	<div id="pass_check_btn">
		<input type="submit" value="확인">
		<input type="reset" value="취소">
	</div>
</center>

</form>
	

</body>
<jsp:include page="footer.jsp" />
</html>