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

<script type="text/javascript">
	test1 = document.getElementById("selected").value;
	console.log(test1);
</script>

<body>
        <form method = "post" action = "NewswritePro.jsp"  enctype="multipart/form-data">
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
     <p>카테고리 선택</p>
     
     
       				<select name="newscategory">
       				<!-- 	<option value="">전체뉴스</option> -->
       					<!-- 전체의경우 value를 null값으로 줘서 가져오게 함 -->
      				 	<option value="경제" >경제</option>
         				<option value="연예">연예</option>
         				<option value="it과학">it과학</option>
         				<option value="사회">사회</option>
         			</select>
         
 <!---------------------------------------------------------------------------------------------------------------------->
                        <tr>
                        <td>제목</td>
                        <td><input type = text name = "subject" size=60></td>
                        
                        </tr>
<!----------------------------------------------------------------------------------------------------------------------> 
                        <tr>
                        	<td>내용</td>
                      		<td>
                        <textarea name = "content" cols=85 rows=15 style="margin: 0px; width: 620px; height: 200px;"></textarea>
                        	</td>
                        </tr>
<!---------------------------------------------------------------------------------------------------------------------->                        
        				<td  colspan="2">
							<span id="id_sp2"> *최대 파일 크기는 100MB이하,확장자는 JPG,PNG만 올려주세요.</span></label>
							<input type="file"  name="file">
						</td>
<!---------------------------------------------------------------------------------------------------------------------->
                        
                        </table>
 
                        <center>
                     		<div id="table_search" style="float: none">
                       			<input type = "submit" value="글쓰기">
                      			<input type="button" value="글목록" class="board_btn01" onclick="location.href='NewsBoard.jsp?num=1'"> 
                       		</div>
                        </center>
                </td>
                </tr>
        </table>       
        </form>
         
            
</body>






 <jsp:include page="footer.jsp"/>

</html>