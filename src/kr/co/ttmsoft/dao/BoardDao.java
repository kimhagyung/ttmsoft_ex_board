package kr.co.ttmsoft.dao;

import java.util.List;

import org.apache.ibatis.session.RowBounds;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.co.ttmsoft.beans.BoardFileBean;
import kr.co.ttmsoft.beans.BoardInfoBean;
import kr.co.ttmsoft.beans.ContentBean;
import kr.co.ttmsoft.beans.NaverEditorBean;
import kr.co.ttmsoft.mapper.BoardMapper;

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
	
	public String getFileFindPath(int board_file_idx) {
		return boardMapper.getFileFindPath(board_file_idx);
	}
	
	public int LetestContent_idx() {
		return boardMapper.LetestContent_idx();
	}
	public int LetestModifyContent_idx(int board_file_idx) {
		return boardMapper.LetestModifyContent_idx(board_file_idx);
	} 
	public int getBoardPageInfoCnt(int content_board_idx) {
		 
		return boardMapper.getBoardPageInfoCnt(content_board_idx);
	}
	
	public List<ContentBean> getAllContentInfoYesORNo(int board_info_idx, String is_deleted){
		return boardMapper.getAllContentInfoYesORNo(board_info_idx, is_deleted);
	}
	
	public ContentBean getBoardInfo(int content_idx) {

		return boardMapper.getBoardInfo(content_idx);
	}

	public List<BoardFileBean> getBoardFileInfo(int content_idx){
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
	
	public void modifyBoardFileBean(BoardFileBean modifyBoardFileInfo) {
		boardMapper.modifyBoardFileBean(modifyBoardFileInfo);
	}
	
	public void deleteBoardInfo(int content_idx) {
		boardMapper.deleteBoardInfo(content_idx);
	}
	

	public BoardInfoBean getAllBoardInfo(int board_info_idx) {
		return boardMapper.getAllBoardInfo(board_info_idx);
	}

	
	public List<ContentBean> getAllContentInfo(int board_info_idx){
		return boardMapper.getAllContentInfo(board_info_idx);
	}
	
	public void UpdateIsDeletedYes(int content_idx) {
		boardMapper.UpdateIsDeletedYes(content_idx);
	}
	
	public void UpdateIsDeletedNo(int content_idx) {
		boardMapper.UpdateIsDeletedNo(content_idx);
	}
	
	public void deleteBoardFile(int board_file_idx) {
		boardMapper.deleteBoardFile(board_file_idx);
	}
	
	public List<BoardInfoBean> searchBoardNameInfo(String board_info_name){
		return boardMapper.searchBoardNameInfo(board_info_name);
	}
	
    public List<BoardInfoBean> searchBoardNameInfoYOrNo(String board_info_name, String is_usage){
    	return boardMapper.searchBoardNameInfoYOrNo(board_info_name, is_usage);
    }
	
    public void plusCnt(int content_idx) {
    	boardMapper.plusCnt(content_idx);
    }
	
	//네이버
	public void addNaverEditorBean(NaverEditorBean naverEditorBean) {
		boardMapper.addNaverEditorBean(naverEditorBean);
	}
	 
}
