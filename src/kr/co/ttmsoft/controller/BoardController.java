package kr.co.ttmsoft.controller;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import kr.co.ttmsoft.beans.ContentBean;
import kr.co.ttmsoft.beans.UserBean;
import kr.co.ttmsoft.service.BoardService;

@Controller
@RequestMapping("/board")
public class BoardController {

	@Resource(name = "loginUserBean")
	private UserBean loginUserBean;

	@Autowired
	private BoardService boardService;

	@GetMapping("/main")
	public String main(Model model) {
		List<ContentBean> MainBoardInfo = boardService.getBoardInfoo();
		List<String> boardWriterName = new ArrayList<String>();

		for (ContentBean main : MainBoardInfo) {
			boardWriterName.add(boardService.getContentUserName(main.getContent_idx()));
		}
		model.addAttribute("MainBoardInfo", MainBoardInfo);
		model.addAttribute("boardWriterName", boardWriterName);
		return "board/main";
	}

	//게시글 조회 
	@GetMapping("/read")
	public String read(@RequestParam("content_idx") int content_idx, Model model) {
		ContentBean boardInfo = boardService.getBoardInfo(content_idx);
		String boardWriterName = (boardService.getContentUserName(content_idx));

		System.out.println("받아온 게시글 내용: " + boardInfo.getContent_text());
		System.out.println("받아온 작성자 이름: " + boardWriterName);

		model.addAttribute("boardWriterName", boardWriterName);
		model.addAttribute("boardInfo", boardInfo);
		return "board/read";
	}
	
	//게시글 작성
	@GetMapping("/write")
	public String write(@ModelAttribute("boardPostBean") ContentBean boardPostBean, Model model) {
		model.addAttribute("boardPostBean", boardPostBean);
		return "board/write";
	}

	@PostMapping("/write_pro")
	public String write_pro(@ModelAttribute("boardPostBean") ContentBean boardPostBean, Model model,
			BindingResult result, @RequestParam("uploadFiles") MultipartFile uploadFile) {
		if (result.hasErrors()) {
			return "board/main";
		}
		System.out.println("받아온 카테고리값은?" + boardPostBean.getContent_idx());
		System.out.println("받아온 사용자 아이디는?" + boardPostBean.getContent_writer_idx());
		System.out.println("받아온 글내용은?" + boardPostBean.getContent_text());
		System.out.println("받아온 제목은?" + boardPostBean.getContent_subject());
		try {
			if (loginUserBean.isUserLogin() == true) {
				boardService.addBoardInfo(boardPostBean, uploadFile);
				model.addAttribute("content_board_idx", boardPostBean.getContent_board_idx());
			} else {
				System.out.println("로그인이 되어있지 않습니다.");
				return "user/not_login";
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "board/write_success";
	}

	//게시글 수정
	@GetMapping("/modify")
	public String modify(Model model, @RequestParam("content_idx") int content_idx,
			@ModelAttribute("modifyPostBean") ContentBean modifyPostBean) {
		ContentBean boardInfo = boardService.getBoardInfo(content_idx);
		String boardWriterName = (boardService.getContentUserName(content_idx));

		System.out.println("받아온 게시글 내용: " + boardInfo.getContent_text());
		System.out.println("받아온 작성자 이름: " + boardWriterName);

		model.addAttribute("boardWriterName", boardWriterName);
		model.addAttribute("boardInfo", boardInfo);
		return "board/modify";
	}

	@PostMapping("/modify_pro")
	public String modify_pro(Model model, @ModelAttribute("modifyPostBean") ContentBean modifyPostBean, @RequestParam("uploadFiles") MultipartFile uploadFile) {
		try {
			boardService.modifyBoardInfo(modifyPostBean, uploadFile);
			model.addAttribute("content_idx", modifyPostBean.getContent_idx());
		} catch (Exception e) {
			e.printStackTrace();
		}

		return "board/modify_success";
	}
	
	@GetMapping("/delete")
	public String delete(Model model, @RequestParam("content_idx") int content_idx) {
		ContentBean boardInfo = boardService.getBoardInfo(content_idx);
		try {
			boardService.deleteBoardInfo(content_idx);
			model.addAttribute("content_board_idx", boardInfo.getContent_board_idx());
		} catch (Exception e) {
			e.printStackTrace();
		}
	
		return "board/delete";
	}
}
