<%@page import="java.math.BigInteger"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
    
    <%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.List"%>
<%@page import="money.MoneyBean"%>
<%@page import="money.MoneyDAO"%>




<html>
<head>
<jsp:include page="header.jsp"/>
<title>Insert title here</title>


       
</head>
<!-- <style type="text/css">
	.hide {
	right: 100px;
	}
</style>


        <form name="" action="" method="" >
          <div class="formRow">     
            <label for="MOD_BLOG1_EmailField" class="hide">Search </label><input id="MOD_BLOG1_EmailField" type="text" placeholder="Search">
          </div>
          <button type="submit" class="btn">검색하기</button>
        </form>
        -->

<%
	MoneyDAO boardDAO = new MoneyDAO();

	//DB에 저장되어 있는 전체 글의 개수를 조회 하기 위해 
	//BoardDAO의 getBoardCount()메소드를 호출함
	int count = boardDAO.getMoneyBoardCount();
	//System.out.println(count);
	
	//하나의 페이지 마다 보여줄 글개수 5
	int pageSize = 1;
		
	//아래의쪽의 클릭한 페이지번호 얻기
	String pageNum = request.getParameter("pageNum");
	
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
		list = boardDAO.getmoneyBoardList(startRow,pageSize);
		System.out.println(list.size());   
	}	
	
	
%> 
	
	<%
/**************************************************************************************/
/*****************************뉴스 댓글 부분******************************************/
	int num = Integer.parseInt(request.getParameter("num"));

	MoneyDAO dao = new MoneyDAO();
	MoneyBean dto = dao.getMoneyBoard(num); // 뉴스게시판 num전용, 댓글이랑 헷깔리면 안됨

	int newscount = dao.getMoneyBoardCount();

	String newspageNum = request.getParameter("pageNum"); // 안쓸거 같은데 일단 보류
	// String subject = request.getParameter("subject");
	MoneyBean bBean = dao.getMoneyBoard(num);
	
	int DBnum = bBean.getNum(); //조회한 글번호 
	// String DBName = bBean.getUserid(); //조회한 작성자 
	// int DBReadcount = bBean.getReadcount();//조회한 조회수
	
	// 댓글 객체 생성
	MoneyDAO cdao = new MoneyDAO(); // 
	int commentcount = dao.getMoneyBoardCount(); // 뉴스보드 다오에 있는 객체를 가져옴띠

// 	List<NewsBoardBean> newslist = null;
/*****************************투자 부분 끝***************************************/

/**************************************************************************************/
%>

<!-- money.jsp?num=1&pageNum=1 -->

<%
if(count > 0){
	//ArryList에 저장되어 있는 검색한 글정보들(BoardBean객체들)의 갯수 만큼 반복하는데..
	for(int i=0; i<list.size(); i++){
		//ArrayList의 각인덱스 위치에 저장 되어 있는 BoardBean객체를 ArrayList배열로부터 얻어
		//BoardBean객체의 각변수값들을getter메소드를 통해 얻어 ~ 출력~
		MoneyBean bean = list.get(i);
		
	
		
// 		 out.print("회사이름 : " + bean.get회사이름() + "<br>");
// 		 out.print("매출액 : " + bean.get매출액()  + "<br>" );
	
	String 회사이름 = bean.get회사이름();
	Long 유동부채 = bean.get유동부채();
	Long 유동자산 = bean.get유동자산();
 	Long 매출액 = bean.get매출액();
 	
 	
 	
 	/******************************************************/
 	// 계산 공식 구해놓기 
 	Long 유동비율 = (유동자산 /  유동부채) * 100; // 유동비율 구하는 공식
 /* 	Long 자본잠식 = (자본금 - 자본총계) / 자본금; // 자본잠식 구하는 공식 
 	Long 영업이익 = 매출액 - (매출원가 + 판매관리비) * 100; // 영업이익구하는 공식 
 	Long 부채비율 = (유동부채 + 비유동부채) / 자기자본 * 100; // */ 
 	
 	/******************************************************/
%>

	 
 
   
	<body>
	<center>
		<table border="1">
		<td>
		<h3> 회사이름 : <%= 회사이름 %> (주) </h3> 
		<h4>※ 경고 : 판단 항목에서 3가지 이상이 기준미달일경우 투자에 신중하시기 바랍니다 </h4>
		<h4>※ 투자판단 결과는 다음과 같습니다  </h4>
		<p style="margin-left:200px"> 회사개요 : <b>뭐하는 회사인지 모름</b> </p>
		
		<p>매출액 : <%= 매출액%> 원 </p> 
		<p>유동자산 <%= 유동자산 %>원 </p> 
	
	<% if( 유동비율 >= 200 ) { // 200퍼센트 이상이면 
	%>
		<p>유동비율 <font color="green"><%= 유동비율 %></font>% ---> 유동비율 기준을 만족합니다 (권장사항 200% 이상)</p>
		
		<p>유동비율 <%= 유동비율 %> 원 </p>
		<%
	}else{	
		%>
		<p>유동비율 <font color="red"><%= 유동비율 %></font> % 입니다 투자에 주의하세요---> 유동비율 기준을 만족하지 않습니다 (권장사항 200% 이상)</p>
<% 
	}
%>
	<p>유동부채 <%= 유동부채 %>원 </p> 
	
		
		</td>


		</center>
		<!-- 
		  <form name="" action="" method="" >
          <div class="formRow">     
            <label for="MOD_BLOG1_EmailField" class="hide">Search </label><input id="MOD_BLOG1_EmailField" type="text" placeholder="Search">
          </div>
          <button type="submit" class="btn">검색하기</button>
        </form>
         -->
	</table>
	
        
	
	
	
	
	<%
	/******************************************************/
		}
		} else {
	%>
		<td>글이 없어용</td>
<%	
	}
/******************************************************/
%>



</body>

<jsp:include page="footer.jsp"/>

</html>