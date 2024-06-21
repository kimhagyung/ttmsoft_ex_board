package kr.co.ttmsoft.beans;
 
public class BoardInfoBean {
	
	private int board_info_idx;//게시판 번호
	private String board_info_name;//게시판 이름
	private String board_explanation;
	private int is_answer; 
	private int is_comment;
	private String board_date;
	private int is_file; 
	private String is_usage;
	private int file_size;
	private String file_ext;
	private int file_checked;
	private int is_public; 
	
	
	 
	public int getIs_public() {
		return is_public;
	}
	public void setIs_public(int is_public) {
		this.is_public = is_public;
	}
	public String getBoard_explanation() {
		return board_explanation;
	}
	public void setBoard_explanation(String board_explanation) {
		this.board_explanation = board_explanation;
	}
	public int getIs_answer() {
		return is_answer;
	}
	public void setIs_answer(int is_answer) {
		this.is_answer = is_answer;
	}
	public int getIs_comment() {
		return is_comment;
	}
	public void setIs_comment(int is_comment) {
		this.is_comment = is_comment;
	}
	public String getBoard_date() {
		return board_date;
	}
	public void setBoard_date(String board_date) {
		this.board_date = board_date;
	}
	public int getIs_file() {
		return is_file;
	}
	public void setIs_file(int is_file) {
		this.is_file = is_file;
	}
	public String getIs_usage() {
		return is_usage;
	}
	public void setIs_usage(String is_usage) {
		this.is_usage = is_usage;
	}
	public int getFile_size() {
		return file_size;
	}
	public void setFile_size(int file_size) {
		this.file_size = file_size;
	}
	public String getFile_ext() {
		return file_ext;
	}
	public void setFile_ext(String file_ext) {
		this.file_ext = file_ext;
	}
	public int getFile_checked() {
		return file_checked;
	}
	public void setFile_checked(int file_checked) {
		this.file_checked = file_checked;
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
	
}

