package kr.co.ttmsoft.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import kr.co.ttmsoft.beans.ContentBean;
import kr.co.ttmsoft.mapper.BoardMapper;
 
@Controller
@RequestMapping("/test")
public class TestController {
	@Autowired
	private BoardMapper boardMapper;
	
	//사용안함 
	@GetMapping("/fileTest")
	public String fileTest() {

		return "test/fileTest";
	}

	//사용안함
	@GetMapping("/fileTest2")
	public String fileTest2() {

		return "test/fileTest2";
	}
	
	//해시태그테스트(사용은안함)
	@GetMapping("/hashTag")
	public String hashTag() {
		
		return "test/hashTag";
	}
	
	@GetMapping("/calendarEx")
	public String testPage() {
		//캘린더 그냥 해본건데 사용은 안함.
		return "test/calendarEx";
	}
	
	@GetMapping("/paging")
	public String paging() { 
		return "test/paging";
	}
	
	//실패함
	@GetMapping("/pagingDo")
	public ModelAndView pagingDo() { 
		ModelAndView mav = new ModelAndView("jsonView"); 
		List<ContentBean> pagingTestAll= boardMapper.PagingTestAllContent();
		System.out.println("pagingTestAll>?????"+pagingTestAll);
		mav.addObject("pagingTestAll",pagingTestAll);
		return mav;
	}
	
	//색상표 테스트(바우처 참고함)
	@GetMapping("/colorTest")
	public String colorTest() {
		return "test/colorTest";
	}

	//ckEditor 테스트 
	@GetMapping("/ckEditor")
	public String ckEditor() {
		return "test/ckEditor";
	}
	 
	@GetMapping("/test")
	public String test() {
		return "test/test";
	}
	
	
}
