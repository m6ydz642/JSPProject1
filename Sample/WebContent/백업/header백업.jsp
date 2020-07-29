<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>

			
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>



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
          <a href="template.jsp" data-theme="_bgp">HOME</a>
        </li>
        <li>
          <a href="#" data-theme="_bgp">Menu Item</a>
          
        </li>
        <li>
          <a href="Board.jsp" data-theme="_bgp">Board</a>
        <li>
          <a href="Test2.jsp" data-theme="_bgp">NewsBoard</a>
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
        <%
           }else{ 
        %>
        <li>
          <a href="Logout.jsp" data-theme="_bgp">Logout</a>
          
        </li>
        
         <li>
          <a href="MyPage.jsp" data-theme="_bgp">Welcome <%=userid%></a>
        </li>
        <% } %>
      </ul>

				
			</nav>
  </div>
</section>

<script src="assets/js/index.js"></script>
					

</body>
</html>