package kr.co.ttmsoft.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import kr.co.ttmsoft.beans.BoardInfoBean;
import kr.co.ttmsoft.beans.CreateBoardBean;

public interface CreateBoardMapper {

	@Insert("insert into board_info_table(board_info_idx,board_info_name,board_explanation,is_answer,is_comment,is_file,is_usage,file_checked,file_size,file_ext,board_date,is_public)\r\n"
			+ "values(board_info_seq.nextval, #{board_info_name}, #{board_explanation}, #{is_answer},#{is_comment},#{is_file}, #{is_usage},#{file_checked}, #{file_size, jdbcType=INTEGER},#{file_ext, jdbcType=VARCHAR}, SYSDATE, #{is_public})\r\n")
	void addCreateBoardInfo(BoardInfoBean CreateBoardBean); //게시판 생성 

	
	@Select("select *from board_info_table order by board_info_idx desc")
	List<BoardInfoBean> showCreateBoardInfo(); //게시판 전체 조회 
	
	@Update("UPDATE board_info_table\r\n"
			+ "SET\r\n"
			+ "    board_info_name = #{board_info_name, jdbcType=VARCHAR},\r\n"
			+ "    board_explanation = #{board_explanation, jdbcType=VARCHAR},\r\n"
			+ "    is_answer = #{is_answer, jdbcType=INTEGER},\r\n"
			+ "    is_comment = #{is_comment, jdbcType=INTEGER},\r\n"
			+ "    is_file = #{is_file, jdbcType=INTEGER},\r\n"
			+ "    is_usage = #{is_usage, jdbcType=VARCHAR},\r\n"
			+ "    board_date = SYSDATE,\r\n"
			+ "    file_size = #{file_size, jdbcType=INTEGER},\r\n"
			+ "    file_ext = #{file_ext, jdbcType=VARCHAR},\r\n"
			+ "    file_checked = #{file_checked, jdbcType=INTEGER} , is_public=#{is_public, jdbcType=INTEGER}\r\n"
			+ "WHERE\r\n"
			+ "    board_info_idx = #{board_info_idx}")
	void modifyCreateBoardInfo(BoardInfoBean ModifyCreateBoardBean); //게시판 수정 
	
	
	/*
	@Select("SELECT * " +
	        "FROM board_management " +
	        "WHERE board_name LIKE '%' || #{board_name} || '%' " +
	        "AND is_usage = #{is_usage, jdbcType=INTEGER}")
	List<CreateBoardBean> searchBoardInfo(@Param("board_name") String board_name, @Param("is_usage") String is_usage);
	*/
	
	@Select({
        "<script>",
        "SELECT * FROM board_management",
        "WHERE 1=1",
        "<if test='board_name != null'>",
        "AND board_name LIKE '%' || #{board_name} || '%'",
        "</if>",
        "<if test='is_usage != null'>",
        "AND is_usage = #{is_usage}",
        "</if>",
        "</script>"
    })
    List<BoardInfoBean> searchBoardInfo(@Param("board_name") String board_name, @Param("is_usage") String is_usage); //조건에 따른 게시판 검색 

	
}
