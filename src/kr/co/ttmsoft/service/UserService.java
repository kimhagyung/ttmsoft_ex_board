package kr.co.ttmsoft.service;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.ttmsoft.beans.UserBean;
import kr.co.ttmsoft.dao.BoardDao;
import kr.co.ttmsoft.dao.UserDao;

@Service
public class UserService {

	@Autowired
	private UserDao userDao;

	@Resource(name = "loginUserBean")
	private UserBean loginUserBean;

	public void addUserInfo(UserBean joinUserBean) {
		userDao.addUserInfo(joinUserBean);
	}

	public void getLoginUserInfo(String user_id) {

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
	}
	
	public boolean checkuserIdExist(String user_id) {
		String user_name = userDao.checkuserIdExist(user_id);
		if(user_name == null) {
			return true;
		}else {
			return false;
		}	
	}
	
	
}
