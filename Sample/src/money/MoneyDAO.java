package money;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;


public class MoneyDAO {
	//전역변수 선언
	Connection con = null;
	ResultSet  rs = null;
	PreparedStatement pstmt = null;
	String sql="";
	
	//자원 해제 하는 메소드 
		public void resourceClose(){
		  try{	
			if(pstmt != null) pstmt.close();
			if(rs != null) rs.close();
			if(con != null) con.close();
		  }catch(Exception e){
			  System.out.println("자원해제 실패 : " + e);
		  }
		}//resourceClose()
		

		private Connection getConnection() throws Exception{ 		
			Connection con = null;
			Context init = new InitialContext();
			//커넥션풀 얻기 
			DataSource ds = (DataSource)init.lookup("java:comp/env/jdbc/Sample");
			//커넥션풀로 부터 커넥션 객체 빌려와서 얻기 
			con = ds.getConnection();
			
			return con; //커넥션을 반환
			
		}//getConnection메소드 끝
		
		
		public int getMoneyBoardCount(){ // 글 있나 없나 확인용
			//board테이블에 저장되어 있는 조회한 글개수를 저장할 변수
			int count = 0;
			
			try {
				//커넥션풀로 부터 케넥션 얻기(DB와의 연결)
				con = getConnection();
				//SQL문 : 전체 글개수 조회
				sql = "select count(*) from money";
				pstmt = con.prepareStatement(sql);
				rs = pstmt.executeQuery();//전체 글개수 조회후 반환
				//전체 글 개수가 조회 된다면
				if(rs.next()){
					count = rs.getInt(1);// 조회한 글개수를 저장
				}
			} catch (Exception e) {
				System.out.println("getMoneyBoardCount()메소드 내부에서 예외발생 : " + e);
			} finally {
				//자원해제
				resourceClose();
			}	
			return count; //조회한 글 개수를 리턴
		}
		
		/******************************************************************/		
		public int getMoneySerachCount(String moneysearch, String moneycategory){ // 투자 게시판에서 검색을 했을때 호출하는 메서드 
															// 오버로딩 해서 써도 되는데 헷깔려서 한개 이름 바꿈 

			int count = 0;
			
			try {
				con = getConnection();
				// ���� �� �� num�� ���� ū �۹�ȣ ��������
				sql = "select count(*) from money where 회사이름 like ? and 구분 like ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, "%"+moneysearch+"%");
				pstmt.setString(2, "%"+moneycategory+"%");
				rs = pstmt.executeQuery();
				
				if(rs.next()) // rs.next가 성공하면 
					count = rs.getInt(1); // 카운트 횟수 저장
				System.out.println("moneyserach count값 " + count);
			} catch (Exception e) {
				e.printStackTrace();
			
			} finally {
				resourceClose();
			}
			return count;
		}	
		/******************************************************************/		
		//글 검색해서 가져오는 메소드 (글 검색해서 보는 용도랑 일반용도랑 해서 2개)
		public List<MoneyBean> getmoneyBoardList(int startRow, int pageSize, String moneysearch, String moneycategory ){
			
			//board테이블로 부터 검색한 글정보들을 
			//각각 한줄단위로  BoardBean객체에 저장후~
			//BoardBean객체들을 각각 ArrayList배열에 추가로 저장하기 위한 용도
			List<MoneyBean> moneyboardList = new ArrayList<MoneyBean>();
			
			try{
				//DB연결
				con = getConnection();
				//SQL문 만들기
				sql = "select * from money where 회사이름 like ? and 구분 like ? order by re_ref desc, re_seq asc limit ?,?";
			//	sql = "select * from money order by num";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, "%"+moneysearch+"%"); // 쿼리요청시 like '%회사이름%'; 해서 해당사항을 전부 가져옴, 삼성이라고 입력시 
														// 예) 삼성으로 시작하고 삼성으로 끝나는 항목을 전부 가져옴
														// (주)삼성전자, 또는 삼성전자(주)
				pstmt.setString(2, "%"+moneycategory+"%");
				pstmt.setInt(3, startRow);
				pstmt.setInt(4, pageSize);
				rs = pstmt.executeQuery();
				
				while (rs.next()) {
					//검색한 글목록중.. 한줄단위의 데이터를 저장할 용도로 객체 생성
					MoneyBean bBean = new MoneyBean();
					// rs => BoardBean객체의 각변수에 저장
					bBean.setNum(rs.getInt("num")); // 글번호
					bBean.set회사이름(rs.getString("회사이름"));
					bBean.set회사개요(rs.getString("회사개요"));
					bBean.set대표자(rs.getString("대표자"));
					bBean.set범위(rs.getString("범위"));
					bBean.set구분(rs.getString("구분"));
					bBean.set매출액(rs.getLong("매출액"));
					bBean.set매출원가(rs.getLong("매출원가"));
					bBean.set판매관리비(rs.getLong("판매관리비"));
					bBean.set유동자산(rs.getLong("유동자산"));
					bBean.set유동부채(rs.getLong("유동부채"));
					bBean.set비유동부채(rs.getLong("비유동부채"));
					bBean.set자본금(rs.getLong("자본금"));
					bBean.set자기자본(rs.getLong("자기자본"));
					bBean.set자본총액(rs.getLong("자본총액"));
					bBean.set주식발행수(rs.getLong("주식발행수"));
					bBean.set당기순이익(rs.getLong("당기순이익"));
					bBean.set시가총액(rs.getLong("시가총액"));
					bBean.set자본총계(rs.getLong("자본총계"));
					bBean.set자산총계(rs.getLong("자산총계"));
					bBean.set부채총계(rs.getLong("부채총계"));
					bBean.set종류(rs.getString("종류"));
					bBean.setRe_ref(rs.getInt("re_ref"));
					bBean.setRe_seq(rs.getInt("re_seq"));
					
					moneyboardList.add(bBean);
				
				}//while반복문 끝
			
			}catch(Exception e){
				System.out.println("getmoneyBoardList메소드 내부에서 예외 발생 (검색용도): " + e);
			}finally {
				//자원해제
				resourceClose();
			}
			
			return moneyboardList; //검색한 글정보들(BoardBean객체들)을 저장하고 있는 배열공간인?
							  //ArrayList를  notice.jsp페이지로 반환(리턴)
		}//메소드 끝
		/******************************************************************/	
		
		// 게시글 조회 리스트 메서드
				public List<MoneyBean> getmoneyBoardList(int startRow, int pageSize){ // IR투자 게시글 조회용도임
																					// 같이 쓰면 search항목에서 null나옴
					//board테이블로 부터 검색한 글정보들을 
					//각각 한줄단위로  BoardBean객체에 저장후~
					//BoardBean객체들을 각각 ArrayList배열에 추가로 저장하기 위한 용도
					List<MoneyBean> moneyboardList = new ArrayList<MoneyBean>();
					
					try{
						//DB연결
						con = getConnection();
						//SQL문 만들기
						sql = "select * from money order by re_ref desc, re_seq asc limit ?,?";
					//	sql = "select * from money order by num";
						pstmt = con.prepareStatement(sql);
						pstmt.setInt(1, startRow);
						pstmt.setInt(2, pageSize);
						rs = pstmt.executeQuery();
						
						while (rs.next()) {
							//검색한 글목록중.. 한줄단위의 데이터를 저장할 용도로 객체 생성
							MoneyBean bBean = new MoneyBean();
							// rs => BoardBean객체의 각변수에 저장
							bBean.setNum(rs.getInt("num")); // 글번호
							bBean.set회사이름(rs.getString("회사이름"));
							bBean.set회사개요(rs.getString("회사개요"));
							bBean.set대표자(rs.getString("대표자"));
							bBean.set범위(rs.getString("범위"));
							bBean.set구분(rs.getString("구분"));
							bBean.set매출액(rs.getLong("매출액"));
							bBean.set매출원가(rs.getLong("매출원가"));
							bBean.set판매관리비(rs.getLong("판매관리비"));
							bBean.set유동자산(rs.getLong("유동자산"));
							bBean.set유동부채(rs.getLong("유동부채"));
							bBean.set비유동부채(rs.getLong("비유동부채"));
							bBean.set자본금(rs.getLong("자본금"));
							bBean.set자기자본(rs.getLong("자기자본"));
							bBean.set자본총액(rs.getLong("자본총액"));
							bBean.set주식발행수(rs.getLong("주식발행수"));
							bBean.set당기순이익(rs.getLong("당기순이익"));
							bBean.set시가총액(rs.getLong("시가총액"));
							bBean.set자본총계(rs.getLong("자본총계"));
							bBean.set자산총계(rs.getLong("자산총계"));
							bBean.set부채총계(rs.getLong("부채총계"));
							bBean.set종류(rs.getString("종류"));
							bBean.setRe_ref(rs.getInt("re_ref"));
							bBean.setRe_seq(rs.getInt("re_seq"));
							
							moneyboardList.add(bBean);
						
						}//while반복문 끝
					
					}catch(Exception e){
						System.out.println("getmoneyBoardList메소드 (일반 사용 검색용도 X) 내부에서 예외 발생 : " + e);
					}finally {
						//자원해제
						resourceClose();
					}
					
					return moneyboardList; //검색한 글정보들(BoardBean객체들)을 저장하고 있는 배열공간인?
									  //ArrayList를  notice.jsp페이지로 반환(리턴)
				}//메소드 끝
		
		/******************************************************************/
		// 밑에 게시글 읽는 함수는 딱히 쓸 필요가 없어보이는데
		
		public MoneyBean getMoneyBoard(int num) { // 게시글을 읽을때
			MoneyBean bBean = null;
			
			try {
				
			
			//DB연결
			con = getConnection();
			//SQL문 만들기 : 매개변수로 전달받은 num에 해당하는글 조회
			sql = "select * from money where num = ?";
		
			//PreparedStatement SQL문 실행객체 얻기
			pstmt = con.prepareStatement(sql);
			//? 기호에 대응되는 글번호num을 설정
			pstmt.setInt(1,num);
			rs = pstmt.executeQuery();
			rs.next();
		
		
			//select문 실행후 조회한 결과 레코드 얻기 
		
			bBean = new MoneyBean();
			
			bBean.setNum(rs.getInt("num")); // 글번호
			bBean.set회사이름(rs.getString("회사이름"));
			bBean.set회사개요(rs.getString("회사개요"));
			bBean.set대표자(rs.getString("대표자"));
			bBean.set범위(rs.getString("범위"));
			bBean.set구분(rs.getString("구분"));
			bBean.set매출액(rs.getLong("매출액"));
			bBean.set매출원가(rs.getLong("매출원가"));
			bBean.set판매관리비(rs.getLong("판매관리비"));
			bBean.set유동자산(rs.getLong("유동자산"));
			bBean.set유동부채(rs.getLong("유동부채"));
			bBean.set비유동부채(rs.getLong("비유동부채"));
			bBean.set자본금(rs.getLong("자본금"));
			bBean.set자기자본(rs.getLong("자기자본"));
			bBean.set자본총액(rs.getLong("자본총액"));
			bBean.set주식발행수(rs.getLong("주식발행수"));
			bBean.set당기순이익(rs.getLong("당기순이익"));
			bBean.set시가총액(rs.getLong("시가총액"));
			bBean.set자본총계(rs.getLong("자본총계"));
			bBean.set자산총계(rs.getLong("자산총계"));
			bBean.set부채총계(rs.getLong("부채총계"));
			bBean.setRe_ref(rs.getInt("re_ref"));
			bBean.setRe_seq(rs.getInt("re_seq"));

			
			} catch (Exception e) {

				System.out.println("getMoneyBoard 오류 : " + e);
			}finally {
				resourceClose();
			}
			
			return bBean; 
		}
		
}
