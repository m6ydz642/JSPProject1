from urllib.request import urlopen
import json
import pymysql
import pandas as pd
from pprint import pprint
import ssl #https용
context = ssl._create_unverified_context() #https 의존성 추가용
##################################################
####회사 고유번호 불러올때 쓸 모듈들
from urllib.request import urlopen
from io import BytesIO
from zipfile import ZipFile
import xml.etree.ElementTree as ET
##################################################
#---------------------------------------------------------------------------------------------------------------
# DB연결 부분
conn = pymysql.connect(host='59.20.215.149', user = 'jspid', password='jsppass', db = 'Sample',charset = 'utf8')
curs = conn.cursor(pymysql.cursors.DictCursor)
#---------------------------------------------------------------------------------------------------------------


### 회사고유번호 데이터 불러오기
url = 'https://opendart.fss.or.kr/api/corpCode.xml?crtfc_key=d5e7465cf6cf7bb4e18384a1387d0b3070f5d04e'
with urlopen(url, context=context) as zipresp:
                    #https 오류나서 의존성 추가
    with ZipFile(BytesIO(zipresp.read())) as zfile:
        zfile.extractall('corp_num')
### 압축파일 안의 xml 파일 읽기
tree = ET.parse('CORPCODE.xml')
root = tree.getroot()
#---------------------------------------------------------------------------------------------------------------
### 회사 이름으로 회사 고유번호 찾기
def find_corp_num(find_name): #사용자 함수 사용
#매개변수로 입력받아 사용하는거
    for country in root.iter("list"): #json파일에 list부분 가져옴
        if country.findtext("corp_name") == find_name:
            return country.findtext("corp_code")
#---------------------------------------------------------------------------------------------------------------
print("------------------------------------------------------------------회사 고유번호 ------------------------------------------------------------------")
print(find_corp_num("광동제약")) #위에서 corp_name (고유번호) 사용자 함수 호출

#하이즈항공 json주소
#https://opendart.fss.or.kr/api/fnlttMultiAcnt.json?crtfc_key=d5e7465cf6cf7bb4e18384a1387d0b3070f5d04e&corp_code=00688358&bsns_year=2017&reprt_code=11011
##################################################



#---------------------------------------------------------------------------------------------------------------

#사업년도에 따라서 데이터 다름 (예 : 2020년 손익계산서, 2019년 손익계산서)
#데이터를 어떤 항목들을 가져올건지

CRTFC_KEY="d5e7465cf6cf7bb4e18384a1387d0b3070f5d04e" # 발급받은 API인증키


#reprt_code="11011" #11011 - 사업보고서 (한해 전체 1월1일 ~ 12월 31일)
                 # 11013 - 1분기 보고서
#00126380 전자공시에서 제공하는 api 샘플 고유 번호
#reprt_code="11011" # 11011은 사업보고서임
#---------------------------------------------------------------------------------------------------------------
#고유코드 리스트
#재무상으로 괜찮은 회사
#하이즈항공 00688358
#광동제약 00103592
#---------------------------------------------------------------------------------------------------------------
#18년도 정도부터 적자가 심한 회사
#샘코 00971090
#두산중공업  00159616

# ※ 매각 예정회사는 매출액 표시 안될 수 있음

#---------------------------------------------------------------------------------------------------------------
###############################################
bgn_de="20190101"
end_de="20191231"
bsns_year="2019" # 사업년도
corp_code="00103592" # 고유코드 (회사자체의 고유코드)
###############################################
#url="https://opendart.fss.or.kr/api/list.json?crtfc_key="+ CRTFC_KEY +"&corp_code={}&bgn_de={}&end_de={}".format(corp_code,bgn_de,end_de) #--------------------백업
url="https://opendart.fss.or.kr/api/fnlttSinglAcntAll.json?crtfc_key="+CRTFC_KEY+"&corp_code="+ corp_code+ "&bsns_year=" + bsns_year + "&reprt_code=11011"+"&fs_div=OFS&sj_div=BS&sj_div=IS&sortmth=asc"


#url="https://opendart.fss.or.kr/api/fnlttSinglAcntAll.json?crtfc_key="+CRTFC_KEY+"&corp_code="+ corp_code+ "&bsns_year=" + bsns_year + "&reprt_code=11011"+"&fs_div=OFS&sortmth=desc"



print("url 출력 방식 \n" + url) #확인용
req=urlopen(url,context=context) # URL request방식으로 받아옴
result=req.read() # request방식 읽어서 result에 저장
result_json=json.loads(result) #json 디코딩, 파싱

print(" --------------------------------------json 출력 방식 --------------------------------------\n")
#a = json.dumps(result_json["list"]) #제목에 list방식으로 해서 가져옴
dump = json.dumps(result_json["list"]) #json에 리스트라고 하는 부분만 가져오기.. 이거 몰라서 이상한거 계속 가져옴 ㅡ,ㅡ
croll = json.loads(dump) #이거쓰면 한글 잘됨, 다시 한번더 로드함

for item in croll:

    sj_nm = item['sj_nm']
    if (sj_nm != "자본변동표"): #자본변동표때문에 당기순이익이 계속 0원으로 들어가서 자본변동표가 아닐경우에 대해 값 넣는걸로 계산

        print("기수 : " + item['thstrm_nm'])
        print("회사종목코드 : " + item['corp_code'])
        print("보고서번호 : " + item['reprt_code'])
        print("-----------------------------------------------------------------------")  # 구분용

        print("자산종류 :  " + item['account_nm'])
        print("돈 : " + item['bfefrmtrm_amount']) #금액만 나옴
        print("-----------------------------------------------------------------------")  # 구분용
        print("재표종류 : " + item['sj_nm'])

        print("들어갈 데이터 ***************************************************************")  # 구분용

        사업년도 = item['bsns_year']
        print("들어간 값 " + 사업년도)
        기수  = item['thstrm_nm'] #기수
        print("들어간 값 " + 기수)
        보고서종류 = item['reprt_code'] #회사 보고서 코드 (사업보고서가 11011이였던가:)
        corp_code = item['corp_code'] #회사종목코드
        print("테스트")
        account_nm = item['account_nm'] #자산종류 이름
        print("들어간 값 자산 종류 값 " + account_nm)
        bfefrmtrm_amount = item['thstrm_amount'] # 어카운트 이름 (예 : 유동자산)
                           #키값 지금까지 잘못가져왔었음 (thstrm_amount)가 맞는 키임
        print("bfefrmtrm_amount 값 " + bfefrmtrm_amount)

#가져온걸 다시 가지고 나가는 방법이 if문 말고 생각이 안남 ㅡ.ㅡ ㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋ


############################################여기서는 돈금액이 String인데 DB로 들어가면서 int를 알아서 받아서 형변환 안함
    if (account_nm == "수익(매출액)" or account_nm == "매출액"): #간혹 매출액(수입) 으로 잡혀있는 회사가 있음
        print("매출액 발견")
        매출액 = bfefrmtrm_amount
        print(매출액)

    if (account_nm == "매출원가" and bsns_year==item['bsns_year']):
        print("매출원가 발견")
        매출원가 = bfefrmtrm_amount
        print(매출원가)


    if (account_nm == "판매비와관리비"):
        print("판매비와관리비 발견")
        판매관리비 = bfefrmtrm_amount
        print(판매관리비)



    if (account_nm == "유동자산"):

        print("유동자산발견")
        print("기수")
        print(기수)
        유동자산  = bfefrmtrm_amount
        print(유동자산)


    if (account_nm == "유동부채"):
        print("유동부채발견")
        유동부채 = bfefrmtrm_amount
        print(유동부채)

    if (account_nm == "비유동부채"):
        print("비유동부채발견")
        비유동부채 = bfefrmtrm_amount
        print(비유동부채)

    if (account_nm == "자본금"):
        print("자본금발견")
        자본금 = bfefrmtrm_amount
        print(자본금)

    if (account_nm == "자본금"):
        print("자본금발견")
        자본금 = bfefrmtrm_amount
        print(자본금)

    if (account_nm == "자본총계"): #자본총액이랑 동일
        print("자본총계발견")
        자본총액 = bfefrmtrm_amount
        print(자본총액)

    if (account_nm == "자본총계"):  # 자본총계 동일
        print("자본총계발견")
        자본총계 = bfefrmtrm_amount
        print(자본총계)

    if (account_nm == "자산총계"):  # 자산총계랑 자본총계랑 다름
        print("자산총계발견")
        자산총계 = bfefrmtrm_amount
        print(자산총계)

#######################################아마 손실나는부분은 당기순이익을 자체적으로 넣지말고 따로 계산해서 산출하는게 괜찮을거라 생각됨
    if (account_nm == "당기순이익"):
        print("당기순이익발견")
        당기순이익 = bfefrmtrm_amount
        print(당기순이익)
    elif (account_nm == "당기순이익(손실)"):

        print("흑자 당기순이익이 없으므로 손실쪽으로 확인함")
        print("당기순손실발견")
        당기순이익 = 0-int(bfefrmtrm_amount) #손실이면 마이너스로 DB에 쿼리
        print("당기순손실")
        print(당기순이익)

    if (account_nm == "부채총계"):
        print("부채총계발견")
        부채총계 = bfefrmtrm_amount
        print(부채총계)


sql = "INSERT INTO money (보고서종류, 기수, 매출액,매출원가,고유번호, 판매관리비,당기순이익, 유동자산 ,유동부채,비유동부채, 자본금, 자본총액,자본총계,부채총계,자산총계) VALUES (%s,%s, %s, %s,%s , %s ,%s, %s,%s,%s,%s, %s, %s, %s, %s)"
val = (보고서종류,기수,매출액,매출원가,corp_code, 판매관리비,당기순이익, 유동자산,유동부채,비유동부채, 자본금, 자본총액,자본총계, 부채총계, 자산총계)
curs.execute(sql,val)
conn.commit()




