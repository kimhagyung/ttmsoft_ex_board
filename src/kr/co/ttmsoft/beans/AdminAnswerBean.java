package kr.co.ttmsoft.beans;

public class AdminAnswerBean {
	
	private int admin_answer_idx; 
    private String amdin_answer; 
    private String admin_answer_date; 
    private int admin_idx;  
    private int content_idx;
    private String admin_name;
     
    
	public String getAdmin_name() {
		return admin_name;
	}
	public void setAdmin_name(String admin_name) {
		this.admin_name = admin_name;
	}
	public int getAdmin_answer_idx() {
		return admin_answer_idx;
	}
	public void setAdmin_answer_idx(int admin_answer_idx) {
		this.admin_answer_idx = admin_answer_idx;
	}
	public String getAmdin_answer() {
		return amdin_answer;
	}
	public void setAmdin_answer(String amdin_answer) {
		this.amdin_answer = amdin_answer;
	}
	public String getAdmin_answer_date() {
		return admin_answer_date;
	}
	public void setAdmin_answer_date(String admin_answer_date) {
		this.admin_answer_date = admin_answer_date;
	}
	public int getAdmin_idx() {
		return admin_idx;
	}
	public void setAdmin_idx(int admin_idx) {
		this.admin_idx = admin_idx;
	}
	public int getContent_idx() {
		return content_idx;
	}
	public void setContent_idx(int content_idx) {
		this.content_idx = content_idx;
	}
    
    
}
