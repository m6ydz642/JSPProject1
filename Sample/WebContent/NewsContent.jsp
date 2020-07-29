<%@page import="java.net.URLEncoder"%>
<%@page import="board.BoardBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="newsboard.NewsBoardBean"%>
<%@page import="newsboard.NewsBoardDAO"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="newsboard.NewsCommentBean" %>
<%@page import="newsboard.NewsCommentDAO" %>
<script src="https://code.jquery.com/jquery-2.2.1.js"></script>


<html>
<head>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>뉴스 글 페이지</title>

</head>
<jsp:include page="header.jsp" /> 

<%

/* 뉴스 보드의 경우 게시판 개념을 없애고 바로 글내용으로 연결되게 함

Board + Content = 뉴스페이지임

*/
/*글 상세보기 페이지*/	
request.setCharacterEncoding("UTF-8");
	int num = Integer.parseInt(request.getParameter("num"));
	String pageNum = request.getParameter("pageNum");
//전달받은 글num을 이용하여 글을 검색 하기 위해 BoardDAO객체를 생성하고 
NewsBoardDAO dao = new NewsBoardDAO();

//하나의 글정보를 검색 하여 얻는다.
//검색하는 하나의 글정보의 조회수를 1증가 시킨다.
// dao.updateReadCount(num); //  지금 안함
 NewsBoardBean bBean = dao.getNewsBoard(num); // 매개변수에 num 넣어서 보내기
 // String subject = request.getParameter("subject");




 

int DBnum = bBean.getNum(); //조회한 글번호 
String DBName = bBean.getUserid(); // 작성자 
int DBReadcount = bBean.getReadcount();//조회한 조회수

//날짜형식을 조작할수 있는 SimpleDataFormat객체의 format()메소드 사용
SimpleDateFormat f = new SimpleDateFormat("yyyy/MM/dd");
Timestamp DBDate =  bBean.getDate();//조회한 작성일
String newDate = f.format(DBDate);

String subject = bBean.getSubject(); // 글제목 
String Content = bBean.getContent();
String DBContent = "";
String newscategory = request.getParameter("newscategory");

if(bBean.getContent() != null){//조회한 글내용이 존재하면

	//조회한 글내용을 변수에 저장. 단! 작성한 글내용중 엔터키로 줄바꿈 한것들을 똑같이 처리하여 반환			
	DBContent = bBean.getContent().replace("\r\n","<br/>");
}


String DBSubject = bBean.getSubject();//조회한 글제목

//답변글에 사용되는 조회한 값들 얻기
int DBRe_ref = bBean.getRe_ref(); //조회한 주글의 그룹번호
// int DBRe_lev = bBean.getRe_lev(); //조회한 주글의 들여쓰기 정도값
int DBRe_seq = bBean.getRe_seq(); //주글들 내의  조회한 주글의 순서값


/*******************************************************/
// 댓글용
NewsCommentDAO cdao = new NewsCommentDAO();
 int count = dao.getNewsBoardCount();
/*******************************************************/
// 글 번호를 넘겨서 DB로부터 글 정보 가져오기
NewsBoardBean bean = dao.getNewsBoard(num);

String userid = (String)session.getAttribute("userid");

String filename = bean.getFilename();

%>


 
<%


/*************************************게시글 내용 부분 **********************************/
%>
<body class="default">


	<section class="MOD_BLOGROLL1">

	<div data-layout="_r">
	
		<div data-layout="ec12 fo10 fo-n2">
		
		
			<div class="MOD_BLOGROLL1_Single">

				<header> 
		
					<h2><%=bean.getSubject()%></h2>
				</a>
				<div class="MOD_BLOG1_Meta">
				글번호 : <%=num %>
					<p class="MOD_BLOG1_Author"><%=bean.getUserid()%>
					</p>
					<p>
						<b>Published</b> <span class="MOD_BLOG1_Date"><%=new SimpleDateFormat("yyyy.MM.dd").format(bean.getDate())%>
						</span> | <b>Categories</b> <span class="MOD_BLOG1_Cats"> 
						<a href="NewsBoard.jsp?pageNum=<%=pageNum%>&newssearch=&newscategory=<%=bean.getNewscategory()%>"><%=bean.getNewscategory()%></a> </span>
					</p>
<!-- 							http://localhost:8080/Sample/NewsBoard.jsp?newssearch=&newscategory=%EC%82%AC%ED%9A%8C -->
						</div>

				</header>
				<div class="MOD_BLOGROLL1_Excerpt">
					<p><%=bean.getContent()%></p>
					<%if(request.getContextPath() != null) { // 사진 없이 업로드가 되었으면%>
					<img src="<%=request.getContextPath()%>/uploadimage/<%=URLEncoder.encode(filename,"UTF-8")%>" >
					<!--   null이 아니라면 img경로 가져와서 사용자한테 보여줌 -->
					<% 
					}else{
						
						
						%>
						<p>사진이 없네요</p>
						<%
					}
					
						%>
					
				</div>
			</div>


		</div>
		

	
		<%
			
		
		
		
		/*************************************게시글 내용 부분 끝 **********************************/		
		%>

	

	<%
			List list = null;

			if (userid != null) {
		%>
<!--********************************************************************************************** -->
<!-- 댓글 부분 (글 내용에 같이 넣어야 됨) -->
	<form action="NewsComment_Pro.jsp" method="post">
				<input type="hidden" name="ref" value="<%=bean.getNum()%>" > 
				<input type="hidden" name="page" value="<%=pageNum%>" > 
				<input type="hidden" name="id" value="<%=userid%>">
				
				<table class="comment">
					 <!-- style="width: 300px; height:70px; align: center; padding: 15px;" 잠시 효과 삭제 -->
					 
					<tr>
						<td align="center" width="174">댓글</td>
						<td colspan="2">
							<textarea name="content" rows="3" cols="60" style="margin: 0px; width: 298px; height: 111px;"></textarea>
							<!--  공백때문에 붙임 -->
							<input type="submit" name="register" value="댓글입력" class="board_btn01"> 
						</td>
					</tr>
				</table>
			</form>
		<%
				}else{
			%>
			<td align="center" width="">로그인후에 댓글을 작성하실 수 있습니다</td>		
			<%
				}
			%>
		<div style="height: 20px;"></div>
	<%
			 if(count!=0){ 
				 list = cdao.getNewsBoardComment(num);	
%>
<!--가져온부분 ************************************************************************** -->
		<table class="comment" style="width: 670px; align: center; border: 1px solid gray;">
			<%
				for (int i = 0; i < list.size(); i++) {
						NewsCommentBean cdto = (NewsCommentBean) list.get(i);

						// board 테이블에 있는 num값과 comment table에있는 ref 값이 같다면	
						if (bean.getNum() == cdto.getRef()) {
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
	location.replace("NewsCommentDelete_pro.jsp?NewscommentNum=<%=cdto.getNum()%>&pageNum=<%=pageNum%>&num=<%=bean.getNum()%>"); 
	<%-- onclick="location.href='NewsCommentDelete_pro.jsp?NewscommentNum=<%=cdto.getNum()%>&pageNum=<%=pageNum%>&num=<%=bean.getNum()%>'">  --%>
	} else { //no 
		alert("취소되었습니다");
	}
	
	}	
</script>

<%						
			if (DBName.equals(userid) || cdto.getId().equals(userid)) {
				// 세션 아이디랑 DB등록된 사용자 비교해서 본인꺼 맞아야 삭제 활성화 
				// 주소타고 들어가도 삭제 불가
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

<!--********************************************************************************************** -->


<%



%>
		</table>
	
	<%
 	if (userid != null) {
	%>

		<div id="table_search">
		<button onclick="location.href='Newswrite.jsp'">글쓰기</button>
		</div>
	
	<%} %>
	</div>



<!-- ----------------------------------------------------------------------------------------------- -->
<!-- 페이징 글 보여주는 부분 -->






<!-- 페이징 글 보여주는 부분 -->
<!-- ----------------------------------------------------------------------------------------------- -->



</body>
 <jsp:include page="footer.jsp"/>
</html>