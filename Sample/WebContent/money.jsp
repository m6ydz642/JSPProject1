<%-- <%@page import="com.sun.javafx.fxml.BeanAdapter"%> --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.List"%>
<%@page import="money.MoneyDAO"%>
<%@page import="money.MoneyBean"%>

<jsp:include page="header.jsp" />

<%@ page import="java.io.PrintWriter"%>

<!-- <link rel= "stylesheet" type="text/css" href="Board.css"> -->
<!-- css자꾸 충돌해서 직접 가져옴 --> 
<style>
.sub_news, .sub_news th, .sub_news td {
	border: 0
}

.sub_news a {
	color: #383838;
	text-decoration: none
}

.sub_news {
	width: 100%;
	border-bottom: 1px solid #999;
	color: #666;
	font-size: 12px;
	table-layout: fixed
}

.sub_news caption {
	display: none
}

.sub_news th {
	padding: 5px 0 6px;
	border-top: solid 1px #999;
	border-bottom: solid 1px #b2b2b2;
	background-color: #f1f1f4;
	color: #333;
	font-weight: bold;
	line-height: 20px;
	vertical-align: top
}

.sub_news td {
	padding: 8px 0 9px;
	border-bottom: solid 1px #d2d2d2;
	text-align: center;
	line-height: 18px;
}

.sub_news .date, .sub_news .hit {
	padding: 0;
	font-family: Tahoma;
	font-size: 11px;
	line-height: normal
}

.sub_news .title {
	text-align: left;
	padding-left: 15px;
	font-size: 13px;
}

.sub_news .title .pic, .sub_news .title .new {
	margin: 0 0 2px;
	vertical-align: middle
}

.sub_news .title a.comment {
	padding: 0;
	background: none;
	color: #f00;
	font-size: 12px;
	font-weight: bold
}

.sub_news tr.reply .title a {
	padding-left: 16px;
	background: url(첨부파일/ic_reply.png) 0 1px no-repeat
}
</style>
<!-- css자꾸 충돌해서 직접 가져옴 --> 

<html>
<head>

<%
	MoneyDAO boardDAO = new MoneyDAO();

	//DB에 저장되어 있는 전체 글의 개수를 조회 하기 위해 
	//BoardDAO의 getBoardCount()메소드를 호출함
	int count = boardDAO.getMoneyBoardCount();
	//System.out.println(count);
	
	//하나의 페이지 마다 보여줄 글개수 5
	int pageSize = 5;
		
	//아래의쪽의 클릭한 페이지번호 얻기
	String pageNum = request.getParameter("pageNum");
	String moneysearch = request.getParameter("moneysearch");
	

	//아래쪽에 클릭한 페이지번호가 존재하지 않으면(현재 선택한 페이지번호가 없으면)
	//1페이지 가 화면에 보여야 하기 떄문에..
	//pageNum을 1로 저장
	if(pageNum == null){
		pageNum = "1";
	}
	
	//현재 보여질(선택한)페이지번호  "1"을  -> 기본정수 1로 변경
	int currentPage = Integer.parseInt(pageNum);
	
	//각페이지 마다 첫번째로 보여질 시작 글번호 구하기
	//(현재 보여질 페이지번호  - 1) * 한페이지당 보여줄 글개수 5
	int startRow = (currentPage - 1) * pageSize;
	
	//board테이블에 존재하는 모든 글을 조회하여 저장할 용도의 ArrayList배열객체를 담을 변수 선언
	List<MoneyBean> list = null;
	
	//만약 board테이블에 글이 있다면
	if(count > 0){
		//board테이블에 존재하는 글을 검색해서 가져옴
		//				getBoardList(시작글번호,한페이지당보여줄글수)
		list = boardDAO.getmoneyBoardList(startRow,pageSize); // 검색인자도 같이넣어 moneydao에서 처리함
		System.out.println("투자게시판 사이즈 : " + list.size());   
		
	}	
%> 
<body>
	<table class="sub_news" border="1" cellspacing="0"
		summary="게시판의 글제목 리스트">
		<caption>게시판 리스트</caption>
		<colgroup>
			<col>
			<col width="110">
			<col width="100">
			<col width="80">
		</colgroup>
		<thead>
			<tr>
				<th scope="col">회사이름</th>
				 <th scope="col">구분</th>
				<th scope="col">범위</th>
				<th scope="col">대표자</th> 
				<th scope="col">글번호</th> 
				<th scope="col">종류</th> 
			</tr>
		</thead>
		<tbody>
			<tr>
			<%
//만약 게시판 글개수가 조회 된다면(게시판에 글이 저장 되어 있다면)
if(count > 0){
	//ArryList에 저장되어 있는 검색한 글정보들(BoardBean객체들)의 갯수 만큼 반복하는데..
	for(int i=0; i<list.size(); i++){
		//ArrayList의 각인덱스 위치에 저장 되어 있는 BoardBean객체를 ArrayList배열로부터 얻어
		//BoardBean객체의 각변수값들을getter메소드를 통해 얻어 ~ 출력~
		MoneyBean bean = list.get(i);
%>
<tr onclick="location.href='moneycontent.jsp?num=<%=bean.getNum()%>&pageNum=<%=bean.getNum()%>'">
<!-- 글안으로 들어갔을때
 -->
				<td class="title">
				<a href="#"><%= bean.get회사이름()%>(주)</a> 
				
				
			<!-- 	<img width="13" height="12" class="pic" alt="첨부이미지" src="첨부파일 ic_pic.gif"> -->
			 <!-- 	<a class="comment" href="#">[5]</a>  댓글 부분-->
			<!-- 	<img width="10" height="9"
					class="new" alt="새글" src="첨부파일/ic_new.gif"> -->
					
				</td>
				
				<td class="username"><%=bean.get구분() %></td> 
			 
			<td class="date"><%=bean.get범위()%></td> 
			
			<td class="name"><%=bean.get대표자()%></td>
			<td class="num"><%=bean.getNum()%></td>
			<td class="cate"><%=bean.get종류()%></td>
				<%-- <td><%=new SimpleDateFormat("yyyy.MM.dd").format(bean.getDate())%></td> --%>
			<%-- 	<td class="count"><%=bean.get() %></td> --%>
			</tr>
			<%
				} 
				} else {
			%>
			<tr>
				<td colspan="5">게시판 글 없음</td>
			</tr>
			<% }%>




		</tbody>
	</table>
	<%
		//각각페이지에서 로그인후 현재 페이지로 이동해 올때  session내장객체 메모리에 값이 존재하는지
		//존재하지 않는디 판단하여 아래의 search버튼만 보이게 하거나 search버튼과 글쓰기버튼을 모두 보이게 처리 하기

		String userid = (String) session.getAttribute("userid");

		//session영역에 값이 저장되어 있으면  글쓰기 버튼 보이게 설정
		// 로그인이 안되어있으면 글을 못쓰게 한다는 의미
		if (userid != null) {
	%>
	<div id="table_search">
		<!-- 	<input type="button" value="글쓰기" class="btn"
					onclick="location.href='write.jsp'" /> -->
		<button onclick="location.href='moneywrite.jsp'">글쓰기</button>
	<%} %>	
<div class="MOD_BLOGROLL1_Pagination">
        <ul>
<%
int pageCount = count / pageSize+ ( count % pageSize == 0 ? 0:1);
if(count>0){

int pageBlock = 5;
// 한 화면(블럭)에 보여줄 페이지 수 +1
int startPage=((currentPage/pageBlock)-(currentPage%pageBlock==0?1:0))*pageBlock+1;

 int endPage = startPage+pageBlock-1;

   			if(Integer.parseInt(pageNum) > 1 ) { // 1페이지면
 %>   
       		 <li><a href="money.jsp?pageNum=<%=Integer.parseInt(pageNum)-1%>&moneysearch=<%=moneysearch%>">&xlArr; 이전</a></li> 
       		<%-- <li><a href="money.jsp?pageNum=<%=Integer.parseInt(pageNum)-1%>&moneysearch=<%=moneysearch%>">&xlArr; 이전</a></li> --%>
           <!-- Sample/Board.jsp?pageNum=2 -->
<%
   	}
   	

   			for (int i = startPage; i<=endPage; i++) {
%>

          	<li><a href="money.jsp?pageNum=<%=i%>"> <%=i%></a></li>

 
 <%
    			}
		 if(Integer.parseInt(pageNum) < pageCount ) {
 %>			
 			<li><a href="money.jsp?pageNum=<%=Integer.parseInt(pageNum)+1%>&moneysearch=<%=moneysearch%>">다음 &xrArr; </a></li>
          
        </ul>
      </div>
<%}
 }%>	
		
		<!--웹으로 DB정보 작성하게 할 생각임 (회원가입처럼)  -->
	</div>
	
		<form action="moneyboardSearch.jsp">
  			<div class="formRow">
            <label for="MOD_BLOG1_EmailField" class="hide">Search </label>
            <input id="MOD_BLOG1_EmailField" type="text" placeholder="검색할 회사를 입력하세요" name="moneysearch">
         	<!-- <input class="board_btn01" type="button" value="검색" onclick="location.href='moneyboardSearch.jsp'"> -->
         	<button onclick="location.href='moneyboardSearch.jsp'" >검색</button>
       			
       				<select name="moneycategory">
       					<option value="">전체</option>
       					<!-- 전체의경우 value를 null값으로 줘서 가져오게 함 -->
      				 	<option value="사업보고서">사업보고서(1년 전체)</option>
      				 	<option value="1분기">1분기</option>
         				<option value="2분기">2분기</option>
         				<option value="3분기">3분기</option>
         				<option value="4분기">4분기</option>
         				<option value="전반기">전반기</option>
         				<option value="후반기">후반기</option>
         			</select>
         		
         		<!-- div밖으로 select 넣으면 밑으로 해서 나옴 -->	
       			</div>
      			
          	
          	
          	  		
         </form>
         
         	
        
        
</body>
<jsp:include page="footer.jsp" />
</html>



