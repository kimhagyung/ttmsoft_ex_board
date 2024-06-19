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
<!-- <script>
	$(function(){
		$('#board_file').on('change', function(event){
			const selectedImageDiv=$('.selected-image')
			const receviedImagDiv=$('.recevied-img')  
			
			receviedImagDiv.remove(); //새로운 파일 선택 시 기존에 받아온 이미지 삭제 
			selectedImageDiv.empty();
			
			const files=event.target.files;
			
			 for (const file of files) {
		            const reader = new FileReader();

		            reader.onload = function (e) {
		                const img = $('<img>').attr('src', e.target.result).addClass('selected-image-item');
		                selectedImageDiv.append(img); 
		            }; 
		            reader.readAsDataURL(file);
		      }
		})
	});
</script> -->
<script>
	let uploadedFiles = []; // 업로드된 파일들을 담을 배열 
		
	$(function(){
		var isFile = ${boardAllInfo.is_file}; 
	 
	    // 숫자만큼 반복하여 "개" 출력
	    for (var i = 0; i < isFile; i++) { 
    	 $('.selected-image').append('<div class="form-inline">' 
                 + '<input type="file" name="uploadFiles" class="border border-secondary" accept="${boardAllInfo.file_ext}"  multiple>'  
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
	});

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
	
	    // 서버로 formData 전송
	 	if (1 <= fileCnt && fileCnt <= 3) {
		    $.ajax({
		        url: '${root }/board/write_pro',
		        type: 'POST',
		        data: formData,
		        processData: false, // 데이터 처리 방식 설정 (FormData 객체 사용시 false로 설정)
		        contentType: false, // 컨텐츠 타입 설정 (FormData 객체 사용시 false로 설정)
		        success: function(response) {
		            console.log('업로드 완료:', response);
		            // 성공적으로 업로드된 경우 처리할 로직
		        },
		        error: function(error) {
		            console.error('업로드 오류:', error);
		        }
		    });
		}
	    // 업로드 후 배열 비우기
	    uploadedFiles = [];
	    
	    
	    
	});
	function deleteFile(boardFileIdx) { 
		
		var isConfirmed=confirm('정말로 이 댓글을 삭제하시겠습니까?');
		
		if(isConfirmed){
	        $.ajax({
	            url: '${root}/deleteFile',  
	            type: 'GET',  
	            data: { board_file_idx: boardFileIdx }, // 삭제할 파일의 인덱스 전달
	            success: function(response) {
	                console.log('파일 삭제 성공:', response); 
	            },
	            error: function(error) {
	                console.error('파일 삭제 오류:', error);
	                // 파일 삭제 오류 시 필요한 로직 추가
	            }
	        });
		}
    }
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
				                   <label for="uploadFiles"> <h5>첨부파일(최대 ${boardAllInfo.is_file }개)<i class="bi bi-camera-fill mx-2" id="uploadFiles"></i></h5></label>
				                   <div class="selected-image mb-3"></div>
				                   <h5>현재 첨부된 파일</h5>
				                   <div class="border-dark p-3 mt-3 col-sm-6">
					                   <c:forEach var="files" items="${boardfileBean }">
					                  	 	<div class="row border border-secondary p-2">
						                   		 <div class="col-8 mb-1 mt-2"> <!-- 기존에 저장된 파일들  -->
						                   		  	${files.file_name } 
						                   		 </div>		
						                   		 <div class="col-2 mb-2">
						                   		 	 <input type="button" value="삭제"  onclick="deleteFile(${files.board_file_idx})" class="btn btn-link"/> 
						                   		 </div>	
					                   		 </div>		                   	
					                   </c:forEach> 
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
