package kr.co.ttmsoft.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.HandlerInterceptor;

import kr.co.ttmsoft.beans.AdminBean;
import kr.co.ttmsoft.beans.UserBean;

public class LoginInterceptor implements HandlerInterceptor {
	
	private UserBean loginUserBean;
	private AdminBean loginAdminBean;
	
	public LoginInterceptor(UserBean loginUserBean,AdminBean loginAdminBean) {
		this.loginUserBean=loginUserBean;
		this.loginAdminBean=loginAdminBean;
	}

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		
		if(loginUserBean.isUserLogin()==false && loginAdminBean.isAdmin_login()==false) {
			String contextPath=request.getContextPath();
			response.sendRedirect(contextPath+"/user/not_login");
			return false;
		}
			
		return true;
	}
	
	
}
