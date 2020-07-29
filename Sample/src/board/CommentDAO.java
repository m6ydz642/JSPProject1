package board;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;


public class CommentDAO {
	
	private Connection getConnection() throws Exception {
		Context init = new InitialContext();
		DataSource ds = (DataSource)init.lookup("java:comp/env/jdbc/Sample");
		Connection con = ds.getConnection();
		
		return con;
		
	} 
			
/***********************************************************************************/
	public void insertComment(CommentDTO cb){ // 댓글 추가 쿼리문
		int num =  cb.getNum();
		int number =0;
		
		Connection con=null;
		String sql="";
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		
		try{
			con = getConnection();
			sql="select max(num) as num from comment";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if(rs.next()){
				number=rs.getInt(1)+1;
			}else{
				number=1;
			}
			sql = "insert into comment values(?, ?, ?, ?, now())";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, number);
			pstmt.setString(2, cb.getId());
			pstmt.setString(3, cb.getContent());
			pstmt.setInt(4, cb.getRef()); // 댓글 확인용
			pstmt.executeUpdate();
		}
		catch(Exception e){
			e.printStackTrace();
		}finally{
			if(rs!=null)try{rs.close();}catch(SQLException ex){};
			if(pstmt!=null)try{pstmt.close();}catch(SQLException ex){};
			if(con!=null)try{con.close();}catch(SQLException ex){};
		}
	}
	
	/***********************************************************************************/
	public List getBoard(int num){  // 댓글 조회
		
		List commentList=new ArrayList();
		
		Connection con=null;
		PreparedStatement pstmt=null;
		String sql="";
		ResultSet rs=null;
		try {
			con=getConnection();
			sql="select * from comment where ref=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, num);
			
			rs=pstmt.executeQuery();
			while(rs.next()){
				CommentDTO cb=new CommentDTO();
				cb.setNum(rs.getInt("num"));
				cb.setId(rs.getString("id"));
				cb.setContent(rs.getString("content"));
				cb.setReg_date(rs.getDate("reg_date"));
				cb.setRef(rs.getInt("ref"));
				commentList.add(cb);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally{
			if(rs!=null)try{rs.close();}catch(SQLException ex){}
			if(pstmt!=null)try{pstmt.close();}catch(SQLException ex){}
			if(con!=null)try{con.close();}catch(SQLException ex){}
		}
		return commentList;
	} 
	/***********************************************************************************/
	/*
	public int getCommentCheck(CommentDTO bean){ // 댓글에 유저 확인하는 함수
		//board테이블에 저장되어 있는 조회한 글개수를 저장할 변수
		int check = 0;
		Connection con=null;
		PreparedStatement pstmt=null;
		String sql="";
		ResultSet rs=null;
		try {
			//커넥션풀로 부터 케넥션 얻기(DB와의 연결)
			con = getConnection();
			//SQL문 : 전체 글개수 조회
			sql="select * from comment where userid=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1,bean.getId()); 

			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();//전체 글개수 조회후 반환
			//전체 글 개수가 조회 된다면
			if (rs.next()) { // 다음단계로 진행이 되면
				check = 1; // 참으로 변경
				System.out.println("넘어온 유저 아이디 값 (rs.next성공)" + bean.getId());
				
				if(bean.getId().equals(rs.getString("userid"))) { // 작성한 유저아이디와 접근한 아이디가 같다면
				
		
					sql = "delete comment where num = ?";
					
					System.out.println("넘어온 유저 아이디 값 (쿼리 정상 작동)" + bean.getId());
					pstmt = con.prepareStatement(sql);
		
					
					pstmt.setString(1, bean.getId());
					
					pstmt.executeUpdate();
				}else {
					check =0; // 아니면 0반환후 입구컷
					System.out.println("넘어온 유저 아이디 값 (본인확인 실패)" + bean.getId());
				}
			}
			
		} catch (Exception e) {
			System.out.println("getCommentCheck()메소드 내부에서 예외발생 : " + e);
		} finally {
			//자원해제
			// 잠시 버림
		}	
		return check; 
	}
	*/
	/***********************************************************************************/
	public int deleteComment(int num, String userid){ // CommentDelete_pro에서 
		// 인자 2개를 받아서 작성자와 댓글번호가 일치하는지 확인한다.
		// 아이디는 세션에서 넘어온 값을 확인하고,  123 이라는 아이디로 작성된 댓글인데 
		// kim이라는 사용자가 로그인을 하면 세션정보가 달라서 123 사용자가 아니라서 거짓으로 리턴한다 
		int check = 0;
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		String sql ="";
		
		try {
			con = getConnection();
			sql = "delete from comment where num = ? and id = ?"; // 댓글 작성번호와 댓글 id 안맞으면 false
			System.out.println("댓글 삭제 쿼리 완료 삭제된 번호 : " + num);
			System.out.println("댓글 삭제 쿼리 완료 넘어온 id : " + userid);
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			pstmt.setString(2, userid);
			check = pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(rs!=null)
				try {
					rs.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			if(pstmt!=null)
				try {
					pstmt.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			if(con!=null)
				try {
					con.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			
		}
		System.out.println("댓글 삭제 check값 = " + check);
		return check;
		
	}
	
	
	public int BoardCommentCount (int ref) { // 댓글수를 세어주는 메서드 (뉴스댓글 옆에 표시할 용도) 
		// ref값을 받아서 글 옆에 댓글 보여줄거
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		String sql ="";
		int count = 0;
		
		try {
			con = getConnection();
			sql = "select count(*) from comment where ref = ?"; // 게시글에 해당하는 댓글 횟수 조회
			System.out.println("보드 댓글 조회 번호 : " + ref);
	
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, ref);
			
			
			rs=pstmt.executeQuery();
			if (rs.next()) {
				count = rs.getInt(1); /// select 조회한 결과물넣음
			}else {
				count = 0;
			}
			System.out.println("뉴스댓글 조회 완료" + ref + " 번호의" + "카운트 갯수" + count);
		
		} catch (Exception e) {
			System.out.println("뉴스 코멘트 카운트 오류 발생 " + e);
		}finally {
			if(rs!=null)
				try {
					rs.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			if(pstmt!=null)
				try {
					pstmt.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			if(con!=null)
				try {
					con.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
		}
		return count;
		
	}
}
