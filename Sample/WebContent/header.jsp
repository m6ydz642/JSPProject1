<%@page import="newsboard.NewsBoardBean"%>
<%@page import="newsboard.NewsBoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<html>
<head>

	
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">


<a href="index.jsp"> 
<!-- <img src="img/papercompany.jpg" width="300" height="100"> -->
</a>


<table width="1000" height="5">
		<tr>
			<td align="right" colspan="5">
				<a>테스트 </a>
			
			</td>
		</tr>
	</table>
	
	
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>Aperitif - Custom Template</title>

	<link rel="stylesheet" href="assets/css/style.min.css">
	<link rel="stylesheet" href="assets/css/modules.css">

	<!-- Canonical URL usage -->
	<link rel="canonical" href="https://aperitif.io/">

	<!-- Facebook Open Graph -->
	<meta property="og:url"                content="https://aperitif.io/" />
	<meta property="og:title"              content="Aperitif | The web template generator" />
	<meta property="og:description"        content="Aperitif is a rapid web template generation tool." />
	<meta property="og:image"              content="https://aperitif.io/img/aperitif-facebook.png" />
	<meta property="og:image:width"        content="1200" />
	<meta property="og:image:height"       content="630" />

	<!-- Twitter Cards -->
	<meta name="twitter:card" content="summary_large_image">
	<meta name="twitter:site" content="@Aperitif">
	<meta name="twitter:creator" content="@Aperitif">
	<meta name="twitter:title" content="Aperitif - The web template generator">
	<meta name="twitter:description" content="Aperitif is a rapid web template generation tool.">
	<meta name="twitter:image" content="https://aperitif.io/img/aperitif-card.png">

	<!-- Google Structured Data -->
	<script type="application/ld+json">
	{
	"@context" : "http://schema.org",
	"@type" : "SoftwareApplication",
	"name" : "Aperitif",
	"image" : "https://aperitif.io/img/aperitif-logo.svg",
	"url" : "https://aperitif.io/",
	"author" : {
	  "@type" : "Person",
	  "name" : "Octavector"
	},
	"datePublished" : "2017-MM-DD",
	"applicationCategory" : "HTML"
	}
	</script>
</head>

<body class="default">



<section class="MOD_MENU" data-theme="_bgp" >
  <div data-layout="_r" class="nopadding">
    <nav class="MOD_MENU_Nav">
      <p class="MOD_MENU_Title">Menu</p>
      <svg class="MOD_MENU_Button" xmlns:xlink="http://www.w3.org/1999/xlink" x="0px" y="0px" width="30px" height="30px" viewBox="0 0 30 30" enable-background="new 0 0 30 30" xml:space="preserve">
        <rect width="30" height="6"/>
        <rect y="24" width="30" height="6"/>
        <rect y="12" width="30" height="6"/>
      </svg>
      <ul class="AP_Menu_List">
      
               
         
	
        <li>
          <a href="index.jsp" data-theme="_bgp">HOME</a>
        </li>
        
           <li>
          <a href="introuce.jsp" data-theme="_bgp">소개</a>
          <!-- money.jsp?num=1&pageNum=1 -->
        </li>
        
        <li>
          <a href="money.jsp?pageNum=1" data-theme="_bgp">IR투자분석</a>
          <!-- money.jsp?num=1&pageNum=1 -->
          
        </li>
        <li>
          <a href="Board.jsp" data-theme="_bgp">Board</a>
        <li>
        <%NewsBoardDAO dao = new NewsBoardDAO();
       //  dao.getNewsBoardSeq(); // 최신 글번호 얻어오기
       // newsboard 게시판을 클릭시 조회된 마지막 순서의 값, 즉 최신 번호를 가져온다
        %>
     <%--      <a href="NewsBoard.jsp?num=<%=dao.getNewsBoardSeq()%>"    data-theme="_bgp">NewsBoard</a> --%>
     <a href="NewsBoard.jsp?newssearch=&newscategory=&pageNum=1"    data-theme="_bgp">NewsBoard</a>
     <!--  처음부터 null값 줘서 전체 검색되게 함 -->
     
     
     
          <!-- pagenum부분 필요없어서 뺌 -->
<%--       null값 오류나서 무조건 글자1번 먼저--%>


        </li>
        <li>
          <a href="#" data-theme="_bgp">Customer</a>
        </li>
        <li>
          <a href="#" data-theme="_bgp">Other</a>
          <ul>
            <li>
              <a href="#" data-theme="_bgpd">Sub-Menu Item</a>
            </li>
            <li>
              <a href="#" data-theme="_bgpd">Sub-Menu Item long title</a>
            </li>
            <li>
              <a href="#" data-theme="_bgpd">Sub-Menu Item</a>
            </li>
             
          </ul>
          
          <ul>
            <li>
              <a href="#" data-theme="_bgpd">Sub-Menu Item</a>
            </li>
            <li>
              <a href="#" data-theme="_bgpd">Sub-Menu Item long title</a>
            </li>
            <li>
              <a href="#" data-theme="_bgpd">Sub-Menu Item</a>
            </li>
    

          </ul>
   
        </li>
           <li>
           <!--  나중에 로그인 안되어있을때는 나오고 로그인 되어있으면 
           logout으로 바꿔야 함 -->
           <%
           String userid = (String)session.getAttribute("userid"); // 세션에저장되어있는 userid값 가져옴 
           if (userid == null) { // userid가 넘어온게 없으면
        	%>
        <li> 	   
        	   <a href="Login.jsp" data-theme="_bgp">Login</a>
        </li>
         <li>
          <a href="Join.jsp" data-theme="_bgp">Join</a>
        </li>
        
        
<script type="text/javascript">
function popup(){
    var url = "Findidpw/Findidpw.jsp";
    var name = "popup test";
    var option = "width = 500, height = 500, top = 100, left = 200, location = no"
    window.open(url, name, option);
}
</script>
        <div style="text-align: right">
		<div> <a href="" onclick="popup();">아이디/비밀번호 찾기</a> </div>
	</div>  

					<%
						} else {
					%>
        <li>
          <a href="Logout.jsp" data-theme="_bgp">Logout</a>
          
        </li>
       
         <li>
          <a href="pass_check.jsp" data-theme="_bgp">Welcome <%=userid%></a>
        </li>
       
        <% } %>
      </ul>

				
			</nav>
  </div>
</section>

<script src="assets/js/index.js"></script>
					

</body>
</html>