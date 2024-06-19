package kr.co.ttmsoft.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.co.ttmsoft.beans.AdminAnswerBean;
import kr.co.ttmsoft.mapper.AnswerMapper;

@Repository
public class AnswerDao {
	
	@Autowired
	private AnswerMapper answerMapper;
	
	public void addAdminAnswerBean(AdminAnswerBean addAdminAnswerBean) {
		answerMapper.addAdminAnswerBean(addAdminAnswerBean);
	}
	
	public List<AdminAnswerBean> getAdminAnswerList(int content_idx){
		return answerMapper.getAdminAnswerList(content_idx);
	}
	
	public void modifyAdminAnswerBean(AdminAnswerBean modifyAdminAnswerBean) {
		answerMapper.modifyAdminAnswerBean(modifyAdminAnswerBean);
	}
	
	public void deleteAdminAnswer(int admin_answer_idx) {
		answerMapper.deleteAdminAnswer(admin_answer_idx);
	}
}
