package kr.co.ttmsoft.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import kr.co.ttmsoft.beans.AdminBean;
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
	@Resource(name="loginAdminBean")
	private AdminBean loginAdminBean;
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
			/*
			System.out.println(main.getContent_subject());
			System.out.println(main.getContent_idx());
			System.out.println(main.getContent_subject());
			System.out.println(main.getContent_text());
			System.out.println(main.getUser_idx());
			System.out.println(main.getContent_board_idx()); 
			System.out.println(main.getContent_is_public());
			System.out.println(main.getIs_deleted());
			*/
		}
		//model.addAttribute("MainBoardInfo", MainBoardInfo);
		model.addAttribute("boardWriterName", boardWriterName);
		
		//-----------------------------------------------------------------------------------
		model.addAttribute("MainBoardInfo", getPostPageInfo); //게시글 전체 정보 
		PageBean pageBean = boardService.getBoardPageInfoCnt(page,content_board_idx);
		model.addAttribute("pageBean", pageBean);
		
		System.out.println("전체 페이지 개수 "+pageBean.getPageCnt());
		return "board/main";
	}

	//게시글 조회 
	@GetMapping("/read")
	public String read(@RequestParam("content_idx") int content_idx, Model model) {
		ContentBean boardInfo = boardService.getBoardInfo(content_idx); //게시글 내용 정보 
		List<BoardFileBean> boardfileBean=boardService.getBoardFileInfo(content_idx); //게시글 사진 정보 
		String boardWriterName = (boardService.getContentUserName(content_idx));
		BoardInfoBean boardAllInfo = boardService.getAllBoardInfo(boardInfo.getContent_board_idx());
		boardService.plusCnt(content_idx); //조회수
	  
 
        // HTML 디코딩
        //String decodedContent = StringEscapeUtils.unescapeHtml4(boardInfo.getContent_text());
        //System.out.println("decodedContent???"+decodedContent);
        //boardInfo.setContent_text(decodedContent);
    
	 
		model.addAttribute("boardWriterName", boardWriterName); //게시글 작성자 이름 
		model.addAttribute("boardInfo", boardInfo); //게시글 정보 
		model.addAttribute("boardAllInfo", boardAllInfo); //게시판 모든 정보 
		model.addAttribute("boardfileBean", boardfileBean); //게시글의 사진 정보 
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
	                        Model model,@RequestParam(value = "uploadFiles[]", required = false) List<MultipartFile> uploadFiles)
	                       {
		//@RequestParam(value = "uploadFiles", required = false) MultipartFile[] uploadFiles
//		/@RequestParam("uploadFiles[]") MultipartFile[] uploadFiles)
		/* 
	    System.out.println("받아온 카테고리값은?" + boardPostBean.getContent_board_idx());
	    System.out.println("받아온 사용자 아이디는?" + boardPostBean.getUser_idx());
	    System.out.println("받아온 글내용은?" + boardPostBean.getContent_text());
	    System.out.println("받아온 제목은?" + boardPostBean.getContent_subject());
	    System.out.println("받아온 파일 사이즈는?" + boardFilePostBean.getFile_size());*/  
	    System.out.println("공개여부는?" + boardPostBean.getContent_is_public());
	    
		 try {
		        if (loginUserBean.isUserLogin() || loginAdminBean.isAdmin_login()) { // 로그인 여부 확인
		            int contentIdx = boardService.addBoardInfo(boardPostBean); // 내용 저장 및 게시글 번호 반환  
		            System.out.println("contentIdx????"+contentIdx);
		            if (contentIdx > 0) { // 내용이 성공적으로 저장된 경우에만 파일 저장
		                if (boardFilePostBean != null && uploadFiles != null) { // 파일 정보가 존재하고 파일이 업로드되었을 경우 파일 정보 저장
		                    for (MultipartFile uploadFile : uploadFiles) {
		                    	if (!uploadFile.isEmpty()) {
		                            System.out.println("write_pro 업로드된 파일 이름: " + uploadFile.getOriginalFilename());
		                            System.out.println("write_pro 업로드된 파일 크기: " + uploadFile.getSize() + " bytes");  
		                            boardService.addBoardFileInfo(boardFilePostBean, uploadFile, contentIdx);
		                        }
		                    	else{
		                    		System.out.println("업로드 이미지 없음");
		                    		return "board/write_success";
		                    	}
		                    }
		                } 
		                System.out.println("게시물 정보 저장에 실패했습니다.");  
		            }
	        } else {
	            System.out.println("로그인이 되어있지 않습니다.");
	            return "user/not_login";
	        } 
	    } catch (Exception e) {
	        e.printStackTrace();
	    }finally {
	    	model.addAttribute("content_board_idx", boardService.LetestContent_idx());
	    	System.out.println(" boardPostBean.getContent_board_idx()???"+ boardService.LetestContent_idx());
		}

	    return "board/write_success";
	}

	//게시글 수정
	@GetMapping("/modify")
	public String modify(Model model, @RequestParam("content_idx") int content_idx,
			@ModelAttribute("modifyPostBean") ContentBean modifyPostBean) {
		ContentBean boardInfo = boardService.getBoardInfo(content_idx); //게시글 정보 
		String boardWriterName = (boardService.getContentUserName(content_idx)); //작성자 
		BoardInfoBean boardAllInfo = boardService.getAllBoardInfo(boardInfo.getContent_board_idx()); //게시판 정보들 
		List<BoardFileBean> boardfileBean=boardService.getBoardFileInfo(content_idx); //게시글 파일 정보 
		
		System.out.println("받아온 게시글 내용: " + boardInfo.getContent_text()); 
		System.out.println("받아온 작성자 이름: " + boardWriterName);

		model.addAttribute("boardWriterName", boardWriterName);
		model.addAttribute("boardInfo", boardInfo);
		model.addAttribute("boardAllInfo", boardAllInfo);
		model.addAttribute("boardfileBean", boardfileBean); //게시글 파일 정보 
		return "board/modify"; 
	}

	@PostMapping("/modify_pro")
	public String modify_pro(Model model, @ModelAttribute("modifyPostBean") ContentBean modifyPostBean,@ModelAttribute("modifyBoardFileBean") BoardFileBean modifyBoardFileBean,  @RequestParam(value = "uploadFiles[]", required = false) MultipartFile[] uploadFiles
			 ) {
		try { 
		 if (loginUserBean.isUserLogin() == true) {  
			 	int contentIdx = boardService.modifyBoardInfo(modifyPostBean); 
				 boardService.modifyBoardInfo(modifyPostBean);    
	           
	             if (contentIdx > 0) {
		             if (modifyPostBean != null && uploadFiles != null) { // 파일 정보가 존재하고 파일이 업로드되었을 경우 파일 정보 저장
		                    for (MultipartFile uploadFile : uploadFiles) {
		                    	if (!uploadFile.isEmpty()) {
		                            System.out.println("업로드된 파일 이름: " + uploadFile.getOriginalFilename());
		                            System.out.println("업로드된 파일 크기: " + uploadFile.getSize() + " bytes");  
		                            boardService.addBoardFileInfo(modifyBoardFileBean, uploadFile,contentIdx );
		                        }
		                    }
		             	}
	             }
		 }
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			//model.addAttribute("content_idx", modifyPostBean.getContent_idx());
			//model.addAttribute("content_idx", modifyBoardFileBean.getContent_idx());
		}

		return "board/modify_success";
	}
	
	@PostMapping("/modifyFile")
	public String modifyFile(Model model, @ModelAttribute("modifyBoardFileBean") BoardFileBean modifyBoardFileBean, @RequestParam("uploadFiles") MultipartFile uploadFile) {
		try { 
		 if (loginUserBean.isUserLogin() == true || loginAdminBean.isAdmin_login() == true ) {   
	             boardService.modifyBoardFileBean(modifyBoardFileBean, uploadFile); 
		 }
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			model.addAttribute("content_idx", modifyBoardFileBean.getContent_idx());
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
	
	@GetMapping("/write2_imge")
	public String write2_imge() { 
		
		
		return "board/write2_imge";
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
	
	 //실패
	 //스마트 에디터 사진파일 처리 
	 @PostMapping("/smarteditorMultiImageUpload")
		public void smarteditorMultiImageUpload(HttpServletRequest request, HttpServletResponse response){
	  
			try {
				System.out.println("smarteditorMultiImageUpload 진입!!");
				//파일정보            
				String sFileInfo = "";
				//파일명을 받는다 - 일반 원본파일명
				String sFilename = request.getHeader("file-name");
				//파일 확장자
				String sFilenameExt = sFilename.substring(sFilename.lastIndexOf(".")+1);
				//확장자를소문자로 변경
				sFilenameExt = sFilenameExt.toLowerCase();
					
				//이미지 검증 배열변수
				String[] allowFileArr = {"jpg","png","bmp","gif"};

				//확장자 체크
				int nCnt = 0;
				for(int i=0; i<allowFileArr.length; i++) {
					if(sFilenameExt.equals(allowFileArr[i])){
						nCnt++;
					}
				}

				//이미지가 아니라면
				if(nCnt == 0) {
					PrintWriter print = response.getWriter();
					print.print("NOTALLOW_"+sFilename);
					print.flush();
					print.close();
				} else {
					//디렉토리 설정 및 업로드	
					
					//파일경로
					//String filePath = request.getServletContext().getRealPath("/resources/multiImageFile/");
					String filePath = "C://workspace_2020_12//ttmsoft_board_test//WebContent//resources//multiImageFile//";
					File file = new File(filePath);
					
					if(!file.exists()) {
						file.mkdirs();
					}
					
					String sRealFileNm = "";
					SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMddHHmmss");
					String today= formatter.format(new java.util.Date());
					sRealFileNm = today+UUID.randomUUID().toString() + sFilename.substring(sFilename.lastIndexOf("."));
					String rlFileNm = filePath + sRealFileNm;
					
					///////////////// 서버에 파일쓰기 ///////////////// 
					try {
					    InputStream inputStream = request.getInputStream();
					    OutputStream outputStream = new FileOutputStream(rlFileNm);
					    int numRead;
					    byte bytes[] = new byte[Integer.parseInt(request.getHeader("file-size"))];
					    
					    while ((numRead = inputStream.read(bytes, 0, bytes.length)) != -1) {
					        outputStream.write(bytes, 0, numRead);
					    }
					    
					    if (inputStream != null) {
					        inputStream.close();
					    }
					    
					    outputStream.flush();
					    outputStream.close();
					    // 파일 저장 완료 후 콘솔에 로그 출력
					    System.out.println("File saved successfully: " + rlFileNm);
					} catch (IOException e) {
					    e.printStackTrace(); // 예외 발생 시 스택 트레이스 출력
					}

					
					///////////////// 이미지 /////////////////
					try {
					    // 정보 출력
					    sFileInfo += "&bNewLine=true";
					    // img 태그의 title 속성을 원본파일명으로 적용시켜주기 위함
					    sFileInfo += "&sFileName=" + sFilename;
					    sFileInfo += "&sFileURL=" + request.getContextPath() + "/resources/multiImageFile/" + sRealFileNm;
					    	
					    
					    PrintWriter printWriter = response.getWriter();
					    printWriter.print(sFileInfo);
					    printWriter.flush();
					    printWriter.close();
					    System.out.println("가져오기 성공 !"); 
					    System.out.println("sFileURL: " + request.getContextPath() + "/resources/multiImageFile/" + sRealFileNm);
					} catch (IOException e) {
					    e.printStackTrace(); // 예외 발생 시 스택 트레이스 출력
					    System.err.println("Failed to print image info: " + e.getMessage());
					}

				}	
			} catch (Exception e) {
				e.printStackTrace();
			}
		} 
 
}
