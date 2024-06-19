package kr.co.ttmsoft.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.ttmsoft.beans.ReplyBean;
import kr.co.ttmsoft.dao.ReplyDao;

@Service
public class ReplyService {
	
	@Autowired
	private ReplyDao replyDao;
	
	public void addReplyBean(ReplyBean addReplyBean) {
		replyDao.addReplyBean(addReplyBean);
	}
	
	public List<ReplyBean> getAllReplyInfo(int comment_idx){
		return replyDao.getAllReplyInfo(comment_idx);
	}
	
	public void UpdateReplyBean(ReplyBean updateReplyBean) {
		replyDao.UpdateReplyBean(updateReplyBean);
	}
 
	public void deleteReply(int reply_idx) {
		replyDao.deleteReply(reply_idx);
	}
}
