package model2.mvcboard;

import java.io.IOException;

import fileupload.FileUtil;
/*
 * 비회원제 게시판에서 게시물을 수정, 삭제를 위해서는 패스워드 
 * 먼저 선행되어야 한다.
 * 따라서 해당 페이지로 진입한 후 패스워드가 일치하지   
 * */
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import utils.JSFunction;

@WebServlet("/mvcboard/pass.do")
public class PassController extends HttpServlet {
	private static final long serialVersionUID = 1L;
    //패스워드 검증 페이지로 진입시에는 get방식으로 처리한다.
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
	throws ServletException, IOException {
		/*페이지로 전달되는 파라미터가 컨트롤러에서 필요한 경우에는 request
		 * 내장객체를 통해 받아 사용한다.
		 * 만약 jsp에서 필요하다면 EL의 내장객체 param을 이용하면 된다.*/
		req.setAttribute("mode",req.getParameter("mode"));
		req.getRequestDispatcher("/14MVCBoard/Pass.jsp").forward(req,resp);
	
		
			
		}

//패스워드 검증 페이지에서 전송한 값을 통해 레코드 검증 	
@Override
protected void doPost(HttpServletRequest req, HttpServletResponse resp)
	throws ServletException, IOException {
	//매개변수 저장
	String idx = req.getParameter("idx");
	String mode= req.getParameter("mode");
	String pass =req.getParameter("pass");
	
	//비빌번호 검증
	MVCBoardDAO dao = new MVCBoardDAO();
	//일련번호와 비밀번호에 일치하는 게시물이 있는지 확인 
	boolean confirmed = dao.confirmPassword(pass, idx);
	dao.close();
	//패스워드와 일치하는 게시물이 있는 경우에는 후속 처리를 한다.
	if(confirmed) {
		if (mode.equals("edit")) {
			HttpSession session = req.getSession();
			session.setAttribute("PASS", pass);
			resp.sendRedirect("../mvcboard/edit/do?idx="+idx);
		}
		else if(mode.equals("delete")) { //mode=delete 인 경우 
			dao= new MVCBoardDAO();
			//기존 게시물의 내용을 가져온다.
			MVCBoardDTO dto = dao.selectView(idx);
			int result= dao.deletePost(idx); 
			//게시물 삭제
			dao.close();
			 //게시물 삭제 성공 시 첨부파일도 삭제
			if(result ==1 ) {
				//서버에 실제 저장된 파일명으로 삭제한다.
				String saveFileName = dto.getSfile();
				FileUtil.deleteFile(req,"/Uploads",saveFileName);
			}
			//게시물 삭제가 완료되면 목록으로 이동한다.
			JSFunction.alertLocation(resp, "삭제되었습니다.", "../mvcboard/list.do");
		}
	}
	else {
		//비밀번호 불일치인 경우 뒤로 이동한다.
		JSFunction.alertBack(resp, "비밀번호 검증에 실패했습니다.");
	}
	
	
}
}