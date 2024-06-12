package kr.co.ttmsoft.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import kr.co.ttmsoft.beans.CommentBean;

public interface CommentMapper {
	
	@Insert("insert into comment_table values(comment_seq.nextval, #{comments},SYSDATE,#{content_idx},#{user_idx})")
	void addComment(CommentBean writeComment); //댓글 추가 
	
	@Select("select user_name, comments, comment_date,comment_idx,u.user_idx   \r\n"
			+ "from user_table u, comment_table c\r\n"
			+ "where u.user_idx=c.user_idx and content_idx=#{content_idx} order by comment_idx desc")
	List<CommentBean> getAllCommentInfo(int content_idx); //댓글 조회 
	
	
	@Update("update comment_table \r\n"
			+ "set comments=#{comments} , comment_date=SYSDATE\r\n"
			+ "where comment_idx=#{comment_idx}")
	void modifyComment(CommentBean modifyCommentBean); //댓글 수정
	
	@Delete("delete from comment_table where comment_idx=#{comment_idx}")
	void deleteComment(int comment_idx);
}
