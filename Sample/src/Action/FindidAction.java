package Action;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import member.MemberDAO;

@WebServlet("/FindidAction.do")
public class FindidAction extends HttpServlet{
	
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
		findIdAction(req,resp);
	}
	
	protected void requestPro(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		System.out.println("find id 리케스트 프로 호출");
	}
	
	
	
	
	private String findIdAction(HttpServletRequest request,  HttpServletResponse response) throws ServletException, IOException {
		System.out.println("findid 호출 성공");
		
		/*모델 2 초창기에 배웠던 방식으로 만든거라 자바 액션 클래스를 2개로 나눔 */
		MemberDAO dao = new MemberDAO();
		request.setCharacterEncoding("UTF-8"); // 한글깨짐 방지
		
		String username = request.getParameter("mem_name"); // 아이디 찾기에 들어간 name값
		String email = request.getParameter("mem_email");
		String id=""; 

		try {
		id = dao.findId(username,email);

		request.setAttribute("userid", id); //  세션에 설정 값, 정상적으로 dao.findId에서 
											// 쿼리결과문을 받았으면 리턴받아서 변수로 저장
		System.out.println("세션에 담긴  유저 아이디 값  :" + id);
		
		System.out.println("컨트롤러로 가져온 항목 아이디찾기  name : " + username );
		System.out.println("컨트롤러로 가져온 항목 이메일 찾기 email : " + email );
		if (id == null) {
			System.out.println(" 사용자로부터 입력 받은 아이디가 틀림 : " + id);
			// return "/Findidpw/findid.jsp";
			
		}
		
		 }catch (Exception e) {
			System.out.println("id 찾기 서블릿 오류 발생 " + e);
			System.out.println("넘어온 값 유저네임 :" + username);
			System.out.println("넘어온 값 유저이메일 :" + email);
			System.out.println("넘어온 값 찾기 성공한  유저 아이디 값  :" + id);
		}
		 RequestDispatcher dispatcher = request.getRequestDispatcher("/Findidpw/FindidSussess.jsp");
		 // 쿼리에 성공을 하던 실패를 하던 일단 넘길 페이지 주소
	        dispatcher.forward(request, response);
	        
	      //  return "/Findidpw/findid.jsp";
		return id;
		

	}



}
