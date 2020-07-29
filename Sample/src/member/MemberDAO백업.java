package member;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class MemberDAO백업 {

// 전역변수로 선언
	Connection con = null;
	ResultSet rs = null;
	PreparedStatement pstmt = null;
	String sql = "";

	public void resourceClose() {
		try {
			if (pstmt != null)
				pstmt.close();
			if (rs != null)
				rs.close();
			if (con != null)
				con.close();
		} catch (Exception e) {
			System.out.println("자원해제 실패 : " + e);
		}
	}// resourceClose()

	private Connection getConnection() throws Exception {

		Connection con = null;
		Context init = new InitialContext();
		// 커넥션풀 얻기
		DataSource ds = (DataSource) init.lookup("java:comp/env/jdbc/Sample");
		// 커넥션풀로 부터 커넥션 객체 빌려와서 얻기
		con = ds.getConnection();

		return con; // 커넥션을 반환

	}

	public void insertMember(MemberBean memberBean) {

		try {
			// 1.DB접속(연결) : 커넥션풀 DataSource로 부터 커넥션 Connection객체 빌려오기
			con = getConnection();

			// 2.SQL문 만들기 (INSERT)
			sql = "insert into member(userid,userpasswd,name,gender,phone,email,address,address2,reg_date)"
					+ "values(?,?,?,?,?,?,?,?,now())";

			// 3. 위 Insert전체 문자열 중에서 ?기호에 대응되는 설정값을 제외한 전체 구문을
			// PreparedStatement객체에 로딩후
			// PreparedStatement객체 자체를 반환
			pstmt = con.prepareStatement(sql);
			// 4. ?기호에 대응되는 값들을 설정
			pstmt.setString(1, memberBean.getUserid());
			pstmt.setString(2, memberBean.getUserpasswd());
			pstmt.setString(3, memberBean.getName());
			pstmt.setString(4, memberBean.getGender());
			pstmt.setInt(5, memberBean.getPhone());
			pstmt.setString(6, memberBean.getEmail()); // 까먹고 Db안만듦
			pstmt.setString(7, memberBean.getAddress());
			pstmt.setString(8, memberBean.getAddress2());

			System.out.println("넘어오는 값 아이 : " + memberBean.getUserid());
			System.out.println("넘어오는 값 패스워드 : " + memberBean.getUserpasswd());
			System.out.println("넘어오는 값 이름 : " + memberBean.getName());
			System.out.println("넘어오는 값 성별 : " + memberBean.getGender());
			System.out.println("넘어오는 값 주소1 : " + memberBean.getAddress());
			System.out.println("넘어오는 값 나머지주소 : " + memberBean.getAddress2());
			
			// 5. insert 문장을 DB에 전송 하여 실행
			pstmt.executeUpdate();
		} catch (Exception e) {
			System.out.println("insertMember메소드 내부에서 SQL실행예외 : \n" + e);
		} finally { // 무조건 한번 실행 해야 할 구문이 있을때.... 작성하는 영역
			// 6.자원해제
			resourceClose();
		}
	}// insertMember메소드 끝

// 로그인시  체크 항목 
public int userCheck(String userid, String userpasswd) { // 매개변수 값 받기
	int check = -1; // 기본적으로 틀린항목으로 만들어 놓는다. 
	System.out.println("로그인 메서드 호출성공 입력한 아이디 -> " + userid);
	System.out.println("로그인 메서드 호출성공 입력한 비밀번호 -> " + userpasswd);
	System.out.println("check값 : " + check);
	try {
		System.out.println("try구문 실행 성공 ");
		con = getConnection();
		sql = "select * from member where userid = ?"; // 레코드 검
		pstmt = con.prepareStatement(sql);  // 프리스테이트 객체 얻기
		pstmt.setString(1,  userid); // 아이디 값 설정  
		rs = pstmt.executeQuery(); 
	if (rs.next()) { // 쿼리를 성공해서 다음 영역으로 넘어갈 수 있으면 
		System.out.println("rs.next성공 입력한 아이디 -> " + userid);
		if(userpasswd.equals(rs.getString("userpasswd"))) {
			// 인자로 입력받은 패스워드가 맞는지 
			// DB에 저장된 항목을 게터에서 가져와 excutequery 해서 가져온 (DB값) 값이랑 비교 
			check = 1; //  값이 같으면 1이라는 항목으로 변경 
		}else {
			check = 0; //  다르면 0이라는 값으로 바꾼다.
			System.out.println("비밀번호  틀림 입력한 비밀번호 -> " + userpasswd);
		} // 2번째 if문 블록 
	}else { // rs.next가 되지않으면, 즉 쿼리검색자체가 안되면
		check = -1; // 위에서선언한 변수처럼 다시 -1로 바꿈 
	}
	}	catch(Exception e)  {
	System.out.println("usercheck메소드에서 오류 발생 \n" + e);
	}  finally {
		resourceClose(); // 자원해제
	}
	System.out.println("곧 반환할 check 값 " + check);
	return check; // loginPro.jsp로 값 리턴

}

/************************************************************************************/
// 마이페이지 확인
public MemberBean getmember(String userid) { // 마이페이지에 들어올 경우 맴버 읽기
	MemberBean bBean = null;
	
	try {
		
	
	//DB연결
	con = getConnection();
	//SQL문 만들기 : 매개변수로 전달받은 num에 해당하는글 조회
	sql = "select * from member where userid = ?";
	//PreparedStatement SQL문 실행객체 얻기
	pstmt = con.prepareStatement(sql);
	//? 기호에 대응되는 글번호num을 설정
	pstmt.setString(1,userid);
	rs = pstmt.executeQuery();
	rs.next();


	//select문 실행후 조회한 결과 레코드 얻기 

	bBean = new MemberBean();
	
	bBean.setUserid(rs.getString("userid"));
	bBean.setUserpasswd(rs.getString("userpasswd"));
	bBean.setGender(rs.getString("gender")); // 나머지는 나중에 가져오던지 하기
	bBean.setName(rs.getString("name"));
	bBean.setPhone(rs.getInt("phone"));
	 bBean.setAddress(rs.getString("address"));
	 bBean.setAddress2(rs.getString("address2"));
	
	 bBean.setEmail(rs.getString("email"));

	
	//BoardBean 객체  =>  ArrayList배열에 추가



	
	} catch (Exception e) {

		System.out.println("getmember 오류 : " + e);
	}finally {
		resourceClose(); // 자원해제
	}
	
	return bBean; 
}

/************************************************************************************/
//마이페이지에서 비밀번호 변경시 미리 체크하는 페이지 
public boolean checkUser(String userid, String userpasswd) { // 마이페이지에 들어올 경우 맴버 읽기
	//아이디가 같이 있어야 비교 대상이 생겨서 같이 가져옴 
	boolean check = false; // 기본값으로 무조건 거짓으로 (안그러면 자기혼자 참뜰수 있어서)
	
	try {
		
	
	//DB연결
	con = getConnection();
	//SQL문 만들기 : 매개변수로 전달받은 num에 해당하는글 조회
	// 넘어온 아이디 값과 같이 비밀번호도 덤으로 확인 
	sql = "select userid, userpasswd from member where userid = ? and userpasswd = ?";
	//PreparedStatement SQL문 실행객체 얻기
	pstmt = con.prepareStatement(sql);
	//? 기호에 대응되는 글번호num을 설정
	pstmt.setString(1,userid);
	pstmt.setString(2,userpasswd);
	
	System.out.println("마이페이지  넘어온 값 아이디 : " + userid);
	System.out.println("마이페이지  넘어온 값 비밀번호 : " + userpasswd);
	System.out.println("비밀번호 체크 완료");
	
	rs = pstmt.executeQuery();
	
	if (rs.next()) { // 정보가 맞아서 rs.next영역으로 넘어가면 
		check = true;
	}else {
		check = false;
	}

	
	} catch (Exception e) {

		System.out.println("checkuser 오류 : " + e);
	}finally {
		resourceClose(); // 자원해제
	}
	
	return check; // 참이냐 구라냐만 리턴 
}

/*********************************************************************/
//비밀번호 변경 메서드
 
public void UpdatePass(String userid, String userpasswd) {
	try {
		con = getConnection();
		String sql = "update member set userpasswd = ? where userid = ? ";
		pstmt = con.prepareStatement(sql);
		pstmt.setString(1, userpasswd);
		pstmt.setString(2, userid);
		
		pstmt.executeUpdate();
		System.out.println("마이페이지  넘어온 값 아이디 : " + userid);
		System.out.println("마이페이지  넘어온 값 비밀번호 : " + userpasswd);
		System.out.println("비밀번호 변경 완료! ");
	} catch (Exception e) {
		System.out.println("updatepass메서드 오류 " + e);
		e.printStackTrace();
	}

}


public void UpdateMember(MemberBean bean) { // 비밀번호 수정외에 일반 정보 수정용
	try {
		con = getConnection();
		String sql = "update member set phone = ?, email = ?, address = ?, address2 = ? where userid = ?";
		pstmt = con.prepareStatement(sql);
		System.out.println("업데이트 메서드 휴대폰 번호 " + bean.getPhone());
		System.out.println("업데이트 메서드 이메일 번호 " + bean.getEmail());
		System.out.println("업데이트 메서드 주소 1 " + bean.getAddress());
		System.out.println("업데이트 메서드 주소 2 " + bean.getAddress2());
		System.out.println("입력받은 아이디" + bean.getUserid());
		
		pstmt.setInt(1, bean.getPhone());
		pstmt.setString(2, bean.getEmail());
		pstmt.setString(3, bean.getAddress());
		pstmt.setString(4, bean.getAddress2());
		pstmt.setString(5, bean.getUserid());
		
		pstmt.executeUpdate();
		System.out.println("그냥 개인정보 변경 완료! ");
	} catch (Exception e) {
		System.out.println("update member메서드 오류 " + e);
		e.printStackTrace();
	}

}


public String findId(String name, String email) throws Exception { // 입력받은 이름과 이메일로 쿼리 검색 (아이디 찾기 메서드)
	String id = null;
	
	try {
		con = getConnection();
		

		String sql = "select userid" + " from member" + " where name = ? and" + " email = ?";

		pstmt = con.prepareStatement(sql);
		
		pstmt.setString(1, name);
		pstmt.setString(2, email);



		rs = pstmt.executeQuery();
		if (rs.next()) {

			id = rs.getString("member.userid"); // 쿼리에 성공하면 member에 해당하는 userid 담음
			System.out.println("아이디 찾기 성공! userid값 " + id);
		}else {
			System.out.println("아이디 찾기 쿼리 실패  userid 값 " + id);
		}


	} catch (SQLException e) {
		System.out.println("findid 오류 발생 " + e);
		System.out.println("들어간 값  : " + id);

	}

	return id;

}

} // 클래스 마지막 
