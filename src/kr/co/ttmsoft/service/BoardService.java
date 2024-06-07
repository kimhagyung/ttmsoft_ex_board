package kr.co.ttmsoft.service;

import java.io.File;
import java.io.IOException;
import java.util.List;

import org.apache.commons.io.FilenameUtils;
import org.apache.ibatis.session.RowBounds;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.PropertySource;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import kr.co.ttmsoft.beans.ContentBean;
import kr.co.ttmsoft.beans.PageBean;
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

	// 게시글 작성
	public void addBoardInfo(ContentBean addBoardInfo, MultipartFile uploadFile) {
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

	// 게시글 조회
	public ContentBean getBoardInfo(int content_idx) {

		return boardDao.getBoardInfo(content_idx);
	}

	// 게시글리스트 조회
	public List<ContentBean> getBoardInfoo(int content_board_idx) {

		return boardDao.getBoardInfoo(content_board_idx);
	}

	// 게시글 리스트 페이징관련
	public List<ContentBean> getBoardPageInfo(int content_board_idx, int page) {
		int start = (page - 1) * page_listcnt;
		RowBounds rowBounds = new RowBounds(start, page_listcnt);
		return boardDao.getBoardPageInfo(content_board_idx, rowBounds);
	}

	//게시글 리스트 페이지 개수 
	public PageBean getBoardPageInfoCnt(int currentPage, int content_board_idx) {
		int contentCnt=boardDao.getBoardPageInfoCnt(content_board_idx);
		PageBean pageBean2 = new PageBean(contentCnt, currentPage, page_listcnt, page_paginationcnt);
		return pageBean2;
	}
	
	// 게시글 작성자 이름
	public String getContentUserName(int content_idx) {
		return boardDao.getContentUserName(content_idx);
	}

	// 게시글 수정
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

	// 게시글 삭제
	public void deleteBoardInfo(int content_idx) {
		boardDao.deleteBoardInfo(content_idx);
	}

	

}
