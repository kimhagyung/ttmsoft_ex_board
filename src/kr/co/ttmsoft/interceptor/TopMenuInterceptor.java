package kr.co.ttmsoft.interceptor;

import java.util.List;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

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
        
        // 요청 시점의 사용자 URI 정보를 Session의 Attribute에 담아서 전달(잘 지워줘야 함)
        // 로그인이 틀려서 다시 하면 요청 시점의 URI가 로그인 페이지가 되므로 조건문 설정
        String uri = request.getHeader("Referer"); // Referer은 요청을 보낸 URL임
        if (uri != null && !uri.contains("/user/login")) {
            request.getSession().setAttribute("prevPage", uri);
        }

        // 세션 정보 출력
        HttpSession session = request.getSession();
        System.out.println("Session ID: " + session.getId());
        System.out.println("Session Creation Time: " + session.getCreationTime());
        System.out.println("Session Last Accessed Time: " + session.getLastAccessedTime());
        System.out.println("Session Max Inactive Interval: " + session.getMaxInactiveInterval());

        // 이전 페이지 정보 출력
        String prevPage = (String) session.getAttribute("prevPage");
        System.out.println("Prev Page: " + prevPage);

        List<BoardInfoBean> topMenuList = topMenuService.getTopMenuList();  
        request.setAttribute("topMenuList", topMenuList); 

        return true;
    }
}
