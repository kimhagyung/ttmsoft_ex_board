package kr.co.ttmsoft.service;

import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.UUID;

import javax.annotation.Resource;

import org.apache.commons.io.FilenameUtils;
import org.apache.ibatis.session.RowBounds;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.PropertySource;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import kr.co.ttmsoft.beans.BoardFileBean;
import kr.co.ttmsoft.beans.BoardInfoBean;
import kr.co.ttmsoft.beans.ContentBean;
import kr.co.ttmsoft.beans.NaverEditorBean;
import kr.co.ttmsoft.beans.PageBean;
import kr.co.ttmsoft.beans.UserBean;
import kr.co.ttmsoft.dao.BoardDao;

@Service
@PropertySource("/WEB-INF/properties/option.properties")
public class BoardService {

	@Autowired
	private BoardDao boardDao;

	@Value("${path.upload}")
	private String path_upload;

	@Value("${page.listcnt}")
	private int page_listcnt;

	@Value("${page.paginationcnt}")
	private int page_paginationcnt;
	@Resource(name = "loginUserBean")
	private UserBean loginUserBean;
	// 게시글 작성
	public int addBoardInfo(ContentBean addBoardInfo) {  
		boardDao.addBoardInfo(addBoardInfo);
		return addBoardInfo.getContent_idx(); 
	}
	
	//게시글 사진 저장
	public void addBoardFileInfo(BoardFileBean boardFileBean, MultipartFile uploadFile, int contentIdx) { 

		try {
			if (uploadFile != null && !uploadFile.isEmpty()) { // 파일이 null이 아니고 비어있지 않은 경우에만 파일 업로드를 수행합니다.
				String originalFileName = uploadFile.getOriginalFilename();
				String extension = originalFileName.substring(originalFileName.lastIndexOf("."));
				String randomName = UUID.randomUUID().toString() + extension; // 임의의 이름 생성
				long fileSize = uploadFile.getSize()/ 1024;
				boardFileBean.setFile_name(originalFileName);
				boardFileBean.setFile_path(randomName);
				boardFileBean.setContent_idx(contentIdx);
				boardFileBean.setFile_size(fileSize);
				System.out.println("서비스에서 파일 사이즈"+fileSize);
				// 파일을 지정된 경로에 저장합니다.
				uploadFile.transferTo(new File(path_upload + "/" + randomName));
				boardDao.addBoardFileInfo(boardFileBean);
			}
		} catch (IOException e) {
			e.printStackTrace();
		}

		
	} 

	// 게시글 조회
	public ContentBean getBoardInfo(int content_idx) { 
		return boardDao.getBoardInfo(content_idx);
	}
	
	//게시글 사진 조회 
	public List<BoardFileBean> getBoardFileInfo(int content_idx){
		return boardDao.getBoardFileInfo(content_idx);
	}
	
	// 게시글리스트 조회
	public List<ContentBean> getBoardInfoo(int content_board_idx) {

		return boardDao.getBoardInfoo(content_board_idx);
	}
	public List<ContentBean> getAllContentInfoYesORNo(int board_info_idx, String is_deleted){
		return boardDao.getAllContentInfoYesORNo(board_info_idx, is_deleted);
	}
	// 게시글 리스트 페이징관련
	public List<ContentBean> getBoardPageInfo(int content_board_idx, int page) {
		int start = (page - 1) * page_listcnt;
		RowBounds rowBounds = new RowBounds(start, page_listcnt);
		return boardDao.getBoardPageInfo(content_board_idx, rowBounds);
	}

	// 게시글 리스트 페이지 개수
	public PageBean getBoardPageInfoCnt(int currentPage, int content_board_idx) {
		int contentCnt = boardDao.getBoardPageInfoCnt(content_board_idx);
		PageBean pageBean2 = new PageBean(contentCnt, currentPage, page_listcnt, page_paginationcnt);
		return pageBean2;
	}

	// 게시글 작성자 이름
	public String getContentUserName(int content_idx) {
		return boardDao.getContentUserName(content_idx);
	}

	// 게시글 수정
	public int modifyBoardInfo(ContentBean modifyBoardInfo) { 
		boardDao.modifyBoardInfo(modifyBoardInfo);
		return modifyBoardInfo.getContent_idx(); 
	}

	// 사진 수정
	public void modifyBoardFileBean(BoardFileBean modifyBoardFileInfo, MultipartFile uploadFile) {
	    try {
	        if (uploadFile != null && !uploadFile.isEmpty()) { // 파일이 null이 아니고 비어있지 않은 경우에만 파일 업로드를 수행합니다.
	            // 기존 파일 삭제
	            String filePath=boardDao.getFileFindPath(modifyBoardFileInfo.getBoard_file_idx());//기존 파일 경로 조회 
	            String existingFilePath = path_upload + "/" + filePath;
	            System.out.println("삭제해야할 getBoard_file_idx:"+existingFilePath);
	            File existingFile = new File(existingFilePath);
	            if (existingFile.exists()) {
	                existingFile.delete();
	                System.out.println("기존 파일 삭제 완료: " + existingFilePath);
	            } 
	            	 // 새로운 파일 업로드
		            String originalFileName = uploadFile.getOriginalFilename();
		            String extension = originalFileName.substring(originalFileName.lastIndexOf("."));
		            String randomName = UUID.randomUUID().toString() + extension; // 임의의 이름 생성
		            long fileSize = uploadFile.getSize() / 1024;
		            modifyBoardFileInfo.setFile_name(originalFileName);
		            modifyBoardFileInfo.setFile_path(randomName); 
		            modifyBoardFileInfo.setFile_size(fileSize);
		            System.out.println("서비스에서 파일 사이즈" + fileSize);

		            // 파일을 지정된 경로에 저장합니다.
		            uploadFile.transferTo(new File(path_upload + "/" + randomName)); 
		            boardDao.modifyBoardFileBean(modifyBoardFileInfo);
	             
	        }
	    } catch (IOException e) {
	        e.printStackTrace();
	    }
	} 

	//가장 최근 생성 (생성 시 사용)
	public int LetestContent_idx() {
		return boardDao.LetestContent_idx();
	}

	//가장 최근에 생성 된 (수정시 사용)
	public int LetestModifyContent_idx(int board_file_idx) {
		return boardDao.LetestModifyContent_idx(board_file_idx);
	} 
	// 게시글 삭제
	public void deleteBoardInfo(int content_idx) {
		boardDao.deleteBoardInfo(content_idx);
	}
	
	//게시판 테이블 정보 
	public BoardInfoBean getAllBoardInfo(int board_info_idx) {
		return boardDao.getAllBoardInfo(board_info_idx);
	}
	
	//게시판 아이디를 사용하여 해당하는 게시판의 게시글 조회하기 
	public List<ContentBean> getAllContentInfo(int board_info_idx){
		return boardDao.getAllContentInfo(board_info_idx);
	}
	
	//삭제처리 함수 
	public void UpdateIsDeletedYes(int content_idx) {
		boardDao.UpdateIsDeletedYes(content_idx);
	}
	
	//삭제처리 취소 함수 
	public void UpdateIsDeletedNo(int content_idx) {
		boardDao.UpdateIsDeletedNo(content_idx);
	}
	
	
	//게시판 수정 시 파일 삭제 
	public void deleteBoardFile(int board_file_idx) { 
	    // 기존 파일 삭제
	    String filePath=boardDao.getFileFindPath(board_file_idx);//기존 파일 경로 조회 
	    String existingFilePath = path_upload + "/" + filePath;
	    System.out.println("삭제해야할 existingFilePath:"+existingFilePath);
	    File existingFile = new File(existingFilePath);
	    if (existingFile.exists()) {
	        existingFile.delete();
	        System.out.println("수정 시 완전 삭제 할 때 기존 파일 삭제 완료: " + existingFilePath);
	    }
		boardDao.deleteBoardFile(board_file_idx);
	}
	
	//게시판 이름으로 검색
	public List<BoardInfoBean> searchBoardNameInfo(String board_info_name){
		return boardDao.searchBoardNameInfo(board_info_name);
	}
	
	//게시판 이름과 사용여부로 검색 
	public List<BoardInfoBean> searchBoardNameInfoYOrNo(String board_info_name, String is_usage){
    	return boardDao.searchBoardNameInfoYOrNo(board_info_name, is_usage);
    }

	
	//조회수 함수 
	 public void plusCnt(int content_idx) {
		 boardDao.plusCnt(content_idx);
	    }
		
	// 네이버
	public void addNaverEditorBean(NaverEditorBean naverEditorBean, MultipartFile uploadFile) {
		String fileName = uploadFile.getOriginalFilename();
		naverEditorBean.setNaverEditor_file(fileName);

		try {
			// 파일을 지정된 경로에 저장합니다.
			String photo_name = FilenameUtils.getBaseName(fileName) + "." + FilenameUtils.getExtension(fileName);
			uploadFile.transferTo(new File(path_upload + "/" + photo_name));
		} catch (IOException e) {
			e.printStackTrace();
		}

		boardDao.addNaverEditorBean(naverEditorBean);
	}

}
