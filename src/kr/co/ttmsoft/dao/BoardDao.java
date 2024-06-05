package kr.co.ttmsoft.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.co.ttmsoft.beans.BoardInfoBean;
import kr.co.ttmsoft.beans.ContentBean;
import kr.co.ttmsoft.beans.UserBean;
import kr.co.ttmsoft.mapper.BoardMapper;
import kr.co.ttmsoft.mapper.UserMapper;

@Repository
public class BoardDao {
	@Autowired
	private BoardMapper boardMapper;

	public void addBoardInfo(ContentBean addBoardInfo) {
		boardMapper.addBoardInfo(addBoardInfo);
	}

	public ContentBean getBoardInfo(int content_idx) {

		return boardMapper.getBoardInfo(content_idx);
	}

	public List<ContentBean> getBoardInfoo(){
		return boardMapper.getBoardInfoo();
	}
	
	public String getContentUserName(int content_idx) {
		return boardMapper.getContentUserName(content_idx);
	}
	
	public void modifyBoardInfo(ContentBean modifyBoardInfo) {
		boardMapper.modifyBoardInfo(modifyBoardInfo);
	}
	
	public void deleteBoardInfo(int content_idx) {
		boardMapper.deleteBoardInfo(content_idx);
	}
	 
}
