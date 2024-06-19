package kr.co.ttmsoft.beans;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

public class BoardFileBean {
	
	private int board_file_idx;  
	private String file_path;  
	private String file_name;  
	private String uploaded_at; 
	private int content_idx; 
	private int user_idx;
	//private List<MultipartFile> upload_photos;
	private long file_size;
	private String existingFile; //기존 파일 경로 
	
	 
	 
	public String getExistingFile() {
		return existingFile;
	}
	public void setExistingFile(String existingFile) {
		this.existingFile = existingFile;
	}
	public long getFile_size() {
		return file_size;
	}
	public void setFile_size(long file_size) {
		this.file_size = file_size;
	}
	public int getBoard_file_idx() {
		return board_file_idx;
	}
	public void setBoard_file_idx(int board_file_idx) {
		this.board_file_idx = board_file_idx;
	}
	public String getFile_path() {
		return file_path;
	}
	public void setFile_path(String file_path) {
		this.file_path = file_path;
	}
	public String getFile_name() {
		return file_name;
	}
	public void setFile_name(String file_name) {
		this.file_name = file_name;
	}
	public String getUploaded_at() {
		return uploaded_at;
	}
	public void setUploaded_at(String uploaded_at) {
		this.uploaded_at = uploaded_at;
	}
	public int getContent_idx() {
		return content_idx;
	}
	public void setContent_idx(int content_idx) {
		this.content_idx = content_idx;
	}
	public int getUser_idx() {
		return user_idx;
	}
	public void setUser_idx(int user_idx) {
		this.user_idx = user_idx;
	} 
	
	
}
