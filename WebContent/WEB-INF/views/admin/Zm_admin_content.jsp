<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="root" value="${pageContext.request.contextPath }" />
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">
<link href="${root}/resources/vendor/fontawesome-free/css/all.min.css"
	rel="stylesheet" type="text/css">
<link
	href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
	rel="stylesheet">
<link href="${root}/resources/css/sb-admin-2.min.css" rel="stylesheet">
<link
	href="${root}/resources/vendor/datatables/dataTables.bootstrap4.min.css"
	rel="stylesheet">
<!-- 
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script
	src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script> -->
<!-- <link
	href="https://maxcdn.bootstrapcdn.com/bootstrap/5.1.3/css/bootstrap.min.css"
	rel="stylesheet"> -->
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p"
	crossorigin="anonymous"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.0/font/bootstrap-icons.css">
 <script src="${root}/resources/se2/js/service/HuskyEZCreator.js"></script>
<script>
	
	$(document).ready(function() {
	
		//smartEditor();
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

		let oEditors = [];
		let currentEditorId = null;
		function smartEditor(editorId) {
		    if (currentEditorId) {
		        nhn.husky.EZCreator.getById[currentEditorId].destroy();
		    }
		    currentEditorId = editorId;

		    nhn.husky.EZCreator.createInIFrame({
		        oAppRef: oEditors,
		        elPlaceHolder: editorId,
		        sSkinURI: "${root}/resources/se2/SmartEditor2Skin.html",
		        fCreator: "createSEditor2"
		    });
		}

	$(document).ready(function() {
	
    // 검색 버튼 클릭 시 이동
   $('#searchButton').on('click', handleSearchButtonClick);

});
	 
let uploadedFiles = []; 
function handleSearchButtonClick() {
        const selectedOption = $('#inputState2').val(); // board_info_idx인듯
        const selectedOption2 = $('#inputState3').val(); // 임시 삭제 여부 검색
        console.log("선택한 옵션", selectedOption);
        console.log("선택한 임시삭제", selectedOption2);

        $.ajax({
        	url: '${root}/searchBoard?board_info_idx=' + selectedOption + '&isDeleted=' + selectedOption2,
            type: "GET",  
            dataType:'Json',
            success: function(response) { 
                $('#searchResults').empty(); // 이전 결과 초기화  
                console.log("검색이 성공했습니다")
                //console.log("받아온 게시글: ",response.searchBoard)
               	//console.log("받아온 파일들: ",response.searchFileBoard) 
                var searchFileBoard = response.searchFileBoard;
                
                if (response.searchBoard.length > 0) {
                	for (var i = 0; i < response.searchBoard.length; i++) {
                		var board=response.searchBoard[i]; 
                    	var replyHtml = '<tr>'
                      	replyHtml += '<td>'+ (i+1) + '</td>'
                      	replyHtml += '<td>'+ board.content_idx + '</td>'
                      	replyHtml += '<td>'+ board.board_info_name + '</td>'
                      	replyHtml += '<td>'+ board.content_subject + '</td>'
                      	replyHtml += '<td>'+ board.content_date + '</td>'
                      	replyHtml += '<td>'+ board.is_deleted+'</td>'
                      	replyHtml += '<td><input type="button" data-bs-toggle="modal" data-bs-target="#ContentManage_' + board.content_idx + '" class="btn btn-info" value="자세히보기" /></td>';
						replyHtml += '</tr>'
                      	
						
						// 자세히 보기 모달의 HTML 생성
		                var modalHtml = '<div class="modal fade" id="ContentManage_' + board.content_idx + '" tabindex="-1" aria-labelledby="ContentManage_' + board.content_idx + 'Label" aria-hidden="true">';
		                modalHtml += '		<div class="modal-dialog modal-lg">';
		                modalHtml += '			<div class="modal-content">';
		                modalHtml += '				<div class="modal-header">';
		                modalHtml += '					<h5 class="modal-title" id="ContentManage_' + board.content_idx + 'Label">게시물 자세히 보기</h5>';
		                modalHtml += '					<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>';
		                modalHtml += '				</div>';
		                modalHtml += '				<div class="modal-body">';
		                modalHtml += '					<table class="table table-bordered"><tbody>';
		                modalHtml += '						<tr>';
		                modalHtml += '							<th scope="row">게시판 명</th>';
		                modalHtml += '							<td>'+board.board_info_name+'</td>';
		                modalHtml += '							<th scope="row">게시판 코드</th>';
		                modalHtml += '							<td>'+board.board_info_idx+'</td>';
		                modalHtml += '						</tr>';
		                modalHtml += '						<tr>';
		                modalHtml += '						<th scope="row">등록일</th>'; 
		                modalHtml += '						<td>'+board.content_date+'</td>'; 
		                modalHtml += '						<th scope="row">수정일</th>'; 
		                modalHtml += '						<td>'+ board.modifyContent_date+'</td>'; 
		                modalHtml += '						</tr>';
		                modalHtml += '						<tr>';
		                modalHtml += '						<th scope="row">작성자</th>'; 
		                modalHtml += '						<td colspan="3">'+ board.user_name +'</td>'; 
		                modalHtml += '						</tr>';
		                modalHtml += '						<tr>';
		                modalHtml += '						<th scope="row">제목</th>'; 
		                modalHtml += '						<td colspan="3">'+ board.content_subject +'</td>'; 
		                modalHtml += '						</tr>';
		                modalHtml += '						<tr>';
		                modalHtml += '						<th scope="row">내용</th>'; 
		                modalHtml += '						<td colspan="3">'+ board.content_text +'</td>'; 
		                modalHtml += '						</tr>';
		                modalHtml += '						<tr>';
		                modalHtml += '						<th scope="row">첨부</th>'; 
		                modalHtml += '						<td colspan="3">';
		             // 파일 리스트 추가
                        var relatedFiles = searchFileBoard.filter(file => file.content_idx === board.content_idx);
                        for (var j = 0; j < relatedFiles.length; j++) { 
                            modalHtml += '<a href="${root}/resources/upload/' + relatedFiles[j].file_path + '" download="' + relatedFiles[j].file_name + '"><i class="bi bi-download"></i>';
                            modalHtml += '<span class="glyphicon glyphicon-save" aria-hidden="true"></span> ' + relatedFiles[j].file_name + '</a>';
                            modalHtml += '&nbsp; &nbsp; Size: ' + relatedFiles[j].file_size + ' KByte<br>';
                        }
 
                        modalHtml += '						</td>';
		                modalHtml += '						</tr>';
		                modalHtml += '						</tbody></table></div>';   
		                modalHtml += '				<div class="modal-footer">';
		                if(board.is_deleted == 'N'){
		                	 modalHtml += '	     			<button type="button" class="btn btn-link" id="isDeleted" onclick="isdeleted(' + board.content_idx + ')" >삭제처리</button>';
				               
		                }else if(board.is_deleted=='Y'){
		                	 modalHtml += '					<button type="button" class="btn btn-link" id="isDeleted" onclick="clearDelete(' + board.content_idx + ')" >삭제처리 해제</button>';
				               
		                }
		                modalHtml += '					<button type="button" class="btn btn-link" onclick="deleted(' + board.content_idx + ')">완전삭제</button>';
		                modalHtml += ' 					<button class="btn btn-link" data-bs-target="#ModifyModalToggle_' + board.content_idx + '"" data-bs-toggle="modal">수정</button>'; 
		                modalHtml += '					<button type="button" class="btn btn-link" data-bs-dismiss="modal">닫기</button>';
		                modalHtml += '				</div>';
		                modalHtml += '			</div>';
		                modalHtml += '		</div>';
		                modalHtml += '</div>';
		             	
		             	
		             	
		             	//수정 모달  
		             	var modifyModal = '<div class="modal fade" id="ModifyModalToggle_' + board.content_idx + '"  aria-hidden="true" aria-labelledby="ModifyModalToggle_' + board.content_idx + 'Label" tabindex="-1">';
		             	modifyModal += '  <div class="modal-dialog modal-lg">';
		             	modifyModal += '    <div class="modal-content">';
		             	modifyModal += '      <div class="modal-header">';
		             	modifyModal += '        <h5 class="modal-title fs-5" id="ModifyModalToggle_' + board.content_idx + '">게시글 수정하기</h5>';
		             	modifyModal += '        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>';
		             	modifyModal += '      </div>';
		             	modifyModal += '      <form action="${root }/board/modify_pro" method="post" enctype="multipart/form-data" id="uploadForm" >' // 여기에 form 태그 추가
		             	modifyModal += '	  <input type="hidden" name="content_idx" value="'+ board.content_idx +'" />'
		             	modifyModal += '      <div class="modal-body">'; 
		             	modifyModal += '					<table class="table table-bordered">'
		             	modifyModal += '						<tbody>';
		             	modifyModal += '							<tr>';
		             	modifyModal += '								<th scope="row">게시판 명</th>';
		             	modifyModal += '								<td>'+board.board_info_name+'</td>';
		             	modifyModal += '								<th scope="row">게시판 코드</th>';
		             	modifyModal += '								<td>'+board.board_info_idx+'</td>';
		             	modifyModal += '							</tr>'; 
		             	modifyModal += '							<tr>';
		                modifyModal += '								<th scope="row">작성자</th>'; 
		                modifyModal += '								<td colspan="3">'+ board.user_name +'</td>'; 
		                modifyModal += '							</tr>';
		                modifyModal += '							<tr>';
		                modifyModal += '								<th scope="row">제목</th>'; 
		                modifyModal += '								<td colspan="3"><input type="text" id="editor" class="form-control" name="content_subject" value="'+board.content_subject+'" /></td>'; 
		                modifyModal += '							</tr>';
		                modifyModal += '                  			<tr>';
                        modifyModal += '                      			<th scope="row">내용</th>';
                        modifyModal += '                      			<td colspan="3"><textarea class="form-control" id="contentText_' + board.content_idx + '" rows="10" name="content_text">' + board.content_text + '</textarea></td>';
                        modifyModal += '                 			</tr>';
		                modifyModal += '							<tr>';
		                modifyModal += '								<th scope="row">첨부</th>'; 
		                modifyModal += '									<td colspan="3">';
			             // 파일 리스트 추가 
                       for (var k = 0; k < relatedFiles.length; k++) {
                    	  
                    		    modifyModal += '<div class="row">';
	   						    modifyModal += '    <div class="col-8" id="filename' + relatedFiles[k].board_file_idx + '">' + relatedFiles[k].file_name + '</div>';
	   						    modifyModal += '    <div class="col-2">';
	   						    modifyModal += '        <input type="button" value="수정" class="btn btn-link" onclick="modifyFile(' + relatedFiles[k].board_file_idx + ', ' + relatedFiles[k].content_idx + ')"/>';
	   						    modifyModal += '    </div>';
	   						    modifyModal += '    <div class="col-2">';
	   						    modifyModal += '        <input type="button" value="삭제" onclick="deleteFile(' + relatedFiles[k].board_file_idx + ')" class="btn btn-link"/>';
	   						    modifyModal += '    </div>';
	   						    modifyModal += '    <div style="display: none;">';
	   						    modifyModal += '        <input type="file" style="display: none;" name="uploadFiles" id="modifyFiles' + relatedFiles[k].board_file_idx + '" class="border border-secondary" accept="'+board.file_ext + '"  multiple>';
	   						    modifyModal += '    </div>';
	   						    modifyModal += '</div>';
                    	  
						   
						}
			             
                       var isFile = board.file_size; //첨부파일 개수 
	       		        if(board.length < isFile) {
	       		        	modifyModal +='<label for="uploadFiles"> <h5>첨부파일(최대 ${boardAllInfo.is_file }개)<i class="bi bi-camera-fill mx-2" id="uploadFiles"></i></h5></label>';
	       		            for (var i = board.length; i < isFile; i++) {
	       		            	modifyModal += '<div class="form-inline">' ;
	       		            	modifyModal += '<input type="file" name="uploadFiles" accept="' + board.file_ext +'" class="form-control" multiple>';
	       		            	modifyModal += '</div>' ;
	       		            } 
	       		            // 파일 선택 시 크기 체크
	       		           $('input[name="uploadFiles"]').on('change', function() {
	       		                var maxFileSizeKB = board.file_size; 
	
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
 
	                    modifyModal += '									</td>';
		                modifyModal += '							</tr>';
		                modifyModal += '						</tbody>';     
		                modifyModal += '					</table>';     
		                modifyModal += '	   			</div>';     
		             	modifyModal += '      			<div class="modal-footer">';
		             	modifyModal += '       			 	<button type="submit" class="btn btn-link"/>수정완료</button>';
		             	modifyModal += '        			<button type="button" class="btn btn-link" data-bs-target="#ContentManage_' + board.content_idx + '" data-bs-toggle="modal">취소</button>';
		             	modifyModal += '      			</div>';
		             	modifyModal += '      		</form>'; //form끝
		             	modifyModal += '    		</div>';
		             	modifyModal += ' 	 </div>';
		             	modifyModal += '</div>'; 
		             	 
		             	$("#searchResults").append(replyHtml);
		             	// 모달을 body에 추가
		                $('body').append(modalHtml);
		             	//수정 모달을 body에 추가
		                $('body').append(modifyModal);

		                // 모달이 열릴 때마다 smartEditor 함수 호출
		                $('[id^=ModifyModalToggle_]').on('shown.bs.modal', function (e) {
		                    let editorId = 'contentText_' + $(this).attr('id').split('_')[1];
		                    smartEditor(editorId);
		                });

		                // 모달이 닫힐 때 에디터 인스턴스 제거
		                $('[id^=ModifyModalToggle_]').on('hidden.bs.modal', function () {
		                    if (currentEditorId) {
		                        nhn.husky.EZCreator.getById[currentEditorId].destroy();
		                        currentEditorId = null;
		                    }
		                }); 
                	}
                } else {
                	$("#searchResults").append('<tr>' +
                									'<td colspan="7">검색 결과가 없습니다.</td>'+
                								'</tr>');
                }
            },
            error: function(error) {
                console.error('Error:', error);
                alert('검색 중 오류가 발생했습니다.');
            }
        });
	}
 
//게시글 임시삭제처리 함수 
function isdeleted(content_idx){
	var isConfirmed=confirm('삭제처리 하시겠습니까?')
	
	if(isConfirmed){
		$.ajax({
			url : '${root}/tempDeleted',
			type : 'GET',
			data : {content_idx:content_idx},
			success : function(response){
				alert('게시글이 삭제처리 되었습니다.')  
				$('#ContentManage_' + content_idx).modal('hide');
				handleSearchButtonClick();
			}
		});
	}else{
		alert('취소하셨습니다. ')
	}
}

//삭제처리 해제 
function clearDelete(content_idx){
var isConfirmed=confirm('삭제처리를 해제 하시겠습니까?')
	
	if(isConfirmed){
		$.ajax({
			url : '${root}/ClearDeleted',
			type : 'GET',
			data : {content_idx:content_idx},
			success : function(response){
				alert('게시글 삭제처리가 해제 되었습니다. 되었습니다.')  
				$('#ContentManage_' + content_idx).modal('hide'); 
				handleSearchButtonClick();
			}
		});
	}else{
		alert('취소하셨습니다.')
	}
}

//게시글 완전삭제 처리 함수 
function deleted(content_idx){
	var isConfirmed=confirm('게시글을 영구적으로 삭제 하시겠습니까?')
	console.log("content_idx :",content_idx)
	if(isConfirmed){
		$.ajax({
			url : '${root}/ComDeleted',
			type : 'GET',
			data : {content_idx:content_idx},
			success : function(response){
				alert('게시글이 삭제 되었습니다.') 
				$('#ContentManage_' + content_idx).modal('hide');
				handleSearchButtonClick();
			}
		});
	}else{
		alert('취소하셨습니다. ')
	}
}
 


// 파일 수정 함수 
function modifyFile(boardFileIdx,content_idx) {
    // 수정할 파일의 id를 가지고 input file을 클릭합니다.
   	document.getElementById('modifyFiles' + boardFileIdx).click(); 
 	// 파일 선택 시 크기 체크
 	
	  $.ajax({
           url: '${root}/ReqboardInfo?board_file_idx='+boardFileIdx +'&content_idx='+content_idx,  
           type: 'GET',
   		   dataType:'Json',   
           success: function(response) {
               //console.log('해당 게시판 정보 가져오기 성공:', response);  
              $('input[name="uploadFiles"]').off('change').on('change', function() {
                   var maxFileSizeKB = response.file_size; //최대 파일 사이즈 
                   console.log("maxFileSizeKB :",maxFileSizeKB)
                   console.log("boardFileIdx :",boardFileIdx)
                   var files = $(this)[0].files;
			        for (var j = 0; j < files.length; j++) {
			            var fileSizeKB = files[j].size / 1024; // 파일 크기 kB
			            var formData = new FormData();  
			            
			            formData.append('board_file_idx', boardFileIdx);
			            formData.append('content_idx', content_idx);
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
			    		            uploadedFiles = []; 
			    		            handleSearchButtonClick();
			    		        },
			    		        error: function(error) {
			    		            console.error('업로드 오류:', error);
			    		        }
			    		    });
			            }
			        }
               });
           },
           error: function(error) {
               console.error('조회 오류:', error); 
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
                handleSearchButtonClick();
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
   	event.preventDefault(); // 폼 기본 동작 방지

    var formData = new FormData(); 
     
 
    var board_subject = $('input[name="content_subject"]').val();
    var content_text = $('input[name="content_text"]').val(); 
    formData.append('content_subject', board_subject);
    formData.append('content_text', content_text);   
	console.log("번호 : ",board_subject);
	console.log("번호 : ",content_text);
	
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
    //uploadedFiles = [];
    
    
    
}); 
 
 
</script>
</head>

<!-- Page Wrapper -->
	<div id="wrapper">
		<!-- Sidebar -->
		<ul
			class="navbar-nav bg-gradient-primary sidebar sidebar-dark accordion"
			id="accordionSidebar">
			<!-- Sidebar - Brand -->
			<a
				class="sidebar-brand d-flex align-items-center justify-content-center"
				href="${root }/admin/m_admin_board">
				<div class="sidebar-brand-icon rotate-n-15">
					<i class="fas fa-laugh-wink"></i>
				</div>
				<div class="sidebar-brand-text mx-3">
					TTMSoft				</div>
			</a>
			<!-- Divider -->
			<hr class="sidebar-divider">
			<!-- Heading -->
			<div class="sidebar-heading">사용자 화면 보기</div>
			<!-- Nav Item - Pages Collapse Menu -->
			<li class="nav-item"><a class="nav-link" href="${root }/index">
					<i class="fas fa-fw fa-chart-area"></i> <span>사용자화면보기</span>
			</a></li>
			<!-- Divider -->
			<hr class="sidebar-divider">

			<!-- Heading -->
			<div class="sidebar-heading">통합게시판관리</div>
			<!-- Nav Item - Pages Collapse Menu -->
			<li class="nav-item"><a class="nav-link"
				href="${root }/admin/m_admin_board"> <i
					class="fas fa-fw fa-chart-area"></i> <span>게시판관리</span></a></li>
			<!-- Nav Item - Tables -->
			<li class="nav-item"><a class="nav-link active"
				href="${root }/admin/m_admin_content"> <i
					class="fas fa-fw fa-chart-area"></i> <span>게시물관리</span></a></li>
			<!-- Divider -->
			<hr class="sidebar-divider d-none d-md-block">

			<!-- Sidebar Toggler (Sidebar) -->
			<div class="text-center d-none d-md-inline">
				<button class="rounded-circle border-0" id="sidebarToggle"></button>
			</div>

		</ul>
		<!-- End of Sidebar -->
		<!-- Content Wrapper -->
		<div id="content-wrapper" class="d-flex flex-column">
			<!-- Main Content -->
			<!-- Topbar -->
			<nav
				class="navbar navbar-expand navbar-light bg-white topbar mb-4 static-top shadow">

				<!-- Sidebar Toggle (Topbar) -->
				<form class="form-inline">
					<button id="sidebarToggleTop"
						class="btn btn-link d-md-none rounded-circle mr-3">
						<i class="fa fa-bars"></i>
					</button>
				</form>
 
				<!-- Topbar Navbar -->
				<ul class="navbar-nav ml-auto">
					<div class="topbar-divider d-none d-sm-block"></div>

					<!-- Nav Item - User Information -->
					<li class="nav-item dropdown no-arrow"><a
						class="nav-link dropdown-toggle" href="#" id="userDropdown"
						role="button" data-toggle="dropdown" aria-haspopup="true"
						aria-expanded="false"> <span
							class="mr-2 d-none d-lg-inline text-gray-600 small">${loginAdminBean.admin_name }</span> 
					</a> <!-- Dropdown - User Information -->
						<div
							class="dropdown-menu dropdown-menu-right shadow animated--grow-in"
							aria-labelledby="userDropdown"> 
							<a class="dropdown-item" href="#" data-toggle="modal"
								data-target="#logoutModal"> <i
								class="fas fa-sign-out-alt fa-sm fa-fw mr-2 text-gray-400"></i>
								Logout
							</a>
						</div></li>

				</ul>

			</nav>
                <!-- End of Topbar -->

               <!-- Begin Page Content -->
			<div class="container-fluid">

				<!-- Page Heading -->
				<h1 class="h3 mb-2 text-gray-800">통합게시물관리</h1>
				<p class="mb-4">
					Integrated board management <a target="_blank">
				</p>
				<hr class="mb-3">
				<span class="h5 mb-2 text-gray-800">게시물 관리 &nbsp</span> <span
					class="mb-4">Post Management<a target="_blank"></span>
				<p>  
				<div class="row g-3">
					<div class="col-md-10">
						<label for="inputState2" class="form-label">게시판 선택</label> <select
						class="form-select form-control" id="inputState2"
						aria-label="Default select example">
						<c:forEach var="obj" items="${topMenuList }">
							<option value="${obj.board_info_idx}">${obj.board_info_name }</option> 
						</c:forEach>
					</select>
					</div>
					<div class="col-md-2">
						<label for="inputState3" class="form-label">임시삭제여부</label>
						<select class="form-select form-control" id="inputState3" name="is_deleted"
							aria-label="Default select example">
							<option value="All" selected>전체</option>
							<option value="Y">Y</option>
							<option value="N">N</option>
						</select>
					</div>
				</div>
				<div class="text-right mt-4 mb-4"> 
					<span>
						<button type="submit" class="btn btn-primary" id="searchButton">검색</button>
					</span>
				</div>
                    <!-- DataTales Example -->
                    <div class="card shadow mb-4">
                        <div class="card-header py-3">
                            <h6 class="m-0 font-weight-bold text-primary">게시물 목록</h6>
                        </div>
                        <div class="card-body">
                            <div class="table-responsive">
                                <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
                                    <thead>
                                         <tr>
                                            <th></th>
                                            <th>번호</th>
                                            <th>게시판명</th>
                                            <th>제목</th>
                                            <th>등록일</th>
                                            <th>임시삭제</th> 
                                            <th>자세히보기</th> 
                                        </tr>
                                    </thead>
                                    <tfoot>
                                        <tr>
                                            <th></th>
                                            <th>번호</th>
                                            <th>게시판명</th>
                                            <th>제목</th>
                                            <th>등록일</th>
                                            <th>임시삭제</th> 
                                            <th>자세히보기</th> 
                                        </tr>
                                    </tfoot>
                                    <tbody id="searchResults"> 
                                        
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>

                </div>
                <!-- /.container-fluid --> 
            </div>
            <!-- End of Main Content --> 

        </div>
        <!-- End of Content Wrapper -->

    </div>
    <!-- End of Page Wrapper -->
 
    <!-- Scroll to Top Button-->
    <a class="scroll-to-top rounded" href="#page-top">
        <i class="fas fa-angle-up"></i>
    </a>
	


    <!-- Logout Modal-->
    <div class="modal fade" id="logoutModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel"
        aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLabel">로그아웃</h5>
                    <button class="close" type="button" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">×</span>
                    </button>
                </div>
                <div class="modal-body">로그아웃 하시겠습니까?</div>
                <div class="modal-footer">
                    <button class="btn btn-secondary" type="button" data-dismiss="modal">Cancel</button>
                    <a class="btn btn-primary" href="${root }/admin/admin_logout">Logout</a>
                </div>
            </div>
        </div>
    </div>
    <!-- Footer -->
            <footer class="sticky-footer bg-white">
                <div class="container my-auto">
                    <div class="copyright text-center my-auto">
                        <span>Copyright &copy; Your Website 2020</span>
                    </div>
                </div>
            </footer>
            <!-- End of Footer -->

    <!-- Bootstrap core JavaScript-->
	<script src="${root}/resources/vendor/jquery/jquery.min.js"></script>
	<script
		src="${root}/resources/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

	<!-- Core plugin JavaScript-->
	<script
		src="${root}/resources/vendor/jquery-easing/jquery.easing.min.js"></script>

	<!-- Custom scripts for all pages-->
	<script src="${root}/resources/js/sb-admin-2.min.js"></script>

	<!-- Page level plugins -->
	<script
		src="${root}/resources/vendor/datatables/jquery.dataTables.min.js"></script>
	<script
		src="${root}/resources/vendor/datatables/dataTables.bootstrap4.min.js"></script>

	<!-- Page level custom scripts -->
	<script src="${root}/resources/js/demo/datatables-demo.js"></script>

 <script>
 $(document).ready(function() {
	    // DataTable 초기화 확인 후 초기화
	    if (!$.fn.DataTable.isDataTable('#dataTable')) {
	        $('#dataTable').DataTable({
	            "paging": true,
	            "searching": true,
	            "ordering": true,
	            "info": true,
	            "lengthChange": true,
	            "pageLength": 10,
	            "lengthMenu": [5, 10, 25, 50, 75, 100]
	        });
	    }
	});
</script>
</body>

</html>