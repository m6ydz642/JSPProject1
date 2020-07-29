<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
    
<%@page import="org.jsoup.nodes.Element"%>
<%@page import="org.jsoup.select.Elements"%>
<%@page import="org.jsoup.Jsoup"%>
<%@page import="org.jsoup.nodes.Document"%>


<%
	//////////////////////////////
	// Jsoup 얻어온 결과 HTML 전체 문서
	Document doc; 
	Document doc2;
	Document doc3;
	//////////////////////////////
	
	 // Document의 HTML 요소
	Element element; 
	Element dateelement2; 
	//////////////////////////////
	
	// Element가 모인 자료형. for나 while 등 반복문 사용이 가능하다.
	// s있냐 없냐 차이인데 은근 헷깔림
	Elements elements; 
	Elements dateelements2;
	Elements elements3;
	//////////////////////////////
	
	
	doc = Jsoup.connect("http://www.worldgovernmentbonds.com/cds-historical-data/south-korea/5-years/")
			.get();

	
	dateelements2 = doc.select("div.w3-small"); // 갱신 날짜 가져옴
	dateelement2 = dateelements2.get(0);  // 날짜 부분
	elements = doc.select("div.w3-xlarge"); // CDS프리미엄 부분
	element = elements.get(0); 
	// out.print(dateelement2); 
	%>
	<%
	/***************************************************************/
	
	// out.print("<한국 5년물 국채 CDS 프리미엄>");
	
	/***************************************************************/

	
	 %>
	<font color="black"><p>&nbsp;<%=dateelement2 %> &nbsp;</p> </font> <!-- 날짜 부분 -->

	<font color="black"><p> &nbsp;<한국 5년물 국채 CDS프리미엄> &nbsp;</p> </font>
	<font color="black"><p>&nbsp;<%=element %> &nbsp;</p> </font> <!-- cds 부분 -->



