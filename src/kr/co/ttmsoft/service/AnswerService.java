package kr.co.ttmsoft.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.ttmsoft.beans.AdminAnswerBean;
import kr.co.ttmsoft.dao.AnswerDao;

@Service
public class AnswerService {
	
	@Autowired
	private AnswerDao answerDao;
	
	//답글 추가 
	public void addAdminAnswerBean(AdminAnswerBean addAdminAnswerBean) {
		answerDao.addAdminAnswerBean(addAdminAnswerBean);
	}
	
	//답글 조회 
	public List<AdminAnswerBean> getAdminAnswerList(int content_idx){
		return answerDao.getAdminAnswerList(content_idx);
	}
	
	//답글 수정 
	public void modifyAdminAnswerBean(AdminAnswerBean modifyAdminAnswerBean) {
		answerDao.modifyAdminAnswerBean(modifyAdminAnswerBean);
	}
	
	//답글 삭제 
	public void deleteAdminAnswer(int admin_answer_idx) {
		answerDao.deleteAdminAnswer(admin_answer_idx);
	}
}
