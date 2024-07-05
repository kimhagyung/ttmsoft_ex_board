package kr.co.ttmsoft.service;
 
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.ttmsoft.beans.BoardInfoBean;
import kr.co.ttmsoft.dao.TopMenuDao; 
@Service
public class TopMenuService {
	
	@Autowired
	private TopMenuDao topMenuDao;
	//TopMenuDao에 담긴 데이터를 사용하기 위해 Bean을 주입 받기
	
	public List<BoardInfoBean> getTopMenuList(){
		List<BoardInfoBean> topMenuList = topMenuDao.getTopMenuList();
		return topMenuList;
	}
	
	public BoardInfoBean getReqboardInfo(int content_idx, int board_file_idx) {
		return topMenuDao.getReqboardInfo(content_idx,board_file_idx);
	}
	
	public int getBoardTopMenu(int content_idx) {
		return topMenuDao.getBoardTopMenu(content_idx);
	}
}

