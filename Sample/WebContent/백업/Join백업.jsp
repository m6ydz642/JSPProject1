<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
<meta charset="UTF-8">
<title>Join Page</title>
</head>

<body>
<jsp:include page="header.jsp"/>

	<center>
    <form action="JoinPro.jsp" method="post" name="twin">
        <table width="800">
            <tr height="40">
                <td align="center"><b>[회원가입]</b></td>
            </tr>
        </table>    
        <table width="700" height="600" cellpadding="0" style="border-collapse:collapse; font-size:9pt;">
            <tr class="register" height="30">
                <td width="5%" align="center">*</td>
                <td width="15%">회원 ID</td>
                <td><input type="text" name="userid" />&nbsp;
                <a href="javascript:id_check()">[ID 중복 검사]</a></td>
            </tr>
            <tr height="7">
                <td colspan="3"><hr /></td>
            </tr>
            <tr class="register" height="30">
                <td width="5%" align="center">*</td>
                <td width="15%">비밀번호</td>
                <td><input type="password" name="userpasswd" id="pw" onchange="isSame()" /></td>
            </tr>
            <tr height="7">
                <td colspan="3"><hr /></td>
            </tr>
            <tr class="register" height="30">
                <td width="5%" align="center">*</td>
                <td width="15%">비밀번호 확인</td>
                <td><input type="password" name="wUserPWConfirm" id="pwCheck" onchange="isSame()" />&nbsp;&nbsp;<span id="same"></span></td>
            </tr>
            <tr height="7">
                <td colspan="3"><hr /></td>
            </tr>
            <tr class="register" height="30">
                <td width="5%" align="center">*</td>
                <td width="15%">이 름</td>
                <td><input type="text" name="name" /></td>
            </tr>
            <tr height="7">
                <td colspan="3"><hr /></td>
            </tr>
            <tr class="register" height="30">
                <td width="5%" align="center">*</td>
                <td width="15%">성 별</td>
           
                <td>
                   		  남 성
                    <input type="radio" name="gender" value="남" />
                    &nbsp;여 성
                    <input type="radio" name="gender" value="여"/>
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
                <td><input type="tel" name="phone" /></td>
            </tr>
            <tr height="7">
                <td colspan="3"><hr /></td>
            </tr>
            <tr class="register" height="30">
                <td width="5%" align="center">*</td>
                <td width="15%">이메일</td>
                <td><input type="email" name="email" /></td>
            </tr>
            <tr height="7">
                <td colspan="3"><hr /></td>
            </tr>
            <tr>
                <td width="5%" align="center">*</td>
                <td width="15%">주 소</td>
                <td>
                    <input type="text" size="10" name="wPostCode" id="postcode" placeholder="우편번호" readonly="readonly" onclick="DaumPostcode()">
                    <input type="button" onclick="DaumPostcode()" value="우편번호 찾기"><br><br />
                    <input type="text" size="30" name="wRoadAddress" id="roadAddress" placeholder="도로명주소" readonly="readonly" onclick="DaumPostcode()">
                    <input type="text" size="30" name="wJibunAddress" id="jibunAddress" placeholder="지번주소" readonly="readonly" onclick="DaumPostcode()">
                    <br /><span id="guide" style="color:#999;font-size:10px;"></span>   
                    <br /><br /><input type="text" name="wRestAddress" placeholder="나머지 주소" size="70" />
                </td>
            </tr>
 
        </table>
        <br />
        <table>
        <button>가입하기</button>
        
<!--        <input type="button" onclick="cancle()" value="취소">  -->
<!--        <input type="button" onclick="goSubmit()" value="확인"> -->



<!--             <tr height="40"> -->
<!--                 <td> -->

				
<!--                  <input width="120" type="image" src="img/button/btn_join.png" alt="Join" align="center" />&nbsp; -->
<!--                 <a href="cancel.jsp"> -->
                
<!--                 <img src="img/button/btn_cancel.png" width="120" alt="Cancel" align="center" /></a></td> -->
<!--             </tr> -->
        </table>
    </form>


</center>




<jsp:include page="footer.jsp"/>
</body>
</html>