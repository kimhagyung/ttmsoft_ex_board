package kr.co.ttmsoft.mapper;

import org.apache.ibatis.annotations.Insert;

public interface CreateBoardMapper {

	//@Insert("insert into board_management values(board_management_seq.nextval, #{board_name}, #{board_explanation}, #{is_answer},#{is_comment},#{is_file}, #{is_usage}, SYSDATE, #{file_size},#{file_ext})")
}
