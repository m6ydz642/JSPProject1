
#아이티윌 신상국 강사님의 파이썬 소스
#아이티윌 신상국 강사님의 파이썬 소스
#아이티윌 신상국 강사님의 파이썬 소스
#아이티윌 신상국 강사님의 파이썬 소스
#아이티윌 신상국 강사님의 파이썬 소스
#아이티윌 신상국 강사님의 파이썬 소스
import pymysql
import ssl #https용
context = ssl._create_unverified_context()

#---------------------------------------------------------------------------------------------------------------
# DB연결 부분
conn = pymysql.connect(host='59.20.215.149', user = 'jspid', password='jsppass', db = 'Sample',charset = 'utf8')
curs = conn.cursor(pymysql.cursors.DictCursor)
#---------------------------------------------------------------------------------------------------------------



# 모듈을 읽어 들입니다.


#urlopen모듈은 url에 접속하기 위한 라이브러리이다.
#웹크롤링을 위해서 반드시 사용해야 하는 라이브러이이다.
# from문은 특정 라이브러리에서 한 부분만을 불러와서 사용할 때 사용하는 구문이다.
# urllib.request모듈 내부에 있는 urlopen 이라는 함수만 불러와서 사용하겠다는 내용이다.
from urllib.request import urlopen
from bs4 import BeautifulSoup  #bs모듈의 BeautifulSoup함수를 사용 하기 위해 bs4모듈을 읽어 들임


#request모듈 내부에 있는 urlopen()함수를 이용해 기상청 페이지의 코드 내용을 읽어들입니다.
#urlopen()함수는 URL주소의 페이지를 열어 주는 함수 입니다.
# urlopen() 함수로 기상청의 전국 날씨를 읽습니다.
api = "d5e7465cf6cf7bb4e18384a1387d0b3070f5d04e";
bsns_year="2019" # 사업년도
corp_code="00103592" # 고유코드 (회사자체의 고유코드)

target = urlopen("https://opendart.fss.or.kr/api/fnlttSinglAcnt.xml?crtfc_key=" + api + "&corp_code=" +corp_code + "&bsns_year=" + bsns_year + "&reprt_code=11011", context=context).read().decode('utf-8')
urllist = "https://opendart.fss.or.kr/api/fnlttSinglAcnt.xml?crtfc_key=" + api + "&corp_code=" +corp_code + "&bsns_year=" + bsns_year + "&reprt_code=11011"
#urllist는 url값 어떻게 되는지 확인용임

print("가지고온 URL " + urllist)
# urllib.request.urlopen() 함수는 웹 서버에 정보를 요청한 후, 돌려받은 응답을 저장하여 ‘응답 객체(HTTPResponse)’를 반환한다.
# 반환된 응답 객체의 read() 메서드를 실행하여 웹 서버가 응답한 데이터를 바이트 배열로 읽어들인다.
# 읽어들인 바이트 배열은 이진수로 이루어진 수열이어서 그대로는 사용하기 어렵다.
# 웹 서버가 응답한 내용이 텍스트 형식의 데이터라면, 바이트 배열의 decode('utf-8') 메서드를 실행하여 문자열로 변환할 수 있다.
# 이 때 ‘utf-8’은 유니코드 부호화 형식의 한 종류인데 decode() 함수의 기본 인자이므로 생략해도 된다

# BeautifulSoup을 사용해 웹 페이지를 분석합니다.
# target변수에 저장된 값들(읽어들인 전체 내용 html 문자열)과, "html.parser"라는 문자열을
# BeautifulSoup()함수의 매개변수로 넣어주면
# 읽어 들인 전체 HTML내용중 특정 부분의 데이터를 파씽 할수 있는 역할 을 하는 BeautifulSoup 객체로 만들어 줌으로서
# BeautifulSoup의 유용한 메서드(원하는 데이터 추출)를 사용하여 데이터를 뽑아 낼수 있다.

soup = BeautifulSoup(target, "html.parser")

# 아래의 사이트의 전체 코드를 모두 읽어 와서 출력 했다는 것을 알수 있다.
# "http://www.kma.go.kr/weather/forecast/mid-term-rss3.jsp?stnId=108"
# print(soup)


#BeautifulSoup객체의 함수!!!!!!
# select("선택하여 가져올 태그명")함수
#-> HTML전체 데이터 중에서..  select함수 호출시 인수로 전달한 태그명에 해당 되는 태그들만 추출해서
#  새로운 배열에 모두 담아 배열을 반환 해주는 함수 이다.

# select_one()함수
# 만족하는 첫번째 경우만 찾아서 반환시킨다.

# select("location")메소드는 읽어 들인 전체 HTML내용중  location 태그들을 찾아서 새로운 배열에 담아서 반환 하는데
#새로운 배열 내부에 저장된  <location>...</location>태그들의 갯수 만큼 반복해서~
for list in soup.select("list"):
    # <list>...</list>태그내부의 thstrm_nm, sj_nm, account_nm, thstrm_amount 태그를 찾아 출력합니다.
    print("기수:", list.select_one("thstrm_nm").string)
    print("계정과목", list.select_one("sj_nm").text)
    print("카운트명:", list.select_one("account_nm").string)
    print("돈:", list.select_one("thstrm_amount").string)
    print()


   # 자본변동표때문에 당기순이익이 계속 0원으로 들어가서 자본변동표가 아닐경우에 대해 값 넣는걸로 계산
    보고서종류 = list.select_one("reprt_code").string
    기수 = list.select_one("thstrm_nm").string
    재표종류 = list.select_one("sj_nm").text
    계정명 = list.select_one("account_nm").string
    돈 = list.select_one("thstrm_amount").int


    #유동자산 = soup.select("thstrm_amount").int
    #soup.select('태그명[속성1=값1]')

    #유동자산 = soup.find('account_nm', '유동자산')



#sql = "INSERT INTO money (보고서종류, 기수, 매출액,매출원가,고유번호, 판매관리비,당기순이익, 유동자산 ,유동부채,비유동부채, 자본금, 자본총액,자본총계,부채총계,자산총계) VALUES (%s,%s, %s, %s,%s , %s ,%s, %s,%s,%s,%s, %s, %s, %s, %s)"
#val = (보고서종류,기수,매출액,매출원가,corp_code, 판매관리비,당기순이익, 유동자산,유동부채,비유동부채, 자본금, 자본총액,자본총계, 부채총계, 자산총계)
#curs.execute(sql,val)
#conn.commit()


