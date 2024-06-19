package kr.co.ttmsoft.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.bind.annotation.RestController;

import kr.co.ttmsoft.beans.AdminAnswerBean;
import kr.co.ttmsoft.beans.BoardFileBean;
import kr.co.ttmsoft.beans.CommentBean;
import kr.co.ttmsoft.beans.ContentBean;
import kr.co.ttmsoft.beans.ReplyBean;
import kr.co.ttmsoft.service.AnswerService;
import kr.co.ttmsoft.service.BoardService;
import kr.co.ttmsoft.service.CommentService;
import kr.co.ttmsoft.service.ReplyService;
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
	} 
	
	//관리자 페이지 게시글 삭제처리 
	@GetMapping("/tempDeleted")
	public void tempDeleted(@RequestParam("content_idx") int content_idx) {
		boardService.UpdateIsDeletedYes(content_idx);
	}
	
	//관리자 페이지 게시글 완전 삭제 
	@GetMapping("/ComDeleted")
	public void ComDeleted(@RequestParam("content_idx") int content_idx) {
		boardService.deleteBoardInfo(content_idx);
	}
}
