
####회사 고유번호 불러올때 쓸 모듈들
from urllib.request import urlopen
from io import BytesIO
from zipfile import ZipFile
import xml.etree.ElementTree as ET
##################################################
import ssl #https용
context = ssl._create_unverified_context() #https 의존성 추가용
### 회사고유번호 데이터 불러오기
url = 'https://opendart.fss.or.kr/api/corpCode.xml?crtfc_key=d5e7465cf6cf7bb4e18384a1387d0b3070f5d04e'
with urlopen(url, context=context) as zipresp:
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
i = input('회사이름을 입력하세요 : ')
print(find_corp_num(i))
#print(find_corp_num("광동제약")) #위에서 corp_name (고유번호) 사용자 함수 호출