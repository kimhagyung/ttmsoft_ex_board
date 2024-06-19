package kr.co.ttmsoft.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import kr.co.ttmsoft.beans.AdminAnswerBean;

public interface AnswerMapper {

	
	@Insert("insert into admin_answer_table(admin_answer_idx,amdin_answer,admin_answer_date,admin_idx,content_idx)\r\n"
			+ "values(admin_answer_seq.nextval, #{amdin_answer}, SYSDATE,#{admin_idx}, #{content_idx})")
	void addAdminAnswerBean(AdminAnswerBean addAdminAnswerBean); //관리자 답글 추가 
	
	@Select("select *from admin_answer_table answer, admin_table adm\r\n"
			+ "where answer.admin_idx=adm.admin_idx and answer.content_idx = #{content_idx} order by admin_answer_idx desc ")
	List<AdminAnswerBean> getAdminAnswerList(int content_idx); //관리자 답글 조회 
	
	@Update("update admin_answer_table \r\n"
			+ "set amdin_answer=#{amdin_answer}, admin_answer_date=SYSDATE\r\n"
			+ "where admin_answer_idx=#{admin_answer_idx}")
	void modifyAdminAnswerBean(AdminAnswerBean modifyAdminAnswerBean); //관리자 답글 수정 
	
	@Select(" delete from admin_answer_table \r\n"
			+ " where admin_answer_idx=#{admin_answer_idx}")
	void deleteAdminAnswer(int admin_answer_idx);
}
