<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>

<!--********************************************************************************************** -->
<!-- 댓글 부분 (글 내용에 같이 넣어야 됨) -->
	<form action="comment_pro.jsp" method="post">
				<input type="hidden" name="ref" value="제목" > 
				<input type="hidden" name="page" value="페이지 제목" > 
				<input type="hidden" name="id" value="아이디">
				
				<table class="comment" style="width: 670px; align: center; padding: 15px;">
					<tr>
						<td align="center" width="174">댓글</td>
						<td colspan="2">
							<textarea name="content" rows="3" cols="60" style="margin: 10px 5px;"></textarea>
								<input type="submit" name="register" value="댓글입력" class="board_btn01"> 
						</td>
					</tr>
				</table>
			</form>
	<!--********************************************************************************************** -->	
</body>
</html>