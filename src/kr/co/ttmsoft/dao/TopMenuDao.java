package kr.co.ttmsoft.dao;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.co.ttmsoft.beans.BoardInfoBean;
import kr.co.ttmsoft.mapper.TopMenuMapper;
 
@Repository
public class TopMenuDao {

	@Autowired
	private TopMenuMapper topMenuMapper;
	//ServletAppContext에서 등록한 TopMenuMapper를 주입
	
	
	public List<BoardInfoBean> getTopMenuList(){
		List<BoardInfoBean> topMenuList = topMenuMapper.getTopMenuList();
		return topMenuList;
	}
}
