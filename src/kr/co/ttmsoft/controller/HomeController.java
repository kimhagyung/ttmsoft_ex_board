package kr.co.ttmsoft.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class HomeController {

	@RequestMapping(value="/", method = RequestMethod.GET)
	//프로젝트 메인페이지에 대한 요청(프로젝트 최초 요청 혹은 메인페이지에 대한 요청 시 매핑)
	//get 방식(URL로 요청 시 매핑)
	public String home() {
		
		return "redirect:/index";
		//루트("/") 요청 시, "/main"으로 리다이렉트(->mainController, main()메서드로 매핑)  
	}
}
