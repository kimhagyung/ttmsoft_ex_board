<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<c:set var="root" value="${pageContext.request.contextPath }"/> 

<!DOCTYPE html>
<html>
<head> 
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="${root}/resources/se2/js/service/HuskyEZCreator.js"></script>
<script>
	let oEditors = [];
	smartEditor=function(){
	    nhn.husky.EZCreator.createInIFrame({
	        oAppRef: oEditors,
	        elPlaceHolder: "editor",
	        sSkinURI: "${root}/resources/se2/SmartEditor2Skin.html",
	        fCreator: "createSEditor2" 
	    })
	}
	$(document).ready(function() {
	
		smartEditor();
        function submitContents(elClickedObj) {
            oEditors.getById["editor"].exec("UPDATE_CONTENTS_FIELD", []); // 에디터의 내용이 textarea에 적용됩니다.
            // 에디터의 내용을 출력합니다.
            //alert(document.getElementById("editor").value);
        } 
        // 전송 버튼 클릭 이벤트 핸들러 추가
        $('#submit').on('click', function() {
            submitContents(this);
        }); 
    });
</script>   
<script>
	let uploadedFiles = []; // 업로드된 파일들을 담을 배열 

	$(function(){
		getFileInfo();
		var isFile = ${boardAllInfo.is_file};  //첨부파일 개수 
		
		
		
	});
	
	
	//파일 삭제 후 조회 & 로딩시 조회 함수
	function getFileInfo(){
		$.ajax({
			url : '${root}/getFileInfo?content_idx=${param.content_idx}',
			type : 'GET',
			dataType:'Json',
			success: function(response){
				$('#fileList').empty(); 
				$('.selected-image').empty(); 
				console.log('파일조회 성공');
				
				var boardFiles = response;
				if (boardFiles.length === 0) {
		            $('#fileList').append('<h5>현재 첨부된 파일 없음</h5>');
		        } else {
		        	$('#fileList').append('<h5>현재 첨부된 파일</h5>');
		            boardFiles.forEach(function(files) {
		                $('#fileList').append(
		                    '<div class="row border border-secondary p-2">' +
		                        '<div class="col-8 mb-1 mt-2" id="filename' + files.board_file_idx + '">' +
		                            files.file_name +
		                        '</div>' +
		                        '<div class="col-2 mb-2">' +
		                            '<input type="button" value="수정" class="btn btn-link" onclick="modifyFile(' + files.board_file_idx + ')"/>' +
		                        '</div>' +
		                        '<div class="col-2 mb-2">' +
		                            '<input type="button" value="삭제" onclick="deleteFile(' + files.board_file_idx + ')" class="btn btn-link"/>' +
		                        '</div>' +
		                        '<div style="display: none;">' +
		                            '<input type="file" style="display: none;" name="uploadFiles" id="modifyFiles' + files.board_file_idx + '" class="border border-secondary" accept="${boardAllInfo.file_ext}"  multiple>' +
		                        '</div>' +
		                    '</div>'
		                );
		                console.log('순서대로 첨부된 파일 idx: ', files.board_file_idx);
		            });
		            console.log('첨부된 파일 총 개수: ', boardFiles.length);
		        }
				
				var isFile = ${boardAllInfo.is_file}; //첨부파일 개수 
		        if(boardFiles.length < isFile) {
		            $('.selected-image').append('<label for="uploadFiles"> <h5>첨부파일(최대 ${boardAllInfo.is_file }개)<i class="bi bi-camera-fill mx-2" id="uploadFiles"></i></h5></label>');
		            for (var i = boardFiles.length; i < isFile; i++) {
		            	 $('.selected-image').append('<div class="form-inline">' 
		                     + '<input type="file" name="uploadFiles" accept="${boardAllInfo.file_ext}" class="form-control" multiple>'  
		                     + '</div>');
		            } 
		            // 파일 선택 시 크기 체크
		            $('input[name="uploadFiles"]').change(function() {
		                var maxFileSizeKB = ${boardAllInfo.file_size}; 

		                var files = $(this)[0].files;
		                for (var j = 0; j < files.length; j++) {
		                    var fileSizeKB = files[j].size / 1024; // 파일 크기 kB
		                    if (fileSizeKB > maxFileSizeKB) {
		                        alert('파일 크기는'+ maxFileSizeKB +'KByte 이하여야 합니다.');
		                        console.log("현재 업로드한 파일 크기", fileSizeKB);
		                        $(this).val(''); // 파일 선택 취소
		                        return false;
		                    }else {
		                        uploadedFiles.push(files[j]); // 배열에 파일 추가
		                    }
		                }
		            }); 
		        }
			},
			error: function(error){
				console.error('파일 조회 오류 :', error)
			} 
		});
	}

  
	// 파일 수정 함수 
	function modifyFile(boardFileIdx) {
	    // 수정할 파일의 id를 가지고 input file을 클릭합니다.
	   	document.getElementById('modifyFiles' + boardFileIdx).click();
	 	// 파일 선택 시 크기 체크
	    $('input[name="uploadFiles"]').change(function() {
	        var maxFileSizeKB = ${boardAllInfo.file_size}; 
			
	        var files = $(this)[0].files;
	        for (var j = 0; j < files.length; j++) {
	            var fileSizeKB = files[j].size / 1024; // 파일 크기 kB
	            var formData = new FormData();  
	            
	            formData.append('board_file_idx', boardFileIdx);
	            if (fileSizeKB > maxFileSizeKB) {
	                alert('파일 크기는'+ maxFileSizeKB +'KByte 이하여야 합니다.');
	                console.log("현재 업로드한 파일 크기", fileSizeKB);
	                $(this).val(''); // 파일 선택 취소
	                return false;
	            }else {
	                uploadedFiles.push(files[j]); // 배열에 파일 추가
	                formData.append('uploadFiles', uploadedFiles[j]);
	                console.log('파일 이름:', uploadedFiles[j].name);
	    	        console.log('파일 크기:', uploadedFiles[j].size / 1024, 'kB');
	    	        // 파일 이름을 해당 요소에 표시
	                $('#filename' + boardFileIdx).text(files[j].name);
	    	        //파일 수정 ajax
	                $.ajax({
	    		        url: '${root }/board/modifyFile',
	    		        type: 'POST',
	    		        data: formData,
	    		        processData: false, // 데이터 처리 방식 설정 (FormData 객체 사용시 false로 설정)
	    		        contentType: false, // 컨텐츠 타입 설정 (FormData 객체 사용시 false로 설정)
	    		        success: function(response) {
	    		            console.log('수정완료:', response); 
	    		            getFileInfo();
	    		            uploadedFiles = [];
	    		        },
	    		        error: function(error) {
	    		            console.error('업로드 오류:', error);
	    		        }
	    		    });
	            }
	        }
	    });
	    
	    
	    console.log("수정버튼을 클릭한 파일아이디 : "+boardFileIdx) 
	}
	
	//파일 삭제 함수 
	function deleteFile(boardFileIdx) { 
		
		var isConfirmed=confirm('파일을 삭제하시겠습니까?');
		
		if(isConfirmed){
	        $.ajax({
	            url: '${root}/deleteFile',  
	            type: 'GET',  
	            data: { board_file_idx: boardFileIdx }, // 삭제할 파일의 인덱스 전달
	            success: function(response) {
	                console.log('파일 삭제 성공:', response); 
	                alert('파일을 삭제 하였습니다.:'); 
	               	getFileInfo();
	            },
	            error: function(error) {
	                console.error('파일 삭제 오류:', error);
	                // 파일 삭제 오류 시 필요한 로직 추가
	            }
	        });
		}
  }	
	
  //업로드 함수  
	$('#uploadForm').submit(function(event) {
	   	//event.preventDefault(); // 폼 기본 동작 방지
	
	    var formData = new FormData(); 
	    var fileCnt= ${boardAllInfo.is_file }; //파일 개수 
	     
	    for (var i = 0; i < uploadedFiles.length; i++) {
	        formData.append('uploadFiles', uploadedFiles[i]);
	        //formData.append('file_size', (uploadedFiles[i].size / 1024));
	        console.log('파일 이름:', uploadedFiles[i].name);
	        console.log('파일 크기:', uploadedFiles[i].size / 1024, 'kB'); 
	    }
	 
	    var board_subject = $('input[name="board_subject"]').val();
	    var content_text = $('input[name="content_text"]').val(); 
	    formData.append('board_subject', board_subject);
	    formData.append('content_text', content_text); 
		console.log("번호",${param.content_idx});
		
	    // 서버로 formData 전송 
		    $.ajax({
		        url: '${root }/board/modify_pro',
		        type: 'POST',
		        data: formData,
		        processData: false, // 데이터 처리 방식 설정 (FormData 객체 사용시 false로 설정)
		        contentType: false, // 컨텐츠 타입 설정 (FormData 객체 사용시 false로 설정)
		        success: function(response) {
		            console.log('수정 완료:', response);
		            // 성공적으로 업로드된 경우 처리할 로직
		        },
		        error: function(error) {
		            console.error('업로드 오류:', error);
		        }
		    });  
		  
	    // 업로드 후 배열 비우기
	    uploadedFiles = [];
	    
	    
	    
	});
	
	
	
</script>
<style>
.selected-image-item{
	width:200px;
	height:200px;
}
</style>
</head>
<body>
<c:import url="/WEB-INF/views/include/top_menu.jsp"/>

	<div class="container" style="margin-top: 100px"> 
			<div class="col-sm-6"></div> 
			<div class="col-sm"> 
						<form action="${root }/board/modify_pro" method="post" enctype="multipart/form-data" id="uploadForm" >
							<input type="hidden" name="content_idx" value="${param.content_idx }"/> 
                			<%-- <input type="hidden" name="user_idx" value="${loginUserBean.user_idx}" />   --%>
                			<input type="hidden" name="user_idx" value="${boardInfo.user_idx}" />  
							<c:forEach var="obj" items="${ boardfileBean}">
								<input type="hidden" name="existingFile" value="${obj.file_path }"/>
							</c:forEach>
							<div class="form-group">
								<label for="board_writer_name"><h4>작성자</h4></label> 
								<input type="text" id="board_writer_name" name="board_writer_name" class="form-control" value="${boardWriterName }" disabled="disabled" />
							</div>
							<div class="form-group">
								<label for="board_date"><h4>작성날짜</h4></label> 
								<input type="text" id="board_date" name="board_date" class="form-control" value="${boardInfo.content_date }" disabled="disabled" />
							</div>
							<div class="form-group">
								<label for="board_subject"><h4>제목</h4></label> 
								<input type="text" id="board_subject" name="content_subject" class="form-control" value="${boardInfo.content_subject }" />
							</div> 
							 <c:if test="${boardAllInfo.is_public==0 }">
								<div class="form-group">
				                <label for="public"><h4>공개여부</h4></label><br>
				                	<div class="form-check form-check-inline">
									  <input class="form-check-input" type="radio" name="content_is_public" id="public1_${boardInfo.content_idx}" value="1" ${boardInfo.content_is_public == 1 ? 'checked' : ''}>
									  <label class="form-check-label" for="public1_${boardInfo.content_idx}">공개</label>
									</div>
									<div class="form-check form-check-inline">
									  <input class="form-check-input" type="radio" name="content_is_public" id="public2_${boardInfo.content_idx}" value="0" ${boardInfo.content_is_public == 0 ? 'checked' : ''}>
									  <label class="form-check-label" for="public2_${boardInfo.content_idx}">비공개</label>
									</div>
				                </div>
			                </c:if>
							<div class="form-group">
							    <label for="board_content">내용</label>
							    <textarea id="editor" name="content_text" class="form-control" rows="10" style="resize: none">${boardInfo.content_text }</textarea>
							</div>
							<c:if test="${boardAllInfo.file_checked==1 }">
				                <div class="form-group">
				                  <div class="selected-image mb-3"></div>
				                   <div class="border-dark p-3 mt-3 col-sm-6" id="showFiles">
					                   <div id="fileList"></div>	 
				                   </div> 
				                   <div class="col-sm-6"></div>
				                </div>     
			                </c:if>   
			                 
							<div class="form-group">
								<div class="text-right">
									<button type="submit" id="submit" class="btn btn-primary">수정완료</button> 
									<a href="${root }/board/read?content_idx=${param.content_idx}" class="btn btn-info">취소</a> 
								</div>
							</div> 
							<div class="col-sm-3"></div>
						</form>
					</div>
				</div> 
 
<c:import url="/WEB-INF/views/include/bottom_info.jsp" />

</body>
</html>
