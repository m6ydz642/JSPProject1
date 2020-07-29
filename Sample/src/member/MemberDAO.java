package member;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Random;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class MemberDAO {

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

	public boolean insertMember(MemberBean memberBean) {
		// 가입 성공 여부 확인 받기 위해 return 받는 걸로 바꿈 
		boolean check = false;
		try {
			// 1.DB접속(연결) : 커넥션풀 DataSource로 부터 커넥션 Connection객체 빌려오기
			con = getConnection();

			// 2.SQL문 만들기 (INSERT)
			sql = "insert into member(userid,userpasswd,name,gender,phone,email,address,address2,session,exfire,reg_date)"
					+ "values(?,?,?,?,?,?,?,?,?,?,now())";

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
			pstmt.setString(6, memberBean.getEmail()); 
			pstmt.setString(7, memberBean.getAddress());
			pstmt.setString(8, memberBean.getAddress2());
			pstmt.setInt(9, 0); // 세션 여부 0으로 초기화 
			pstmt.setString(10, "N"); // 만료 여부 N으로 고정
	
			
			System.out.println("넘어오는 값 아이 : " + memberBean.getUserid());
			System.out.println("넘어오는 값 패스워드 : " + memberBean.getUserpasswd());
			System.out.println("넘어오는 값 이름 : " + memberBean.getName());
			System.out.println("넘어오는 값 성별 : " + memberBean.getGender());
			System.out.println("넘어오는 값 주소1 : " + memberBean.getAddress());
			System.out.println("넘어오는 값 나머지주소 : " + memberBean.getAddress2());
			
			/*****************************************************/
			// 패스워드 잠금처리 부분 insert하기
			System.out.println("넘어오는 값 session값 : " + memberBean.getSession());
			System.out.println("넘어오는 값 getExfire 값 : " + memberBean.getExfire());
			/*****************************************************/
			check = true;
			System.out.println("가입 진행중 check 값 = " + check);
			// 5. insert 문장을 DB에 전송 하여 실행
			pstmt.executeUpdate();
		} catch (Exception e) {
			System.out.println("insertMember메소드 내부에서 SQL실행예외 : \n" + e);
			// 예외 발생시 false로 리턴
			check = false;
			System.out.println("회원 가입 에서 오류가 발생함 check값 " + check);
		} finally { // 무조건 한번 실행 해야 할 구문이 있을때.... 작성하는 영역
			// 6.자원해제
			resourceClose();
		}
		return check;
	}// insertMember메소드 끝

	

public int userCheck(String userid, String userpasswd) { // 매개변수 값 받기
	int check = -1; // 기본적으로 틀린항목으로 만들어 놓는다. 
	String sql2="";
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
		// pstmt.executeUpdate();
	if (rs.next()) { // 쿼리를 성공해서 다음 영역으로 넘어갈 수 있으면 
		System.out.println("rs.next성공 입력한 아이디 -> " + userid);

		
		if(userpasswd.equals(rs.getString("userpasswd"))) {
			// 인자로 입력받은 패스워드가 맞는지 
			// DB에 저장된 항목을 게터에서 가져와 excutequery 해서 가져온 (DB값) 값이랑 비교 
			check = 1; //  값이 같으면 1이라는 항목으로 변경 
			
			// UserSuccess(userid); // 로그인 성공시 세션값 초기화 하러 감, 유저 인자 같이 전송
		//	userexfirestatus(userid); // 로그인 아이디 인자 전송, 성공시 만료여부 N으로 초기화
		}else {
			check = 0; //  다르면 0이라는 값으로 바꾼다.
			System.out.println("비밀번호  틀림 입력한 비밀번호 -> " + userpasswd);
		//	UserSession(userid); // 로그인 실패시, 유저인자 같이 전송
				
			
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
	public int userexfirestatus(String userid) { // 계정 사용가능 여부
		// 참거짓으로만 하니까 가입안된 계정에서도 동일한 경고가 떠서 boolean에서 int로 수정함
		
		// LoginPro로 부터 아이디 받아옴
		int check = 0; // 기본값으로 무조건 거짓으로 (안그러면 자기혼자 참뜰수 있어서)
		String status = "";
		try {

			// DB연결
			con = getConnection();
			// SQL문 만들기 : 매개변수로 전달받은 num에 해당하는글 조회
			// 넘어온 아이디 값과 같이 비밀번호도 덤으로 확인
			sql = "select userid, exfire from member where userid = ?";
			// PreparedStatement SQL문 실행객체 얻기
			pstmt = con.prepareStatement(sql);
			// ? 기호에 대응되는 글번호num을 설정
			pstmt.setString(1, userid);

			System.out.println("유저 exfire 아이디 상태 : " + userid);
			// System.out.println("마이페이지 넘어온 값 비밀번호 : " + userpasswd);
			System.out.println("아이디 만료여부 체크 완료");

			rs = pstmt.executeQuery();

			rs.next();
		
			System.out.println("DB로 부터 조회해서 가져온 유저 세션 값 : " + rs.getString(2));
			// 첫번째 항목을 가져옴
			status = rs.getString(2);
			System.out.println("rs.next성공 계정 유효기간 상태" + status);
			

			if (status.equals("Y")) { // Y은 만료로 처리함
				System.out.println(userid + "는 유효기간 만료된 계정");
				System.out.println("유효기간 상태" + status);
				check = 2; // 만료상태면 false값 주기
				System.out.println("유효기간에 문제가 있음 check 값 처리 : " + check );
			} else if (status.equals("N"))  {
				System.out.println(userid + "유저의 계정 상태 ");
				System.out.println("계정상태 " + status);
				check = 1;
				System.out.println("유효기간에 문제가 없음 check 값 처리 : " + check );
			}else {
				check = 999;
				System.out.println("없는 계정 접속 check 값 처리 : " + check );
			}
		} catch (Exception e) {

			System.out.println("checkuser 오류 : " + e);
		} finally {
			resourceClose(); // 자원해제
		}
		return check; // 체크값을 리턴함
	}



public void UserSuccess(String userid) {  // 유저 체크 함수에서 인자 같이 받아옴
	//유저 로그인 성공시
	// 세션값 초기화 하러옴
	// 초기화 안하면 로그인 실패했던거 누적되서 마지막 3번째가 되면 
	// 로그인 못함
	System.out.println(userid + "님이 로그인 성공 세션 호출 성공");
	System.out.println(userid + "님의 세션 초기화 완료");

	try {
		// 세션 부분
		con = getConnection();
		sql = "update member set session = 0 " // 세션 초기화 항목
				// 초반부터 -1을 부여함...
				// usersessionover 부분에서 로직처리가 잘못되서 로그인할때 마다 1로 초기화가 되기 때문
				+ "where userid = ?";
		
		pstmt = con.prepareStatement(sql);
		pstmt.setString(1,userid);
		pstmt.executeUpdate();
		// rs.next();
		
		/***********************************************************************/
		
		// exfire부분
		String sql2 = "update member set exfire = 'N' where userid = ?"; // 로그인에 성공하면 exfire를 N으로 바꿈

	
		pstmt = con.prepareStatement(sql2);
		pstmt.setString(1,userid);
		// rs = pstmt.executeQuery(); 
		pstmt.executeUpdate();
//		while(rs.next())
//		{
//		System.out.println ("DB로 부터 조회해서 가져온 유저 exfire 값 : " + rs.getString(1));
//		// 첫번째 항목을 가져옴
//		exfire = rs.getString(1);
//		}
		System.out.println("유저 exfire 초기화 완료");

		
	} catch (SQLException e) {
		System.out.println("유저 success 오류" + e);
		e.printStackTrace();
	} catch (Exception e) {
		// TODO Auto-generated catch block
		System.out.println("유저 success 오류" + e);
		e.printStackTrace();
	}finally {
		resourceClose(); // 자원해제
	}

}

/************************************************************************************/
//public int UserSession (String userid) throws Exception { // 세션 항목
//	
//	int  session = 0;
//	
//	System.out.println("유저 세션 함수 호출 성공");
//
//	try {
//		con = getConnection();
//		System.out.println("세션으로 받은 받은 userid  값 : " + userid);
//		String sql2 = "select session, userid from member where userid=?";
//		pstmt = con.prepareStatement(sql2);
//		pstmt.setString(1,userid);
//		rs = pstmt.executeQuery(); 
//		
//		// rs.next(); // 밑에서 println에 넣으면서 rs.next가 작동해서 
//	// 또 못함
//		// System.out.println("세션 rs next값 : " + rs.next());
//		System.out.println("유저 세션 쿼리 성공");
//		/////////////////////////////////////////////////////////
//		// while(rs.next())
//		rs.next();
//		
//		System.out.println ("DB로 부터 조회해서 가져온 유저 세션 값 : " + rs.getInt(1));
//		// 첫번째 항목을 가져옴
//		session = + rs.getInt(1);
//		
//		
//		 System.out.println("rx.next로 들어간 세션 값" + session);
//	
//		
//		 System.out.println();
//		
//		if (session < 3) { // 세션이 3미만 이면
//			session = session +1;
//			con = getConnection();
//			System.out.println("비밀번호 오류로 인한 오류카운트 추가 : " + session);
//			
//			String sql3 = "update member set session = session + 1 " // 비밀번호를 틀릴때 마다 해당 유저의  세션값을 1씩 추가함
//					+ "where userid = ?";
//			pstmt = con.prepareStatement(sql3);
//			pstmt.setString(1,userid);
//			 // rs = pstmt.executeQuery(); 
//			pstmt.executeUpdate();
//		System.out.println("유저 로그인 실패 세션값 추가 완료");
//			System.out.println(userid + "아이디에 추가된 세션 값 : " + session);
//		// 또 다른 함수를 추가할 예정
//
//		}else{
//			System.out.println("세션항목이 이미 오버됨 세션값 :" + session);
//			// UserSessionOver(userid); // 세션항목을 카운트 하다가 오버되면  오버처리를 함
//		//	 System.out.println("세션 오버 함수 호출 완료 결과 : " + UserSessionOver(userid));
//			
//		}
//		
//	} catch (SQLException e) {
//		System.out.println("유저세션 체크 항목 오류");
//		e.printStackTrace();
//	}finally {
//		resourceClose(); // 자원해제
//	}
//	
//	return session;
//	
//} // 유저세션 마지막 항목

/************************************************************************************/

public boolean UserSessionOver(String userid) { // 비밀번호 위 UserSession 함수에서 3번이상 
										// 틀리면 비밀번호 이상하게 바꿔놈
	boolean check = true;
// 세션 오버 부분	
	
	try {
	//	System.out.println("세션 오버로 받은 세션의 값 " + session);
		con = getConnection();
		System.out.println("UserSessionOver 호출 완료");
		System.out.println("세션으로 받은 받은 userid  값 : " + userid);
		sql= "select session, userid from member where userid=?";
		pstmt = con.prepareStatement(sql);
		pstmt.setString(1,userid);
		rs = pstmt.executeQuery(); 

		rs.next();
		System.out.println("유저 세션 쿼리 성공");
		
		
		System.out.println ("DB로 부터 조회해서 가져온 유저 세션 int 값 : " + rs.getInt(1));
		// 첫번째 항목을 가져옴
		int session = rs.getInt(1);
		 System.out.println("rx.next로 들어간 세션 값" + session);
	
		
		 System.out.println();
		
		if (session < 3) { // 세션이 3미만 이면
			session = session + 1;
			System.out.println("비밀번호 오류로 인한 오류카운트 추가 : " + session);
			
			String sql3 = "update member set session = session + 1 " // 비밀번호를 틀릴때 마다 해당 유저의  세션값을 1씩 추가함
					+ "where userid = ?";
			pstmt = con.prepareStatement(sql3);
			pstmt.setString(1,userid);
			pstmt.executeUpdate();
		System.out.println("유저 로그인 실패 세션값 추가 완료");
			System.out.println(userid + "아이디에 추가된 세션 값 : " + session);
		// 또 다른 함수를 추가할 예정

		}else{
			System.out.println("세션항목이 이미 오버됨 세션값 :" + session);
			// UserSessionOver(userid); // 세션항목을 카운트 하다가 오버되면  오버처리를 함
		//	 System.out.println("세션 오버 함수 호출 완료 결과 : " + UserSessionOver(userid));
			
		}
		if (session == 3) {
		sql = "update member set userpasswd = ? "
				+ "where userid = ?";
		
		pstmt = con.prepareStatement(sql);
		
		pstmt.setString(1,"비밀번호 잠금처리"); // 강제로 해당 유저의 비밀번호 세팅
		pstmt.setString(2,userid);
		pstmt.executeUpdate();
		
		
		System.out.println("usersessionover userid값 " + userid);
		
/**************************************************************************/
	// 세션 오버로 인한 exfire y처리 부분
		// con = getConnection();
		String sql2 = "update member set exfire = 'Y' where userid = ?"; // 로그인에 성공하면 exfire를 N으로 바꿈

		
		pstmt = con.prepareStatement(sql2);
		pstmt.setString(1,userid);
		pstmt.executeUpdate();
		System.out.println(userid + " 아이디는 비밀번호 횟수초과로 계정 잠금처리 됨");
		//	System.out.println("세션이 이미 3이라 더이상 조회할 내용 없음 종료 시도 횟수 -> " + session);
		check = false;
		}

	} catch (Exception e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}finally {
		resourceClose(); // 자원해제
	}
return check;
	
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
	}finally {
		resourceClose(); // 자원해제
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
			id = null; // 존재하지 않으면 null로 변경후 리턴에서 그대로 반환
		}


	} catch (SQLException e) {
		System.out.println("findid 오류 발생 " + e);
		System.out.println("들어간 값  : " + id);

	}finally {
		resourceClose(); // 자원해제
	}

	return id;

}




public String findPw(String userid, String email) throws Exception { // 입력받은 이름과 이메일로 쿼리 검색 (아이디 찾기 메서드)
	
	String userpasswd = "";
	try {
		PasswordRandom(userid); // 서블릿에서 요청할때 미리 비밀번호를 랜덤한 값으로 쿼리를 바꿈
		con = getConnection();
		
		/*********************************************************************************/
		// exfire부분 초기화
		String sql2 = "update member set exfire = 'N', session = 0 where userid = ?"; 
		// 비밀번호 찾기로 비번발급 성공시 exfire를 N으로 바꿈(로그인 할 수 있게) 
		
		pstmt = con.prepareStatement(sql2);
		pstmt.setString(1,userid);
		pstmt.executeUpdate();
		System.out.println(userid + " 유저가 비밀번호 찾기 성공으로 exfire 값을 해제함");
		// 세션값은 초기화를 안해도 상관없음 어짜피 비밀번호 틀린횟수 카운트 용도라서
	//	rs.next();
		/*********************************************************************************/
	
		String sql = "select userpasswd" + " from member" + " where userid = ? and" + " email = ?";

		pstmt = con.prepareStatement(sql);
		
		pstmt.setString(1, userid);
		pstmt.setString(2, email);
		System.out.println("다오 패스워드 찾기 쿼리결과물 " + userpasswd);

		rs = pstmt.executeQuery();
		if (rs.next()) {
			
			userpasswd = rs.getString("member.userpasswd"); // 쿼리에 성공하면 member에 해당하는 passwd담음
			System.out.println("패스워드 찾기 성공! 패스워드값 " + userpasswd);
		}else {
			userpasswd = null; // 없으면 null로 반환
			System.out.println("패스워드  찾기 쿼리 실패  userid 값 " + userpasswd);
		}


	} catch (SQLException e) {
		System.out.println("findpw 오류 발생 " + e);
		System.out.println("들어간 값  : " + userpasswd);

	}finally {
		resourceClose(); // 자원해제
	}

	return 	userpasswd;

}

public void PasswordRandom (String userid) { // 패스워드 랜덤으로 교체용
	
	// long random = (int)(Math.random() * 100000) + 1;
	
	 Random rnd = new Random(); // 랜덤주는  메서드 
	  int random = rnd.nextInt(999999); // 유효범위 99999까지 
	    
	    
	System.out.println("랜덤으로 바꾼 결과물" + random);
	String userpasswd = Integer.toString(random); 

	
	try {
		con = getConnection();
		String sql = "update member set userpasswd = ? where userid = ?";
		System.out.println("passwordrandom 메서드 요청완료!");
		pstmt = con.prepareStatement(sql);
		pstmt.setString(1,userpasswd); // 강제로 해당 유저의 비밀번호 세팅
		pstmt.setString(2,userid);
		pstmt.executeUpdate();
		System.out.println("변경된 패스워드 " + userpasswd);
		
	} catch (Exception e) {
		System.out.println("passwordrandom 예외 발생 " + e);
		e.printStackTrace();
	}finally {
		resourceClose(); // 자원해제
	}
	

}

public int idcheck (String userid) {
int check = 0;

try {
		
	//DB연결
	con = getConnection();
	//SQL문 만들기 : 매개변수로 전달받은 num에 해당하는글 조회
	// 넘어온 아이디 값과 같이 비밀번호도 덤으로 확인 
	sql = "select userid from member where userid = ?";
	//PreparedStatement SQL문 실행객체 얻기
	pstmt = con.prepareStatement(sql);
	//? 기호에 대응되는 글번호num을 설정
	pstmt.setString(1,userid);
	rs = pstmt.executeQuery();
	
	System.out.println("가입페이지  넘어온 값 아이디 : " + userid);
	System.out.println("아이디 체크 완료");
	

	
	if (rs.next()) { // 정보가 맞아서 rs.next영역으로 넘어가면 
		check = 1; // 아이디가 존재하면
		System.out.println("아이디 사용 불가");
	}else {
		check = 0;
		System.out.println("아이디 사용가능");
	}

	
	} catch (Exception e) {

		System.out.println("id check 오류 : " + e);
	}finally {
		resourceClose(); // 자원해제
	}

return check;
}


public boolean phonecheck (int phone) {
boolean check = false;

try {
		
	//DB연결
	con = getConnection();
	//SQL문 만들기 : 매개변수로 전달받은 num에 해당하는글 조회
	// 넘어온 아이디 값과 같이 비밀번호도 덤으로 확인 
	sql = "select phone from member where phone = ?";
	//PreparedStatement SQL문 실행객체 얻기
	pstmt = con.prepareStatement(sql);
	//? 기호에 대응되는 글번호num을 설정
	pstmt.setInt(1,phone);
	rs = pstmt.executeQuery();
	
	System.out.println("가입페이지  넘어온 폰 번호: " + phone);
	System.out.println("번호 체크 완료");
	

	
	if (rs.next()) { // 정보가 맞아서 rs.next영역으로 넘어가면 
		check = false; // 아이디가 존재하면
		System.out.println("폰 사용 불가");
	}else {
		check = true;
		System.out.println("폰 사용가능");
	}

	
	} catch (Exception e) {

		System.out.println("폰 check 오류 : " + e);
	}finally {
		resourceClose(); // 자원해제
	}

return check;
}



public boolean emailcheck (String email) {
boolean check = false;

try {
		
	//DB연결
	con = getConnection();
	//SQL문 만들기 : 매개변수로 전달받은 num에 해당하는글 조회
	// 넘어온 아이디 값과 같이 비밀번호도 덤으로 확인 
	sql = "select email from member where email = ?";
	//PreparedStatement SQL문 실행객체 얻기
	pstmt = con.prepareStatement(sql);
	//? 기호에 대응되는 글번호num을 설정
	pstmt.setString(1,email);
	rs = pstmt.executeQuery();
	
	System.out.println("입력받은 이메일 : " + email);
	System.out.println("메일 체크 완료");
	

	
	if (rs.next()) { // 정보가 맞아서 rs.next영역으로 넘어가면 
		check = false; // 아이디가 존재하면
		System.out.println("메일 사용 불가");
	}else {
		check = true;
		System.out.println("메일 사용가능");
	}

	
	} catch (Exception e) {

		System.out.println("메일 check 오류 : " + e);
	}finally {
		resourceClose(); // 자원해제
	}

return check;
}
} // 클래스 마지막 
