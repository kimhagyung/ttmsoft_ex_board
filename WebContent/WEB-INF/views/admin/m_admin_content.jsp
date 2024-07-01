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
			 var dataTable = $('#dataTable').DataTable({
			        "paging": true, // 페이징 기능 활성화
			        "lengthChange": false, // 페이지당 아이템 수 변경 기능 비활성화
			        "searching": false, // 검색 기능 비활성화 (검색은 별도로 처리됨)
			        "info": true, // 정보 표시 기능 활성화
			        "autoWidth": false, // 자동 너비 조정 비활성화
			        "responsive": true // 반응형 테이블 지원
			    });
		 
		    // 검색 버튼 클릭 시 테이블 갱신
		    $('#searchButton').on('click', function() {
		        handleSearchButtonClick(dataTable);
		    });
		//smartEditor();
        function submitContents(editorId) { 
            oEditors.getById[editorId].exec("UPDATE_CONTENTS_FIELD", []); // 에디터의 내용이 textarea에 적용 
            console.log("editorId??:",editorId)
            // 에디터의 내용을 출력합니다.
            //alert(document.getElementById("editor").value); 
        }  
         
        $(document).on('click', '[id^=submit]', function() {
            var buttonId = $(this).attr('id'); // 클릭된 버튼의 id  
            var boardIdx = buttonId.replace('submit', ''); // 'submit' 문자열을 제거하여 board.content_idx 값 .  
            console.log("boardIdx?",boardIdx)
            submitContents("contentText_"+boardIdx); 
            //alert(document.getElementById("contentText_"+boardIdx).value);  
            submitForm(boardIdx);
        });
        
    });   
	
var filesArr = []; //서버로 보낼 파일들이 저장되어있음 
var fileNo = 0; //deleteNewFile함수에 사용하는 것 
var deletedFiles = []; // 삭제된 파일을 추적하기 위한 배열
var modifyFiles = []; //아직 사용은 안하고 있음
var modify=0; //deletedFiles배열의 인덱스값을 관리하는 변수임 

function handleSearchButtonClick(dataTable) {
        const selectedOption = $('#inputState2').val(); // board_info_idx인듯
        const selectedOption2 = $('#inputState3').val(); // 임시 삭제 여부 검색
        console.log("선택한 옵션", selectedOption);
        console.log("선택한 임시삭제", selectedOption2);

        $.ajax({
        	url: '${root}/searchBoard?board_info_idx=' + selectedOption + '&isDeleted=' + selectedOption2,
            type: "GET",  
            dataType:'Json',
            success: function(response) { 
            	// 기존 데이터 삭제
                dataTable.clear().draw();
                $('#searchResults').empty(); // 이전 결과 초기화  
                console.log("검색이 성공했습니다")
                //console.log("받아온 게시글: ",response.searchBoard)
               	//console.log("받아온 파일들: ",response.searchFileBoard) 
                var searchFileBoard = response.searchFileBoard;
                
                if (response.searchBoard.length > 0) {
                	for (var i = 0; i < response.searchBoard.length; i++) {
                		
                		var board=response.searchBoard[i]; 
                		 var rowData = [ 
                             (i + 1),
                             board.content_idx,
                             board.board_info_name,
                             board.content_subject,
                             board.content_date,
                             board.viewCnt,
                             board.is_deleted,
                             '<input type="button" data-bs-toggle="modal" data-bs-target="#ContentManage_' + board.content_idx + '" class="btn btn-info" value="자세히보기" />'
     	                    ];
     	                    dataTable.row.add(rowData).draw(false); // 테이블에 행 추가
						
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
		                	 modalHtml += '	     			<button type="button" class="btn btn-link" id="isDeleted_'+board.content_idx+'" onclick="isdeleted(' + board.content_idx + ')" >삭제처리</button>';
				               
		                }else if(board.is_deleted=='Y'){
		                	 modalHtml += '					<button type="button" class="btn btn-link" id="isDeleted_'+board.content_idx+'" onclick="clearDelete(' + board.content_idx + ')" >삭제처리 해제</button>';
				               
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
		             	modifyModal += '      <form action="${root }/admin/m_admin_contentPro" method="post" enctype="multipart/form-data" id="uploadForm_' + board.content_idx + '">'; 
		             	modifyModal += '	  <input type="hidden" name="hiddenContent_idx" value="'+ board.content_idx +'" />'
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
		                modifyModal += '								<td colspan="3"><input type="text" class="form-control" id="content_subject_'+board.content_idx +'" name="content_subject" value="'+board.content_subject+'" /></td>'; 
		                modifyModal += '							</tr>';
		                modifyModal += '                  			<tr>';
                        modifyModal += '                      			<th scope="row">내용</th>';
                      	modifyModal += '    							<td colspan="3"><textarea class="form-control editor_' + board.content_idx + '" id="contentText_' + board.content_idx + '" rows="10" name="content_text">' + board.content_text + '</textarea></td>';
                        modifyModal += '                 			</tr>';
		                modifyModal += '							<tr>';
		                modifyModal += '								<th scope="row">첨부</th>'; 
		                modifyModal += '									<td colspan="3">'; 
			             // 파일 리스트 추가 
		                if (board.file_checked == 1) {
						    modifyModal += '<input type="file" id="uploadFiles" onchange="filechange(' + board.is_file + ', ' + board.file_size + ', ' + relatedFiles.length +  ')" name="uploadFiles[]" style="display: none;" class="form-control" accept="' + board.file_ext + '" multiple />';
						    modifyModal += '<label for="uploadFiles"><h5>첨부파일(최대 ' + board.is_file + ' 개)<i class="bi bi-camera-fill mx-2" id="uploadFiles"></i></h5></label>';
						}
						
						for (var k = 0; k < relatedFiles.length; k++) {  
						    modifyModal += '<div id="file" class="filebox_'+relatedFiles[k].board_file_idx+'">'
						    modifyModal += '<span class="name'+relatedFiles[k].board_file_idx+'">'+ relatedFiles[k].file_name + '</span>'
						    modifyModal += '  <a class="delete'+relatedFiles[k].board_file_idx+'" onclick="deleteFile('+relatedFiles[k].board_file_idx+');"><i class="bi bi-dash" style="color:red;"></i></a>'
						    modifyModal += '</div>' 
						    modifyModal += '<div class="NewFiles_' + relatedFiles[k].board_file_idx + '"></div>'; //수정된 파일 리스트 올 자리 
						} 
						modifyModal += '<div class="NewFiles"></div>';//새롭게 추가될 파일 리스트가 올 자리
	                    modifyModal += '									</td>';
		                modifyModal += '							</tr>';
		                modifyModal += '						</tbody>';     
		                modifyModal += '					</table>';     
		                modifyModal += '	   			</div>';     
		             	modifyModal += '      			<div class="modal-footer">';
		             	modifyModal += '					<button type="submit" id="submit'+board.content_idx+'"   class="btn btn-link">수정완료</button>';
		             	modifyModal += '        			<button type="button" class="btn btn-link" data-bs-target="#ContentManage_' + board.content_idx + '" data-bs-toggle="modal">취소</button>';
		             	modifyModal += '      			</div>';
		             	modifyModal += '      		</form>'; //form끝
		             	modifyModal += '    		</div>';
		             	modifyModal += ' 	 </div>';
		             	modifyModal += '</div>'; 
		             	
		             	//$("#searchResults").append(replyHtml);
		             	// 모달을 body에 추가
		                $('body').append(modalHtml);
		             	//수정 모달을 body에 추가
		                $('body').append(modifyModal);
		             	
		            	$('[id^=ModifyModalToggle_]').on('shown.bs.modal', function () {
		        		    var editorId = 'contentText_' + $(this).attr('id').split('_')[1];
		        		    console.log("editorId : ????",editorId)  
		        		    smartEditor(editorId);  
		        		});  

		        	    // 모달이 닫힐 때 에디터 인스턴스 제거
		        		$('[id^=ModifyModalToggle_]').on('shown.bs.modal', function () {
		        		    var editorId = 'contentText_' + $(this).attr('id').split('_')[1]; 
		        		    smartEditor(editorId); 
		        		    
		        		}); 
                	} 
                }  else {
                	 dataTable.clear().draw(); // 검색 결과가 없을 경우 테이블 초기화
                     //$("#searchResults").append('<tr><td colspan="7">검색 결과가 없습니다.</td></tr>');
                } 
            },
            error: function(error) {
                console.error('Error:', error);
                alert('검색 중 오류가 발생했습니다.');
            }
        });
	}
  
function filechange(is_file,file_size,relatedFilesLength) {
    var maxFileSizeKB = file_size;
    var maxFileCnt = is_file;
   	var attFileCnt = relatedFilesLength; // DB에서 받아온 값 사이즈 
    console.log("attFileCnt 는???????????????????", attFileCnt);
    console.log("현재첨부된 파일 개수 :", totalFiles);
    console.log("uploadFiles를 클릭 시 modify의 값", modify);
	console.log("file_size??",file_size) 
	
    var files = $('#uploadFiles')[0].files; 
    for (var j = 0; j < files.length; j++) {
        var fileSizeKB = files[j].size / 1024; // 파일 크기 kB
        if (fileSizeKB > maxFileSizeKB) {
            alert('파일 크기는 ' + maxFileSizeKB + 'KByte 이하여야 합니다.');
            console.log("현재 업로드한 파일 크기", fileSizeKB);
            $('#uploadFiles').val(''); // 파일 선택 취소
            return false;
        } else {
            var FileBoardIdx = deletedFiles[modify];
            console.log("existingFileIdx?????", FileBoardIdx);

            if (FileBoardIdx != undefined) {
                var formData = new FormData();
                formData.append('board_file_idx', FileBoardIdx);
                console.log("modify의 현재값 :", modify);
                let htmlData2 = '';
                htmlData2 += '<div id="file' + deletedFiles[modify] + '" class="filebox_' + deletedFiles[modify] + '">';
                htmlData2 += '   <span class="name">' + files[j].name + '</span>';
                htmlData2 += '   <a class="delete" onclick="deleteFile(' + deletedFiles[modify] + ');"><i class="bi bi-dash" style="color:red;"></i></a>';
                htmlData2 += '</div>';
                $('.NewFiles_' + deletedFiles[modify]).append(htmlData2);

                formData.append('uploadFiles', files[j]); //수정할 파일임 
                $.ajax({
                    url: '${root}/board/modifyFile',
                    type: 'POST',
                    data: formData,
                    processData: false,
                    contentType: false,
                    success: function(response) {
                        console.log('수정완료:', response);
                        modifyFiles.push(); //얜 모임 ?? 
                        modify++;
                        console.log("modify의 수정완료 후 값:", modify);
                        // DataTable 객체 다시 가져오기
    	                var dataTable = $('#dataTable').DataTable();
    	                handleSearchButtonClick(dataTable);
                    },
                    error: function(error) {
                        console.error('업로드 오류:', error);
                    }
                });
            } else {
                var totalFiles = attFileCnt + filesArr.length + 1;
                if (totalFiles > maxFileCnt) {
                    alert('파일 첨부는 최대 ' + maxFileCnt + '개까지 가능합니다.');
                    $('#uploadFiles').val(''); // 파일 선택 취소
                    return false;
                }

                let htmlData = '';
                htmlData += '<div id="file' + fileNo + '"  class="filebox_' + deletedFiles[modify] + '">';
                htmlData += '   <span class="name">' + files[j].name + '</span>';
                htmlData += '   <a class="delete" onclick="deleteNewFile(' + fileNo + ');"><i class="bi bi-dash" style="color:red;"></i></a>';
                htmlData += '</div>';
                $('.NewFiles').append(htmlData); 
                fileNo++;
                filesArr.push(files[j]);
                console.log("새로운 파일 추가됨:", files[j].name);
            }
        }
    }
} 
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
 
	// 게시글 임시삭제처리 함수 
	function isdeleted(content_idx) {
	    var isConfirmed = confirm('삭제처리 하시겠습니까?'); 
	    if (isConfirmed) {
	        $.ajax({
	            url: '${root}/tempDeleted',
	            type: 'GET',
	            data: { content_idx: content_idx },
	            success: function(response) {
	                alert('게시글이 삭제처리 되었습니다.');
	                $('#isDeleted_' + content_idx)
	                    .text('삭제처리 해제')
	                    .attr('onclick', 'clearDelete(' + content_idx + ')');
	                $('#ContentManage_' + content_idx).modal('hide');
	                // DataTable 객체 다시 가져오기
	                var dataTable = $('#dataTable').DataTable();
	                handleSearchButtonClick(dataTable);
	            }
	        });
	    } else {
	        alert('취소하셨습니다.');
	    }
	}

	// 삭제처리 해제 
	function clearDelete(content_idx) {
	    var isConfirmed = confirm('삭제처리를 해제 하시겠습니까?');
	    if (isConfirmed) {
	        $.ajax({
	            url: '${root}/ClearDeleted',
	            type: 'GET',
	            data: { content_idx: content_idx },
	            success: function(response) {
	                alert('게시글 삭제처리가 해제 되었습니다.');
	                $('#isDeleted_' + content_idx)
	                    .text('삭제처리')
	                    .attr('onclick', 'isdeleted(' + content_idx + ')');
	                $('#ContentManage_' + content_idx).modal('hide');
	                var dataTable = $('#dataTable').DataTable();
	                handleSearchButtonClick(dataTable);
	            }
	        });
	    } else {
	        alert('취소하셨습니다.');
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
 				
 				 var dataTable = $('#dataTable').DataTable();
	                handleSearchButtonClick(dataTable); 
 				$('#ContentManage_' + content_idx).modal('hide');
 			}
 		});
 	}else{
 		alert('취소하셨습니다. ')
 	}
 }


 //폼제출 !  
function submitForm(content_idx){
        var formData = new FormData(); 
     //event.preventDefault(); // 폼 기본 동작 방지 
      var board_subject = $('#content_subject_'+content_idx).val();
      var content_text = $('#contentText_' + content_idx).val();  
      
      
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
        formData.append('content_idx', content_idx);  
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
		        url: '${root }/admin/m_admin_contentPro?content_idx='+content_idx,
		        type: 'POST',
		        data: formData,
		        processData: false, // 데이터 처리 방식 설정 (FormData 객체 사용시 false로 설정)
		        contentType: false, // 컨텐츠 타입 설정 (FormData 객체 사용시 false로 설정)
		        success: function(response) {
		            console.log('수정 완료:', response);
		            $('#ContentManage_' + content_idx).modal('hide');
		            var dataTable = $('#dataTable').DataTable();
	                handleSearchButtonClick(dataTable); 
		        },
		        error: function(error) {
		            console.error('업로드 오류:', error);
		        }
		    });    
    
}
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
					</a>  
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
                                            <th>조회수</th>
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
                                            <th>조회수</th>
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

 
</body>

</html>