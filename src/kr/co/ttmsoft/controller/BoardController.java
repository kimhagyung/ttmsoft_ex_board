package kr.co.ttmsoft.controller;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import kr.co.ttmsoft.beans.BoardFileBean;
import kr.co.ttmsoft.beans.BoardInfoBean;
import kr.co.ttmsoft.beans.ContentBean;
import kr.co.ttmsoft.beans.NaverEditorBean;
import kr.co.ttmsoft.beans.PageBean;
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
	public String main(Model model,@RequestParam(value="page",defaultValue="1") int page, @RequestParam("index") int content_board_idx) {
		//List<ContentBean> MainBoardInfo = boardService.getBoardInfoo();
		List<String> boardWriterName = new ArrayList<String>();
		List<ContentBean> getPostPageInfo=boardService.getBoardPageInfo(content_board_idx, page); 
		
		BoardInfoBean boardAllInfo = boardService.getAllBoardInfo(content_board_idx); //게시판 테이블 전체 정보 
		model.addAttribute("boardAllInfo", boardAllInfo);
		
		for (ContentBean main : getPostPageInfo) {
			boardWriterName.add(boardService.getContentUserName(main.getContent_idx()));
		}
		//model.addAttribute("MainBoardInfo", MainBoardInfo);
		model.addAttribute("boardWriterName", boardWriterName);
		
		//-----------------------------------------------------------------------------------
		model.addAttribute("MainBoardInfo", getPostPageInfo);
		PageBean pageBean = boardService.getBoardPageInfoCnt(page,content_board_idx);
		model.addAttribute("pageBean", pageBean);
		
		System.out.println("전체 페이지 개수 "+pageBean.getPageCnt());
		return "board/main";
	}

	//게시글 조회 
	@GetMapping("/read")
	public String read(@RequestParam("content_idx") int content_idx, Model model) {
		ContentBean boardInfo = boardService.getBoardInfo(content_idx); //게시글 내용 정보 
		BoardFileBean boardfileBean=boardService.getBoardFileInfo(content_idx); //게시글 사진 정보 
		String boardWriterName = (boardService.getContentUserName(content_idx));
			
		System.out.println("받아온 게시글 내용: " + boardInfo.getContent_text());
		System.out.println("받아온 사진 이름 :"+boardfileBean.getFile_name());
		System.out.println("받아온 작성자 이름: " + boardWriterName);

		model.addAttribute("boardWriterName", boardWriterName);
		model.addAttribute("boardInfo", boardInfo);
		return "board/read";
	}
	
	//게시글 작성
	@GetMapping("/write")
	public String write(@ModelAttribute("boardPostBean") ContentBean boardPostBean, Model model, @RequestParam("index") int content_board_idx) {
		
		BoardInfoBean boardAllInfo = boardService.getAllBoardInfo(content_board_idx);
		model.addAttribute("boardAllInfo", boardAllInfo);
		System.out.println("받아온 인덱스 번호는!??!!"+content_board_idx);
		return "board/write";
	}
	
	//게시글 작성 과정 
	@PostMapping("/write_pro")
	public String write_pro(@ModelAttribute("boardPostBean") ContentBean boardPostBean,
	                        @ModelAttribute("boardFilePostBean") BoardFileBean boardFilePostBean,
	                        Model model,
	                        @RequestParam("uploadFiles") MultipartFile[] uploadFiles) {

	    System.out.println("받아온 카테고리값은?" + boardPostBean.getContent_idx());
	    System.out.println("받아온 사용자 아이디는?" + boardPostBean.getUser_idx());
	    System.out.println("받아온 글내용은?" + boardPostBean.getContent_text());
	    System.out.println("받아온 제목은?" + boardPostBean.getContent_subject());
	    System.out.println("공개여부는?" + boardPostBean.getIs_public());

	    try {
	        if (loginUserBean.isUserLogin()) { // 로그인 여부 확인
	            int contentIdx = boardService.addBoardInfo(boardPostBean); // 내용 저장 및 게시글 번호 반환 
	            if (contentIdx > 0) { // 내용이 성공적으로 저장된 경우에만 파일 저장
	                if (boardFilePostBean != null && uploadFiles != null) { // 파일 정보가 존재하고 파일이 업로드되었을 경우 파일 정보 저장
	                    for (MultipartFile uploadFile : uploadFiles) {
	                        if (!uploadFile.isEmpty()) {
	                            boardService.addBoardFileInfo(boardFilePostBean, uploadFile, contentIdx);
	                        }
	                    }
	                }
	                model.addAttribute("content_board_idx", boardPostBean.getContent_board_idx());
	            } else {
	                System.out.println("게시물 정보 저장에 실패했습니다.");
	                // 저장 실패 시 처리 로직 추가 가능
	            }
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
		 if (loginUserBean.isUserLogin() == true) { 
            if (!uploadFile.isEmpty()) { // 업로드된 파일이 있는지 확인
            	boardService.modifyBoardInfo(modifyPostBean, uploadFile); 
            } else {
            	modifyPostBean.setContent_file(modifyPostBean.getExistingFile()); 
                boardService.modifyBoardInfoWithoutFile(modifyPostBean); // 파일이 없는 경우의 로직 처리
            }
		 }
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			model.addAttribute("content_idx", modifyPostBean.getContent_idx());
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
	

	//naver-smart-editor
	@GetMapping("/naverEditor")
	public String naverEditor(@ModelAttribute("naverEditorBean") NaverEditorBean naverEditorBean) {
		return "board/naverEditor";
	}
	
	@PostMapping("/WriteNaverEditorPro")
	public String WriteNaverEditorPro(@ModelAttribute("naverEditorBean") NaverEditorBean naverEditorBean,
			@RequestParam("uploadFiles") MultipartFile uploadFile, Model model) {
		System.out.println("받아온 카테고리값은?" + naverEditorBean.getBoard_info_idx());
		System.out.println("받아온 사용자 아이디는?" + naverEditorBean.getUser_idx());
		System.out.println("받아온 글내용은?" + naverEditorBean.getNaverEditor_text());
		System.out.println("받아온 제목은?" + naverEditorBean.getNaverEditor_subject());
		try {
			if (loginUserBean.isUserLogin() == true) {
				boardService.addNaverEditorBean(naverEditorBean, uploadFile);
				model.addAttribute("content_board_idx", naverEditorBean.getBoard_info_idx()); 
			} else {
				System.out.println("로그인이 되어있지 않습니다.");
				return "user/not_login";
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "board/write_success";
	}
}
