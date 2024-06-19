package kr.co.ttmsoft.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.co.ttmsoft.beans.ReplyBean;
import kr.co.ttmsoft.mapper.ReplyMapper;

@Repository
public class ReplyDao {
	
	@Autowired
	private ReplyMapper replyMapper;
	
	public void addReplyBean(ReplyBean addReplyBean) {
		replyMapper.addReplyBean(addReplyBean);
	}
	
	public List<ReplyBean> getAllReplyInfo(int comment_idx){
		return replyMapper.getAllReplyInfo(comment_idx);
	}
	
	public void UpdateReplyBean(ReplyBean updateReplyBean) {
		replyMapper.UpdateReplyBean(updateReplyBean);
	}
	
 
	
	public void deleteReply(int reply_idx) {
		replyMapper.deleteReply(reply_idx);
	}
}
