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
var filesArr = []; //서버로 보낼 파일들이 저장되어있음 
var fileNo = 0; //deleteNewFile함수에 사용하는 것 
var deletedFiles = []; // 삭제된 파일을 추적하기 위한 배열
var modifyFiles = []; //아직 사용은 안하고 있음
var modify=0; //deletedFiles배열의 인덱스값을 관리하는 변수임 
$(function(){ 
	$('input[name="uploadFiles[]"]').change(function() {
	    var maxFileSizeKB = ${boardAllInfo.file_size};

        var files = $(this)[0].files;
	    var maxFileCnt = ${boardAllInfo.is_file};  //최대 파일 첨부 개수  
	    var attFileCnt = ${boardfileBean.size() }; //DB에서 받아온 값 사이즈 
        console.log("attFileCnt 는!!!!!!!!!!!!!!!!!!!!!", attFileCnt);
        console.log("filesArr.length 는!!!!!!!!!!!!!!!!!!!!!", filesArr.length+1);
       
	    console.log("현재첨부된 파일 개수 :",totalFiles) 
		console.log("uploadFiles를 클릭 시 modify의 값", modify)
		
	    
	    for (var j = 0; j < files.length; j++) { 
	        var fileSizeKB = files[j].size / 1024; // 파일 크기 kB 
	        if (fileSizeKB > maxFileSizeKB) {
	            alert('파일 크기는 ' + maxFileSizeKB + 'KByte 이하여야 합니다.');
	            console.log("현재 업로드한 파일 크기", fileSizeKB);
	            $(this).val(''); // 파일 선택 취소
	            return false;
	        } else {
	            // 삭제된 기존 파일이 있는지 확인
	            var FileBoardIdx = deletedFiles[modify]; //modify 인덱스에 해당하는 값
	            console.log("existingFileIdx?????",FileBoardIdx)
	            //var existingFileIdx = deletedFiles.indexOf(modify); 
	            if (FileBoardIdx != undefined) { //modify 인덱스에 해당하는 값이 존재하지 않으면(즉, 그 이후로 임시삭제가 진행된 값이 없는 경우 )
	                // 삭제된 파일을 다시 추가
	                //modifyFiles.push(files[j]); // 배열에 파일 추가
	                //console.log("삭제된 파일이 다시 추가됨:", files[j].name);
	                //console.log("삭제된 파일이 idx:", existingFileIdx);
	                
	                var formData = new FormData();  
	                formData.append('board_file_idx', FileBoardIdx); 
	                console.log("modify의 현재값 :", modify)
	                let htmlData2 = ''; 
	                htmlData2 += '<div id="file' + deletedFiles[modify] + '" class="filebox_' + deletedFiles[modify] + '">'; 
	                htmlData2 += '   <span class="name">' + files[j].name + '</span>';  
	                htmlData2 += '   <a class="delete" onclick="deleteFile(' + deletedFiles[modify] + ');"><i class="bi bi-dash" style="color:red;"></i></a>';
	                htmlData2 += '</div>';
	                $('.NewFiles').append(htmlData2)
	                
	                formData.append('uploadFiles', files[j]); 
	                //deletedFiles.pop(); //배열에서 제거 
	                $.ajax({
	    		        url: '${root }/board/modifyFile',
	    		        type: 'POST',
	    		        data: formData,
	    		        processData: false, // 데이터 처리 방식 설정 (FormData 객체 사용시 false로 설정)
	    		        contentType: false, // 컨텐츠 타입 설정 (FormData 객체 사용시 false로 설정)
	    		        success: function(response) {
	    		            console.log('수정완료:', response);  
	    		            modifyFiles.push(); 
	    		            modify++; //deletedFiles배열의 인덱스값을 관리하는 변수임 
	    		            console.log("modify의 수정완료 후 값:", modify)
	    		        },
	    		        error: function(error) {
	    		            console.error('업로드 오류:', error);
	    		        }
	    		    });
	            } else { 
	            	var totalFiles = attFileCnt + filesArr.length+1;
	        	    if (totalFiles > maxFileCnt) {
	        	        alert('파일 첨부는 최대 ' + maxFileCnt + '개까지 가능합니다.');
	        	        $(this).val(''); // 파일 선택 취소 
	        	        return false;
	        	    }
	                // 목록 추가
	                let htmlData = '';
	                htmlData += '<div id="file' + fileNo + '" class="filebox">';
	                htmlData += '   <span class="name">' + files[j].name + '</span>'; // files.name -> files[j].name 수정
	                htmlData += '   <a class="delete" onclick="deleteNewFile(' + fileNo + ');"><i class="bi bi-dash" style="color:red;"></i></a>';
	                htmlData += '</div>';
	                $('.NewFiles').append(htmlData); 
	                fileNo++; 
	                filesArr.push(files[j]);
	                console.log("새로운 파일 추가됨:", files[j].name);
	            }
	        }
	    }  
	});
});
	// 삭제 함수 
	function deleteFile(board_file_idx) {
	    var filename = $('.name_' + board_file_idx).text();
	    console.log("deleteFilefilename??", filename);
	    console.log("삭제한 파일 아이디??", board_file_idx);
	    $('.filebox_'+board_file_idx).remove(); // .empty() 대신 .remove() 사용
	    deletedFiles.push(board_file_idx); // 삭제된 파일 인덱스를 배열에 추가
	   // filesArr[board_file_idx].is_delete = true;
	    console.log("현재 삭제된 파일 인덱스 배열:", deletedFiles);
	    console.log("현재 삭제된 파일의 modify인덱스에 해당하는 값 : ", deletedFiles[modify])
	}
	
	// 새로운 파일 삭제 함수
	function deleteNewFile(num) {
	    document.querySelector("#file" + num).remove(); 
	    //filesArr[num].is_delete = true; 
	    filesArr.pop(); // 배열에서 파일을 제거
	}
   
$(function(){ 
    $('#uploadForm').submit(function(event) {
        var formData = new FormData(); 
      //event.preventDefault(); // 폼 기본 동작 방지

      var board_subject = $('#board_subject').val();
      var content_text = $('#editor').val(); 
        for (var i = 0; i < filesArr.length; i++) { 
                formData.append('uploadFiles[]', filesArr[i]);
                console.log("filesArr[i] :", filesArr[i])
                console.log('파일 이름:', filesArr[i].name);
                console.log('파일 크기:', filesArr[i].size / 1024, 'kB');  
        }


        formData.append('content_subject', board_subject);
        formData.append('content_text', content_text); 
        //formData.append('content_board_idx', ${param.index}); 
      //  formData.append('user_idx', ${loginUserBean.user_idx});
        formData.append('content_idx', ${boardInfo.content_idx});  
        console.log("board_subject : ", board_subject)
        console.log("content_text : ", content_text)
 
        //console.log("content_board_idx : ", ${param.index})
       // console.log("user_idx : ", ${loginUserBean.user_idx})
			 
       console.log("deletedFiles[modify] 상태는?????",deletedFiles[modify])
       if (deletedFiles[modify] !== undefined) {
		    // 삭제할 파일들 중 undefined가 나타나기 전까지의 부분 배열 추출
		    let filesToDelete = []; 
		    for (let i = modify; i < deletedFiles.length; i++) {
		        if (deletedFiles[i] === undefined) break;
		        filesToDelete.push(deletedFiles[i]);
		    }
		    
		    // 파일 삭제하기 
		    $.ajax({
		        url: '${root}/deleteFile',
		        type: 'GET',
		        data: { board_file_idx: JSON.stringify(filesToDelete) }, //배열은 이런형태로
		        success: function(response) {
		            console.log('파일이 성공적으로 삭제되었습니다.'); 
		        },
		        error: function(xhr, status, error) {
		            console.error('파일 삭제 실패:', error);
		        }
		    });
		}  
	        // 서버로 formData 전송 
	        $.ajax({
			        url: '${root }/board/modify_pro?content_idx=${param.content_idx}',
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
        //filesArr = [];
    }); 
});

</script>
<style> 
.insert .file-list {
    height: 200px;
    overflow: auto;
    border: 1px solid #989898;
    padding: 10px;
}
.insert .file-list .filebox p {
    font-size: 14px;
    margin-top: 10px;
    display: inline-block;
}
.insert .file-list .filebox .delete i{
    color: #ff5353;
    margin-left: 5px;
}
</style> 
</head>
<body>
<c:import url="/WEB-INF/views/include/top_menu.jsp"/>

	<div class="container" style="margin-top: 100px"> 
			<div class="col-sm-6"></div>  
			
			<div class="col-sm"> 
						<form action="${root }/board/modify_pro " method="post" enctype="multipart/form-data" id="uploadForm" >
						  <%-- <input type="hidden" name="content_idx" value="${param.content_idx }"/>    --%>
                			<%-- <input type="hidden" name="user_idx" value="${loginUserBean.user_idx}" />   --%>
                			<input type="hidden" name="user_idx" value="${boardInfo.user_idx}" />   
               	<input type="hidden" name="hiddenContent_idx" value="${boardInfo.content_idx}" />   
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
				                <div class="form-group insert">
				                  	<input type="file" id="uploadFiles" name="uploadFiles[]" style="display: none;"   class="form-control" accept="${boardAllInfo.file_ext}" multiple  />
									<label for="uploadFiles"> <h5>첨부파일(최대 ${boardAllInfo.is_file }개)<i class="bi bi-camera-fill mx-2" id="uploadFiles"></i></h5></label>
				                    <c:forEach var="file" items="${boardfileBean}">
									    <div id="file" class="filebox_${file.board_file_idx}">
									        <span class="name_${file.board_file_idx}">${file.file_name}</span>
									        <a class="delete_${file.board_file_idx}" onclick="deleteFile(${file.board_file_idx});"><i class="bi bi-dash" style="color:red;"></i></a>
									       <%--  <input type="file" id="modifyFiles" name="uploadFiles[]"  onchange="modifyFile(${file.board_file_idx});" style="display: none;" class="form-control modify_${file.board_file_idx}" accept="${boardAllInfo.file_ext}" multiple  />
									        <label for="modifyFiles"><i class="bi bi-pencil"></i></label> --%>
									    </div>
									</c:forEach>
									<div class="NewFiles"></div>
								<%-- 	<input type="hidden" value="${boardfileBean.size() }"/>  --%>
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