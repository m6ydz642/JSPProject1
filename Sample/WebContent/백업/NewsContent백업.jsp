
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
// int contentnum = Integer.parseInt(request.getParameter("num")); //밑에 댓글까지 반영이 안되서 따로 한개 다시 만듦
int num = Integer.parseInt(request.getParameter("num"));
request.setCharacterEncoding("UTF-8");
NewsBoardDAO boardDAO = new NewsBoardDAO();
NewsBoardBean bean2 = boardDAO.getNewsBoard(num); // DB번호에서 num값 얻어옴 (글번호)
System.out.println("넘어온 게시글 num값 " + num);
//DB에 저장되어 있는 전체 글의 개수를 조회 하기 위해 
//BoardDAO의 getNewsBoardCount()메소드를 호출함
int count = boardDAO.getNewsBoardCount();
//System.out.println(count);

//하나의 페이지 마다 보여줄 글개수 5
int pageSize = 1;

//아래의쪽의 클릭한 페이지번호 얻기
String pageNum = request.getParameter("pageNum");

String userid = (String)session.getAttribute("userid"); // 사용자 아이디값

// String filename = bean2.getFilerealname(); // 썸내일 사용시 원본으로 쓸건데 필요없어서 일반으로 사용
String filename = bean2.getFilename();
	
//아래쪽에 클릭한 페이지번호가 존재하지 않으면(현재 선택한 페이지번호가 없으면)
//1페이지 가 화면에 보여야 하기 떄문에..
//pageNum을 1로 저장
if (pageNum == null) {
	pageNum = "1";
}

//현재 보여질(선택한)페이지번호  "1"을  -> 기본정수 1로 변경
int currentPage = Integer.parseInt(pageNum);

//각페이지 마다 첫번째로 보여질 시작 글번호 구하기
//(현재 보여질 페이지번호  - 1) * 한페이지당 보여줄 글개수 5
int startRow = (currentPage - 1) * pageSize;

//board테이블에 존재하는 모든 글을 조회하여 저장할 용도의 ArrayList배열객체를 담을 변수 선언
List<NewsBoardBean> list = null;
// List<NewsCommentBean> newslist = null;
//만약 board테이블에 글이 있다면
if (count > 0) {
	//board테이블에 존재하는 글을 검색해서 가져옴
	//				getBoardList(시작글번호,한페이지당보여줄글수)
	list = boardDAO.getNewsBoardList(startRow, pageSize);
	System.out.println(list.size());

}
%>


 
<%
/**************************************************************************************/
/*****************************뉴스 댓글 부분******************************************/
	
	
	NewsBoardDAO dao = new NewsBoardDAO();
	NewsBoardBean dto = dao.getNewsBoard(num); // 뉴스게시판 num전용

	NewsCommentBean combean = new NewsCommentBean();
	NewsCommentDAO comdao = new NewsCommentDAO();
	
	// int newscount = dao.getNewsBoardCount();

	// String pageNum = request.getParameter("pageNum"); // 안쓸거 같은데 일단 보류
	String subject = request.getParameter("subject");
	NewsBoardBean bBean = dao.getNewsBoard(num);
	
	int DBnum = bBean.getNum(); //조회한 글번호 
	String DBName = bBean.getUserid(); //조회한 작성자 
	// String DBName = combean.getId();
	int DBReadcount = bBean.getReadcount();//조회한 조회수
	
	// 댓글 객체 생성
	NewsCommentDAO cdao = new NewsCommentDAO(); // 뉴스 댓글전용
	int commentcount = dao.getNewsBoardCount(); // 뉴스보드 다오에 있는 객체를 가져옴띠

// 	List<NewsBoardBean> newslist = null;
/*****************************뉴스 댓글 부분 끝***************************************/
/**************************************************************************************/


/*************************************게시글 내용 부분 **********************************/
%>
<body class="default">


	<section class="MOD_BLOGROLL1">

	<div data-layout="_r">
		<%
		//만약 게시판 글개수가 조회 된다면
		if (count > 0) {
			//ArryList에 저장되어 있는 검색한 글정보들(BoardBean객체들)의 갯수 만큼 반복
			for (int i = 0; i < list.size(); i++) {
				//ArrayList의 각인덱스 위치에 저장 되어 있는 BoardBean객체를 ArrayList배열로부터 얻어
				//BoardBean객체의 각변수값들을getter메소드를 통해 얻어 출력
				NewsBoardBean bean = list.get(i);
		%>
		<div data-layout="ec12 fo10 fo-n2">
		
		
			<div class="MOD_BLOGROLL1_Single">

				<header> 
				<%-- <a href="javascript:return false;" onclick="location.href='NewsBoardContent.jsp?num=<%=bean.getNum()%>&pageNum=<%=bean.getNum()%>' return false" class="MOD_BLOGROLL1_SingleTitle" --%>
				<a href="NewsBoard.jsp?num=<%=bean.getNum()%>&pageNum=<%=Integer.parseInt(pageNum) %>" class="MOD_BLOGROLL1_SingleTitle"
					data-theme="_ts2">
					<!-- 한페이지로 다 표현할꺼라서 num값과 pageNum값을 통일함 -->
	
					<h2><%=bean.getSubject()%></h2>
				</a>
				<div class="MOD_BLOG1_Meta">
				글번호 : <%=bean.getNum() %>
					<p class="MOD_BLOG1_Author"><%=bean.getUserid()%>
					</p>
					<p>
						<b>Published</b> <span class="MOD_BLOG1_Date"><%=new SimpleDateFormat("yyyy.MM.dd").format(bean.getDate())%>
						</span> | <b>Categories</b> <span class="MOD_BLOG1_Cats"> <a
							href="#">Web Design</a> <a href="#">Web Develpment</a></span>
					</p>
				</div>

				</header>
				<div class="MOD_BLOGROLL1_Excerpt">
					<p><%=bean.getContent()%></p>
					<%if(request.getContextPath() != null) { // 사진 없이 업로드가 되었으면%>
					<img src="<%=request.getContextPath()%>/image/<%=URLEncoder.encode(filename,"UTF-8")%>" >
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
		} // for문
		} else {
		%>
		<tr>
			<td colspan="5">게시판 글 없음</td>
		</tr>
		<%
			}
		
		
		
		/*************************************게시글 내용 부분 끝 **********************************/		
		%>

	

<%
			List newslist = null;

			if (userid != null) {
		%>
<!--********************************************************************************************** -->
<!-- 댓글 부분 (글 내용에 같이 넣음) -->
<%if (count > 0) { %>
	<form action="NewsComment_Pro.jsp" method="post">
				<input type="hidden" name="ref" value="<%=dto.getNum()%>" > 
				<input type="hidden" name="page" value="<%=pageNum%>" > 
				<input type="hidden" name="id" value="<%=userid%>">
				
				<table class="comment">
					<tr>
						<td align="center" width="174">뉴스댓글</td>
						<td colspan="2">
							<textarea name="content" rows="3" cols="60"  style="width: 670px; align: center; padding: 15px;"></textarea>
								<input type="submit" name="register" value="댓글입력" class="board_btn01"> 
						</td>
					</tr>
				</table>
			</form>
		<%
	}  // count if문
} // 일반ß if문
			%>
		
		<div style="height: 20px;"></div>
	<%
			 if(count != 0 ){ 
				 newslist = cdao.getNewsBoardComment(num);//댓글 함수	
%>
<!--가져온부분 ************************************************************************** -->
		<table class="comment" style="width: 670px; align: center; border: 1px solid gray;">
			<%
				for (int j = 0; j < newslist.size(); j++) {
					NewsCommentBean cdto = (NewsCommentBean)newslist.get(j);

						// board 테이블에 있는 num값과 comment table에있는 ref 값이 같다면	
					if (dto.getNum() == cdto.getRef()) {
			%>
				<tr style="border-bottom: 1px solid gray;" id="testgood">
					<td align="center" width="20" height="30" bgcolor="#efeff5"><%=cdto.getNum()%>
					</td>
						<td align="center" width="150" height="30" bgcolor="#efeff5"><%=cdto.getId()%>
						</td>
							<td style="border-left: 1px solid gray;">&nbsp;&nbsp;<%=cdto.getContent()%>
							</td>
				
				<td width="30">
<%
	// 게시판 글 작성자 or 댓글 작성자인지 비교
	if (DBName.equals(userid) || cdto.getId().equals(userid)) {
%> <%-- 본인아이디 (<%=userid %>) 세션 확인용  --%>
<%-- (<%=cdto.getId() %>) --%>		
 	<img src="img/del.png" class="del"
		onclick="location.href='NewsCommentDelete_pro.jsp?NewscommentNum=<%=cdto.getNum()%>&pageNum=<%=Integer.parseInt(pageNum)%>&num=<%=dto.getNum()%>'">
<%-- 	onclick="location.href='commentDelete_pro.jsp?Newscomment.jsp?num=<%=cdto.getNum()%>&=<%=pageNum%>&num=<%=dto.getNum()%>'"> --%>
<%
	 }
%>
<script type="text/javascript">




</script>

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


		<div id="table_search">
		<button onclick="location.href='Newswrite.jsp'">글쓰기</button>
		</div>
		
	</div>



<!-- ----------------------------------------------------------------------------------------------- -->
<!-- 페이징 글 보여주는 부분 -->
	<div class="MOD_BLOGROLL1_Pagination">
        <ul>
        
<% 
if (count > 0) {
		
		if(count>0){
			int pageCount = count / pageSize+ ( count % pageSize == 0 ? 0:1);
			int pageBlock = 5;
			


				
			if(num > 1 ) { // 1페이지면
				
				for (int i = 0; i < list.size(); i++) {
					//ArrayList의 각인덱스 위치에 저장 되어 있는 BoardBean객체를 ArrayList배열로부터 얻어
					//BoardBean객체의 각변수값들을getter메소드를 통해 얻어 출력
					NewsBoardBean bean = list.get(i);
%>	

       		<li><a href="NewsBoard.jsp?num=<%=bean.getNum()-1%>">&xlArr; 이전</a></li> 

<%
   	}
   	

%>
          <li><a href="#">2</a></li>
          <li><a href="#">3</a></li>
          <li><a href="#">4</a></li>
          
           <%
 if(num < pageCount ) {
	 
 %>			
 			<li><a href="NewsBoard.jsp?num=<%=num+1 %>">다음 &xrArr; </a>
 
 			
 			<% } }%>
          <%-- <li><a href="javascript:return false;" onclick="location.href='NewsBoard.jsp?num=<%<%-- <%-- =bean.getNum()+1%>&pageNum=<%=bean.getNum()+1%>'">Next &xrArr;</a></li> --%>
        </ul>
      </div>
	</section>

<%

} } // 페이징 글부분 마지막 주석 
%>
<!-- 페이징 글 보여주는 부분 -->
<!-- ----------------------------------------------------------------------------------------------- -->



</body>
 <jsp:include page="footer.jsp"/>
</html>