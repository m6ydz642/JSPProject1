<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
    <%@page import="java.util.List"%>
<%@page import="newsboard.NewsBoardBean"%>
<%@page import="newsboard.NewsBoardDAO"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="newsboard.NewsCommentBean" %>
<%@page import="newsboard.NewsCommentDAO" %>


<!-- ���⼭ �ٽ� �ؾ߰ڴ�  -->
<%
 /***************************************************************/
 //�� �󼼺���
int num = Integer.parseInt(request.getParameter("num"));
String pageNum = request.getParameter("pageNum");

 String pageNumtest = request.getParameter("pageNum");
 
 	System.out.println(num + "�Ѿ�� num��");
 	//String num = request.getParameter("num");
 	
 	// String pageNum = request.getParameter("pageNum");
 	String subject = request.getParameter("subject");

	NewsBoardDAO dao = new NewsBoardDAO();
 	 NewsBoardBean bBean = dao.getNewsBoard(num);

 	int DBnum = bBean.getNum(); //��ȸ�� �۹�ȣ 
 	String DBName = bBean.getUsername(); //��ȸ�� �ۼ��� 
 	int DBReadcount = bBean.getReadcount();//��ȸ�� ��ȸ��
 	
 	//��¥������ �����Ҽ� �ִ� SimpleDataFormat��ü�� format()�޼ҵ� ���
 	SimpleDateFormat f = new SimpleDateFormat("yyyy/MM/dd");
 	Timestamp DBDate =  bBean.getDate();//��ȸ�� �ۼ���
 	String newDate = f.format(DBDate);
 	
 	String DBSubject = bBean.getSubject();//��ȸ�� ������

 	//�亯�ۿ� ���Ǵ� ��ȸ�� ���� ���
 	int DBRe_ref = bBean.getRe_ref(); //��ȸ�� �ֱ��� �׷��ȣ
 	// int DBRe_lev = bBean.getRe_lev(); //��ȸ�� �ֱ��� �鿩���� ������
 	int DBRe_seq = bBean.getRe_seq(); //�ֱ۵� ����  ��ȸ�� �ֱ��� ������
 	String userid = (String) session.getAttribute("userid");
 	// ���߿� ��ۿ����� ������ ����

 	
 	//���޹��� ��num�� �̿��Ͽ� ���� �˻� �ϱ� ���� BoardDAO��ü�� �����ϰ� 
 
 	
 	NewsCommentDAO cdao = new NewsCommentDAO(); // ���� �������
 	
 	NewsBoardBean dto = dao.getNewsBoard(num); // �����Խ��� num����, ����̶� ��򸮸� �ȵ�
 	int count = dao.getNewsBoardCount();
 %> 


<!--********************************************************************************************** -->
<%
			List list = null;

			if (userid != null) {
		%>
<!--********************************************************************************************** -->
<!-- ��� �κ� (�� ���뿡 ���� �־�� ��) -->
	<form action="comment_pro.jsp" method="post">
				<input type="hidden" name="ref" value="<%=dto.getNum()%>" > 
				<input type="hidden" name="page" value="<%=pageNum%>" > 
				<input type="hidden" name="id" value="<%=userid%>">
				
				<table class="comment" style="width: 670px; align: center; padding: 15px;">
					<tr>
						<td align="center" width="174">���</td>
						<td colspan="2">
							<textarea name="content" rows="3" cols="60" 
							style="margin: 0px; width: 298px; height: 111px;">
							</textarea>
								<input type="submit" name="register" value="����Է�" class="board_btn01"> 
						</td>
					</tr>
				</table>
			</form>
		<%
				}
			%>
		<div style="height: 20px;"></div>
	<%
			 if(count!=0){ 
				 list = cdao.getNewsBoardComment(num);//��� �Լ�	
%>
<!--�����ºκ� ************************************************************************** -->
		<table class="comment" style="width: 670px; align: center; border: 1px solid gray;">
			<%
				for (int j = 0; j < list.size(); j++) {
						NewsCommentBean cdto = (NewsCommentBean)list.get(j);

						// board ���̺� �ִ� num���� comment table���ִ� ref ���� ���ٸ�	
						if (dto.getNum() == cdto.getRef()) {
			%>
			<tr style="border-bottom: 1px solid gray;">
				<td align="center" width="150" height="30" bgcolor="#efeff5"><%=cdto.getId() %></td>
				<td align="center" width="150" height="30" bgcolor="#efeff5"><%=cdto.getNum()%>
				</td>
				
				<td style="border-left: 1px solid gray;">&nbsp;&nbsp;<%=cdto.getContent()%>
				</td>
				<td width="30">
					<%
						// �Խ��� �� �ۼ��� or ��� �ۼ��ڸ� ���� ����
			if (DBName.equals(userid) || cdto.getId().equals(userid)) {
					%> <img src="img/del.png" class="del"
					onclick="location.href='commentDelete_pro.jsp?Newscomment.jsp?num=<%=cdto.getNum()%>&=<%=pageNum%>&num=<%=dto.getNum()%>'"> <%
 	}
 %>
				</td>
				<td align="center" width="100" bgcolor="#efeff5">
 					style="border-left: 1px solid gray;"><%=cdto.getReg_date()%>  <!-- ��¥�κ� ��� ���� -->
				</td> 
			</tr>

			<%
				}
			}
			%>
		</table>
		<%
		 }
		%>


</body>
</html>