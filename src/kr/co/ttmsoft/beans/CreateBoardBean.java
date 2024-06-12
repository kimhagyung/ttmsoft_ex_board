package kr.co.ttmsoft.beans;

public class CreateBoardBean {
	
		private int board_management_idx;
		private String board_name;
		private String board_explanation;
		private int is_answer; 
		private int is_comment;
		private int is_file; 
		private String is_usage;
		private int file_size;
		private String file_ext;
		
		
		
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
		public int getBoard_management_idx() {
			return board_management_idx;
		}
		public void setBoard_management_idx(int board_management_idx) {
			this.board_management_idx = board_management_idx;
		}
		public String getBoard_name() {
			return board_name;
		}
		public void setBoard_name(String board_name) {
			this.board_name = board_name;
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
		
		
}
