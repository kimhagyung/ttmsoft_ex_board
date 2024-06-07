//#2-1
//상단메뉴 서비스까지 만들고 컨트롤러에서 서비스를 주입 받아 사용X
package kr.co.ttmsoft.interceptor;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.HandlerInterceptor;

import kr.co.ttmsoft.beans.BoardInfoBean;
import kr.co.ttmsoft.beans.UserBean;
import kr.co.ttmsoft.service.TopMenuService;

public class TopMenuInterceptor2 implements HandlerInterceptor {
	
	@Resource(name="loginUserBean")
	private UserBean loginUserBean;

	public TopMenuInterceptor2(UserBean loginUserBean) {
		this.loginUserBean = loginUserBean;
	}

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		request.setAttribute("loginUserBean", loginUserBean);
		return true;
	}
}
