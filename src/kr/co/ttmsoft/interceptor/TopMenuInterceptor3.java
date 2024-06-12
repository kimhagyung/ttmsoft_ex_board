package kr.co.ttmsoft.interceptor;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.HandlerInterceptor;

import kr.co.ttmsoft.beans.AdminBean;

public class TopMenuInterceptor3 implements HandlerInterceptor{
	
	@Resource(name="loginAdminBean")
	private AdminBean loginAdminBean;
	
	public TopMenuInterceptor3(AdminBean loginAdminBean) {
		this.loginAdminBean=loginAdminBean;
	}
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
 
		request.setAttribute("loginAdminBean", loginAdminBean); 
		return true;
	}
	
}
