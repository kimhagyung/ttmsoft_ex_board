package kr.co.ttmsoft.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;
import org.apache.ibatis.session.RowBounds;

import kr.co.ttmsoft.beans.ContentBean;
import kr.co.ttmsoft.beans.NaverEditorBean;
import kr.co.ttmsoft.beans.PageBean;

public interface BoardMapper {
	@Insert("insert into content_table(content_idx,content_subject,content_text,content_file,content_writer_idx,content_board_idx,content_date,is_public) values(content_seq.nextval,#{content_subject},#{content_text, jdbcType=VARCHAR},#{content_file, jdbcType=VARCHAR},#{content_writer_idx},#{content_board_idx},sysdate,#{is_public})")
	void addBoardInfo(ContentBean boardPostBean);
	
	@Select("select * from content_table where content_idx=#{content_idx} ")
	ContentBean getBoardInfo(int content_idx); //각 게시글들 조회 
	
	@Select("select * \r\n"
			+ "from board_info_table b, content_table c\r\n"
			+ "where b.board_info_idx=c.content_board_idx and content_board_idx=#{content_board_idx} order by content_idx desc")
	List<ContentBean> getBoardPageInfo(int content_board_idx,RowBounds rowBounds); //각 게시글들 페이징 
	
	@Select("select count(*)\r\n"
			+ "from content_table where content_board_idx=#{content_board_idx}")
	int getBoardPageInfoCnt(int content_board_idx);
	
	@Select("SELECT * \r\n"
			+ "FROM (\r\n"
			+ "    SELECT * \r\n"
			+ "    FROM content_table \r\n"
			+ "    ORDER BY content_idx DESC\r\n"
			+ ") \r\n"
			+ "WHERE ROWNUM <= 5 and content_board_idx=#{content_board_idx} and is_public=1")
	List<ContentBean> getBoardInfoo(int content_board_idx); //메인에 뿌려주는 게시글들  
	
	@Select("select distinct(user_name) from content_table c, user_table u where c.content_writer_idx=u.user_idx and content_idx=#{content_idx}")
	String getContentUserName(int content_idx); //작성자 이름 조회
	
	@Update("update content_table\r\n"
			+ "set content_subject=#{content_subject}, is_public=#{is_public}, content_text=#{content_text}, content_file=#{content_file, jdbcType=VARCHAR},content_date=sysdate\r\n"
			+ "where content_idx=#{content_idx}")
	void modifyBoardInfo(ContentBean modifyBoardInfo); //게시글 수정
	
	@Update("update content_table\r\n"
			+ "set content_subject=#{content_subject}, is_public=#{is_public},  content_text=#{content_text},content_date=sysdate\r\n"
			+ "where content_idx=#{content_idx}")
	void modifyBoardInfoWithoutFile(ContentBean modifyBoardInfo); //추가된 사진없는게시글 수정
	
	@Delete("delete from content_table where content_idx=#{content_idx}")
	void deleteBoardInfo(int content_idx);
 
	
	//네이버 에디터 (테스트용)
	@Insert("insert into naverEditor_table(naverEditor_idx,naverEditor_subject,naverEditor_text,naverEditor_file,naverEditor_date,is_publish,user_idx,board_info_idx) values(naverEditor_seq.nextval, #{naverEditor_subject},#{naverEditor_text},#{naverEditor_file, jdbcType=VARCHAR},sysdate,#{is_publish, jdbcType=INTEGER },#{user_idx},#{board_info_idx})")
	void addNaverEditorBean(NaverEditorBean naverEditorBean);
	 
}
