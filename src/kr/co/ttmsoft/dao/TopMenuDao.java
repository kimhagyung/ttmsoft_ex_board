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
	
	
	public List<BoardInfoBean> getTopMenuList(){
		List<BoardInfoBean> topMenuList = topMenuMapper.getTopMenuList();
		return topMenuList;
	}
	
	public BoardInfoBean getReqboardInfo(int content_idx,int board_file_idx) {
		return topMenuMapper.getReqboardInfo(content_idx,board_file_idx);
	}
	
	public int getBoardTopMenu(int content_idx) {
		return topMenuMapper.getBoardTopMenu(content_idx);
	}
}
