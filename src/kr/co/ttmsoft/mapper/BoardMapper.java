package kr.co.ttmsoft.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.SelectKey;
import org.apache.ibatis.annotations.Update;
import org.apache.ibatis.session.RowBounds;

import kr.co.ttmsoft.beans.BoardFileBean;
import kr.co.ttmsoft.beans.BoardInfoBean;
import kr.co.ttmsoft.beans.ContentBean;
import kr.co.ttmsoft.beans.NaverEditorBean;

public interface BoardMapper {
	
	@Insert("insert into content_table(content_idx,content_subject,content_text,user_idx,content_board_idx,content_date,content_is_public,modifyContent_date) values(content_seq.nextval,#{content_subject, jdbcType=VARCHAR},#{content_text, jdbcType=VARCHAR},#{user_idx},#{content_board_idx},sysdate,#{content_is_public}, SYSDATE)")
	@SelectKey(statement="SELECT content_seq.currval FROM dual", keyProperty="content_idx", before=false, resultType=int.class)
	void addBoardInfo(ContentBean boardPostBean); //컨텐츠 내용 추가 
	
	@Insert("insert into board_file values(board_file_seq.nextval,#{file_path},#{file_name},SYSDATE,#{content_idx},#{user_idx},#{file_size,jdbcType=VARCHAR}) ")
	void addBoardFileInfo(BoardFileBean boardFileBean); // 컨텐츠 사진 추가 
	
	@Select("select * from content_table where content_idx=#{content_idx} ")
	ContentBean getBoardInfo(int content_idx); //각 게시글들 조회 
	
	@Select("select * from board_file where content_idx=#{content_idx} order by board_file_idx desc")
	List<BoardFileBean> getBoardFileInfo(int content_idx); //게시글 사진 조회 
	
	@Select("select * \r\n"
			+ "from board_info_table b, content_table c\r\n"
			+ "where b.board_info_idx=c.content_board_idx and content_board_idx=#{content_board_idx} order by content_idx desc")
	List<ContentBean> getBoardPageInfo(int content_board_idx,RowBounds rowBounds); //각 게시글들 페이징 
	
	@Select("select count(*)\r\n"
			+ "from content_table where content_board_idx=#{content_board_idx}")
	int getBoardPageInfoCnt(int content_board_idx); //게시글 개수 
	
	@Select("select * from board_info_table where board_info_idx=#{board_info_idx}")
	BoardInfoBean getAllBoardInfo(int board_info_idx); //게시판 테이블 모든 정보 가져오기  
	
	@Select("select * from board_info_table b, content_table c, user_table u\r\n"
			+ "where b.board_info_idx=c.content_board_idx \r\n"
			+ "and u.user_idx = c.user_idx\r\n"
			+ "and content_board_idx=#{board_info_idx} \r\n"
			+ "order by content_idx desc")
	List<ContentBean> getAllContentInfo(int board_info_idx); //게시판 번호로 게시글들 조회하기 
	
	@Select("select * from board_info_table b, content_table c, user_table u\r\n"
			+ "where b.board_info_idx=c.content_board_idx \r\n"
			+ "and u.user_idx = c.user_idx\r\n"
			+ "and content_board_idx=#{content_board_idx} and is_deleted=#{is_deleted} \r\n"
			+ "order by content_idx desc")
	List<ContentBean> getAllContentInfoYesORNo(@Param("content_board_idx")int board_info_idx, @Param("is_deleted")String is_deleted); //게시판 번호로 게시글들 조회하기 
	
	
	@Select("SELECT * \r\n"
			+ "FROM (\r\n"
			+ "    SELECT * \r\n"
			+ "    FROM content_table \r\n"
			+ "    ORDER BY content_idx DESC\r\n"
			+ ") \r\n"
			+ "WHERE ROWNUM <= 5 and content_board_idx=#{content_board_idx} and is_deleted = 'N'") //and is_public=1
	List<ContentBean> getBoardInfoo(int content_board_idx); //메인에 뿌려주는 게시글들  (5개씩만)
	
	@Select("select distinct(user_name) from content_table c, user_table u where c.user_idx=u.user_idx and content_idx=#{content_idx}")
	String getContentUserName(int content_idx); //작성자 이름 조회
	
	@Update("update content_table\r\n"
			+ "set content_subject=#{content_subject, jdbcType=VARCHAR}, content_is_public=#{content_is_public, jdbcType=INTEGER}, content_text=#{content_text, jdbcType=VARCHAR},modifyContent_date=sysdate\r\n"
			+ "where content_idx=#{content_idx}")
	void modifyBoardInfo(ContentBean modifyBoardInfo); //게시글 수정
	
	@Update("update board_file \r\n"
			+ "set file_path = #{file_path}, file_name=#{file_name}, uploaded_at=SYSDATE, file_size=#{file_size}\r\n"
			+ "where board_file_idx=#{board_file_idx}")
	void modifyBoardFileBean(BoardFileBean modifyBoardFileInfo); //게시글 파일 수정
	
	/*
	@Update("update content_table\r\n"
			+ "set content_subject=#{content_subject}, is_public=#{is_public},  content_text=#{content_text},content_date=sysdate\r\n"
			+ "where content_idx=#{content_idx}")
	void modifyBoardInfoWithoutFile(ContentBean modifyBoardInfo); //추가된 사진없는게시글 수정
	*/
	
	
	@Delete("delete from content_table where content_idx=#{content_idx}")
	void deleteBoardInfo(int content_idx);
	
	@Update("update content_table \r\n"
			+ "set is_deleted = 'Y'\r\n"
			+ "where content_idx=#{content_idx}")
	void UpdateIsDeletedYes(int content_idx); //삭제처리 함수 

	@Update("update content_table \r\n"
			+ "set is_deleted = 'N'\r\n"
			+ "where content_idx=#{content_idx}")
	void UpdateIsDeletedNo(int content_idx); //삭제처리취소 함수 (사용은 안하는중)
	
	@Delete("delete from board_file where board_file_idx=#{board_file_idx}")
	void deleteBoardFile(int board_file_idx);
	
	
    @Select("SELECT * " +
            "FROM board_info_table " +
            "WHERE UPPER(board_info_name) LIKE '%' || UPPER(#{board_info_name}) || '%'")
    List<BoardInfoBean> searchBoardNameInfo(String board_info_name);  //게시판 이름 검색 
    
    @Select("SELECT * " +
    		"FROM board_info_table " +
    		"WHERE UPPER(board_info_name) LIKE '%' || UPPER(#{board_info_name, jdbcType=VARCHAR}) || '%' and is_usage=#{is_usage, jdbcType=VARCHAR}")
    List<BoardInfoBean> searchBoardNameInfoYOrNo(@Param("board_info_name")String board_info_name, @Param("is_usage")String is_usage); //사용여부도 검색 
	
	//네이버 에디터 (테스트용)
	@Insert("insert into naverEditor_table(naverEditor_idx,naverEditor_subject,naverEditor_text,naverEditor_file,naverEditor_date,is_publish,user_idx,board_info_idx) values(naverEditor_seq.nextval, #{naverEditor_subject},#{naverEditor_text},#{naverEditor_file, jdbcType=VARCHAR},sysdate,#{is_publish, jdbcType=INTEGER },#{user_idx},#{board_info_idx})")
	void addNaverEditorBean(NaverEditorBean naverEditorBean);
	 
}
