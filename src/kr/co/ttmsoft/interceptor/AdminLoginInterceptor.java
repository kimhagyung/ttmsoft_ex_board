package kr.co.ttmsoft.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.HandlerInterceptor;

import kr.co.ttmsoft.beans.AdminBean;

public class AdminLoginInterceptor implements HandlerInterceptor {
	
	private AdminBean loginAdminBean;
	
	public AdminLoginInterceptor(AdminBean loginAdminBean) {
		this.loginAdminBean=loginAdminBean;
	}

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		
		if(loginAdminBean.isAdmin_login()==false) {
			String contextPath=request.getContextPath();
			response.sendRedirect(contextPath+"/admin/not_login");
			return false;
		}
			
		return true;
	}
	
	
}
