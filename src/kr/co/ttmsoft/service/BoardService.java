package kr.co.ttmsoft.service;

import java.io.File;
import java.io.IOException;
import java.util.List;

import org.apache.commons.io.FilenameUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.PropertySource;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import kr.co.ttmsoft.beans.ContentBean;
import kr.co.ttmsoft.dao.BoardDao;

@Service
@PropertySource("/WEB-INF/properties/option.properties")
public class BoardService {
	
	@Autowired
	private BoardDao boardDao;
	
	 @Value("${path.upload}")
	 private String path_upload;
	   
	   
	//게시글 작성
	public void addBoardInfo(ContentBean addBoardInfo,  MultipartFile uploadFile) {
		 String fileName = uploadFile.getOriginalFilename();
	     addBoardInfo.setContent_file(fileName);
		   
	        try {
	            // 파일을 지정된 경로에 저장합니다.
	            String photo_name = FilenameUtils.getBaseName(fileName) + "." + FilenameUtils.getExtension(fileName);
	            uploadFile.transferTo(new File(path_upload + "/" + photo_name));
	        } catch (IOException e) {
	            e.printStackTrace();
	        }
		   
		boardDao.addBoardInfo(addBoardInfo);
	} 
	
	//게시글 조회 
	public ContentBean getBoardInfo(int content_idx) {

		return boardDao.getBoardInfo(content_idx);
	}
	
	//게시글리스트 조회 
	public List<ContentBean> getBoardInfoo(){

		return boardDao.getBoardInfoo();
	}
	
	//게시글 작성자 이름 
	public String getContentUserName(int content_idx) {
		return boardDao.getContentUserName(content_idx);
	}

	//게시글 수정
	public void modifyBoardInfo(ContentBean modifyBoardInfo, MultipartFile uploadFile) {
		 String fileName = uploadFile.getOriginalFilename();
		 modifyBoardInfo.setContent_file(fileName);
		   
	        try {
	            // 파일을 지정된 경로에 저장합니다.
	            String photo_name = FilenameUtils.getBaseName(fileName) + "." + FilenameUtils.getExtension(fileName);
	            uploadFile.transferTo(new File(path_upload + "/" + photo_name));
	        } catch (IOException e) {
	            e.printStackTrace();
	        }
		boardDao.modifyBoardInfo(modifyBoardInfo);
	}
	
	//게시글 삭제 
	public void deleteBoardInfo(int content_idx) {
		boardDao.deleteBoardInfo(content_idx);
	}
	
}
