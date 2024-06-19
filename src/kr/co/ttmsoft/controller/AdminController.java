package kr.co.ttmsoft.controller;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.co.ttmsoft.beans.AdminBean;
import kr.co.ttmsoft.beans.BoardInfoBean;
import kr.co.ttmsoft.beans.BoardInfoBean;
import kr.co.ttmsoft.service.CreateBoardService;
import kr.co.ttmsoft.service.UserService;
import oracle.jdbc.proxy.annotation.Post;

@Controller
@RequestMapping("admin")
public class AdminController {

	@Resource(name = "loginAdminBean")
	private AdminBean loginAdminBean;

	@Autowired
	UserService userservice;

	@Autowired
	CreateBoardService createBoardService;

	// 게시판 생성 페이지
	@GetMapping("/m_admin_board")
	public String m_admin_board(@ModelAttribute("BoardInfoBean") BoardInfoBean BoardInfoBean, Model model) {

		List<BoardInfoBean> createBoard = createBoardService.showCreateBoardInfo();

		model.addAttribute("CreateBoard", createBoard);
		model.addAttribute("createBoardSize", createBoard.size());
		// System.out.println("사이즈" + createBoard.size());
		return "admin/m_admin_board";
	}

	// 게시판 생성Pro
	@PostMapping("/admin_boardPro")
	public String admin_boardPro(@ModelAttribute("BoardInfoBean") BoardInfoBean BoardInfoBean) {

		try {
			createBoardService.addCreateBoardInfo(BoardInfoBean);
			return "admin/admin_board_success";
		} catch (Exception e) {
			e.printStackTrace();
		}
		System.out.println("받아온 공개여부: "+BoardInfoBean.getIs_public());
		/*
		 * System.out.println("받아온 게시판 이름: "+BoardInfoBean.getBoard_name());
		 * System.out.println("받아온 게시판 설명: "+BoardInfoBean.getBoard_explanation());
		 * System.out.println("받아온 답변 여부: "+BoardInfoBean.getIs_answer());
		 * System.out.println("받아온 댓글 여부: "+BoardInfoBean.getIs_comment());
		 * System.out.println("받아온 파일 개수: "+BoardInfoBean.getIs_file());
		 * System.out.println("받아온 파일 사이즈: "+BoardInfoBean.getFile_size());
		 * System.out.println("받아온 파일 확장자: "+BoardInfoBean.getFile_ext());
		 */

		return "admin/admin_board_success";
	}

	// 게시판 수정
	@PostMapping("/modifyBoardPro")
	public String modifyBoardPro(@ModelAttribute("ModifyBoardInfoBean") BoardInfoBean ModifyBoardInfoBean) {

		
		try {
			createBoardService.modifyCreateBoardInfo(ModifyBoardInfoBean);
			return "admin/admin_board_modify_success";
		} catch (Exception e) {
			e.printStackTrace();
		}
		

		System.out.println("받아온 게시판 이름: " + ModifyBoardInfoBean.getBoard_info_name());
		System.out.println("받아온 게시판 번호: " + ModifyBoardInfoBean.getBoard_info_idx());
		System.out.println("받아온 게시판 설명: " + ModifyBoardInfoBean.getBoard_explanation());
		System.out.println("받아온 답변 여부: " + ModifyBoardInfoBean.getIs_answer());
		System.out.println("받아온 댓글 여부: " + ModifyBoardInfoBean.getIs_comment());
		System.out.println("받아온 파일 개수: " + ModifyBoardInfoBean.getIs_file());
		System.out.println("받아온 파일 사이즈: " + ModifyBoardInfoBean.getFile_size());
		System.out.println("받아온 파일 확장자: " + ModifyBoardInfoBean.getFile_ext());
		System.out.println("받아온 사용 여부: " + ModifyBoardInfoBean.getIs_usage());

		return "admin/admin_board_modify_success";
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

		HttpSession session = request.getSession();
		session.invalidate();
		loginAdminBean.setAdmin_login(false);

		return "admin/admin_logout";
	}
}
