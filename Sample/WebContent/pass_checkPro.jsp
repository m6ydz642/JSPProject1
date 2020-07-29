<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@page import="member.MemberBean"%>
<%@page import="member.MemberDAO"%>

<jsp:useBean id="dao" class="member.MemberDAO"/>
<jsp:useBean id="bean" class="member.MemberBean"/>
<jsp:setProperty property="*" name="bean"/>

<!-- 회원정보 및 비밀번호 처리 페이지  --> 

<%
request.setCharacterEncoding("UTF-8");
String userid = (String)session.getAttribute("userid"); // 로그인 되어있어야 하기 때문에 세션값 가져옴
														// 아이디가 같이 안되어있으면 패스워드만 확인을 해서 
														// 문제생김
String curr_pass = request.getParameter("curr_pass");   // MyPage에서 원래  비밀번호
														// MyPage.pro 에서 name값으로 받아옴 
String pass = request.getParameter("pass"); // 수정한 비밀번호 


if (userid != null) { // 아이디값이 널이 아니면 작동 
				
//	MemberDAO dao = new MemberDAO(); // useBean 태그로 바꿈

	boolean check = dao.checkUser(userid, curr_pass); // 원래 비밀번호가 맞나 
													  // 참이냐 거짓이냐로만 판단한다. 
	
	if (check){ // 비밀번호와 아이디가 참이면 마이페이지로 넘겨줌 
		dao.UpdatePass(userid, pass); // 바뀐 비밀번호를 dao에 전달
		dao.UpdateMember(bean); // 바뀐 일반 정보를 dao 에 전달
%>

	<script>
	alert("정보수정 완료");
	location.href = "index.jsp";
		</script>
		
	
<%
	}else{
		%>
		<script>
		alert("비밀번호를 다시 확인하세요");
		history.back();
		</script>
		
		<%
	}
}
%>