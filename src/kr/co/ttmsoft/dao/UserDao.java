package kr.co.ttmsoft.dao;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.co.ttmsoft.beans.UserBean;
import kr.co.ttmsoft.mapper.UserMapper;

@Repository
public class UserDao {
	@Autowired
	private UserMapper UserMapper;
	
	public void addUserInfo(UserBean joinUserBean) {
		UserMapper.addUserInfo(joinUserBean);
	}
	
	public UserBean getLoginUserInfo(String user_id){
		return UserMapper.getLoginUserInfo(user_id);
	} 
	
	public String checkuserIdExist(String user_id) {
		return UserMapper.checkuserIdExist(user_id);
	}
	
	public void ModifyUserInfo(UserBean modifyUserBean) {
		UserMapper.ModifyUserInfo(modifyUserBean);
	}
}
