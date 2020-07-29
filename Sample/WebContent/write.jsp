<%@page import="board.BoardBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="member.MemberBean"%>
<%@page import="member.MemberDAO"%>

<jsp:useBean id="dao" class="member.MemberDAO"/>
<jsp:useBean id="bean" class="member.MemberBean"/>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%
request.setCharacterEncoding("UTF-8");
String pageNum = request.getParameter("pageNum");

String userid = (String) session.getAttribute("userid");
if (userid == null) // 로그인 안하면
	response.sendRedirect("Login.jsp"); // 바로 로그인으로 안내, 입구컷

	
%>

<html>
 <head>
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
        <form method = "post" action = "writePro.jsp?&pageNum=<%=pageNum%>">
        <table  style="padding-top:50px" align = center width=700 border=0 cellpadding=2 >
                <tr>
                	<td height=20 align= center bgcolor=#ccc>
                	<font color=white>글쓰기</font></td>
                </tr>
                <tr>
                <td bgcolor=white>
                <table class = "table2">
<!---------------------------------------------------------------------------------------------------------------------->                
                        <tr>
                        <td>작성자</td>
                        <td><%=userid %></td>
                        </tr>
 <!---------------------------------------------------------------------------------------------------------------------->
                        <tr>
                        <td>제목</td>
                        <td><input type = text name = "subject" size=60></td>
                        
                        </tr>
<!----------------------------------------------------------------------------------------------------------------------> 
                        <tr>
                        	<td>내용</td>
                      		<td>
                        <textarea name = "content" cols=85 rows=15 style="margin: 0px; width: 620px; height: 200px;">	</textarea>
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
                       			<input type = "submit" value="글쓰기">
                      			<input type="button" value="글목록" class="board_btn01" onclick="location.href='Board.jsp'"> 
                       		</div>
                        </center>
                </td>
                </tr>
        </table>
        </form>
</body>






 <jsp:include page="footer.jsp"/>

</html>