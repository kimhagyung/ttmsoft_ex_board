package kr.co.ttmsoft.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.co.ttmsoft.beans.CommentBean;
import kr.co.ttmsoft.mapper.CommentMapper;

@Repository
public class CommentDao {
	
	@Autowired
	private CommentMapper commentMapper;
	
	
	public void addComment(CommentBean writeComment) {
		commentMapper.addComment(writeComment);
	}
	
	public List<CommentBean> getAllCommentInfo(int content_idx){
		return commentMapper.getAllCommentInfo(content_idx);
	}
	
	public void modifyComment(CommentBean modifyCommentBean) {
		commentMapper.modifyComment(modifyCommentBean);
	}
	
	public void deleteComment(int comment_idx) {
		commentMapper.deleteComment(comment_idx);
	}
}
