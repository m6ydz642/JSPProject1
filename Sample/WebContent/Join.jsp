<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<!-- 이상한 경고떠서 HTML5 임을 알리는 문구 추가 -->
<html>
<head>
<meta charset="UTF-8">
<title>Join Page</title>
</head>

<!-- <script type="text/JavaScript" src="http://code.jquery.com/jquery-1.7.min.js"></script> -->
<script src="https://code.jquery.com/jquery-3.3.1.js"></script>
	<script type="text/JavaScript" src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
	
<script type="text/javascript">
// $(document).ready(function() {
		function openDaumZipAddress() {

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
		
		/******************************************************************************************/
		function emailcheck() { // 이메일검사


			var email = $("#email").val();

			if (email == '') {
				window.alert("이메일을 입력 하세요");
				return;
			}

		
			$.ajax({

				type : "post",
				async : true,
				url : "emailcheck.jsp",
				data : {email : email}, // name값과 위에 변수값
				dataType : "text",
				
				success : function(data, textStatus) {
			 	

					
					  $("#emailcheck").html(data); // check 값 아이디 써서 입력 옆에 띄움 
					
				},
				error : function() {
					alert("에러가 발생했습니다.");
					console.log(error);
				}
		

			});
		}		
		
		/******************************************************************************************/
		function phonecheck() { // 휴대폰 번호 검사


			var phone = $("#phone").val();

			if (phone == '') {
				window.alert("폰번호를 입력 하세요");
				return;
			}

		
			$.ajax({

				type : "post",
				async : true,
				url : "phonecheck.jsp",
				data : {phone : phone}, // name값과 위에 변수값
				dataType : "text",
				
				success : function(data, textStatus) {
			 	

					
					  $("#phonecheck").html(data); // check 값 아이디 써서 입력 옆에 띄움 
					
				},
				error : function() {
					alert("에러가 발생했습니다.");
					console.log(error);
				}
		

			});
		}		
/******************************************************************************************/
// 아이디 중복체크 ajax 방식
function id_check() {


			var userid = $("#userid").val();

			if (userid == '') {
				window.alert("ID를 입력 하세요");
				return;
			}

		
			$.ajax({

				type : "post",
				async : true,
				url : "idcheck.jsp",
				data : {userid : userid}, // name값과 위에 변수값
				dataType : "text",
				
				success : function(data, textStatus) {
			 	

					
					  $("#check").html(data); // check 값 아이디 써서 아이디 입력 옆에 띄움 
					
				},
				error : function() {
					alert("에러가 발생했습니다.");
					console.log(error);
				}
		

			});
		}
/******************************************************************************************/	
// 유효성 검사

	function joincheck () {

		var name = $("#name").val();
		
	 if (name == "") { 
		 
			// val()함수를 사용하기때문에 name==''이 사용가능한것임
			// 그 외에는 null사용
			window.alert("이름를 입력 하세요");
			$("#name").focus(); // 변수에 넣으니깐 안되는 이상한 현상이 ㅡ,ㅡ;;;;;
			return false;
		}
 		var id = $("#userid").val();
 	
 		if (id == "") { 
 			window.alert("아이디를 입력 하세요");
 			$("#userid").focus();
 			return false;
 		}

 		var pass = $("#userpasswd").val();
 		if (pass == '') { 
 			window.alert("비밀번호를 입력 하세요");
 			$("#userpasswd").focus();
 			return false;
 		}
 		var gender = false; // 기본값을 false로 줘버린다. 
		
		
// 		 if(!($('#man')[0].checked == true || $('#woman')[0].checked == true)){
//  			 // 0번째로 시작하기 때문에 0번째로 받아온다. 
//  			 // class로 하려고 했는데 기억이 안나서 id값으로 각각 비교 
//  			   alert("성별을 선택하십시오.");
//  			   $('#gender').focus();
//  			   return false;
//  			  }
		
 		var email = $("#email").val();
 		if (email == '') { 
 			window.alert("email 입력 하세요");
 			$("#email").focus();
 			return false;
 		}
		
 		var phone = $("#phone").val();
 		if (phone == '') { 
 			window.alert("phone번호를 입력 하세요");
 			$("#phone").focus();
 			return false;
 		}
		 
 		var select = $("#sel").val();
 		if ( select == '') {

 	alert("반드시 선택해야 합니다");
 	return false;

				}
 		
 		
 
 		
	}	

	/******************************************************************************************/	
	
	function checkPass() { // 비밀번호 입력시 확인해주는 영역 
			if($("#userpasswd").val() != "") { // 공백이 아니라면 
				if($("#userpasswd").val() != $("#userpasswdcheck").val() ) {
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
		
	
		
		
/******************************************************************************************/		
 function idcheck2() { // 비밀번호 입력시 확인해주는 영역 
			if($("#userpasswd").val() != "") { // 공백이 아니라면 
				if($("#userpasswd").val() != $("#userpasswdcheck").val() ) {
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
	</script>
<body>
<jsp:include page="header.jsp"/>

	<center>
    <form action="JoinPro.jsp" method="post" name="joinform" onsubmit="return joincheck();">
        <table width="800">
            <tr height="40">
                <td align="center"><b>[회원가입]</b></td>
            </tr>
        </table>    
        <table width="700" height="600" cellpadding="0" style="border-collapse:collapse; font-size:9pt;">
            <tr class="register" height="30">
                <td width="5%" align="center">*</td>
                <td width="15%">회원 ID  </td>   
                <td><input type="text" name="userid"  id="userid"/>&nbsp;
                <a  id="check" > </a><a href="javascript:id_check()">[ID 중복 검사]</a> </td>
          
            </tr>
            <tr height="7">
                <td colspan="3"><hr /></td>
            </tr>
            <tr class="register" height="30">
                <td width="5%" align="center">*</td>
                <td width="15%">비밀번호</td>
                <td><input type="password" name="userpasswd" id="userpasswd" onchange="" onkeyup="checkPass();"/></td>
            </tr>
            <tr height="7">
                <td colspan="3"><hr /></td>
            </tr>
            <tr class="register" height="30">
                <td width="5%" align="center">*</td>
                <td width="15%">비밀번호 확인</td>
                   
                <td><input type="password" name="userpasswdcheck" id="userpasswdcheck" onchange="" onkeyup="checkPass();"/>&nbsp;&nbsp;<span id="same"></span>
                
                 <span id="passCheck"></span>
                </td>
     		
     		   </td>  <!-- 비번 맞는지 틀리는지 표시해주는 부분 -->
            </tr>
            <tr height="7">
                <td colspan="3"><hr /></td>
            </tr>
            <tr class="register" height="30">
                <td width="5%" align="center">*</td>
                <td width="15%">이 름</td>
                <td><input type="text" name="name" id="name"/></td>
            </tr>
            <tr height="7">
                <td colspan="3"><hr /></td>
            </tr>
            <tr class="register" height="30">
                <td width="5%" align="center">*</td>
                <td width="15%">성 별</td>
           
                <td>
                   		  남 성
                    <input type="radio" id="gender" name="gender" value="남" />
                    &nbsp;여 성
                    <input type="radio" id="gender" name="gender" value="여"/>
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
                <td><input type="tel" name="phone" id="phone" /> <a id="phonecheck"></a>
                 <a href="javascript:phonecheck()">[폰번호 검사]</a>
              
                </td>
               
            </tr>
            <tr height="7">
                <td colspan="3"><hr /></td>
            </tr>
            <tr class="register" height="30">
                <td width="5%" align="center">*</td>
                <td width="15%">이메일</td>
                <td><input type="email" name="email"  id="email"/><a id="emailcheck"></a>
                 <a href="javascript:emailcheck()">[이메일 검사]</a>
                
                </td>
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
						
						<input type="text" id="address" name="address" value="" style="width: 240px;" readonly />

						<input type="text" id="address2" name="address2" value="" style="width: 200px;" />
					</td>
            </tr>
 
        </table>
        <br />
        <table>

	<!-- <input type="submit" onclick="joincheck();" value="가입하기" > -->
        <button type="submit" onclick="">가입하기</button>


        </table>
    </form>


</center>




<jsp:include page="footer.jsp"/>
</body>
</html>