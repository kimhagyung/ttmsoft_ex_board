package kr.co.ttmsoft.config;

import java.io.IOException;

import javax.annotation.Resource;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.security.web.authentication.WebAuthenticationDetails;

import kr.co.ttmsoft.beans.UserBean;
import kr.co.ttmsoft.service.UserService;
//이 파일 없어도 수행됨
@Configuration
@EnableWebSecurity
public class SecurityConfig extends WebSecurityConfigurerAdapter implements AuthenticationSuccessHandler {
 
    private final UserService userService; 
	
    @Autowired
    public SecurityConfig(UserService userService) {
        this.userService = userService;
    }

    @Override
    protected void configure(HttpSecurity http) throws Exception {
        // configure 메서드 내용은 생략하고, 인증 관련 설정을 구현합니다.
    }

    @Override
    public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response,
                                        Authentication authentication) throws IOException, ServletException {
        String user_id = authentication.getName(); // 인증된 사용자 ID
        UserBean authenticatedUser = userService.getLoginUserInfo(user_id);
         

        if (authenticatedUser != null) {
            // 세션에 사용자 정보 설정
            HttpSession session = request.getSession();
            session.setAttribute("authenticatedUser", authenticatedUser);
            System.out.println("여기는 SecurityConfig 임미다 ~");

            // 인증 정보 로깅
            WebAuthenticationDetails web = (WebAuthenticationDetails) authentication.getDetails();
            System.out.println("IP : " + web.getRemoteAddress());
            System.out.println("Session ID : " + web.getSessionId());
            System.out.println("Authenticated User : " + authenticatedUser.getUser_id());
             
        } else {
            // 사용자 정보가 없을 경우 처리
            response.sendRedirect("/login?error=true");
            System.out.println("SecurityConfig 로그인 실패 ");
        }
    }

}
 