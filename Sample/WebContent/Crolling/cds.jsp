<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
    
<%@page import="org.jsoup.nodes.Element"%>
<%@page import="org.jsoup.select.Elements"%>
<%@page import="org.jsoup.Jsoup"%>
<%@page import="org.jsoup.nodes.Document"%>


<%
	//////////////////////////////
	// Jsoup ���� ��� HTML ��ü ����
	Document doc; 
	Document doc2;
	Document doc3;
	//////////////////////////////
	
	 // Document�� HTML ���
	Element element; 
	Element dateelement2; 
	//////////////////////////////
	
	// Element�� ���� �ڷ���. for�� while �� �ݺ��� ����� �����ϴ�.
	// s�ֳ� ���� �����ε� ���� ���
	Elements elements; 
	Elements dateelements2;
	Elements elements3;
	//////////////////////////////
	
	
	doc = Jsoup.connect("http://www.worldgovernmentbonds.com/cds-historical-data/south-korea/5-years/")
			.get();

	
	dateelements2 = doc.select("div.w3-small"); // ���� ��¥ ������
	dateelement2 = dateelements2.get(0);  // ��¥ �κ�
	elements = doc.select("div.w3-xlarge"); // CDS�����̾� �κ�
	element = elements.get(0); 
	// out.print(dateelement2); 
	%>
	<%
	/***************************************************************/
	
	// out.print("<�ѱ� 5�⹰ ��ä CDS �����̾�>");
	
	/***************************************************************/

	
	 %>
	<font color="black"><p>&nbsp;<%=dateelement2 %> &nbsp;</p> </font> <!-- ��¥ �κ� -->

	<font color="black"><p> &nbsp;<�ѱ� 5�⹰ ��ä CDS�����̾�> &nbsp;</p> </font>
	<font color="black"><p>&nbsp;<%=element %> &nbsp;</p> </font> <!-- cds �κ� -->



