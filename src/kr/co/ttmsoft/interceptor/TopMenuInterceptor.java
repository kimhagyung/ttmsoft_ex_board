package kr.co.ttmsoft.interceptor;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.HandlerInterceptor;

import kr.co.ttmsoft.beans.BoardInfoBean;
import kr.co.ttmsoft.service.TopMenuService;

public class TopMenuInterceptor implements HandlerInterceptor {

	private TopMenuService topMenuService;

	public TopMenuInterceptor(TopMenuService topMenuService) {
		this.topMenuService = topMenuService;
	}

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		
		// 요청 매개변수에서 content_idx를 가져옵니다.
        String contentIdxStr = request.getParameter("content_idx");
        if (contentIdxStr != null) {
            int content_idx = Integer.parseInt(contentIdxStr);

            int getBoardTopMenu = topMenuService.getBoardTopMenu(content_idx);  

            request.setAttribute("getBoardTopMenu", getBoardTopMenu);
        }

        List<BoardInfoBean> topMenuList = topMenuService.getTopMenuList();  
        
        request.setAttribute("topMenuList", topMenuList); 
        return true;
    }

}
