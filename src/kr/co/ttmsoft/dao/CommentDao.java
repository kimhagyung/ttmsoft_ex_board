package kr.co.ttmsoft.dao;

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
}
