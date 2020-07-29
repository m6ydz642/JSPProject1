<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
    <%@page import="java.util.List"%>
<%@page import="newsboard.NewsBoardBean"%>
<%@page import="newsboard.NewsBoardDAO"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="newsboard.NewsCommentBean" %>
<%@page import="newsboard.NewsCommentDAO" %>


<!-- 여기서 다시 해야겠다  -->
<%
 /***************************************************************/
 //글 상세보기
int num = Integer.parseInt(request.getParameter("num"));
String pageNum = request.getParameter("pageNum");

 String pageNumtest = request.getParameter("pageNum");
 
 	System.out.println(num + "넘어온 num값");
 	//String num = request.getParameter("num");
 	
 	// String pageNum = request.getParameter("pageNum");
 	String subject = request.getParameter("subject");

	NewsBoardDAO dao = new NewsBoardDAO();
 	 NewsBoardBean bBean = dao.getNewsBoard(num);

 	int DBnum = bBean.getNum(); //조회한 글번호 
 	String DBName = bBean.getUsername(); //조회한 작성자 
 	int DBReadcount = bBean.getReadcount();//조회한 조회수
 	
 	//날짜형식을 조작할수 있는 SimpleDataFormat객체의 format()메소드 사용
 	SimpleDateFormat f = new SimpleDateFormat("yyyy/MM/dd");
 	Timestamp DBDate =  bBean.getDate();//조회한 작성일
 	String newDate = f.format(DBDate);
 	
 	String DBSubject = bBean.getSubject();//조회한 글제목

 	//답변글에 사용되는 조회한 값들 얻기
 	int DBRe_ref = bBean.getRe_ref(); //조회한 주글의 그룹번호
 	// int DBRe_lev = bBean.getRe_lev(); //조회한 주글의 들여쓰기 정도값
 	int DBRe_seq = bBean.getRe_seq(); //주글들 내의  조회한 주글의 순서값
 	String userid = (String) session.getAttribute("userid");
 	// 나중에 댓글용으로 수정할 예정

 	
 	//전달받은 글num을 이용하여 글을 검색 하기 위해 BoardDAO객체를 생성하고 
 
 	
 	NewsCommentDAO cdao = new NewsCommentDAO(); // 뉴스 댓글전용
 	
 	NewsBoardBean dto = dao.getNewsBoard(num); // 뉴스게시판 num전용, 댓글이랑 헷깔리면 안됨
 	int count = dao.getNewsBoardCount();
 %> 


<!--********************************************************************************************** -->
<%
			List list = null;

			if (userid != null) {
		%>
<!--********************************************************************************************** -->
<!-- 댓글 부분 (글 내용에 같이 넣어야 됨) -->
	<form action="comment_pro.jsp" method="post">
				<input type="hidden" name="ref" value="<%=dto.getNum()%>" > 
				<input type="hidden" name="page" value="<%=pageNum%>" > 
				<input type="hidden" name="id" value="<%=userid%>">
				
				<table class="comment" style="width: 670px; align: center; padding: 15px;">
					<tr>
						<td align="center" width="174">댓글</td>
						<td colspan="2">
							<textarea name="content" rows="3" cols="60" 
							style="margin: 0px; width: 298px; height: 111px;">
							</textarea>
								<input type="submit" name="register" value="댓글입력" class="board_btn01"> 
						</td>
					</tr>
				</table>
			</form>
		<%
				}
			%>
		<div style="height: 20px;"></div>
	<%
			 if(count!=0){ 
				 list = cdao.getNewsBoardComment(num);//댓글 함수	
%>
<!--가져온부분 ************************************************************************** -->
		<table class="comment" style="width: 670px; align: center; border: 1px solid gray;">
			<%
				for (int j = 0; j < list.size(); j++) {
						NewsCommentBean cdto = (NewsCommentBean)list.get(j);

						// board 테이블에 있는 num값과 comment table에있는 ref 값이 같다면	
						if (dto.getNum() == cdto.getRef()) {
			%>
			<tr style="border-bottom: 1px solid gray;">
				<td align="center" width="150" height="30" bgcolor="#efeff5"><%=cdto.getId() %></td>
				<td align="center" width="150" height="30" bgcolor="#efeff5"><%=cdto.getNum()%>
				</td>
				
				<td style="border-left: 1px solid gray;">&nbsp;&nbsp;<%=cdto.getContent()%>
				</td>
				<td width="30">
					<%
						// 게시판 글 작성자 or 댓글 작성자만 삭제 가능
			if (DBName.equals(userid) || cdto.getId().equals(userid)) {
					%> <img src="img/del.png" class="del"
					onclick="location.href='commentDelete_pro.jsp?Newscomment.jsp?num=<%=cdto.getNum()%>&=<%=pageNum%>&num=<%=dto.getNum()%>'"> <%
 	}
 %>
				</td>
				<td align="center" width="100" bgcolor="#efeff5">
 					style="border-left: 1px solid gray;"><%=cdto.getReg_date()%>  <!-- 날짜부분 잠시 보류 -->
				</td> 
			</tr>

			<%
				}
			}
			%>
		</table>
		<%
		 }
		%>


</body>
</html>