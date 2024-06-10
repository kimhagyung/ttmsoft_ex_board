package kr.co.ttmsoft.beans;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

public class ContentBean {
	
	private int content_idx;//게시글 번호
	private String content_subject;//게시글 제목
	private String content_text;//게시글 본문
	private String content_file;//게시글 첨부파일명
	private int content_writer_idx;//작성자 번호(=회원테이블의 회원번호)
	private int content_board_idx;//게시판 번호(=게시판테이블의 게시판번호)
	private String content_date;//작성일
	private MultipartFile upload_photos;
	private int is_public; //공개여부  
	private String existingFile; //기존 파일 경로 
	 
	public int getIs_public() {
		return is_public;
	}
	public void setIs_public(int is_public) {
		this.is_public = is_public;
	}
	public String getExistingFile() {
		return existingFile;
	}
	public void setExistingFile(String existingFile) {
		this.existingFile = existingFile;
	}
	public MultipartFile getUpload_photos() {
		return upload_photos;
	}
	public void setUpload_photos(MultipartFile upload_photos) {
		this.upload_photos = upload_photos;
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
	public String getContent_file() {
		return content_file;
	}
	public void setContent_file(String content_file) {
		this.content_file = content_file;
	}
	public int getContent_writer_idx() {
		return content_writer_idx;
	}
	public void setContent_writer_idx(int content_writer_idx) {
		this.content_writer_idx = content_writer_idx;
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
