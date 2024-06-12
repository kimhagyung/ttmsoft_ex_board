package kr.co.ttmsoft.controller;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.co.ttmsoft.beans.AdminBean;
import kr.co.ttmsoft.beans.CreateBoardBean;
import kr.co.ttmsoft.service.UserService;
import oracle.jdbc.proxy.annotation.Post;

@Controller
@RequestMapping("admin")
public class AdminController {
	
	@Resource(name="loginAdminBean")
	private AdminBean loginAdminBean;
	
	@Autowired
	UserService userservice;
	 
	@GetMapping("/m_admin_board")
	public String m_admin_board(@ModelAttribute("CreateBoardBean") CreateBoardBean CreateBoardBean) {
		return "admin/m_admin_board";
	}
	
	@PostMapping("/admin_boardPro")
	public String admin_boardPro(@ModelAttribute("CreateBoardBean") CreateBoardBean CreateBoardBean) {
		
		System.out.println("받아온 게시판 이름: "+CreateBoardBean.getBoard_name());
		System.out.println("받아온 게시판 설명: "+CreateBoardBean.getBoard_explanation());
		System.out.println("받아온 답변 여부: "+CreateBoardBean.getIs_answer());
		System.out.println("받아온 댓글 여부: "+CreateBoardBean.getIs_comment());
		System.out.println("받아온 파일 개수: "+CreateBoardBean.getIs_file());
		System.out.println("받아온 파일 사이즈: "+CreateBoardBean.getFile_size());
		System.out.println("받아온 파일 확장자: "+CreateBoardBean.getFile_ext());
		return "admin/admin_board_success";
	}
	
	
	@GetMapping("/m_admin_content")
	public String m_admin_content() { 
		return "admin/m_admin_content"; 	
	}
	
	@GetMapping("/admin_login")
	public String admin_login(@ModelAttribute("AdminLoginBean") AdminBean AdminLoginBean) {
		return "admin/admin_login";
	}
	
	@PostMapping("/admin_loginPro")
	public String admin_loginPro(@ModelAttribute("AdminLoginBean") AdminBean AdminLoginBean) {
		
		try {
			userservice.getAdminInfo(AdminLoginBean.getAdmin_id());
			if (loginAdminBean.isAdmin_login() == true) {
				System.out.println("지금 로그인 !!" + loginAdminBean.getAdmin_id());
				return "admin/admin_login_success";
			} else {
				return "admin/admin_login_fail";
			}
		} catch (Exception e) {
			e.printStackTrace();
			return "user/admin_login_fail";
		}
		 
	}
	
	@GetMapping("/admin_logout")
	public String admin_logout(HttpServletRequest request) throws Exception {
		
		HttpSession session=request.getSession(); 
		session.invalidate();
		loginAdminBean.setAdmin_login(false);
		
		return "admin/admin_logout";
	} 
}
