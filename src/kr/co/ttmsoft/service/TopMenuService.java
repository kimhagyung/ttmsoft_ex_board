package kr.co.ttmsoft.service;

//#1-4
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.ttmsoft.beans.BoardInfoBean;
import kr.co.ttmsoft.beans.ContentBean;
import kr.co.ttmsoft.dao.TopMenuDao;
//DAO에서 데이터 가져오기
//비즈니스 로직을 처리하는 클래스
@Service
public class TopMenuService {
	
	@Autowired
	private TopMenuDao topMenuDao;
	//TopMenuDao에 담긴 데이터를 사용하기 위해 Bean을 주입 받기
	
	public List<BoardInfoBean> getTopMenuList(){
		List<BoardInfoBean> topMenuList = topMenuDao.getTopMenuList();
		return topMenuList;
	}
	
}

