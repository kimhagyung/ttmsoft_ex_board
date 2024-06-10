package kr.co.ttmsoft.config;

import javax.annotation.Resource;

import org.apache.commons.dbcp2.BasicDataSource;
import org.apache.ibatis.session.SqlSessionFactory;
import org.mybatis.spring.SqlSessionFactoryBean;
import org.mybatis.spring.mapper.MapperFactoryBean;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.PropertySource;
import org.springframework.context.support.PropertySourcesPlaceholderConfigurer;
import org.springframework.context.support.ReloadableResourceBundleMessageSource;
import org.springframework.web.multipart.support.StandardServletMultipartResolver;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;
import org.springframework.web.servlet.config.annotation.InterceptorRegistration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.ViewResolverRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import kr.co.ttmsoft.beans.UserBean;
import kr.co.ttmsoft.interceptor.LoginInterceptor;
import kr.co.ttmsoft.interceptor.TopMenuInterceptor;
import kr.co.ttmsoft.interceptor.TopMenuInterceptor2;
import kr.co.ttmsoft.mapper.BoardMapper;
import kr.co.ttmsoft.mapper.CommentMapper;
import kr.co.ttmsoft.mapper.TopMenuMapper;
import kr.co.ttmsoft.mapper.UserMapper;
import kr.co.ttmsoft.service.TopMenuService;

@Configuration
@EnableWebMvc // 스캔한 패키지 내부의 클래스 중 Controller 어노테이션을 가지고 있는 클래스 들을 Controller로 등록
@ComponentScan("kr.co.ttmsoft.controller")
@ComponentScan("kr.co.ttmsoft.dao")
@ComponentScan("kr.co.ttmsoft.service")
@PropertySource("/WEB-INF/properties/db.properties") // 해당 경로의 프로퍼티 값 자동 주입
public class ServletAppContext implements WebMvcConfigurer {
//Spring MVC 프로젝트에 관련된 설정을 하는 클래스

	@Value("${db.classname}")
	private String db_classname;
	// 프로퍼티의 해당 key(db.classname)에 해당하는 값을 변수에 주입

	@Value("${db.url}")
	private String db_url;

	@Value("${db.username}")
	private String db_username;

	@Value("${db.password}")
	private String db_password;

	@Resource(name = "loginUserBean")
	private UserBean loginUserBean;

	@Autowired
	private TopMenuService topMenuService;

	@Override
	public void addResourceHandlers(ResourceHandlerRegistry registry) {
		// 정적 파일 경로 매핑(이거 지우면 사진 경로 못찾음)
		registry.addResourceHandler("/**").addResourceLocations("/resources/");
		//WebMvcConfigurer.super.addResourceHandlers(registry);
		 
		// 네이버 스마트 에디터 경로때문에 적어둠 
		 registry.addResourceHandler("/resources/**").addResourceLocations("/resources/");
	}
	@Override
	public void configureViewResolvers(ViewResolverRegistry registry) {
		// Controller의 메서드가 반환하는 파일 앞뒤에 경로와 확장자 추가
		WebMvcConfigurer.super.configureViewResolvers(registry);
		registry.jsp("/WEB-INF/views/", ".jsp");
	}

	@Bean
	public BasicDataSource dataSource() {
		BasicDataSource source = new BasicDataSource();
		source.setDriverClassName(db_classname);
		source.setUrl(db_url);
		source.setUsername(db_username);
		source.setPassword(db_password);

		return source;
	}

	@Bean
	public SqlSessionFactory factory(BasicDataSource source) throws Exception {
		SqlSessionFactoryBean factoryBean = new SqlSessionFactoryBean();
		factoryBean.setDataSource(source);
		SqlSessionFactory factory = factoryBean.getObject();
		return factory;
	}

	@Bean
	public MapperFactoryBean<BoardMapper> getBoardMapper(SqlSessionFactory factory) throws Exception {
		MapperFactoryBean<BoardMapper> factoryBean = new MapperFactoryBean<BoardMapper>(BoardMapper.class);
		factoryBean.setSqlSessionFactory(factory);
		return factoryBean;
	}

	@Bean
	public MapperFactoryBean<TopMenuMapper> getTopMenuMapper(SqlSessionFactory factory) throws Exception {
		MapperFactoryBean<TopMenuMapper> factoryBean = new MapperFactoryBean<TopMenuMapper>(TopMenuMapper.class);
		factoryBean.setSqlSessionFactory(factory);
		return factoryBean;
	}

	@Bean
	public MapperFactoryBean<UserMapper> getUserMapper(SqlSessionFactory factory) throws Exception {
		MapperFactoryBean<UserMapper> factoryBean = new MapperFactoryBean<UserMapper>(UserMapper.class);
		factoryBean.setSqlSessionFactory(factory);
		return factoryBean;
	}
	
	@Bean
	public MapperFactoryBean<CommentMapper> getCommentMapper(SqlSessionFactory factory) throws Exception {
		MapperFactoryBean<CommentMapper> factoryBean = new MapperFactoryBean<CommentMapper>(CommentMapper.class);
		factoryBean.setSqlSessionFactory(factory);
		return factoryBean;
	}

	@Override
	public void addInterceptors(InterceptorRegistry registry) { 
		TopMenuInterceptor topMenuInterceptor = new TopMenuInterceptor(topMenuService);
		TopMenuInterceptor2 topMenuInterceptor2 = new TopMenuInterceptor2(loginUserBean);
		LoginInterceptor loginInterceptor=new LoginInterceptor(loginUserBean);
		
		InterceptorRegistration reg1 = registry.addInterceptor(topMenuInterceptor);
		InterceptorRegistration reg2 = registry.addInterceptor(topMenuInterceptor2);
		InterceptorRegistration reg3 = registry.addInterceptor(loginInterceptor);
		
		reg1.addPathPatterns("/**"); // 모든 요청에서 동작
		reg2.addPathPatterns("/**");
		reg3.addPathPatterns("/board/modify","/board/delete", "/user/modify", "/board/write");
	}

	@Bean
	public static PropertySourcesPlaceholderConfigurer PropertySourcesPlaceholderConfigurer() {
		return new PropertySourcesPlaceholderConfigurer();
	}

	// 이미지
	@Bean
	public StandardServletMultipartResolver multipartResolver() {
		return new StandardServletMultipartResolver();
	}

	@Bean
	public ReloadableResourceBundleMessageSource messageSource() {
		ReloadableResourceBundleMessageSource res = new ReloadableResourceBundleMessageSource();
		res.setBasenames("/WEB-INF/properties/error_message");
		return res;
	}

}
