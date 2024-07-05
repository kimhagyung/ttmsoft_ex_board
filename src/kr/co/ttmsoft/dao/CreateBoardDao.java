package kr.co.ttmsoft.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.co.ttmsoft.beans.BoardInfoBean;
import kr.co.ttmsoft.mapper.CreateBoardMapper;

@Repository
public class CreateBoardDao {
	
	
	@Autowired
	private CreateBoardMapper createBoardMapper;
	
	public void addCreateBoardInfo(BoardInfoBean CreateBoardBean) {
		createBoardMapper.addCreateBoardInfo(CreateBoardBean);
	}
	
	public List<BoardInfoBean> showCreateBoardInfo(){
		return createBoardMapper.showCreateBoardInfo();
	}
	
	public void modifyCreateBoardInfo(BoardInfoBean modifyBoardInfoBean) {
		createBoardMapper.modifyCreateBoardInfo(modifyBoardInfoBean);
	}
}
