package kr.co.ttmsoft.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.ttmsoft.beans.BoardInfoBean;
import kr.co.ttmsoft.beans.CreateBoardBean;
import kr.co.ttmsoft.dao.CreateBoardDao;

@Service
public class CreateBoardService {
	
	@Autowired
	private CreateBoardDao createBoardDao;
	
	//게시판 생성 
	public void addCreateBoardInfo(BoardInfoBean CreateBoardBean) {
		createBoardDao.addCreateBoardInfo(CreateBoardBean);
	}
	
	//게시판 조회 
	public List<BoardInfoBean> showCreateBoardInfo(){
		return createBoardDao.showCreateBoardInfo();
	}
	
	//게시판 수정 
	public void modifyCreateBoardInfo(BoardInfoBean modifyBoardInfoBean) {
		createBoardDao.modifyCreateBoardInfo(modifyBoardInfoBean);
	}
}
