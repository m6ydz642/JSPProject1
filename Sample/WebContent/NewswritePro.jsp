<%@page import="newsboard.NewsBoardDAO"%>
<%@page import="newsboard.NewsBoardBean"%>
<%@page import="member.MemberBean"%>
<%@page import="java.awt.Graphics2D"%>
<%@page import="java.awt.image.BufferedImage"%>
<%@page import="javax.media.jai.JAI"%>
<%@page import="javax.media.jai.RenderedOp"%>
<%@page import="javax.imageio.ImageIO"%>
<%@page import="java.awt.image.renderable.RenderableImage"%>
<%@page import="java.awt.image.renderable.ParameterBlock"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="java.util.Enumeration"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="java.io.File"%>
<%@page import="java.util.List"%>


<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

    
<%-- <jsp:useBean id="dao" class="newsboard.NewsBoardDAO"/>
<jsp:useBean id="bean" class="newsboard.NewsBoardBean"/> --%>
    
        
<%-- <jsp:useBean id="memdao" class="member.MemberDAO"/>
<jsp:useBean id="membean" class="member.MemberBean"/> 
     --%>
 <%
 	request.setCharacterEncoding("UTF-8");
 	// 값 확인 
 	ServletContext context = request.getServletContext();
 	
	String imagePath = context.getRealPath("uploadimage"); // 저장될 경로 (image라는폴더에 저장됨)
													// 톰캣서버가서 publish 체크 해야 됨
	
	System.out.println(imagePath + " <---------경로 내용");

	int size = 100 * 1024  * 1024; // 바이트를 메가로 환산, 총 100M임
	String filename = "";
	
	
	
	NewsBoardBean dto = new NewsBoardBean();
	NewsBoardDAO dao = new NewsBoardDAO();
	// int num = Integer.parseInt(request.getParameter("num"));
	String pageNum = request.getParameter("pageNum");
	
	//  String[] newscategory = request.getParameterValues("newscategory");
	 
/* 	  for (int i =0; i<=newscategory.length;i++) {
		 System.out.println("반복문 카테고리 값 " + newscategory[i] );
	 }  */
	 

	
	 
	
	try{
		MultipartRequest multi = new MultipartRequest(request,imagePath,size,"UTF-8",new DefaultFileRenamePolicy());
		
 	String subject = multi.getParameter("subject");
	String userid = (String) session.getAttribute("userid"); // 이전에 로그인된 세션값 
 	String content = multi.getParameter("content"); // write.jsp에서 작성한 내용 name값으로 받아오기 
	
 	String newscategory = multi.getParameter("newscategory"); // 계속 request로 받아써서 삽질 오지게함 ㅡ.ㅡ
 														// 파일 기능 들어가있으면 request말고 multi쓰면됨 
 				/* Newswrite form태그에 enctype="multipart/form-data 가 문제임 */										
 		/* https://okky.kr/article/28403 */
 	System.out.println("입력받은 카테고리 값 : " + newscategory);

	dto.setContent(content); // 세터에게 내용 전달
	dto.setSubject(subject); // 세터에게 제목 전달
	dto.setUserid(userid); // 로그인이 되어있는 세션값 아이디를 보드에 UserId에 전달
	
	
		
 	 dto.setNewscategory(newscategory); // 글 작성시 뉴스 카테고리값 같이 전달
 /**********************************************************/
 // 자료 값 테스트용 
	out.print("넘어온 아이디  : " +userid +  "<br>");
 	out.print("넘어온 제목 : " + subject +  "<br>");
 	out.print("넘어온 내용 : " +content  +  "<br>");
	out.print("넘어온 카테고리 : " + newscategory  +  "<br>");
	
    System.out.println("Newswrite pro page 넘어온 카테고리 = " + newscategory);
 	
 	/**********************************************************/	

		Enumeration files = multi.getFileNames();
		String file = (String)files.nextElement();
		filename = multi.getFilesystemName(file);
		
		dto.setFilename(filename); // 원래 이름 그대로
		dto.setPreview("ne_" + filename); // 업로드시 ne_붙여서 나감
		
		
	}catch(Exception e){
		e.printStackTrace();
	}
	
	
	ParameterBlock pb = new ParameterBlock();
	pb.add(imagePath + "/" + filename); // 파일경로 추가
	
/****************************************************/
// 썸내일 
	RenderedOp rOp = JAI.create("fileload", pb);
	BufferedImage bi = rOp.getAsBufferedImage(); // 버퍼 이미지 로드
	BufferedImage thumb = new BufferedImage(300,300,BufferedImage.TYPE_INT_RGB);
	Graphics2D g = thumb.createGraphics();
	g.drawImage(bi, 0, 0, 300,300,null);
	
/****************************************************/ 
 if(!filename.endsWith(".jpg") && !filename.endsWith(".png")){ // jpg나 png만 가능하게
		File file = new File(imagePath + filename);
		// file.delete(); 
	%>
		<script>
		 window.alert("jpg,png 확장자만 선택해주세요 이외의 파일은 불가능 합니다");
		 history.back();
		</script>
	
	
<%	
	}
	File file = new File(imagePath + "/ne_" + filename); // 사진이 업로드될시 파일이름 강제설정
	ImageIO.write(thumb,"jpg",file);
	 dao.insertNews(dto);
%>
	
<script>
				window.alert("업로드 되었습니다.");
				location.href='NewsBoard.jsp?pageNum=<%=pageNum%>&newssearch=&newscategory='; 



<% response.sendRedirect("index.jsp"); %>
</script>


<%-- /* NewsBoard.jsp?pageNum=<%=pageNum%>&newssearch=<%=newssearch%>&newscategory=<%=newscategory%> */ --%>

 	 


