<%@page import="com.mysql.fabric.xmlrpc.base.Member"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="java.text.SimpleDateFormat"%>

<%@page import="java.util.List"%>
<%@page import="board.BoardBean"%>
<%@page import="board.BoardDAO"%>
<%@page import="board.CommentDAO"%>
<%@page import="board.CommentDTO"%>
<script src="https://code.jquery.com/jquery-2.2.1.js"></script>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<!--위에 문서타입 HTML4로 정의안하면 HTML5로 지정되는데 HTML5는 center태그경고떠서 선언함 -->

<jsp:include page="header.jsp"/>
<html>
<head>

<title>글속으로 들어왔습니다</title>
</head>
<body>



<%
	/*글 상세보기 페이지*/	
	request.setCharacterEncoding("UTF-8");
		int num = Integer.parseInt(request.getParameter("num"));
		String pageNum = request.getParameter("pageNum");
	//전달받은 글num을 이용하여 글을 검색 하기 위해 BoardDAO객체를 생성하고 
	BoardDAO dao = new BoardDAO();
	
	//하나의 글정보를 검색 하여 얻는다.
	//검색하는 하나의 글정보의 조회수를 1증가 시킨다.
	 dao.updateReadCount(num);
	 BoardBean bBean = dao.getBoard(num); // 매개변수에 num 넣어서 보내	
	 // String subject = request.getParameter("subject");
	
	
	
	
	 

	int DBnum = bBean.getNum(); //조회한 글번호 
	String DBName = bBean.getUserid(); // 작성자 
	int DBReadcount = bBean.getReadcount();//조회한 조회수
	
	//날짜형식을 조작할수 있는 SimpleDataFormat객체의 format()메소드 사용
	SimpleDateFormat f = new SimpleDateFormat("yyyy/MM/dd");
	Timestamp DBDate =  bBean.getDate();//조회한 작성일
	String newDate = f.format(DBDate);
	
	String subject = bBean.getSubject(); // 글제목 
	String DBContent = "";
	
	if(bBean.getContent() != null){//조회한 글내용이 존재하면
	
		//조회한 글내용을 변수에 저장. 단! 작성한 글내용중 엔터키로 줄바꿈 한것들을 똑같이 처리하여 반환			
		DBContent = bBean.getContent().replace("\r\n","<br/>");
	}
	
	
	String DBSubject = bBean.getSubject();//조회한 글제목

	//답변글에 사용되는 조회한 값들 얻기
	int DBRe_ref = bBean.getRe_ref(); //조회한 주글의 그룹번호
	int DBRe_lev = bBean.getRe_lev(); //조회한 주글의 들여쓰기 정도값
	int DBRe_seq = bBean.getRe_seq(); //주글들 내의  조회한 주글의 순서값
	
	/*******************************************************/
	// 댓글용
	CommentDAO cdao = new CommentDAO();
	int count = dao.getBoardCount();
	/*******************************************************/
	// 글 번호를 넘겨서 DB로부터 글 정보 가져오기
	BoardBean dto = dao.getBoard(num);
%> 
<%
//각각페이지에서 로그인후 현재 페이지로 이동해 올때  session내장객체 메모리에 값이 존재하는지
//존재하지 않는디 판단하여 아래의 search버튼만 보이게 하거나 search버튼과 글쓰기버튼을 모두 보이게 처리 하기

String userid = (String)session.getAttribute("userid");

//session영역에 값이 저장되어 있으면   글수정, 글삭제, 답글쓰기  버튼 보이게 설정
// if(id != null){
// 	if (userid == null) // 로그인 안하면
// 	response.sendRedirect("Login.jsp"); // 바로 로그인으로 안내
	
%>	


<center>
<table>

  <tr>
   <td>
    <table width="100%" cellpadding="0" cellspacing="0" border="0">
     <tr style="background:url('img/table_mid.gif') repeat-x; text-align:center;">
      <td width="5"><img src="img/table_left.gif" width="5" height="30" /></td>
      <td>내 용</td>
      <td width="5"><img src="img/table_right.gif" width="5" height="30" /></td>
     </tr>
    </table>
   <table width="500"> <!-- 기본값 413 -->
     <tr>
      <td width="0">&nbsp;</td>
      <td align="center" width="76">글번호</td>
      <td width="319"><%=num %></td>
      <td width="0">&nbsp;</td>
     </tr>
	 <tr height="1" bgcolor="#dddddd"><td colspan="4" width="407"></td></tr>
    <tr>
      <td width="0">&nbsp;</td>
      <td align="center" width="76">조회수</td>
      <td width="319"><%=DBReadcount %></td>
      <td width="0">&nbsp;</td>
     </tr>
	 <tr height="1" bgcolor="#dddddd"><td colspan="4" width="407"></td></tr>
    <tr>
      <td width="0">&nbsp;</td>
      <td align="center" width="76">아이디</td>
      <td width="319"><%=bBean.getUserid() %></td>
      <td width="0">&nbsp;</td>
     </tr>
     <tr height="1" bgcolor="#dddddd"><td colspan="4" width="407"></td></tr>
    <tr>
      <td width="0">&nbsp;</td>
      <td align="center" width="76">작성일</td>
      <td width="319"><%=DBDate%></td>
      <td width="0">&nbsp;</td>
     </tr>
      <tr height="1" bgcolor="#dddddd"><td colspan="4" width="407"></td></tr>
    <tr>
      <td width="0">&nbsp;</td>
      <td align="center" width="76">제목</td>
      <td width="319"><%=bBean.getSubject() %></td>
      <td width="0">&nbsp;</td>
     </tr>
     <tr height="1" bgcolor="#dddddd"><td colspan="4" width="407"></td></tr>
                <tr>
      <td width="0">&nbsp;</td>
                   <td width="399" colspan="2" height="200"> 
                  <%=bBean.getContent() %>
                </tr>
     <tr height="1" bgcolor="#dddddd"><td colspan="4" width="407"></td></tr>
     <tr height="1" bgcolor="#82B5DF"><td colspan="4" width="407"></td></tr>
     <tr align="center"> 
      <td width="0">&nbsp;</td>
      
      <td colspan="2" width="399">
      
<%
    	if (userid != null) {
%>
		<div id="table_search">
			<button onclick="location.href='write.jsp?&pageNum=<%=pageNum%>'">글쓰기</button>
<% } %>		

<% 		if (DBName.equals(userid)) { //본인이 쓴 글인지 확인후 글수정 버튼 활성화 %>
			<button onclick="location.href='update.jsp?num=<%=num%>'">글수정</button>
			
		<script>
	

function deletecontent() {
					
				
var result = confirm('글을 삭제하시겠습니까?'); 
	if(result) { //yes 
	location.replace("deletecontent.jsp?num=<%=num%>&pageNum=<%=pageNum%> "); // pagenum이랑 글 num같이 넘겨줌 
	} else { //no 
		alert("취소되었습니다");
	}
	
	}
	
	/*객체 위치 때문에 여기서 다이렉트로 선언함 ㅎ */

	
	
</script>
<%-- <button id="delete" onclick="location.href='delete.jsp?num=<%=num%>'">글삭제</button> --%>
<button id="delete" onclick="deletecontent();">글삭제</button>

</div>

<%
		}else{
			
			

		}

		
		
%>
<!-- 	<input type=button value="답글"> -->
<!-- <input type=button value="글목록"> -->
<!-- 	<input type=button value="수정"> -->
<!-- 	<input type=button value="삭제"> -->
	
<button onclick="location.href='Board.jsp?&pageNum=<%=pageNum%>'">글목록</button>
	

      <td width="0">&nbsp;</td>
     </tr>
    </table>  
   </td>
  </tr>
</center>
 </table>

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
				
				<table class="comment">
					 <!-- style="width: 300px; height:70px; align: center; padding: 15px;" 잠시 효과 삭제 -->
					 
					<tr>
						<td align="center" width="174">댓글</td>
						<td colspan="2">
							<textarea name="content" rows="3" cols="60" style="margin: 0px; width: 298px; height: 111px;"></textarea>
							<!--  공백때문에 붙임 -->
							<input type="submit" name="commentwrite" value="댓글입력" class="board_btn01"> 
						</td>
					</tr>
				</table>
			</form>
		<%
				}else{
					%>
					<td align="center" width="174">로그인후에 댓글을 작성하실 수 있습니다</td>
					<% 
				}
			%>
		<div style="height: 20px;"></div>
	<%
			 if(count!=0){ 
				 list = cdao.getBoard(num);	
%>
<!--가져온부분 ************************************************************************** -->
		<table class="comment" style="width: 670px; align: center; border: 1px solid gray;">
			<%
				for (int i = 0; i < list.size(); i++) {
						CommentDTO cdto = (CommentDTO) list.get(i);

						// board 테이블에 있는 num값과 comment table에있는 ref 값이 같다면	
						if (dto.getNum() == cdto.getRef()) {
			%>
			<tr style="border-bottom: 1px solid gray;">
					<td align="center" width="20" height="30" bgcolor="#efeff5"><%=cdto.getNum()%>
					</td>
						<td align="center" width="150" height="30" bgcolor="#efeff5"><%=cdto.getId()%>
					</td>
					<td style="border-left: 1px solid gray;">&nbsp;&nbsp;<%=cdto.getContent()%>
					</td>
					<td width="30">
<%
						// 게시판 글 작성자 or 댓글 작성자만 삭제 아이콘이 뜸 
						// 만약에 삭제를 비정상적으로 하려고 commentDelete.pro로 직접접속해서 하려는 경우 
						// 거기서도 세션 확인 절차를 거쳐서 사전에 차단해야함
%>						
<script>
function deletecomment() {
	/*객체 위치 때문에 여기서 다이렉트로 선언함 ㅎ */
				
var result = confirm('댓글을 삭제하시겠습니까?'); 
	if(result) { //yes 
	location.replace("commentDelete_pro.jsp?commentNum=<%=cdto.getNum()%>&pageNum=<%=pageNum%>&num=<%=dto.getNum()%>"); 
	<%-- location.href='commentDelete_pro.jsp?commentNum=<%=cdto.getNum()%>&pageNum=<%=pageNum%>&num=<%=dto.getNum()%>' --%>
	} else { //no 
		alert("취소되었습니다");
	}
	
	}	
</script>
<%	
			if (DBName.equals(userid) || cdto.getId().equals(userid)) {
%> 
					<img src="img/del.png" class="del" width="20px" height="20px"
					onclick="deletecomment();"> 
<%					//코멘트 객체생성해서 코맨트의 Num값을 가져옴 (글 Num값 아님)
 	}
 %>
				</td>
				<td align="center" width="100" bgcolor="#efeff5"
					style="border-left: 1px solid gray;"><%=cdto.getReg_date()%>
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

</div>


<!--********************************************************************************************** -->	


<!------------------------------------------------------------------------------------------>
<!-- 댓글창 이걸로 변경예정 
아니다 바꾸기 귀찮다 다음에 ㅋㅋ-->
<%-- <div class="container">
		<form id="commentForm" name="commentForm" method="post">
			<br>
			<br>
			<div>
				<div>
					<span><strong>Comments</strong></span> <span id="cCnt"></span>
				</div>
				<div>
					<table class="table">
						<tr>
							<td><textarea style="width: 1100px" rows="3" cols="30"
									id="comment" name="comment" placeholder="댓글을 입력하세요"></textarea>
								<br>
								<div>
									<a href='#' onClick="fn_comment('${result.code }')"
										class="btn pull-right btn-success">등록</a>
								</div></td>
						</tr>
					</table>
				</div>
			</div>
			<input type="hidden" id="b_code" name="b_code"
				value="${result.code }" />
		</form>
	</div>
	<div class="container">
		<form id="commentListForm" name="commentListForm" method="post">
			<div id="commentList"></div>
		</form>
	</div> --%>
<!------------------------------------------------------------------------------------------>
<!-- 댓글창 이걸로 변경예정 -->

</body>
<jsp:include page="footer.jsp"/>
</html>