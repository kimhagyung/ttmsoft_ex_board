package kr.co.ttmsoft.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
 

import kr.co.ttmsoft.beans.CommentBean;
import kr.co.ttmsoft.service.CommentService;
import kr.co.ttmsoft.service.UserService;

@RestController 
public class RestApiController {
	@Autowired
	private UserService userService;
	
	@Autowired
	private CommentService commentService;
	
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
	
	//댓글조회 
	@GetMapping("/commentShow")
	public List<CommentBean> getAllComments(@RequestParam("content_idx") int content_idx){
		List<CommentBean> comments=commentService.getAllCommentInfo(content_idx);

		return comments;
	}
	
	//댓글 수정 
	@PostMapping("/modifyComment")
	public CommentBean modifyComment(@RequestBody CommentBean modifyCommentBean) {
		commentService.modifyComment(modifyCommentBean);
		System.out.println("수정되어 받은 댓글"+modifyCommentBean.getComments());
		return modifyCommentBean;
	}
	
	//댓글 삭제 
	@GetMapping("/deleteComment")
	public void deleteComment(@RequestParam("comment_idx") int comment_idx) {
		commentService.deleteComment(comment_idx);
	}
}
