
<%@page import="board.BoardBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>  


<%@page import="member.MemberBean"%>
<%@page import="member.MemberDAO"%>
<%@page import="board.BoardDAO"%>
<%@page import="board.BoardBean"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="java.text.SimpleDateFormat"%>

<!-- <!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd"> -->



<%
request.setCharacterEncoding("UTF-8");
// response.setContentType("text/html;charset=UTF-8");

String userid = (String) session.getAttribute("userid");
String content = request.getParameter("content");
	
int num = Integer.parseInt(request.getParameter("num"));
String pageNum = request.getParameter("pageNum");

if (userid == null) {// 로그인 안하면
	response.sendRedirect("Login.jsp"); // 바로 로그인으로 안내, 입구컷
}


 
BoardDAO dao = new BoardDAO();


 dao.updateReadCount(num); //  지금 안함
 BoardBean bBean = dao.getBoard(num); // num  pageNum 가져오기



int DBnum = bBean.getNum(); //조회한 글번호 
String DBName = bBean.getUserid(); // 작성자, DB에서 한번 확인

//날짜형식을 조작할수 있는 SimpleDataFormat객체의 format()메소드 사용
SimpleDateFormat f = new SimpleDateFormat("yyyy/MM/dd");
Timestamp DBDate =  bBean.getDate();//조회한 작성일
String newDate = f.format(DBDate);

String subject = bBean.getSubject(); // 글제목 
String DBContent = bBean.getContent(); // 글내용

if (DBName.equals(userid)) { // 본인아이디인지 세션과 비교함, 혹시나 주소로 강제로 접근할경우 대비 (어짜피 DB 에서 검수함)
							// 과정 확인용도
	
		System.out.println(userid + "님이 글을 수정하러 들어왔습니다");
}else{
	System.out.println("글 수정 부분에서 " + userid+ "님으로 부터 " + "비정상적인 접근 감지");
}


%>

<html>
 <head>
 <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">


 <jsp:include page="header.jsp"/>
 <title>게시판</title>
 
 </head>
 
<style>
        table.table2{
                border-collapse: separate;
                border-spacing: 1px;
                text-align: left;
                line-height: 1.5;
                border-top: 1px solid #ccc;
                margin : 20px 10px;
        }
        table.table2 tr {
                 width: 50px;
                 padding: 10px;
                font-weight: bold;
                vertical-align: top;
                border-bottom: 1px solid #ccc;
        }
        table.table2 td {
                 width: 100px;
                 padding: 10px;
                 vertical-align: top;
                 border-bottom: 1px solid #ccc;
        }
 
</style>


<body>
<% 
 if (DBName.equals(userid)){
%>
       <form method = "post" action = "update_pro.jsp?num=<%=num %>"   > 
        <table  style="padding-top:50px" align = center width=700 border=0 cellpadding=2 >
                <tr>
                	<td height=20 align= center bgcolor=#ccc>
                	<font color=white>Write</font></td>
                </tr>
                <tr>
                <td bgcolor=white>
                <table class = "table2">
<!---------------------------------------------------------------------------------------------------------------------->                
                        <tr>
                        <td>UserID</td>
                        <td><%=userid %></td>
                        </tr>
 <!---------------------------------------------------------------------------------------------------------------------->
                        <tr>
                        <td>Subject</td>
                        <td><input type = text name = "subject" size=60 value="<%=subject %>"></td>
                        
                        </tr>
<!----------------------------------------------------------------------------------------------------------------------> 
                        <tr>
                        	<td>Content</td>
                      		<td>
                        		<textarea name = "content" cols=85 rows=15 style="margin: 0px; width: 620px; height: 200px;"><%=DBContent %></textarea>
                        	</td>
                        </tr>
<!---------------------------------------------------------------------------------------------------------------------->                        
           <!--         <tr> <!--익명으로 안남기고 작성자 아이디가 갈 수 있게
                        <td>비밀번호</td>
                        <td><input type = password name = pw size=10 maxlength=10></td>
                        </tr> -->
<!---------------------------------------------------------------------------------------------------------------------->
                        
                        </table>
 
                        <center>
                     		<div id="table_search" style="float: none">
                       		 <input type = "submit" value="write"> 
                 
                      			<input type="button" value="boardlist" class="board_btn01" onclick="location.href='Board.jsp'"> 
                       		</div>
                        </center>
                </td>
                </tr>
        </table>
        </form>
<% } %>       
</body>






 <jsp:include page="footer.jsp"/>

</html>