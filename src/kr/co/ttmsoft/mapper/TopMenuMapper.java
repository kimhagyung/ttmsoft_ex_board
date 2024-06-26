package kr.co.ttmsoft.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import kr.co.ttmsoft.beans.BoardInfoBean;

public interface TopMenuMapper {
	
	@Select("select * " +
			"from board_info_table " + 
			"order by board_info_idx")
	List<BoardInfoBean> getTopMenuList();
	
	/*
	@Select("select * " +
			"from board_info_table " + 
			"order by board_info_idx")
	int get getTopMenuList();*/
	
	
	@Select("select *from board_info_table b, board_file f, content_table c\r\n"
			+ "where b.board_info_idx = c.content_board_idx and c.content_idx = f.content_idx and f.content_idx=#{content_idx} and f.board_file_idx=#{board_file_idx}")
	BoardInfoBean getReqboardInfo(@Param("content_idx")int content_idx, @Param("board_file_idx")int board_file_idx);
	
	@Select("select board_info_idx from content_table c, board_info_table b \r\n"
			+ "where c.content_board_idx=b.board_info_idx and c.content_idx=#{content_idx}")
	int getBoardTopMenu(int content_idx);
}
