package kr.co.ttmsoft.controller;

import java.util.List;

import javax.annotation.Resource;
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
	public String login_pro(@ModelAttribute("LoginUserBean") UserBean LoginUserBean, Model model) {
 
		try {
			userService.getLoginUserInfo(LoginUserBean.getUser_id());
			if (loginUserBean.isUserLogin() == true) {
				System.out.println("지금 로그인 !!" + LoginUserBean.getUser_id());
				return "user/login_success";
			} else {
				return "user/login_fail";
			}
		} catch (Exception e) {
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
	public String logout() {
		loginUserBean.setUserLogin(false);
		return "user/logout_success";
	}

	
	@GetMapping("/not_login")
	public String not_login() {
		return "user/not_login";
	}
}
