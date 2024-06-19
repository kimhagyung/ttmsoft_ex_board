package kr.co.ttmsoft.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import kr.co.ttmsoft.beans.BoardInfoBean;
import kr.co.ttmsoft.beans.ContentBean;
import kr.co.ttmsoft.service.BoardService;
import kr.co.ttmsoft.service.TopMenuService;

@Controller
public class MainController {
 
	
	@Autowired
	private BoardService boardService;
	
	@Autowired
	private TopMenuService topMenuService;
	
	@GetMapping("/index")
	public String main(Model model) {
		List<ContentBean> MainBoardInfo=new ArrayList<ContentBean>();
		List<BoardInfoBean> topMenuList = topMenuService.getTopMenuList(); //메뉴 사이즈를 위해 
		
		System.out.println("메뉴 사이즈 !!"+topMenuList.size());
		
		for(int i=1;i<=topMenuList.size();i++) {
			MainBoardInfo.addAll(boardService.getBoardInfoo(i));  
			System.out.println("i의 값은? "+i);
		}
		
		model.addAttribute("MainBoardInfo", MainBoardInfo);   
		
		return "index";
	} 
	
	@GetMapping("/fileTest")
	public String fileTest(Model model) {
		
		return "fileTest";
	}

}
