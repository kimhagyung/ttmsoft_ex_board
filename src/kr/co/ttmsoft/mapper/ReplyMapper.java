package kr.co.ttmsoft.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import kr.co.ttmsoft.beans.ReplyBean;

public interface ReplyMapper {
	@Insert("insert into reply_table(reply_idx,reply,reply_date,comment_idx,user_idx)\r\n"
			+ "values(reply_seq.nextval,#{reply},SYSDATE,#{comment_idx},#{user_idx})")
	void addReplyBean(ReplyBean addReplyBean); //대댓글 추가 
	
	@Select("select *from reply_table r, user_table u where r.user_idx=u.user_idx and comment_idx=#{comment_idx} order by reply_idx")
	List<ReplyBean> getAllReplyInfo(int comment_idx); //대댓글 조회 
	
	@Update("\r\n"
			+ "update reply_table \r\n"
			+ "set reply = #{reply} , reply_date = SYSDATE\r\n"
			+ "where reply_idx=#{reply_idx}")
	void UpdateReplyBean(ReplyBean updateReplyBean); //대댓글 수정 
	 
	
	@Delete("delete from reply_table \r\n"
			+ "where reply_idx=#{reply_idx}") //대댓글 삭제 
	void deleteReply(int reply_idx);
}
