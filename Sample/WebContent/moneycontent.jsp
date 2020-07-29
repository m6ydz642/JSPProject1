<%@page import="java.math.BigInteger"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
    
    <%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.List"%>
<%@page import="money.MoneyBean"%>
<%@page import="money.MoneyDAO"%>

<!-- 투자판단페이지 내부 -->


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
	
/*************************************************************************************/
// DB에 있는 자료들 가져와서 변수로 저장
	String 회사이름 = bean.get회사이름();
	Long 매출액 = bean.get매출액();
	Long 유동부채 = bean.get유동부채();
	Long 유동자산 = bean.get유동자산();
 	Long 자본금 = bean.get자본금();
 	Long 자본총액 = bean.get자본총액();
 	Long 매출원가 = bean.get매출원가();
 	Long 판매관리비 = bean.get판매관리비();
 	Long 비유동부채= bean.get비유동부채();
 	Long 자산총계 = bean.get자산총계();
 	Long 자본총계 = bean.get자본총계();
 	Long 부채총계 = bean.get부채총계();
 	Long 주식발행수 = bean.get주식발행수();
 	Long 당기순이익 = bean.get당기순이익();
 	Long 시가총액 = bean.get시가총액();

 	int moneycount=0; // 투자적합한지 횟수 세기
 	/*************************************************************************************/ 	
 	
 	/******************************************************/
 	// 계산 공식 구해놓기 및 공식값 적어놓는 곳 
 	float 유동비율 = ((float)유동자산 /  (float)유동부채) * 100; // 유동비율 구하는 공식
 	float 자본잠식률 = ((float)자본금 - (float)자본총액) / (float)자본금 * 100; // 자본잠식 구하는 공식 
 	Long 매출총이익 = 매출액 - 매출원가; // 매출총이익 구하는 공식
 	
 	Long 영업이익 = 매출총이익 - 판매관리비; // 영업이익구하는 공식
 	float 영업이익률 = (((float)영업이익/ (float)매출액) * 100); // float로 변환안했다가 계속 0나와서 삽질함 ㅡ.ㅡ

 	Long 자기자본 = 자산총계 - 부채총계; /**/
 	float 부채비율 = ((float)유동부채 + (float)비유동부채) / (float)자기자본 * 100; // 
 	
 	Long EPS = 당기순이익 / 주식발행수;
 //	float 자기자본률 = ((float)자기자본 / (float)총자산) * 100; // 아 이거 좀 헷깔려서 잠시 보류 
 	
 
 	float ROE = (Long)당기순이익 / (float)자기자본 * 100;
 
 	float PER = (float)시가총액 / (float)당기순이익;
 	
 	
 	// 판매 총이익 대비 판매비와 관리비 비율
 	float 판매관리비율 = ((float)판매관리비 / (float)매출총이익) * 100;
 	/* 

매출 - 매출원가 = 매출총이익

매출총이익 - 판관비 = 영업이익
*/
 
 	/*
 	Long 부채비율 = (유동부채 + 비유동부채) / 자기자본 * 100; // 
 	
 	
 	매출액 - 매출원가 = 매출총이익
 			매출총이익률 = 매출총이익 / 매출액 * 100
 			(30%이하인경우 경고)
 		/*	
 			
 	EPS(주당순이익) = 당기순이익 / 주식발행수(회계에 나와있음)
 	현재주가 (그때그때 변동됨) /  (당기순이익 / 주식발행수) 해서 나온 결과
 	
 	
 	PER = 시가총액 / 당기순이익
 	ROE = (당기순이익 / 자본총액) = (EPS / BPS) = (PBR / PER)
 	
 	
 	*/ 
 	
 	
 	/******************************************************/
%>

	 
 
   
	<body>
	<center>
		<table border="1">
		<td>
		<h3> 회사이름 : <%= 회사이름 %>(주) </h3> 
		<h4>※ 경고 : 판단 항목에서 3가지 이상 기준미달일경우 투자에 주의하시기 바라며 <br> <font color="red">투자에 참고용으로만 사용하세요</font></h4>
		<h4>※ 투자판단 결과는 다음과 같습니다  </h4>
		<hr>
		<p > 회사개요 : <b><%=bean.get회사개요() %></b> </p>
		<p> 대표자 <%=bean.get대표자() %></p>
		<p> 보고서 범위 <%=bean.get범위() %> </p>
		<!-- style="margin-left:200px" -->
		<hr>
		<p>매출액 : <%= 매출액%> 원 </p> 
<%-- 		<p>유동자산 <%= 유동자산 %>원 </p>  --%>
	
	<% if( 유동비율 >= 150 ) { // 200퍼센트 이상이면 
	%>
		<p>유동비율 <font color="green"><%= 유동비율 %></font>% --- 유동비율 기준이 양호합니다 (권장사항 200% 이상)</p>
		<%
	}else{	
		moneycount++; // 기준에 어긋나면 경고점수 추가
		%>
		<p>유동비율 <font color="red"><%= 유동비율 %></font> % 입니다 투자에 주의하세요 --- 유동비율 기준을 만족하지 않습니다 (권장사항 200% 이상)</p>
<%-- 	<p> <%=moneycount%> 횟수 추가  </p> --%>
	
<% 

	}
%>

	<%if (자본잠식률 <= 1)  { // 10%이상이면 경고, 아 모르고 거꾸로함 ㅡ.ㅡ%>
		<p>자본잠식률 <font color="green"><%=자본잠식률%></font>% 입니다  ---- 자본잠식률이 <font color="green"><%=자본잠식률%>%</font>이므로 양호합니다(권장사항 0~1%)</p>

	<%}else{ // 10%이상이면 주의 %>
	<p>자본잠식률 <font color="red"><%=자본잠식률%></font>% 입니다  ---- 자본잠식률이 <font color="red"><%=자본잠식률%>%</font>이므로 위험합니다(권장사항 0%)</p>
	<%moneycount++; // 기준에 어긋나면 경고점수 추가 
	}%>

	
		<%if (영업이익률 >= 30)  { // 20%이상이면 양호 %>
	<p>영업이익률 <font color="green"><%=영업이익률%></font>% 입니다  ---- 영업이익률이 <font color="green"><%=영업이익률%>%</font>이므로 양호합니다(권장사항 20~100이상%)</p>
		<%}else{ moneycount++; %>
	<p>영업이익률 <font color="red"><%=영업이익률%></font>% 입니다  ---- 영업이익률이 <font color="red"><%=영업이익률%>%</font>이므로 주의가 필요합니다(권장사항 20~100이상%)</p>	
		<%}%>


	<%if (부채비율 <=70)  { // %>
	<p>부채비율 <font color="green"><%=부채비율%></font>% 입니다  ---- 부채비율이 <font color="green"><%=부채비율%>%</font>이므로 양호합니다(※ 업종에 따라다름))</p>
		<%}else{ moneycount++; %>
	<p>부채비율 <font color="red"><%=부채비율%></font>% 입니다  ---- 부채비율이 <font color="red"><%=부채비율%>%</font> (철강, 항공, 선박의 경우 100% 안으로 왔다갔다 합니다) <br> 부채율이 조금 높으므로 주의가 필요합니다(※ 업종에 따라다름)</p>	
		<%}%>
		
		
	<%if (EPS >= 20)  { // %>
	<p>EPS(주당순이익) <font color="green"><%=EPS%></font> 입니다  ---- EPS(주당순이익)이 <font color="green"><%=EPS%></font>입니다 (※ 권장사항 없음) )</p>
		<%}else{ moneycount++; %>
	<p>EPS(주당순이익) <font color="red"><%=EPS%></font> 입니다  ---- EPS(주당순이익)이 <font color="red"><%=EPS%></font>이므로 비율이 낮습니다 (마이너스이면 적자상태) </p>	
		<%}%>

	<%if (ROE >=5)  { // %>
	<p>ROE(자기자본이익률) <font color="green"><%=ROE%></font> 입니다  ---- ROE(자기자본이익률)이 <font color="green"><%=ROE%></font>입니다 (※ 권장사항 5~10이상 높을수록 좋음) )</p>
		<%}else{ moneycount++; %>
	<p>ROE(자기자본이익률) <font color="red"><%=ROE%></font> 입니다  ---- ROE(자기자본이익률)이 <font color="red"><%=ROE%></font> 이므로 비율이 낮습니다 (※ 권장사항 5~10이상 ) (마이너스이면 적자상태) </p>	
		<%}%>


	<%if (PER >= 5 && PER<=30)  { // %>
	<p>PER(주가수익률) <font color="green"><%=PER%></font> 입니다  ---- PER(주가수익률)이 <font color="green"><%=PER%></font>입니다 <br> 기업이 저평가 되어있는것 같네요 ~ (높을수록 기업의 가치가 고평가)<br> (마이너스이면  <font color="red">적자상태 </font>) <br> (※ 권장사항 없음, 바이오 기업은 PER이 높을수 있음) </p>
		<% }else{  %>
	<p>PER(주가수익률) <font color="red"><%=PER%></font> 입니다  ---- PER(주가수익률)이 <font color="red"><%=PER%></font> 입니다 좀  고평가 된것 같네요(마이너스이면 적자상태) </p>	
		<%moneycount++; } %>

<!-- 매출총이익 대비 판매관리비와 관리비 비율 -->
	<%if (판매관리비율 >= 5 && 판매관리비율 <=30)  { // %>
	<p>매출총이익 대비 판매비와 관리비 비율은 <font color="green"><%=판매관리비율%>%</font> 입니다  ---- 판매관리비율 <font color="green"><%=판매관리비율%></font>입니다 <br> 낮을수록 좋음 <br> (마이너스이면  <font color="red">적자상태 </font>) <br> (※ 권장사항 20%~50%)</p>
		<% }else{  %>
	<p>매출총이익 대비 판매비와 관리비 비율은<font color="red"><%=판매관리비율%>%</font> 입니다  ---- 판매관리비율 <font color="red"><%=판매관리비율%></font> 입니다 (마이너스이면 적자상태),(※ 권장사항 20%~50%) </p>	
		<%moneycount++; } %>

<!-- -->



<!-- 점수가 나올경우 -->
<!-- ----------------------------------------------------------------------------------------------- -->
	<% if(moneycount >= 4) { // 4점 이상일 경우 %>
		<h3><%= 회사이름 %>(주) 회사의 종목 진단결과 경고점수는 총 <font color="red"> <%=moneycount%>점</font>입니다 투자에 주의하세요</h3>
		<%}else{ %>
		<h3><%= 회사이름 %>(주) 회사의 종목 진단결과 경고점수는 총 <font color="green"> <%=moneycount%>점</font>입니다 회계상으론 크게 문제가없지만 투자에 신중하세요</h3>
		<%} %>
		
			
	
		
		
		
		
		
		
		
		
		
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
		} // 위에 for문
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