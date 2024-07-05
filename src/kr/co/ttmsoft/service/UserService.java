package kr.co.ttmsoft.service;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.ttmsoft.beans.AdminBean;
import kr.co.ttmsoft.beans.UserBean;
import kr.co.ttmsoft.dao.UserDao;
import kr.co.ttmsoft.mapper.UserMapper;

@Service
public class UserService {

	@Autowired
	private UserDao userDao;

	@Autowired
    private UserMapper userMapper;
	
	@Resource(name = "loginUserBean")
	private UserBean loginUserBean;
	
	@Resource(name="loginAdminBean")
	private AdminBean loginAdminBean;

	public void addUserInfo(UserBean joinUserBean) {
		userDao.addUserInfo(joinUserBean);
	}

	public UserBean getLoginUserInfo(String user_id) {

		UserBean tb2 = userDao.getLoginUserInfo(user_id); 
			if (tb2 != null) {
				loginUserBean.setUser_id(tb2.getUser_id());
				loginUserBean.setUser_idx(tb2.getUser_idx());
				loginUserBean.setUser_pw(tb2.getUser_pw());
				loginUserBean.setUser_name(tb2.getUser_name());
				loginUserBean.setUserLogin(true); 
			} else {
				System.out.println("로그인 사용자 정보가 없숨"); 
			}
			System.out.println("로그인 사용자 이름"+tb2.getUser_name()); 
			return tb2;
	}
	
	public boolean checkuserIdExist(String user_id) {
		String user_name = userDao.checkuserIdExist(user_id);
		if(user_name == null) {
			return true;
		}else {
			return false;
		}	
	}
	
	public void ModifyUserInfo(UserBean modifyUserBean) {
		loginUserBean.setUser_name(modifyUserBean.getUser_name());
		loginUserBean.setUser_id(modifyUserBean.getUser_id());
		userDao.ModifyUserInfo(modifyUserBean);
		
	}
	
	//비밀번호 존재 여부 
	 public boolean confirmPassword(int user_idx, String user_pw) {
	        return userMapper.confirmPassword(user_idx, user_pw);
	    }
	
	 //관리자 로그인  
	 public void getAdminInfo(String admin_id) {
	 	AdminBean ab=userMapper.getAdminInfo(admin_id);
	 	
	 	if(ab!=null) {
	 		loginAdminBean.setAdmin_id(ab.getAdmin_id());
	 		loginAdminBean.setAdmin_idx(ab.getAdmin_idx());
	 		loginAdminBean.setAdmin_pw(ab.getAdmin_pw());
	 		loginAdminBean.setAdmin_name(ab.getAdmin_name());
	 		loginAdminBean.setAdmin_login(true);
	 		System.out.println("현재 관리자 로그인 상태 : "+loginAdminBean.isAdmin_login());
	 	}else {
	 		System.out.println("로그인 사용자 정보 없음 ");
	 	}
	}
	
}
