package kr.co.ttmsoft.mapper;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;

import kr.co.ttmsoft.beans.UserBean;

public interface UserMapper {
	@Select("select *from user_table where user_id=#{user_id}")
	UserBean getLoginUserInfo(String user_id); // 현재 로그인한 사용자 조회
	
	@Select("select *from user_table where user_id=#{user_id}")
	String checkuserIdExist(String user_id); //중복 체크 
	
	@Insert("insert into user_table values(user_seq.nextval, #{user_name}, #{user_id},#{user_pw}) ")
	void addUserInfo(UserBean joinUserBean); //회원가입
}
