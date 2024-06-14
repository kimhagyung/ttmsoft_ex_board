package kr.co.ttmsoft.dao;

import java.util.List;

import org.apache.ibatis.session.RowBounds;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.co.ttmsoft.beans.BoardFileBean;
import kr.co.ttmsoft.beans.BoardInfoBean;
import kr.co.ttmsoft.beans.ContentBean;
import kr.co.ttmsoft.beans.NaverEditorBean;
import kr.co.ttmsoft.beans.PageBean;
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
	
	public void addBoardFileInfo(BoardFileBean boardFileBean) {
		boardMapper.addBoardFileInfo(boardFileBean);
	}
	 
	
	public List<ContentBean> getBoardPageInfo(int content_board_idx, RowBounds rowBounds){
		return boardMapper.getBoardPageInfo(content_board_idx,rowBounds);
	}
	
	public int getBoardPageInfoCnt(int content_board_idx) {
		 
		return boardMapper.getBoardPageInfoCnt(content_board_idx);
	}
	
	public ContentBean getBoardInfo(int content_idx) {

		return boardMapper.getBoardInfo(content_idx);
	}

	public BoardFileBean getBoardFileInfo(int content_idx){
		return boardMapper.getBoardFileInfo(content_idx);
	}
	
	public List<ContentBean> getBoardInfoo(int content_board_idx){
		return boardMapper.getBoardInfoo(content_board_idx);
	}
	
	public String getContentUserName(int content_idx) {
		return boardMapper.getContentUserName(content_idx);
	}
	
	public void modifyBoardInfo(ContentBean modifyBoardInfo) {
		boardMapper.modifyBoardInfo(modifyBoardInfo);
	}
	
	public void modifyBoardInfoWithoutFile(ContentBean modifyBoardInfo) {
		boardMapper.modifyBoardInfoWithoutFile(modifyBoardInfo);
	}
	
	public void deleteBoardInfo(int content_idx) {
		boardMapper.deleteBoardInfo(content_idx);
	}
	

	public BoardInfoBean getAllBoardInfo(int board_info_idx) {
		return boardMapper.getAllBoardInfo(board_info_idx);
	}

	
	//네이버
	public void addNaverEditorBean(NaverEditorBean naverEditorBean) {
		boardMapper.addNaverEditorBean(naverEditorBean);
	}
	 
}
