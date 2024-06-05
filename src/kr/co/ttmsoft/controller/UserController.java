package kr.co.ttmsoft.controller;

import javax.annotation.Resource;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import kr.co.ttmsoft.beans.UserBean;
import kr.co.ttmsoft.service.UserService;
import kr.co.ttmsoft.validator.UserValidator;

@Controller
@RequestMapping("/user")
public class UserController {

	
	@Autowired
	private UserService userService;
	
	@Resource(name="loginUserBean")
	private UserBean loginUserBean;
	
	@GetMapping("/login")
	public String login(@ModelAttribute("LoginUserBean") UserBean LoginUserBean, Model model, @RequestParam(value="fail", defaultValue="false") boolean fail) {
		model.addAttribute("LoginUserBean",LoginUserBean);
		return "user/login";
	} 
	
	@PostMapping("/login_pro")
	public String login_pro(@ModelAttribute("LoginUserBean") UserBean LoginUserBean, Model model, BindingResult result) {
 
		if(result.hasErrors()) {
			return "user/login";
		}
		try { 
			userService.getLoginUserInfo(LoginUserBean.getUser_id());
			if(loginUserBean.isUserLogin()==true) {
				System.out.println("지금 로그인 !!"+LoginUserBean.getUser_id());
				return "user/login_success";
			}else {
				return "user/login_fail";
			}
		} catch (Exception e) {
			e.printStackTrace();
			return "user/login_fail";
		}
		
	}
	
	@GetMapping("/join")
	public String join(@ModelAttribute("joinUserBean") UserBean joinUserBean){ 
		return "user/join";
	}
	 
	
	@PostMapping("/join_pro")
	public String join_pro(@Valid @ModelAttribute("joinUserBean") UserBean joinUserBean, BindingResult result) { 
		
		if(result.hasErrors()) { 
			return "user/join"; 
		}
		userService.addUserInfo(joinUserBean);
		return "user/join_success";
	} 
	
	@GetMapping("/modify")
	public String modify() {
		
		return "user/modify";
	}

	@GetMapping("/logout")
	public String logout() {
		loginUserBean.setUserLogin(false);
		return "user/logout";
	}
	@InitBinder
	public void initBinder(WebDataBinder binder) {
		UserValidator validator1 = new UserValidator();
		binder.addValidators(validator1);
	}
}
