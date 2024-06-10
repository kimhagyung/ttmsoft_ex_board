package kr.co.ttmsoft.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.ttmsoft.beans.CommentBean;
import kr.co.ttmsoft.dao.CommentDao;

@Service
public class CommentService {
	@Autowired
	private CommentDao commentDao;
	
	public void addComment(CommentBean writeComment) {
		commentDao.addComment(writeComment);
	}
}
