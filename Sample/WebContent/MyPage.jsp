<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.List"%>
<%@page import="member.MemberBean"%>
<%@page import="member.MemberDAO"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%
request.setCharacterEncoding("UTF-8");
/************************************************************************************/
// 패스워드 수정시 필요한 영역
	String userid = (String) session.getAttribute("userid"); // 세션값 그대로 가져옴
 	// pass_checkPro 에서 확인후 가져올용도 
	// String userpasswd = (String) session.getAttribute("userpasswd"); // 확인안하면 그냥 마이페이지 주소로 올경우 들어와짐
	String userpasswd = request.getParameter("pass_check");
	String mypagecheck = request.getParameter("mypagecheck"); // myPageCheck로 부터 넘어온 페이지

/************************************************************************************/

// int num = Integer.parseInt(request.getParameter("num")); 
// int pageNum = Integer.parseInt(request.getParameter("pageNum")); 



MemberDAO dao2 = new MemberDAO();
MemberBean bean2 = new MemberBean();
int exfirecheck = dao2.userexfirestatus(userid);



// String DBName = bean2.getUserid(); // 댓글작성자를 게터로 부터 가져옴


int check = dao2.userCheck(userid, mypagecheck); // 유저 아이디는 세션 , 비밀번호는 DB저장된 값을 가져옴
												// 현재 접속된 세션 아이디+ DB에 저장된 유저비밀번호를 비교함
												// 세션 아이디는 123인데 비밀번호가 123의 아이디가 아니면 
												// 다른 방법으로 접근을 한것으로 간주, 거짓으로 처리
System.out.println("mypage check값 : " + check);
// System.out.println("DBName 값 : " + DBName);
System.out.println("mypagecheck (비밀번호) 값 : " + mypagecheck); 
System.out.println("MyPageuserid (아이디)값 : " + userid);
// System.out.println("Userpasswd값 : " + userpasswd);

// 변수선언과 동시에 삭제 함수 실행, 참이던 거짓이던 해당 값 반환 
// 거짓이면 댓글이 없다는 뜻



/************************************************************************************/
// 일반정보 수정 영역
/* MemberDAO dao = new MemberDAO();
MemberBean bean = dao.getmember(userid); // userid 인자 가져오기

int phone = bean.getPhone();
String address = bean.getAddress(); // 카카오 API로 겅색해오는 메인 주소 
String address2 = bean.getAddress2(); // 나머지 주소 
String email = bean.getEmail(); */



/************************************************************************************/

%>

<%-- <jsp:useBean id="cp" class="member.MemberBean" /> <!-- 자바코드 안쓰고 태그로 bean 가져오기  --> --%>
<%-- 	<jsp:setProperty property="*" name="cp" />  --%>
	
<%--   <jsp:forward page="MyPagePro.jsp"/> --%>

<script type="text/JavaScript" src="http://code.jquery.com/jquery-1.7.min.js"></script>

<script type="text/JavaScript" src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
	
<script type="text/javascript">

		function openDaumZipAddress() {// 카카오 API 

			new daum.Postcode({

				oncomplete:function(data) {

					jQuery("#postcode1").val(data.postcode1);

					jQuery("#postcode2").val(data.postcode2);

					jQuery("#zonecode").val(data.zonecode);

					jQuery("#address").val(data.address);

					jQuery("#address2").focus();

					console.log(data);

				}

			}).open();

		}
		
		function checkPass() { // 비밀번호 입력시 확인해주는 영역 
			if($("#pass").val() != "") { // 공백이 아니라면 
				if($("#pass").val() != $("#pass2").val() ) {
					$("#passCheck").css("color", "red"); // 비밀번호 다르면 빨간색으로 변경 
					$("#passCheck").text("비밀번호가 달라요");
					pass_Check = false;
				}else{
					$("#passCheck").css("color", "green"); 
					$("#passCheck").text("비밀번호가 동일합니다");
				pass_Check = true;
				}
				
				}else{
					$("#passCheck").text("");
				}
			}
		
		function checkForm() {
			if(!pass_Check) {
				alert("비밀번호가 다릅니다");
				$("#pass").focus();
				return false;
			}
		}


		function popup(){ // 아이디 비밀번호 찾기 팝업
		    var url = "Findidpw/Findidpw.jsp";
		    var name = "popup test";
		    var option = "width = 500, height = 500, top = 100, left = 200, location = no"
		    window.open(url, name, option);
		}
	
	</script>
<jsp:include page="header.jsp" />
<%  

/************************************************************************************/
// 마이페이지 접속시 기존 정보 로딩 항목
// 회원정보 수정시 데이터들은  pass_checkPro 에서 처리함

MemberDAO dao = new MemberDAO(); 
MemberBean bean = dao.getmember(userid); // 아이디만 일단 넣으면 DB에서 쿼리 검색해서 나머지 같이 바로 가져옴 
String name = bean.getName();
String gender = bean.getGender();
int phone = bean.getPhone();
String email = bean.getEmail();
String address = bean.getAddress();
String address2 = bean.getAddress2();
/************************************************************************************/
%>




<body>

	<%
		if (userid != null && check != -1 && check != 0 ) { 
												// 유저아이디가 null이 아니고, check 값이 -1도 아닌 
												// 0도 아닌 값이면, 1만을 참으로 판단
		out.print(userid + "님 반갑습니다");
	%>
	

	<p><%=userid%>
		님의 마이페이지 입니다
		
	<%-- 	넘어온 pass값 <%= mypagecheck %> --%>
	</p>
	<%
		} else {
	%>
	<p>
		정보가 확인되지 않습니다 <br> 으딜^^
	</p>
	<%}%>




<%if (check != 0 && check != -1) { // 아이디 비밀번호가 쿼리로 부터 거짓이 아니면
								 // 1만을 참으로 판단한다
 //사용자가 넘어와 userid 값이 일치하면 %>

<body>
	
	<center>
    <form action="pass_checkPro.jsp" method="get" onsubmit="return checkForm();">
        <table width="800">
            <tr height="40">
                <td align="center"><b>[회원정보수정]</b></td>
            </tr>
        </table>    
        <table width="700" height="600" cellpadding="0" style="border-collapse:collapse; font-size:9pt;">
            <tr class="register" height="30">
                <td width="5%" align="center">*</td>
                <td width="15%"  >회원 ID</td>
                <td> <input type="text" name="userid" readonly value="<%= userid%>"/>&nbsp;
        
            </tr>
            <tr height="7">
                <td colspan="3"><hr /></td>
            </tr>
            
             <tr class="register" height="30">
                <td width="5%" align="center">*</td>
                <td width="15%">현재 비밀번호</td>
                <td><input type="password" name="curr_pass" id="pw" onchange="isSame()" /></td>
            </tr>
            
            <tr class="register" height="30">
                <td width="5%" align="center">*</td>
                <td width="15%">비밀번호</td>
                <td><input type="password" name="pass" id="pass"  onkeyup="checkPass();"/></td>
                
                <!-- onchange="isSame()" -->
            </tr>
            <tr height="7">
                <td colspan="3"><hr /></td>
            </tr>
            <tr class="register" height="30">
                <td width="5%" align="center">*</td>
                <td width="15%">비밀번호 확인</td>
                <td><input type="password" name="pass2" id="pass2" onkeyup="checkPass();" />&nbsp;&nbsp;<span id="same"></span></td>
            	<td colspan="2">
            	<span id="passCheck"></span> </td>  <!-- 비번 맞는지 틀리는지 표시해주는 부분 -->
            </tr>
            <tr height="7">
                <td colspan="3"><hr /></td>
            </tr>
            <tr class="register" height="30">
                <td width="5%" align="center">*</td>
                <td width="15%">이 름</td>
                <td><input type="text" name="name" value="<%=name%>" readonly/></td>
            </tr>
            <tr height="7">
                <td colspan="3"><hr /></td>
            </tr>
            <tr class="register" height="30">
                <td width="5%" align="center">*</td>
                <td width="15%">성 별</td>
           
                <td>
                   		
                    <input type="text" name="gender" value="<%=gender %>" readonly />
                </td>
            </tr>
            <tr height="7">
                <td colspan="3"><hr /></td>
            </tr>
            
            <tr height="7">
                <td colspan="3"><hr /></td>
            </tr>
            <tr class="register" height="30">
                <td width="5%" align="center">*</td>
                <td width="15%">휴대전화</td>
                <td><input type="tel" name="phone" value="<%=phone%>"/></td>
            </tr>
            <tr height="7">
                <td colspan="3"><hr /></td>
            </tr>
            <tr class="register" height="30">
                <td width="5%" align="center">*</td>
                <td width="15%">이메일</td>
                <td><input type="email" name="email" value="<%=email%>"/></td>
            </tr>
            <tr height="7">
                <td colspan="3"><hr /></td>
            </tr>
            
            
            <tr>
                <td width="5%" align="center">*</td>
                <td width="15%">주 소</td>
                <td>
                <input id="postcode1" type="text" value="" style="width: 50px;" readonly /> &nbsp;-&nbsp;
				<input id="postcode2" type="text" value="" style="width: 50px;" readonly />
						&nbsp;&nbsp; 
						<input id="zonecode" type="text" value="" style="width: 50px;" readonly /> &nbsp; 
						
						<input type="button" onClick="openDaumZipAddress();" value="주소 찾기" /> <br /> 
						
						<input type="text" id="address" name="address" value="<%=address %>" style="width: 240px;" readonly />

						<input type="text" id="address2" name="address2" value="<%=address2 %>" style="width: 200px;" />
					</td>
            </tr>
 
        </table>
        <br />
        <table>
        <button>변경하기</button>
<%
	}else{
		// out.print("Mypage에 비정상적으로 접근하였습니다");
		
%>
	<a href="pass_check.jsp">로그인 하러 가기 (클릭) </a>		
	
<%
	}

if(check == 0 && exfirecheck == 1) { // 비밀번호 잘못들어오면

	%>
				<script type="text/javascript">
				location.href="pass_check.jsp";
			
				alert("마이페이지 비밀번호를 확인해주세요 \n 3회 이상 실패시 계정이 잠금처리 됩니다");
				</script>
<%	

dao2.UserSessionOver(userid); // 실패할때 마다 세션함수호출하여 값 upate


} if (exfirecheck == 2) { // 로그인 시도를 3번이상해서 exfirecheck값이 2가 되면
	
	session.invalidate(); // 세션영역 제거시켜서 강제로 로그아웃 시켜버림
%>
<script>
// alert("비밀번호를 3번이상 틀리셨네요 \n 꺼지세요");
alert("비밀번호를 3번이상 틀리셨네요 \n 귀하의 계정은 잠금처리 됩니다 \n 아이디/비밀번호 찾기에서 비밀번호를 초기화 해주세요 ");
// location.href="index.jsp"; // 강제로 메인으로 보내버림
setTimeout(function() {
	popup(); 
	} , 1000);

</script>
<meta http-equiv="Refresh" content="5; url=index.jsp">
<!-- 5초후에 새로고침 -->
<!-- <meta http-equiv="refresh" content="3;url=(이동할경로)"> -->

<%

}

%>
        </table>
    </form>


</center>





	<jsp:include page="footer.jsp" />
</body>