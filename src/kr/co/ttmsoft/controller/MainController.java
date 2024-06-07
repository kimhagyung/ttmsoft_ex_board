package kr.co.ttmsoft.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import kr.co.ttmsoft.beans.ContentBean;
import kr.co.ttmsoft.service.BoardService;

@Controller
public class MainController {
 
	
	@Autowired
	private BoardService boardService;
	
	@GetMapping("/index")
	public String main(Model model) {
		List<ContentBean> MainBoardInfo=new ArrayList<ContentBean>();
		for(int i=1;i<=4;i++) {
			MainBoardInfo.addAll(boardService.getBoardInfoo(i)); 
		}
		
		model.addAttribute("MainBoardInfo", MainBoardInfo); 
		
		
		return "index";
	} 

}
