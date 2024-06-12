package kr.co.ttmsoft.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.ttmsoft.beans.CommentBean;
import kr.co.ttmsoft.dao.CommentDao;

@Service
public class CommentService {
	@Autowired
	private CommentDao commentDao;
	
	//댓글 추가
	public void addComment(CommentBean writeComment) {
		commentDao.addComment(writeComment);
	}
	
	//댓글 조회
	public List<CommentBean> getAllCommentInfo(int content_idx){
		return commentDao.getAllCommentInfo(content_idx);
	}
	
	//댓글 수정 
	public void modifyComment(CommentBean modifyCommentBean) {
		commentDao.modifyComment(modifyCommentBean);
	}
	
	//댓글 삭제 
	public void deleteComment(int comment_idx) {
		commentDao.deleteComment(comment_idx);
	}
}
