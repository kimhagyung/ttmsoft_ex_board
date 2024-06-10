package kr.co.ttmsoft.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
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
	
	//댓글 입력 
	@PostMapping("/comment")
	public CommentBean addComment(@RequestBody CommentBean writeCommentBean ) {
		commentService.addComment(writeCommentBean);
		return writeCommentBean;
	}
}
