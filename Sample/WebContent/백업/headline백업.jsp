<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@page import="java.text.SimpleDateFormat"%>
<%@page import="board.BoardBean"%>
<%@page import="java.util.List"%>
<%@page import="board.BoardDAO"%>

<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>

<%
	BoardDAO boardDAO = new BoardDAO();

	//DB에 저장되어 있는 전체 글의 개수를 조회 하기 위해 
	//BoardDAO의 getBoardCount()메소드를 호출함
	int count = boardDAO.getBoardCount();
	//System.out.println(count);
	
	//하나의 페이지 마다 보여줄 글개수 5
	int pageSize = 5;
		
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
	List<BoardBean> list = null;
	
	//만약 board테이블에 글이 있다면
	if(count > 0){
		//board테이블에 존재하는 글을 검색해서 가져옴
		//				getBoardList(시작글번호,한페이지당보여줄글수)
		list = boardDAO.getBoardList(startRow,pageSize);
		System.out.println(list.size());   
	}	
%> 


<body>

  <div data-layout="_r">
    <div data-layout="ec12 fo10 fo-n2">
      <div class="MOD_BLOGROLL1_Single">
  
  
  <%--글꼴용 --%>
     
<%
//만약 게시판 글개수가 조회 된다면(게시판에 글이 저장 되어 있다면)
if(count > 0){
	//ArryList에 저장되어 있는 검색한 글정보들(BoardBean객체들)의 갯수 만큼 반복하는데..
	for(int i=0; i<list.size(); i++){
		//ArrayList의 각인덱스 위치에 저장 되어 있는 BoardBean객체를 ArrayList배열로부터 얻어
		//BoardBean객체의 각변수값들을getter메소드를 통해 얻어 ~ 출력~
		BoardBean bean = list.get(i);
%>

        <header>
        
<!--         																		헤드라인제목으로 다시만들꺼 -->
          <a href="#" class="MOD_BLOGROLL1_SingleTitle" data-theme="_ts2"><h2><%= bean.getSubject() %></h2></a>
          <div class="MOD_BLOG1_Meta">
          <p class="MOD_BLOG1_Author"><%=bean.getName()%></p>
            <p><b>Published</b> <span class="MOD_BLOG1_Date"><%=new SimpleDateFormat("yyyy.MM.dd").format(bean.getDate())%>
            </span> | <b>Categories</b> <span class="MOD_BLOG1_Cats"><a href="#">Web Design</a> <a href="#">Web Develpment</a></span></p>
          </div>
        </header>
        <div class="MOD_BLOGROLL1_Excerpt">
          <p> <%=bean.getContent() %></p>
        </div>
      </div>

       
          <%
				} 
				} else {
			%>
			<tr>
				<td colspan="5">게시판 글 없음</td>
			</tr>
			<% }%>
			
  
      
      
      
</body>
</html>