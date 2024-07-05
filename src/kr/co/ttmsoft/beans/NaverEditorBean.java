package kr.co.ttmsoft.beans;

public class NaverEditorBean {
	private int naverEditor_idx;
	private String naverEditor_subject; 
	private String naverEditor_text;
	private String naverEditor_file; 
	private String naverEditor_date;
	private int is_publish;
	private int user_idx;
	private int board_info_idx;
	public int getIs_publish() {
		return is_publish;
	}
	public void setIs_publish(int is_publish) {
		this.is_publish = is_publish;
	}
	public int getNaverEditor_idx() {
		return naverEditor_idx;
	}
	public void setNaverEditor_idx(int naverEditor_idx) {
		this.naverEditor_idx = naverEditor_idx;
	}
	public String getNaverEditor_subject() {
		return naverEditor_subject;
	}
	public void setNaverEditor_subject(String naverEditor_subject) {
		this.naverEditor_subject = naverEditor_subject;
	}
	public String getNaverEditor_text() {
		return naverEditor_text;
	}
	public void setNaverEditor_text(String naverEditor_text) {
		this.naverEditor_text = naverEditor_text;
	}
	public String getNaverEditor_file() {
		return naverEditor_file;
	}
	public void setNaverEditor_file(String naverEditor_file) {
		this.naverEditor_file = naverEditor_file;
	}
	public String getNaverEditor_date() {
		return naverEditor_date;
	}
	public void setNaverEditor_date(String naverEditor_date) {
		this.naverEditor_date = naverEditor_date;
	}
	public int getUser_idx() {
		return user_idx;
	}
	public void setUser_idx(int user_idx) {
		this.user_idx = user_idx;
	}
	public int getBoard_info_idx() {
		return board_info_idx;
	}
	public void setBoard_info_idx(int board_info_idx) {
		this.board_info_idx = board_info_idx;
	}
	
	
}
