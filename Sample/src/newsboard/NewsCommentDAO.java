package newsboard;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;


public class NewsCommentDAO {
	
	private Connection getConnection() throws Exception {
		Context init = new InitialContext();
		DataSource ds = (DataSource)init.lookup("java:comp/env/jdbc/Sample");
		Connection con = ds.getConnection();
		
		return con;
		
	} 
			

	/***********************************************************************************/	
	public void insertNewsComment(NewsCommentBean cb){
		int num =  cb.getNum();
		int number =0;
		
		Connection con=null;
		String sql="";
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		
		try{
			con = getConnection();
			sql="select max(num) as num from newscomment";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if(rs.next()){
				number=rs.getInt(1)+1;
			}else{
				number=1;
			}
			sql = "insert into newscomment values(?, ?, ?, ?, now())";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, number); // 오토인크리먼트 대체용
			pstmt.setString(2, cb.getId()); // 댓글 아이디임
			pstmt.setString(3, cb.getContent());
			pstmt.setInt(4, cb.getRef());
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
	public List getNewsBoardComment(int num){  // 댓글 조회
		
		List commentList=new ArrayList();
		
		Connection con=null;
		PreparedStatement pstmt=null;
		String sql="";
		ResultSet rs=null;
		try {
			con=getConnection();
			sql="select * from newscomment where ref=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, num);
			
			rs=pstmt.executeQuery();
			while(rs.next()){
				NewsCommentBean cb=new NewsCommentBean();
				cb.setNum(rs.getInt("num"));
				cb.setId(rs.getString("id"));
				cb.setContent(rs.getString("content"));
				cb.setReg_date(rs.getDate("reg_date"));
				cb.setRef(rs.getInt("ref"));
				commentList.add(cb);
				// NewsCommentCount(num);
				// System.out.println("뉴스 코맨트 카운트 횟수 + ");
				
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
	
	public int deleteComment(int num){
		int check = 0;
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		String sql ="";
		
		try {
			con = getConnection();
			sql = "delete from newscomment where num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
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
		return check;
		
	}
	/***********************************************************************************/	
	public int deleteNewsComment(int num, String userid){ // NewsCommentDelete_pro에서 
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
			sql = "delete from newscomment where num = ? and id = ?"; // 댓글 작성번호와 댓글 id 안맞으면 false
			System.out.println("뉴스 댓글 삭제 쿼리 완료 삭제된 번호 : " + num);
			System.out.println("뉴스 댓글 삭제 쿼리 완료 넘어온 id : " + userid);
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
		System.out.println("뉴스 댓글 삭제 check값 = " + check);
		return check;
		
	}
	
	public int NewsCommentCount (int ref) { // 댓글수를 세어주는 메서드 (뉴스댓글 옆에 표시할 용도) 
		// ref값을 받아서 글 옆에 댓글 보여줄거
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		String sql ="";
		int count = 0;
		
		try {
			con = getConnection();
			sql = "select count(*) from newscomment where ref = ?"; // 게시글에 해당하는 댓글 횟수 조회
			System.out.println("뉴스 댓글 조회 번호 : " + ref);
	
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
	/***********************************************************************************/
}
