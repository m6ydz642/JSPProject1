<%@page import="newsboard.NewsCommentBean"%>
<%@page import="newsboard.NewsCommentDAO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<% 
// 뉴스 댓글 삭제 기능

int NewscommentNum = Integer.parseInt(request.getParameter("NewscommentNum")); 
// commetnum은 content.jsp 에 241번줄에서 댓글 객체를 가져와서 댓글 num값 가져오는거 해놓은걸 한번더 가져오는거
int num = Integer.parseInt(request.getParameter("num")); 
int pageNum = Integer.parseInt(request.getParameter("pageNum")); 
String userid = (String) session.getAttribute("userid"); // 세션에서 돌아다니는 userid 값 확인


NewsCommentDAO newsdao = new NewsCommentDAO();
NewsCommentBean newsdto = new NewsCommentBean();

newsdto.setId(userid); // setter에게 넘어온 userid 값 세팅 해줌
// 세팅안했다가 계속 null값 나와서 삽질함 ㅡ.ㅡ 


String DBName = newsdto.getId(); // 댓글작성자를 게터로 부터 가져옴


int check = newsdao.deleteNewsComment(NewscommentNum, userid);  // 코맨트에서 넘어온 번호와 userid, 인자 2개  전달

// 변수선언과 동시에 삭제 함수 실행, 참이던 거짓이던 해당 값 반환 
// 거짓이면 댓글이 없다는 뜻

if (check == 1) { // 번호가 존재해서 참이면
	if(DBName.equals(userid)) { // 댓글 사용자와 넘어와 userid 값이 일치하면
%>
<script>
	alert("삭제 완료");
	location.href="NewsContent.jsp?num=<%=num%>&pageNum=<%=pageNum%>";
	// 삭제후 이전에 받아왔던던 num값, 즉 원래 있던 게시물 안으로 다시 이동
	// num값 받아오는 여부는 아래에서 확인함
</script>	
<% 
	}else{
	%>
	<script>
	alert("비정상적인 접근 입니다 으~~~~~딜!!"); // 세션 id값이랑 db값이 안맞는경우 
											// 즉, 어떤 사용자가 commentDelete_pro.jsp?num값 주소로 직접 접근 할경우
	history.back();
	</script>
	<%
		
	}
}else{
	%>
	<script>
	
	alert("본인 댓글이 아닌데요?");
	history.back();
	</script>
<% 
}

/************************************************************************/
// 번호 가져오는지 확인
/* System.out.println("댓글 commentNum : \n" + commentNum);
System.out.println("글번호 : \n" + num);
System.out.println("페이지 번호 : \n" + pageNum);
System.out.println("넘어온 유저값: \n" + userid);
System.out.println("넘어온 DB 유저값: \n" + DBName);


out.print("댓글 코맨트 넘버값 " + commentNum + "<br>");
out.print("글번호 " + num + "<br>");
out.print("페이지 번호" + pageNum + "<br>");
out.print("넘어온 유저값: " + userid + "<br>");
out.print("넘어온 DB유자값 : " + DBName + "<br>"); */
/************************************************************************/
%>