<%@page import="member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">


<!-- <!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd"> -->

<script src="https://code.jquery.com/jquery-2.2.1.js"></script>

<script>

function popup(){ // 아이디 비밀번호 찾기 팝업
    var url = "Findidpw/Findidpw.jsp";
    var name = "popup test";
    var option = "width = 500, height = 500, top = 100, left = 200, location = no"
    window.open(url, name, option);
}


</script>

<%
	request.setCharacterEncoding("UTF-8");

String userid = request.getParameter("userid"); // login.jsp에서 아이디값을 가져와 스트링 변수에 저장
String userpasswd = request.getParameter("userpasswd");

MemberDAO memberdao = new MemberDAO(); //맴버 다오 객체 생성 

int sessioncount = 0;

int check = memberdao.userCheck(userid, userpasswd); // DB에저장여부 확인
int exfirecheck = memberdao.userexfirestatus(userid);




if (exfirecheck == 999) {  // userexfirestatus에서 리턴받은 값이 999면
	System.out.println("exfirecheck 결과받음 : " + exfirecheck);

%>

	
<%	
}
%>

<%

if (exfirecheck == 2 ) { // userexfirestatus에서 리턴받은 값이 2면
%>
	<script>
	alert("귀하의 계정은 비밀번호 횟수 초과로 계정이 잠금처리 되었습니다 \n 아이디 비밀번호 찾기로 비밀번호를 재발급 해주세요");
	// history.back(); // 이전페이지로 이동 

	setTimeout(function() {
	popup(); 
	} , 1000);

	</script>
	
<meta http-equiv="Refresh" content="1; url=index.jsp">

	<%	
}
if (check == 1 && exfirecheck == 1) { // 로그인에 성공했고 exfire상태가 Y가 아니면

	session.setAttribute("userid", userid); // 세션 내장객체 메모리에 저장
	response.sendRedirect("index.jsp"); // 메인페이지로 이동
	memberdao.UserSuccess(userid);
	memberdao.userexfirestatus(userid);
	
%>	
	
<%
} else if (check == 0 ) {
%>
<script type="text/javascript">
	alert("비밀번호가 잘못되었습니다 \n 3회 이상 실패시 계정이 잠금처리 됩니다");
	 // history.back(); // 이전페이지로 이동 

</script>
	 <meta http-equiv="Refresh" content="2; url=Login.jsp">
	<%
	memberdao.UserSessionOver(userid); // 실패할때 마다 세션함수호출하여 값 insert 
	%>

<%
	}else{ // 받은 값이 -1이면 
%>
<script type="text/javascript">
	alert("그런 아이디는 없습니다 \n 회원가입을 해주세요");
	 history.back(); // 이전페이지로 이동 

</script>
<%
	}

%>