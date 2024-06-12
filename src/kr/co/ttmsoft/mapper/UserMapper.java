package kr.co.ttmsoft.mapper;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import kr.co.ttmsoft.beans.AdminBean;
import kr.co.ttmsoft.beans.UserBean;

public interface UserMapper {
	@Select("select *from user_table where user_id=#{user_id}")
	UserBean getLoginUserInfo(String user_id); // 현재 로그인한 사용자 조회
	
	@Select("select *from user_table where user_id=#{user_id}")
	String checkuserIdExist(String user_id); //중복 체크 
	
	@Insert("insert into user_table values(user_seq.nextval, #{user_name}, #{user_id},#{user_pw}) ")
	void addUserInfo(UserBean joinUserBean); //회원가입
	
	@Update("update user_table\r\n"
			+ "set user_name=#{user_name, jdbcType=VARCHAR} ,user_id=#{user_id, jdbcType=VARCHAR}\r\n"
			+ "where user_idx=#{user_idx}")
	void ModifyUserInfo(UserBean modifyUserBean);
	
    @Select("SELECT COUNT(*) " +
            "FROM user_table " +
            "WHERE user_idx = #{user_idx} AND user_pw = #{user_pw}")
    boolean confirmPassword(@Param("user_idx") int user_idx, @Param("user_pw") String user_pw);
    
    
    @Select("select *from admin_table where admin_id=#{admin_id}")
    AdminBean getAdminInfo(String admin_id);//관리자 로그인 
}
