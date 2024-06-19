package kr.co.ttmsoft.beans;

import java.util.List;

import org.apache.ibatis.annotations.Options;

public class ContentBean {
	 
	private int content_idx;//게시글 번호
	
	private String content_subject;//게시글 제목
	private String content_text;//게시글 본문
	private int user_idx;//작성자 번호(=회원테이블의 회원번호)
	private int content_board_idx;//게시판 번호(=게시판테이블의 게시판번호)
	private String content_date;//작성일 
	private int content_is_public; //공개여부  
	private String is_deleted;
	private String existingFile; //기존 파일 경로 
	private String board_info_name;
	private int board_info_idx;
	private String user_name;
	//private List<BoardFileBean> file_name;
	
	
	 
	public String getUser_name() {
		return user_name;
	}
	public void setUser_name(String user_name) {
		this.user_name = user_name;
	}
	public int getBoard_info_idx() {
		return board_info_idx;
	}
	public void setBoard_info_idx(int board_info_idx) {
		this.board_info_idx = board_info_idx;
	}
	public String getBoard_info_name() {
		return board_info_name;
	}
	public void setBoard_info_name(String board_info_name) {
		this.board_info_name = board_info_name;
	}
	public String getIs_deleted() {
		return is_deleted;
	}
	public void setIs_deleted(String is_deleted) {
		this.is_deleted = is_deleted;
	}
	
	public int getContent_is_public() {
		return content_is_public;
	}
	public void setContent_is_public(int content_is_public) {
		this.content_is_public = content_is_public;
	}
	public String getExistingFile() {
		return existingFile;
	}
	public void setExistingFile(String existingFile) {
		this.existingFile = existingFile;
	} 
	public int getContent_idx() {
		return content_idx;
	}
	public void setContent_idx(int content_idx) {
		this.content_idx = content_idx;
	}
	public String getContent_subject() {
		return content_subject;
	}
	public void setContent_subject(String content_subject) {
		this.content_subject = content_subject;
	}
	public String getContent_text() {
		return content_text;
	}
	public void setContent_text(String content_text) {
		this.content_text = content_text;
	} 
	
	public int getUser_idx() {
		return user_idx;
	}
	public void setUser_idx(int user_idx) {
		this.user_idx = user_idx;
	}
	public int getContent_board_idx() {
		return content_board_idx;
	}
	public void setContent_board_idx(int content_board_idx) {
		this.content_board_idx = content_board_idx;
	}
	public String getContent_date() {
		return content_date;
	}
	public void setContent_date(String content_date) {
		this.content_date = content_date;
	}
	
	
	
	
}
