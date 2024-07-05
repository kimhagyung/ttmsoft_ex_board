package kr.co.ttmsoft.controller;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import kr.co.ttmsoft.beans.UserBean;
import kr.co.ttmsoft.service.UserService; 

@Controller
@RequestMapping("/user")
public class UserController {

	@Autowired
	private UserService userService;

	@Resource(name = "loginUserBean")
	private UserBean loginUserBean; 
    
	@GetMapping("/login")
	public String login(@ModelAttribute("LoginUserBean") UserBean LoginUserBean, Model model,
			@RequestParam(value = "fail", defaultValue = "false") boolean fail) {
		model.addAttribute("LoginUserBean", LoginUserBean);
		return "user/login";
	}
	@PostMapping("/login_pro")
	public String login_pro(@ModelAttribute("LoginUserBean") UserBean LoginUserBean, Model model,
			HttpServletRequest request,HttpServletResponse response, HttpSession session){
		 // 이전 페이지 URI 가져오기
        String prevPage = (String) request.getSession().getAttribute("prevPage");
        System.out.println("prevPage 정보는?" + prevPage);
		try {
			userService.getLoginUserInfo(LoginUserBean.getUser_id());
			if (loginUserBean.isUserLogin() == true) {
				 // 로그인 성공 후 리다이렉트 설정
		        if (prevPage != null && !prevPage.equals("")) { // 이전 페이지가 있으면 그 페이지로 리다이렉트
					System.out.println("지금 로그인 !!" + LoginUserBean.getUser_id());
					model.addAttribute("prevPage", prevPage);
			        }

		        session.setAttribute("user_id", LoginUserBean.getUser_id());
				session.setAttribute("user_pw", LoginUserBean.getUser_pw());
				session.setAttribute("user_name",LoginUserBean.getUser_name());  
				

		        String userId = (String) session.getAttribute("user_id");
		        String userPw = (String) session.getAttribute("user_pw");
		        String userName = (String) session.getAttribute("user_name");
		        System.out.println("세션에 저장된 user_id: " + userId);
		        System.out.println("세션에 저장된 user_pw: " + userPw);
		        System.out.println("세션에 저장된 user_name: " + userName);
		        //LoginUserBean에는 클라이언트에서 보낸 id, pw 값 뿐이어서 user_name은 null로 뜬다. !  
		        
		        return "user/login_success"; 
			}else {
				return "user/login_fail";
			}
		}catch (Exception e) {
			e.printStackTrace();
			return "user/login_fail";
		}
	}

	@GetMapping("/join")
	public String join(@ModelAttribute("joinUserBean") UserBean joinUserBean) {
		return "user/join";
	}
	@PostMapping("/join_pro")
	public String join_pro(@Valid @ModelAttribute("joinUserBean") UserBean joinUserBean) {
 
		userService.addUserInfo(joinUserBean);
		return "user/join_success";
	}

	
	
	@GetMapping("/modify")
	public String modify(@ModelAttribute("ModicyUserInfo") UserBean modifyUserBean,Model model) {
		
		//userService.getLoginUserInfo(loginUserBean.getUser_id());
		return "user/modify";
	}
	
	@PostMapping("/modify_pro")
	public String modify_pro(@ModelAttribute("ModicyUserInfo") UserBean modifyUserBean,Model model ) {
		
		try {
			userService.ModifyUserInfo(modifyUserBean);
		} catch (Exception e) {
			e.printStackTrace();
		} 
		System.out.println("user idx"+modifyUserBean.getUser_idx());
		System.out.println("변경된 user name"+modifyUserBean.getUser_name());
		System.out.println("변경된 user id"+modifyUserBean.getUser_id());
		
		model.addAttribute("id", modifyUserBean.getUser_idx());
		return "user/modify_success";
	}
	
	
	@GetMapping("/logout")
	public String logout(HttpServletRequest request, Model model) throws Exception {
		String prevPage = (String) request.getSession().getAttribute("prevPage");
		HttpSession session=request.getSession(); 
		session.invalidate();
		loginUserBean.setUserLogin(false);
		
	   if (prevPage != null && !prevPage.equals("")) { // 이전 페이지가 있으면 그 페이지로 리다이렉트
	        model.addAttribute("prevPage", prevPage);
	    }

	    return "user/logout_success";
	}

	
	@GetMapping("/not_login")
	public String not_login() {
		return "user/not_login";
	}
}
