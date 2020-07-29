package newsboard;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class NewsBoardDAO {

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
	
	/*******************************************************************************************************/
	private Connection getConnection() throws Exception{ 		
		Connection con = null;
		Context init = new InitialContext();
		//커넥션풀 얻기 
		DataSource ds = (DataSource)init.lookup("java:comp/env/jdbc/Sample");
		//커넥션풀로 부터 커넥션 객체 빌려와서 얻기 
		con = ds.getConnection();
		
		return con; //커넥션을 반환
		
	}//getConnection메소드 끝
	/*******************************************************************************************************/	
	public int getNewsBoardCount(){
		//board테이블에 저장되어 있는 조회한 글개수를 저장할 변수
		int count = 0;
		
		try {
			//커넥션풀로 부터 케넥션 얻기(DB와의 연결)
			con = getConnection();
			//SQL문 : 전체 글개수 조회
			sql = "select count(*) from newsboard";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();//전체 글개수 조회후 반환
			//전체 글 개수가 조회 된다면
			if(rs.next()){
				count = rs.getInt(1);// 조회한 글개수를 저장
			}
		} catch (Exception e) {
			System.out.println("getBoardCount()메소드 내부에서 예외발생 : " + e);
		} finally {
			//자원해제
			resourceClose();
		}	
		return count; //조회한 글 개수를 리턴
	}
	
	
	public int getNewsSerachCount(String newssearch, String newscategory) { // 투자 게시판에서 검색을 했을때 호출하는 메서드
		// 오버로딩 해서 써도 되는데 헷깔려서 한개 이름 바꿈

		int count = 0;

		try {
			con = getConnection();
// ���� �� �� num�� ���� ū �۹�ȣ ��������
			sql = "select count(*) from newsboard where subject like ? and newscategory like ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, "%" + newssearch + "%");
			pstmt.setString(2, "%" + newscategory + "%");
			rs = pstmt.executeQuery();

			if (rs.next()) // rs.next가 성공하면
				count = rs.getInt(1); // 카운트 횟수 저장
			System.out.println("newssearch count값 " + count);
		} catch (Exception e) {
			e.printStackTrace();

		} finally {
			resourceClose();
		}
		return count;
	}

	/*******************************************************************************************************/
	public List<NewsBoardBean> getnewscategory () {
		// 	newscategory
		List<NewsBoardBean> newscategorylist = new ArrayList<NewsBoardBean>();
		
		try{
			//DB연결
			con = getConnection();
			//SQL문 만들기
			sql = "select category from newsboard "; // 답글기능 없어서 num값으로 순위바꿈
			pstmt = con.prepareStatement(sql);
	
			rs = pstmt.executeQuery();
			while (rs.next()) {
				//검색한 글목록중.. 한줄단위의 데이터를 저장할 용도로 객체 생성
				NewsBoardBean bBean = new NewsBoardBean();
				bBean.setNewscategory(rs.getString("newscategory"));
				newscategorylist.add(bBean);
			}
			
		}catch (Exception e) {
				// TODO: handle exception
			}
		return newscategorylist;
	}

	/*******************************************************************************************************/	
	//글목록 검색해서 가져오는 메소드
	// 뉴스보드 전용 게시판임, 헤드라인용은 밑에서 오버로딩함
	public List<NewsBoardBean> getNewsBoardList(int startRow,int pageSize,String newssearch, String newscategory){
		
		//board테이블로 부터 검색한 글정보들을 
		//각각 한줄단위로  BoardBean객체에 저장후~
		//BoardBean객체들을 각각 ArrayList배열에 추가로 저장하기 위한 용도
		List<NewsBoardBean> newsboardList = new ArrayList<NewsBoardBean>();
		
		try{
			//DB연결
			con = getConnection();
			//SQL문 만들기
			// sql = "select * from newsboard order by re_ref desc, re_seq asc limit ?,?";
			// sql = "select * from newsboard  ?,?";
			// sql = "select * from newsboard order by re_ref desc, re_seq asc limit ?,?";
			sql = "select * from newsboard where subject like ? and newscategory like ? order by num desc limit ?,?"; // 답글기능 없어서 num값으로 순위바꿈
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, "%"+newssearch+"%");
			pstmt.setString(2, "%"+ newscategory + "%");
			pstmt.setInt(3, startRow);
			pstmt.setInt(4, pageSize);
			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				//검색한 글목록중.. 한줄단위의 데이터를 저장할 용도로 객체 생성
				NewsBoardBean bBean = new NewsBoardBean();
				// rs => BoardBean객체의 각변수에 저장
				bBean.setNum(rs.getInt("num")); // 글번호
				bBean.setUsername(rs.getString("username"));
				bBean.setUserid(rs.getString("userid"));
				bBean.setSubject(rs.getString("subject"));
				bBean.setContent(rs.getString("content"));
				bBean.setDate(rs.getTimestamp("date"));
				bBean.setRe_seq(rs.getInt("re_seq")); // 이거 없애야 됨
				bBean.setRe_ref(rs.getInt("re_ref"));
				bBean.setNewscategory(rs.getString("newscategory"));
				/***************************************************************/
				// 그냥 사진은 쿼리 딱히 필요없는데 썸내일의 경우 리스트로 보드에서 읽을때 필요
				// 없으면 경로 못 가져옴
				bBean.setFilename(rs.getString("filename"));  // 파일 원본
				bBean.setPreview(rs.getString("preview")); //썸내일 
				/***************************************************************/
				
				//BoardBean 객체  =>  ArrayList배열에 추가
				newsboardList.add(bBean);
			
			
			}//while반복문 끝
		
		}catch(Exception e){
			System.out.println("getNewsBoardList메소드 내부에서 예외 발생 : " + e);
		}finally {
			//자원해제
			resourceClose();
		}
		
		return newsboardList; //검색한 글정보들(BoardBean객체들)을 저장하고 있는 배열공간인?
						  //ArrayList를  notice.jsp페이지로 반환(리턴)
	}//getBoardList메소드 끝
	
	/*******************************************************************************************************/		
public List<NewsBoardBean> getNewsBoardList(int startRow,int pageSize){ // 헤드라인 전용
		
		//board테이블로 부터 검색한 글정보들을 
		//각각 한줄단위로  BoardBean객체에 저장후~
		//BoardBean객체들을 각각 ArrayList배열에 추가로 저장하기 위한 용도
		List<NewsBoardBean> newsboardList = new ArrayList<NewsBoardBean>();
		
		try{
			//DB연결
			con = getConnection();
			//SQL문 만들기
			// sql = "select * from newsboard order by re_ref desc, re_seq asc limit ?,?";
			// sql = "select * from newsboard  ?,?";
			// sql = "select * from newsboard order by re_ref desc, re_seq asc limit ?,?";
			sql = "select * from newsboard order by num desc limit ?,?"; // 답글기능 없어서 num값으로 순위바꿈
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, startRow);
			pstmt.setInt(2, pageSize);
			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				//검색한 글목록중.. 한줄단위의 데이터를 저장할 용도로 객체 생성
				NewsBoardBean bBean = new NewsBoardBean();
				// rs => BoardBean객체의 각변수에 저장
				bBean.setNum(rs.getInt("num")); // 글번호
				bBean.setUsername(rs.getString("username"));
				bBean.setUserid(rs.getString("userid"));
				bBean.setSubject(rs.getString("subject"));
				bBean.setContent(rs.getString("content"));
				bBean.setDate(rs.getTimestamp("date"));
				bBean.setRe_seq(rs.getInt("re_seq")); // 이거 없애야 됨
				bBean.setRe_ref(rs.getInt("re_ref"));
				bBean.setNewscategory(rs.getString("newscategory"));
				/***************************************************************/
				// 그냥 사진은 쿼리 딱히 필요없는데 썸내일의 경우 리스트로 보드에서 읽을때 필요
				// 없으면 경로 못 가져옴
				bBean.setFilename(rs.getString("filename"));  // 파일 원본
				bBean.setPreview(rs.getString("preview")); //썸내일 
				/***************************************************************/
				
				//BoardBean 객체  =>  ArrayList배열에 추가
				newsboardList.add(bBean);
			
			
			}//while반복문 끝
		
		}catch(Exception e){
			System.out.println("getNewsBoardList메소드 내부에서 예외 발생 : " + e);
		}finally {
			//자원해제
			resourceClose();
		}
		
		return newsboardList; //검색한 글정보들(BoardBean객체들)을 저장하고 있는 배열공간인?
						  //ArrayList를  notice.jsp페이지로 반환(리턴)
	}//getBoardList메소드 끝

	/*******************************************************************************************************/	
	public NewsBoardBean getNewsBoard(int num) { // 뉴스 게시글 읽기
		NewsBoardBean bBean = null;
		System.out.println("뉴스보드 num값 : " + num);
		try {
			
		
		//DB연결
		con = getConnection();
		//SQL문 만들기 : 매개변수로 전달받은id 에 해당하는글 조회
		sql = "select * from newsboard where num = ?";
		//PreparedStatement SQL문 실행객체 얻기
		pstmt = con.prepareStatement(sql);
		//? 기호에 대응되는 글번호 id를 설정
		pstmt.setInt(1,num);
		rs = pstmt.executeQuery();
		rs.next();
		System.out.println("뉴스보드 쿼리성공");
	
		//select문 실행후 조회한 결과 레코드 얻기 
	
		bBean = new NewsBoardBean();
		
		
		bBean.setNum(rs.getInt("num")); // 게시글 전용
		bBean.setUserid(rs.getString("userid")); // 게시글 전용
		bBean.setSubject(rs.getString("subject")); // 게시글 전용
		bBean.setDate(rs.getTimestamp("date"));
		bBean.setFilename(rs.getString("filename"));
		bBean.setContent(rs.getString("content"));
		bBean.setFilename(rs.getString("filename")); // 파일원본
		bBean.setPreview(rs.getString("preview")); //썸내일 
		bBean.setNewscategory(rs.getString("newscategory")); //카테고리
		
		} catch (Exception e) {

			System.out.println("뉴스게시판 조회 오류 : " + e);
		}finally {
			resourceClose();
		}
		
		return bBean; 
	}
	/*******************************************************************************************************/	
	// 뉴스 글 작성 메서드
	public void insertNews( NewsBoardBean Bean ) {
		// 글작성 메소드
		int num = 1; // 오토인크리먼트 대신해서 쓸놈
		try {
			// 1.DB접속(연결) : 커넥션풀 DataSource로 부터 커넥션 Connection객체 빌려오기
			con = getConnection();

			sql = "select max(num) from newsboard"; // 미리 한번 확인해보고
					pstmt=con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
		/*	if (rs.next()) {
			    num = rs.getInt(1)+1; // 오토인크리먼트는 num이 쓰고 있어서 얘로 대신씀, 조회수 증가용도
			}else {
				num = 1;
			}*/
			
			sql = "insert into newsboard(num,userid, subject,content,filename,preview, re_seq,newscategory , date) "
					+ "values(null,?,?,?,?,?,?,?,now())";

			pstmt = con.prepareStatement(sql);
			// 4. ?기호에 대응되는 값들을 설정
			pstmt.setString(1, Bean.getUserid());
			pstmt.setString(2, Bean.getSubject());
			pstmt.setString(3, Bean.getContent());
			pstmt.setString(4, Bean.getFilename());
			pstmt.setString(5, Bean.getPreview());
			pstmt.setInt(6, Bean.getRe_seq());
			pstmt.setString(7, Bean.getNewscategory()); //  카테고리
			// pstmt.setInt(7, 0); // 조회수, 게시글을 작성할 때 처음부터 조회수 1을 미리 안주면 0인상태로 계속 안올라감
			
		
			
			System.out.println("넘어오는 값 아이디 : " + Bean.getUserid());
			System.out.println("넘어오는 값 제목 : " + Bean.getSubject());
			System.out.println("넘어오는 값 내용  : " + Bean.getContent());
			System.out.println("넘어오는 파일 경로값 내용  : " + Bean.getFilename());
			System.out.println("넘어오는 카테고리  : " + Bean.getNewscategory());
			
			
			// 5. insert 문장을 DB에 전송 하여 실행
			pstmt.executeUpdate();
		} catch (Exception e) {
			System.out.println("뉴스 글작성 메소드 내부에서 SQL실행예외 : \n" + e);
		} finally { // 무조건 한번 실행 해야 할 구문이 있을때.... 작성하는 영역
			// 6.자원해제
			resourceClose();
		}
	}// insert글씨메소드 끝
	
/*******************************************************************************************************/	
	public int getNewsBoardSeq(){ // 게시글 최신 리스트 반환하는 함수
		//board테이블에 저장되어 있는 조회한 글개수를 저장할 변수
		int seq = 0;
		
		try {
			//커넥션풀로 부터 케넥션 얻기(DB와의 연결)
			con = getConnection();
			//SQL문 : 전체 글개수 조회
			sql = "select * from newsboard order by num desc limit 1";
			// 최신 num값 가져옴
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();//전체 글개수 조회후 반환
			//전체 글 개수가 조회 된다면
			if(rs.next()){
				seq = rs.getInt(1);// 조회한 글개수를 저장
				System.out.println("조회된 최신 num번호" + seq);
			}
		} catch (Exception e) {
			System.out.println("getNewsBoardSeq()메소드 내부에서 예외발생 : " + e);
		} finally {
			//자원해제
			resourceClose();
		}	
		return seq; //조회한 글 마지막 num값 리턴 (즉 최신글 번호를 리턴하겠다는 의미임)
	}
	/*******************************************************************************************************/
	
}
