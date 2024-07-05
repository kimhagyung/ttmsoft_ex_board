package kr.co.ttmsoft.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.fasterxml.jackson.databind.ObjectMapper;

import kr.co.ttmsoft.beans.AdminAnswerBean;
import kr.co.ttmsoft.beans.BoardFileBean;
import kr.co.ttmsoft.beans.BoardInfoBean;
import kr.co.ttmsoft.beans.CommentBean;
import kr.co.ttmsoft.beans.ContentBean;
import kr.co.ttmsoft.beans.ReplyBean;
import kr.co.ttmsoft.mapper.BoardMapper;
import kr.co.ttmsoft.service.AnswerService;
import kr.co.ttmsoft.service.BoardService;
import kr.co.ttmsoft.service.CommentService;
import kr.co.ttmsoft.service.ReplyService;
import kr.co.ttmsoft.service.TopMenuService;
import kr.co.ttmsoft.service.UserService;

@RestController 
public class RestApiController {
	@Autowired
	private UserService userService;
	
	@Autowired
	private CommentService commentService;
	
	@Autowired
	private ReplyService replyService;
	
	@Autowired 
	private AnswerService answerService;
	
	@Autowired
	private BoardService boardService;
	
	@Autowired
	private BoardMapper boardMapper;
	
	@Autowired
	private TopMenuService topMenuService;
	
	//아이디 중복 검사 
	@GetMapping("/user/checkUserIdExist/{user_id:.+}")
	public boolean checkUserIdExist(@PathVariable String user_id) {
		boolean chk = userService.checkuserIdExist(user_id);
		System.out.println("RestApiController-checkUserIdExist: "+chk);
		return chk;
	}
	
	//비밀번호 일치 검사 
	@GetMapping("/confirmPassword")
	public boolean confirmPassword(@RequestParam("user_idx") int user_idx, @RequestParam("user_pw") String user_pw) {
		
		System.out.println("user_idx"+user_idx);
		System.out.println("user_pw"+user_pw);
		return userService.confirmPassword(user_idx,user_pw);
	}
	
	//댓글 입력 
	@PostMapping("/comment")
	public CommentBean addComment(@RequestBody CommentBean writeCommentBean ) {
		commentService.addComment(writeCommentBean);
		return writeCommentBean;
	}	

	//대댓글 작성 
	@PostMapping("/submitReply")
	public ReplyBean addReply(@RequestBody ReplyBean WriteReplyBean) {
		replyService.addReplyBean(WriteReplyBean);
		return WriteReplyBean;
	}
	
	//관리자 답글 작성  
	@PostMapping("/AdminAnswer")
	public AdminAnswerBean addComment(@RequestBody AdminAnswerBean writeAnswerAdmin ) {
		answerService.addAdminAnswerBean(writeAnswerAdmin);
		return writeAnswerAdmin;
	}

	
	//댓글조회 
	@GetMapping("/commentShow")
	public List<CommentBean> getAllComments(@RequestParam("content_idx") int content_idx){
		List<CommentBean> comments=commentService.getAllCommentInfo(content_idx);
		for(CommentBean reply:comments) {
			System.out.println("서비스에서 받아온 댓글 :"+reply.getComments());
			
		}
		return comments;
	}
	
	//대댓글 조회  
	@GetMapping("/replyShow")
	public List<ReplyBean> getAllReply(@RequestParam("comment_idx") int comment_idx){
		List<ReplyBean> replys=replyService.getAllReplyInfo(comment_idx);
		for(ReplyBean reply:replys) {
			System.out.println("서비스에서 받아온 답글 :"+reply.getReply());
			
		}
		return replys;
	}
	
	//관리자 답글 조회  
		@GetMapping("/AnswerShow")
		public List<AdminAnswerBean> getAllAnswer(@RequestParam("content_idx") int content_idx){
			List<AdminAnswerBean> answers=answerService.getAdminAnswerList(content_idx);
			for(AdminAnswerBean answ:answers) {
				System.out.println("서비스에서 받아온 댓글 :"+answ.getAdmin_answer_idx());
				
			}
			return answers;
		}
	
	//댓글 수정 
	@PostMapping("/modifyComment")
	public CommentBean modifyComment(@RequestBody CommentBean modifyCommentBean) {
		commentService.modifyComment(modifyCommentBean);
		System.out.println("수정되어 받은 댓글"+modifyCommentBean.getComments());
		return modifyCommentBean;
	}
	
	//대댓글 수정 
	@PostMapping("/modifyReply")
	public ReplyBean modifyReply(@RequestBody ReplyBean modifyReply) {
		replyService.UpdateReplyBean(modifyReply);
		System.out.println("수정되어 받은 댓글"+modifyReply.getReply());  
		return modifyReply;
	}
	
	//관리자 답글 수정 
	@PostMapping("/modifyAnswer")
	public AdminAnswerBean modifyAnswer(@RequestBody AdminAnswerBean modifyAnswer) {
		answerService.modifyAdminAnswerBean(modifyAnswer);
		System.out.println("수정되어 받은 댓글"+modifyAnswer.getAmdin_answer());  
		return modifyAnswer;
	}
	 
	
	//댓글 삭제 
	@GetMapping("/deleteComment")
	public void deleteReply(@RequestParam("comment_idx") int comment_idx) {
		commentService.deleteComment(comment_idx);
	}
	
	//대댓글 삭제  
	@GetMapping("/deleteReply")
	public void deleteReReply(@RequestParam("reply_idx") int reply_idx) {
		replyService.deleteReply(reply_idx);
	}
	 

	//관리자 답글 삭제 
	@GetMapping("/deleteAnswer")
	public void deleteAnswer(@RequestParam("admin_answer_idx") int admin_answer_idx) {
		answerService.deleteAdminAnswer(admin_answer_idx);
	}
	
	//관리자 페이지 게시판 검색 
	/*
	@GetMapping("/searchBoard")
	public List<ContentBean> searchBoard(@RequestParam("board_info_idx") int board_info_idx) {
		List<ContentBean> searchBoard= boardService.getAllContentInfo(board_info_idx);
		System.out.println("받아온 게시판 번호 :"+board_info_idx);
		List<ContentBean> searchFileBoard=new ArrayList<ContentBean>(); 
		for(ContentBean search : searchBoard) {
			System.out.println("게시글 내용 :" +search.getContent_text());
			System.out.println("게시글 번호 :" +search.getContent_idx());
			  List<BoardFileBean> boardFiles = boardService.getBoardFileInfo(search.getContent_idx());
			  //search.setFile_name(boardFiles); // ContentBean에 BoardFileBean 리스트를 설정

		}
		return searchBoard;
	} */
	@GetMapping("/searchBoard")
	public Map<String, Object> searchBoard(@RequestParam("board_info_idx") int board_info_idx, @RequestParam("isDeleted") String isDeleted) {
	    List<ContentBean> searchBoard = new ArrayList<>();
	    List<BoardFileBean> searchFileBoard = new ArrayList<>();

	    System.out.println("받아온 게시판 번호 :" + board_info_idx);

	    if(isDeleted.equals("All")) {
	        searchBoard = boardService.getAllContentInfo(board_info_idx);
	        for (ContentBean search : searchBoard) {
	            System.out.println("게시글 내용 :" + search.getContent_text());
	            System.out.println("게시글 번호 :" + search.getContent_idx()); 
	            int contentIdx = search.getContent_idx();
	            List<BoardFileBean> files = boardService.getBoardFileInfo(contentIdx);
	            searchFileBoard.addAll(files);
	        }
	    } else if(isDeleted.equals("Y") || isDeleted.equals("N")) {
	        searchBoard = boardService.getAllContentInfoYesORNo(board_info_idx, isDeleted);
	        for (ContentBean search : searchBoard) {
	            System.out.println("게시글 내용 :" + search.getContent_text());
	            System.out.println("게시글 번호 :" + search.getContent_idx());
	            int contentIdx = search.getContent_idx();
	            List<BoardFileBean> files = boardService.getBoardFileInfo(contentIdx);
	            searchFileBoard.addAll(files);
	        }
	    }

	    Map<String, Object> result = new HashMap<>();
	    result.put("searchBoard", searchBoard);
	    result.put("searchFileBoard", searchFileBoard);

	    return result;
	}

	
	//관리자 페이지 게시글 삭제처리 
	@GetMapping("/tempDeleted")
	public void tempDeleted(@RequestParam("content_idx") int content_idx) {
		boardService.UpdateIsDeletedYes(content_idx);
	}
	
	
	//관리자 페이지 게시글 삭제처리 
	@GetMapping("/ClearDeleted")
	public void ClearDeleted(@RequestParam("content_idx") int content_idx) {
		boardService.UpdateIsDeletedNo(content_idx);
	}
	
	//관리자 페이지 게시글 완전 삭제 
	@GetMapping("/ComDeleted")
	public void ComDeleted(@RequestParam("content_idx") int content_idx) {
		boardService.deleteBoardInfo(content_idx);
	}
	
	//게시글 수정 시 파일 삭제 
	/*
	@GetMapping("/deleteFile")
	public void deleteFile(@RequestParam("board_file_idx") int board_file_idx) {
		System.out.println("받은 파일 번호:"+board_file_idx);
		boardService.deleteBoardFile(board_file_idx);
	}
	*/
	
	//게시글 수정 시 파일 삭제 후 조회  
	@GetMapping("/getFileInfo")
	public List<BoardFileBean> getFileInfo(@RequestParam("content_idx") int content_idx){
		List<BoardFileBean> files=boardService.getBoardFileInfo(content_idx);
		 
		return files;
	}
	 

	//게시판 검색 Pro
	@GetMapping("/SearchInfo")
	public Map<String, Object> SearchInfo(@RequestParam("board_info_name") String board_info_name, @RequestParam("is_usage") String is_usage){
		List<BoardInfoBean> Result=new ArrayList<BoardInfoBean>(); 
		List<Integer> contentCnt = new ArrayList<>();
		
		if(is_usage.equals("All")) {
			Result= boardService.searchBoardNameInfo(board_info_name);
		}else if(is_usage.equals("Y") || is_usage.equals("N")){
			Result=boardService.searchBoardNameInfoYOrNo(board_info_name,is_usage); 
			
		} 
		 
		for (BoardInfoBean getBoardIdx : Result) {
		    contentCnt.add(boardMapper.getBoardPageInfoCnt(getBoardIdx.getBoard_info_idx()));
		    System.out.println("게시글 개수 :"+ contentCnt);
		}
		
		 Map<String, Object> result = new HashMap<>();
	    result.put("searchResult", Result);
	    result.put("contentCnt", contentCnt);
		return result;
	}
	
	
	//관리자 페이지 게시판 정보 요청 ReqboardInfo
	@GetMapping("/ReqboardInfo") 
	public BoardInfoBean ReqboardInfo(@RequestParam("board_file_idx") int board_file_idx,
									@RequestParam("content_idx")int content_idx){
		
		BoardInfoBean req=topMenuService.getReqboardInfo(content_idx,board_file_idx);
		System.out.println("req의 게시판 값");
		return req;
	}
	 
	 
	 @GetMapping("/deleteFile")
	    public void deleteFile(@RequestParam("board_file_idx") String boardFileIdxJson) {
	        try {
	            ObjectMapper objectMapper = new ObjectMapper();
	            List<Integer> boardFileIdxList = objectMapper.readValue(boardFileIdxJson, List.class);
	            
	            for (Integer fileIdx : boardFileIdxList) { 
	                boardService.deleteBoardFile(fileIdx);
	                System.out.println(fileIdx + "번 째 삭제 완료");
	            }
	        } catch (Exception e) {
	            e.printStackTrace();
	        }
	    }
	 
	 /*
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
					String filePath = "C://workspace_2020_12//ttmsoft_board_test//WebContent//resources//multiImageFile//";
					//String filePath = request.getContextPath() + "resources//multiImageFile//";
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
					    System.out.println("sFileURL??: " + request.getContextPath() + "/resources/multiImageFile/" + sRealFileNm);
					} catch (IOException e) {
					    e.printStackTrace(); // 예외 발생 시 스택 트레이스 출력
					    System.err.println("Failed to print image info: " + e.getMessage());
					}

				}	
			} catch (Exception e) {
				e.printStackTrace();
			}
		}*/ 
}
