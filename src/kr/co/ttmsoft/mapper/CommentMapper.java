package kr.co.ttmsoft.mapper;

import org.apache.ibatis.annotations.Insert;

import kr.co.ttmsoft.beans.CommentBean;

public interface CommentMapper {
	
	@Insert("insert into comment_table values(comment_seq.nextval, #{comments},SYSDATE,#{content_idx},#{user_idx})")
	void addComment(CommentBean writeComment);
}
