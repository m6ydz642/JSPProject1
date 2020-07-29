package board;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class BoardDAO {
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
	public int getBoardCount(){
		//board테이블에 저장되어 있는 조회한 글개수를 저장할 변수
		int count = 0;
		
		try {
			//커넥션풀로 부터 케넥션 얻기(DB와의 연결)
			con = getConnection();
			//SQL문 : 전체 글개수 조회
			sql = "select count(*) from board";
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
	/*******************************************************************************************************/	
	//글목록 검색해서 가져오는 메소드
	public List<BoardBean> getBoardList(int startRow,int pageSize){
		
		//board테이블로 부터 검색한 글정보들을 
		//각각 한줄단위로  BoardBean객체에 저장후~
		//BoardBean객체들을 각각 ArrayList배열에 추가로 저장하기 위한 용도
		List<BoardBean> boardList = new ArrayList<BoardBean>();
		
		try{
			//DB연결
			con = getConnection();
			//SQL문 만들기
			// sql = "select * from board order by re_ref desc, re_seq asc limit ?,?";
			sql = "select * from board order by num desc limit ?,?"; // 답글없어서 단순하게 num값으로만 함
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, startRow);
			pstmt.setInt(2, pageSize);
			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				//검색한 글목록중.. 한줄단위의 데이터를 저장할 용도로 객체 생성
				BoardBean bBean = new BoardBean();
				// rs => BoardBean객체의 각변수에 저장
				bBean.setContent(rs.getString("content"));
				bBean.setDate(rs.getTimestamp("date"));
				bBean.setUserid(rs.getString("userid"));
				// bBean.setName(rs.getString("name"));
				bBean.setNum(rs.getInt("num"));
				// bBean.setPasswd(rs.getString("passwd"));
				// bBean.setRe_lev(rs.getInt("re_lev"));
				// bBean.setRe_seq(rs.getInt("re_seq"));
				// bBean.setRe_ref(rs.getInt("re_ref"));
				bBean.setReadcount(rs.getInt("readcount"));
				bBean.setSubject(rs.getString("subject"));
				//BoardBean 객체  =>  ArrayList배열에 추가
				boardList.add(bBean);
			
			}//while반복문 끝
		
		}catch(Exception e){
			System.out.println("getBoardList메소드 내부에서 예외 발생 : " + e);
		}finally {
			//자원해제
			resourceClose();
		}
		
		return boardList; //검색한 글정보들(BoardBean객체들)을 저장하고 있는 배열공간인?
						  //ArrayList를  notice.jsp페이지로 반환(리턴)
	}//getBoardList메소드 끝
	
	/*******************************************************************************************************/
	public BoardBean getBoard(int num) { // 게시글 읽기
		BoardBean bBean = null;
		
		try {
			
		
		//DB연결
		con = getConnection();
		//SQL문 만들기 : 매개변수로 전달받은 num에 해당하는글 조회
		sql = "select * from board where num = ?";
		//PreparedStatement SQL문 실행객체 얻기
		pstmt = con.prepareStatement(sql);
		//? 기호에 대응되는 글번호num을 설정
		pstmt.setInt(1,num);
		rs = pstmt.executeQuery();
		rs.next();
	
	
		int count = 0;
	
		bBean = new BoardBean();
		
		bBean.setContent(rs.getString("content"));
		bBean.setDate(rs.getTimestamp("date"));
		bBean.setUserid(rs.getString("userid"));
		// bBean.setName(rs.getString("name"));
		bBean.setNum(rs.getInt("num"));
		// bBean.setPasswd(rs.getString("passwd"));
		bBean.setRe_lev(rs.getInt("re_lev"));
		bBean.setRe_seq(rs.getInt("re_seq"));
		bBean.setRe_ref(rs.getInt("re_ref"));
		bBean.setReadcount(rs.getInt("readcount"));
		bBean.setSubject(rs.getString("subject"));
		//BoardBean 객체  =>  ArrayList배열에 추가
	


		
		} catch (Exception e) {

			System.out.println("getBoard 오류 : " + e);
		}finally {
			resourceClose();
		}
		
		return bBean; 
	}
	
	
	
	
/*******************************************************************************************************/	
	public void insertContent( BoardBean Bean ) {
		// 글작성 메소드
		int num = 1; // 오토인크리먼트 대신해서 쓸놈
		try {
			// 1.DB접속(연결) : 커넥션풀 DataSource로 부터 커넥션 Connection객체 빌려오기
			con = getConnection();

			sql = "select max(num) from board"; // 미리 한번 확인해보고
					pstmt=con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			if (rs.next()) {
			    num = rs.getInt(1)+1; // 오토인크리먼트는 num이 쓰고 있어서 얘로 대신씀
			}else {
				num = 1;
			}
			
			sql = "insert into board(num,userid, subject,content, re_seq,readcount, date) "
					+ "values(null,?,?,?,?,?,now())";

			pstmt = con.prepareStatement(sql);
			// 4. ?기호에 대응되는 값들을 설정
			pstmt.setString(1, Bean.getUserid());
			pstmt.setString(2, Bean.getSubject());
			pstmt.setString(3, Bean.getContent());
			pstmt.setInt(4, Bean.getRe_seq());
			pstmt.setInt(5, 0); // 조회수, 게시글을 작성할 때 처음부터 조회수 1을 미리 안주면 0인상태로 계속 안올라감
			
		
			
			System.out.println("넘어오는 값 아이디 : " + Bean.getUserid());
			System.out.println("넘어오는 값 제목 : " + Bean.getSubject());
			System.out.println("넘어오는 값 내용  : " + Bean.getContent());
			
			
			
			// 5. insert 문장을 DB에 전송 하여 실행
			pstmt.executeUpdate();
		} catch (Exception e) {
			System.out.println("글작성 메소드 내부에서 SQL실행예외 : \n" + e);
		} finally { // 무조건 한번 실행 해야 할 구문이 있을때.... 작성하는 영역
			// 6.자원해제
			resourceClose();
		}
	}// insert글씨메소드 끝
	
/*******************************************************************************************************/
	// 글조회 메서드
	public void updateReadCount(int num){

		//DB연결
		try {
			con = getConnection();
			sql = "update board set readcount=readcount+1 where num = ?";
			//PreparedStatement SQL문 실행객체 얻기
			pstmt = con.prepareStatement(sql);
			//? 기호에 대응되는 글번호num을 설정
			pstmt.setInt(1,num);
			pstmt.executeUpdate();
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			resourceClose();
		}
		
	
		
	}
/*******************************************************************************************************/	
	public int updateBoard(BoardBean bean) { // 글 수정
		int check = 0;
		try {
			con = getConnection();
			sql = "select userid from board where num = ?"; //글번호에 해당하는 유저 아이디를 확인하는 쿼리

			pstmt = con.prepareStatement(sql);
			
			pstmt.setInt(1,bean.getNum()); 
			System.out.println("num값 " +bean.getNum());
			
			System.out.println("넘어온 유저 아이디 값 (쿼리전)" + bean.getUserid());
			rs = pstmt.executeQuery();
			
			if (rs.next()) { // 다음단계로 진행이 되면
				check = 1; // 참으로 변경
				System.out.println("넘어온 유저 아이디 값 (rs.next성공)" + bean.getUserid());
				
				if(bean.getUserid().equals(rs.getString("userid"))) { // 작성한 유저아이디와 접근한 아이디가 같다면
				
		
					sql = "update board set subject = ?, content = ? where num = ?";
					
					System.out.println("넘어온 유저 아이디 값 (쿼리 정상 작동)" + bean.getUserid());
					pstmt = con.prepareStatement(sql);
					pstmt.setString(1, bean.getSubject());
					
					pstmt.setString(2, bean.getContent());
					pstmt.setInt(3, bean.getNum());
					
					pstmt.executeUpdate();
					
					System.out.println("넘어온 유저  값 (내용 )" + bean.getContent());
					System.out.println("넘어온 유저  내용 (제목) " + bean.getSubject());
		
					
				}else {
					check =0; // 아니면 0반환후 입구컷
					System.out.println("넘어온 유저 아이디 값 (본인확인 실패)" + bean.getUserid());
				}
				
			}
			
		} catch (Exception e) {

			e.printStackTrace();
		} finally {
			resourceClose();
		}
		return check;
	}
	
	/*******************************************************************************************************/	
	public void DeleteContent (int num) { // 글삭제 메서드
		try {
			con = getConnection();
			int check = 0;
			sql="delete board, comment from board  inner join comment on comment.ref = board.num where board.num = ?";
			// 글삭제시 댓글테이블이랑 조인하여 같이 삭제
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			// pstmt.executeUpdate();
			check = pstmt.executeUpdate();
			System.out.println("update문 실행후 deletecontent excuteupdate결과 " + check );
			
			if (check == 0) { // 댓글이 없어서 삭제가 안되면, excuteupdate가 쿼리에 실패하면
				System.out.println("글 삭제 실패, 다른 쿼리문으로 전환");
				
				con = getConnection();
				sql="delete board from board where num = ?";
				// 글삭제시 댓글테이블이랑 조인하여 같이 삭제
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, num);
				System.out.println("update문 변경후 글삭제 완료 - 전달받은 excuteupdate 결과 값 : " + pstmt.executeUpdate());
			}
			// System.out.println("excuteupdate 결과 값 " + pstmt.executeUpdate());

			System.out.println("글삭제 메서드 실행 완료 ");
			
			

			
		}catch (Exception e) {
				System.out.println("글삭제 메서드 오류 발생" + e);
			}finally {
				resourceClose();
			}
	
	}
	/*******************************************************************************************************/
	
	
}
