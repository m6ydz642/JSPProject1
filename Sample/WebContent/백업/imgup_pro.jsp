<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%@ page
	import="com.oreilly.servlet.MultipartRequest,com.oreilly.servlet.multipart.DefaultFileRenamePolicy,java.util.*,java.io.*"%>
<%@ page import="java.sql.*"%>
<%
	request.setCharacterEncoding("euc-kr");
	String realFolder = "";
	String filename1 = "";
	int maxSize = 1024 * 1024 * 5;
	String encType = "euc-kr";
	String savefile = "img";
	ServletContext scontext = getServletContext();
	realFolder = scontext.getRealPath(savefile);

	try {
		MultipartRequest multi = new MultipartRequest(request, realFolder, maxSize, encType,
				new DefaultFileRenamePolicy());
		Enumeration<?> files = multi.getFileNames();
		String file1 = (String) files.nextElement();
		filename1 = multi.getFilesystemName(file1);
	} catch (Exception e) {
		e.printStackTrace();
	}

	// String fullpath = realFolder + "\\" + filename1;
	String fullpath = "img" + "/" + filename1;
%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
</head>
<body>
	<img src="<%=fullpath%>" width=512 height=384 alt="사진 오류"></img>
	<%=fullpath %>
</body>
</html>