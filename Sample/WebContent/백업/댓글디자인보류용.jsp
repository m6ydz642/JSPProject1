<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="header.jsp" />
<meta charset="UTF-8">
<title>testpage</title>
</head>
<body>
<head>
<!--     <link rel="stylesheet" href="/css/bootstrap.css"> -->
</head>
<body>
	<div class="container">
		<form id="commentForm" name="commentForm" method="post">
			<br>
			<br>
			<div>
				<div>
					<span><strong>Comments</strong></span> <span id="cCnt"></span>
				</div>
				<div>
					<table class="table">
						<tr>
							<td><textarea style="width: 1100px" rows="3" cols="30"
									id="comment" name="comment" placeholder="댓글을 입력하세요"></textarea>
								<br>
								<div>
									<a href='#' onClick="fn_comment('${result.code }')"
										class="btn pull-right btn-success">등록</a>
								</div></td>
						</tr>
					</table>
				</div>
			</div>
			<input type="hidden" id="b_code" name="b_code"
				value="${result.code }" />
		</form>
	</div>
	<div class="container">
		<form id="commentListForm" name="commentListForm" method="post">
			<div id="commentList"></div>
		</form>
	</div>

	<!-- --------------------------------------------------------------------- -->
	<!-- https://gangnam-americano.tistory.com/32 에서 가져옴 -->
	<!-- --------------------------------------------------------------------- -->


	<jsp:include page="footer.jsp" />
</body>
</html>