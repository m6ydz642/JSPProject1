<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="member.MemberDAO"%>
<%@page import="member.MemberBean"%>
<body>
join pro page
</body>
<%

	boolean check = false;
	
	request.setCharacterEncoding("UTF-8");


	//2. 요청한 값 얻기 (join.jsp에서 입력한 회원정보를 request영역에서 꺼내오기)
	//입력한 ID얻기
	// DB에서 일반 id는 가져오지 않는다. 오토인크리먼트로 만들어서 회원수가 몇명인지
	// 만들어놓기 전용이라서 (입력받을 항목이 아님)
	String userid = request.getParameter("userid");
	String userpasswd = request.getParameter("userpasswd");
	String name = request.getParameter("name");
	String gender = request.getParameter("gender");
	int phone = Integer.parseInt(request.getParameter("phone"));
	String email = request.getParameter("email");
	String address =  request.getParameter("address"); // 검색 완료된 주소 
	String address2 =  request.getParameter("address2"); // 나머지 주소 
	/////// reg_date는 얻어오지 않는다 (시스템에서 자동으로 되게 만들었기 때문에)

	////////// 넘어온값 
	out.print("넘어온값  아이디 : " + userid + "<br>");
	out.print("넘어온값 : 패스워드 " + userpasswd + "<br>");
	out.print("넘어온값 : 이름" +  name + "<br>");
	out.print("넘어온값 : 성" +  gender + "<br>");

	//3. 입력한 회원정보들을? MemberBean객체를 생성해서 각각의 변수에 저장
	MemberBean memberBean = new MemberBean();
	
	

	// setter메소드들을 호출하여  입력한 정보를 매개변수로 전달하여 MemberBean의 각변수에 저장
	memberBean.setUserid(userid); //setter메소드를 호출하여 입력한 아이디를 MemberBean의 id변수에 저장
	memberBean.setUserpasswd(userpasswd);
	memberBean.setName(name);
	memberBean.setGender(gender);
	memberBean.setPhone(phone);
	memberBean.setEmail(email);
	memberBean.setAddress(address);
	memberBean.setAddress2(address2);
	
	
	//4. DB와 연동하여  입력한 회원정보를 DB의 테이블에 추가 시키는 역할을 하는 DAO객체 생성 후 메소드 호출하여
		//   insert작업을 명령 해야 함.
		MemberDAO memberDAO = new MemberDAO();
			check= memberDAO.insertMember(memberBean); //메소드 호출시 위의 MemerBean객체 전달
			System.out.println("JoinPro에서 insert전달후 전달받은 값 : " + check );
				  
		if (check == true) {	
			
			
			session.setAttribute("userid", userid); // 회원가입시 입력받았던 userid로 로그인처리함	
			response.sendRedirect("index.jsp");// 쿼리에 insert후 (참이면) 회원가입에 성공 하면  login.jsp를 재요청(포워딩)하여 보여 주기
	

	%>
	<script>
		alert("반갑습니다 "+ userid + "님!"); 
	</script>		
<!-- 	<meta http-equiv="Refresh" content="2; url=index.jsp"> -->
<%		

	}else{
		System.out.println("if문 실행된 JoinPro값 : " + check );
%>
<script>
	alert("회원가입에 실패하였습니다 정보를 다시 확인해주세요");
	history.back();
</script>		
<%
	}
%>