<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
    
    <%@page import="org.jsoup.nodes.Element"%>
<%@page import="org.jsoup.select.Elements"%>
<%@page import="org.jsoup.Jsoup"%>
<%@page import="org.jsoup.nodes.Document"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
</head>
<body>
<%
	//////////////////////////////
	// Jsoup 얻어온 결과 HTML 전체 문서
	Document doc; 
	Document doc2;
	Document doc3;
	//////////////////////////////
	
	 // Document의 HTML 요소
	Element element; 
	Element element2; 
	Element element3; 
	Element element4; 
	Element element5; 
	Element elementtitle;   // 제목 부분 (환전 고시환율) 
	Element elementtitle2; // 미국 usd나오고 한칸 띄움
	//////////////////////////////
	
	// Element가 모인 자료형. for나 while 등 반복문 사용이 가능하다.
	// s있냐 없냐 차이인데 은근 헷깔림
	Elements elements; 
	Elements elements2;
	Elements elements3;
	//////////////////////////////
	
	
	doc = Jsoup.connect("https://finance.naver.com/marketindex/")
			.get();
	elements = doc.select("div.market1").select("span"); // 요소 선택해서 가져옴
	
// 	out.print("<환전 고시환율>");
	 elementtitle = elements.get(0); // 제목 부분 (환전 고시환율) ->제목 떨어져서 그냥 손으로 적음


	 elementtitle2 = elements.get(1); // 미국 USD라는 제목 부분
	 element = elements.get(2);  // 돈 부분 
	 element2 = elements.get(3); // 원이라는 부분 (예 : 3000원)
	 element3 = elements.get(4); // span태그 4번째 영역가져옴
	 element4 = elements.get(5); // span태그 5번째 영역가져옴
	 element5 = elements.get(6); // 상승 or 하락, or 보합(하루전이라 ᆼ비교했을때 안올라간거)

	%>
	<font color="black"><p> <%=elementtitle%> | &nbsp;</p> </font>
	
	<font color="cyon"><p> <%=elementtitle2 %> | &nbsp;</p> </font>
	
	<font color="red"><p> <%=element %> &nbsp;</p> </font>
	
	<font color="black"><p><%=element2 %>  &nbsp;</p> </font>

	<font color="black"><p><%=element4 %> &nbsp;</p> </font> <!-- 오른가격 -->

	<font color="red"><p><%=element5 %> &nbsp;</p> </font>
	
	 
	 
	 
</body>
</html>