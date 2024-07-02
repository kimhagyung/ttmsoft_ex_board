package kr.co.ttmsoft.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import kr.co.ttmsoft.beans.BoardFileBean;
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
		List<ContentBean> MainBoardInfo = new ArrayList<ContentBean>();
		List<BoardInfoBean> topMenuList = topMenuService.getTopMenuList(); // 메뉴 사이즈를 위해

		System.out.println("메뉴 사이즈 !!" + topMenuList.size());
		 
		for(BoardInfoBean topMenu : topMenuList) {
			MainBoardInfo.addAll(boardService.getBoardInfoo(topMenu.getBoard_info_idx())); 
			System.out.println("topMenu의 값은? " + topMenu);
		} 

		model.addAttribute("MainBoardInfo", MainBoardInfo);

		return "index";
	}

	@GetMapping("/fileTest")
	public String fileTest() {

		return "fileTest";
	}

	@GetMapping("/fileTest2")
	public String fileTest2() {

		return "fileTest2";
	}

	@PostMapping("/register")
	public String register(@ModelAttribute("boardFilePostBean") BoardFileBean boardFilePostBean,
			@RequestParam(value = "uploadFiles", required = false) MultipartFile[] uploadFiles, Model model) {

		for (MultipartFile uploadFile : uploadFiles) {
			if (!uploadFile.isEmpty()) {
				System.out.println("업로드된 파일 이름: " + uploadFile.getOriginalFilename());
				System.out.println("업로드된 파일 크기: " + uploadFile.getSize() + " bytes");
				// 파일 저장 로직(boardService.addBoardFileInfo() 호출 등)을 추가해야 합니다.
				boardService.addBoardFileInfo(boardFilePostBean, uploadFile, 1043);
			} 
		}
		return "board/write_success";
	}
}