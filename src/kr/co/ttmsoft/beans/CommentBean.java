package kr.co.ttmsoft.beans;

public class CommentBean {
	
	private int comment_idx;
	private String comments;
	private String comment_date;
	private int content_idx;
	private int user_idx;
	private String user_name;  
	
	
	 
	public String getUser_name() {
		return user_name;
	}
	public void setUser_name(String user_name) {
		this.user_name = user_name;
	}
	public int getComment_idx() {
		return comment_idx;
	}
	public void setComment_idx(int comment_idx) {
		this.comment_idx = comment_idx;
	}
	public String getComments() {
		return comments;
	}
	public void setComments(String comments) {
		this.comments = comments;
	}
	public String getComment_date() {
		return comment_date;
	}
	public void setComment_date(String comment_date) {
		this.comment_date = comment_date;
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
	public void setUser_idx(int user_id) {
		this.user_idx = user_id;
	}
	
	
}
