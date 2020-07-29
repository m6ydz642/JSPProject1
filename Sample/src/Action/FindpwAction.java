package Action;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import member.MemberDAO;

@WebServlet("/FindpwAction.do")
public class FindpwAction extends HttpServlet{
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// TODO Auto-generated method stub
		requestPro(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// TODO Auto-generated method stub
		requestPro(req, resp);
		
	
		// findPasswordAction(req);
		findPasswordAction(req,resp);
	}
	
	protected void requestPro(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		System.out.println("패스워드 찾기 리케스트 프로 호출");
	}
	
	
	

private String findPasswordAction(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	/*모델 2 초창기에 배웠던 방식으로 만든거라 자바 액션 클래스를 2개로 나눔 */
		
		MemberDAO dao = new MemberDAO();
		request.setCharacterEncoding("UTF-8"); // 한글깨짐 방지
		
		
		String userid = request.getParameter("mem_id"); // findidpw.jsp에서 name 값 받아옴

		String email = request.getParameter("mem_email"); // 아이디 찾기 페이지에 들어간 email값
		String pw = null;
		
	System.out.println("findpw.jsp에서 넘어온 id값" + userid);
	System.out.println("findpw.jsp에서 넘어온 email 값" + email);
		
		
		try {
			pw = dao.findPw(userid, email); // dao객체의 findPw호출해서 쿼리문 실행후 결과값 리턴 받은거 pw로 전송
			request.setAttribute("userpasswd", pw); // 정상적으로 dao.findId에서 
			// 쿼리결과문을 받았으면 리턴받아서 변수로 세션에 저장
			System.out.println("세션에 담긴  유저 패스워드 값  :" + pw);

			System.out.println("컨트롤러로 가져온 항목 패스워드 찾기 -> 아이디  id : " + userid );
			System.out.println("컨트롤러로 가져온 항목 패스워드 찾기  이메일 찾기 email : " + email );
			
			if (pw == null) {
				System.out.println(" 사용자로부터 입력 받은 정보가 틀림 : " + pw);
			}
		
		        
		} catch (Exception e) {
			System.out.println("패스워드찾기 컨트롤러에서 예외 발생" + e);
				System.out.println(" 다오 객체로 부터 받은 pw  : " + pw);
		}

		
		 RequestDispatcher dispatcher = request.getRequestDispatcher("/Findidpw/FindpwSussess.jsp");
		 // 쿼리에 성공을 하던 실패를 하던 일단 넘길 페이지 주소
	        dispatcher.forward(request, response);
	        
return pw;
	}


}
