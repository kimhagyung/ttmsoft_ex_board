<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<c:set var="root" value="${pageContext.request.contextPath }" />
<!DOCTYPE html>
<!-- <html xmlns:th="http://www.thymeleaf.org"> thymeleaf 선언 -->
<meta charset="UTF-8">
<html>
<head>
<title>미니 프로젝트</title>
</head>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
	function confirmDelete(deletUrl) {
		if (confirm("삭제하시겠습니까??")) {
			window.location.href = deletUrl;
		}
	}
</script>
<script>
$(function(){
	// 댓글 목록 조회
    updateReplyList(); 
    getAdminAnswerList(); 
    window.editComment = editComment;
    window.replyComment=replyComment;
	//댓글 작성 ajax
	$("#commentSubmit").click(function(){ 
		var replyText = $('#replyText').val();  
		if(replyText.trim() == ''){
			alert("댓글을 입력해 주세요");
			return;
		} 
		
		 if (${boardAllInfo.is_comment == 0} && !${loginAdminBean.admin_login}) {
	            alert('관리자만 답글을 남길 수 있습니다.');
	            return;
	        }
		
		//관리자 답글 입력 
		if(${loginAdminBean.admin_login==true && loginUserBean.userLogin==false}){ 
			$.ajax({
				url : '${root}/AdminAnswer',
				type : 'POST',
				contentType: 'application/json',
				data:JSON.stringify({
					amdin_answer : replyText,
					content_idx : ${param.content_idx},
					admin_idx : ${loginAdminBean.admin_idx}
				}),
				success: function(response){
					var replyHtml = '<div class="card mt-2"><div class="card-body">' +
	                '<p class="card-text">' + response.amdin_answer + '</p>' + '</div></div>';
					$("#AdminAnswerSection").append(replyHtml);
	                $("#replyText").val(''); 
	                alert('관리자 답글이 성공적으로 추가되었습니다.'); // 이거는 삭제하던가 ㅅ하셈 
	                
	             	// 댓글 목록 조회
	                getAdminAnswerList(); 
	                 
				},
				error:function(error){
					console.log(error);
					alert('댓글 추가에 실패했습니다.')
				}
			});
		}
		  
		
		console.log("입력한 댓글:", replyText); 
		console.log("게시글 번호:", ${param.content_idx}); 
		console.log("현재 로그인 idx:", ${loginUserBean.user_idx});  
			
		//댓글 입력 
		if(${loginUserBean.userLogin==true && loginAdminBean.admin_login==false}){ 
			$.ajax({
				url:'${root}/comment',
				type:'POST',
				contentType: 'application/json', //전송하는 데이터 타입 지정 
				data:JSON.stringify({
					comments : replyText,
					content_idx : ${param.content_idx},
					user_idx : ${loginUserBean.user_idx}
				}),
				success: function(response){
					var replyHtml = '<div class="card mt-2"><div class="card-body">' +
	                '<p class="card-text">' + response.comments + '</p>' + '</div></div>';
					$("#replySection").append(replyHtml);
	                $("#replyText").val(''); 
	                alert('댓글이 성공적으로 추가되었습니다.'); 
	                
	             	// 댓글 목록 조회
	                updateReplyList(); 
	                getAdminAnswerList(); 
				},
				error:function(error){
					console.log(error);
					alert('댓글 추가에 실패했습니다.')
				}
			});
		}else if(${loginUserBean.userLogin==false && loginAdminBean.admin_login==false} ){
				alert("로그인 해주세요"); 
				location.href='${root}/user/login' 	
			 
		} 
	});
	
});

//댓글 조회 함수 
function updateReplyList(){
	$.ajax({
		url:'${root}/commentShow?content_idx=${param.content_idx}', //받아오는 데이터 타입 지정 
		type: 'GET',
		dataType:'Json',
		success: function(response){
			$("#replySection").empty();
			$.each(response, function(index, comment){ //댓글 데이터 반복 처리 
				 //console.log("현재 댓글 번호", comment.comment_idx);
				 console.log("comment.user_idx",comment.user_idx);
				 console.log("loginUserBean.user_idx",${loginUserBean.user_idx});
				 var replyHtml = '<hr><div class="row" style="margin-bottom: 20px;">';
				 replyHtml += '<div class="col-sm-5"><i class="bi bi-person-circle" style="font-size:25px;"></i> ' + comment.user_name + '</div>'; //댓글 단 사람 이름
				 replyHtml += '<div class="col-sm-5"></div>'
				
				 if (${loginUserBean.user_idx} == comment.user_idx) {
				      replyHtml += '<input type="button" class="col-sm-1 btn btn-link" onclick="editComment(' + comment.comment_idx + ')" value="수정"/>';
				      replyHtml += '<input type="button" class="col-sm-1 btn btn-link" onclick="deleteComment(' + comment.comment_idx + ')" id="deleteBtn' + comment.comment_idx + '" value="삭제"/>';
				    }
				 replyHtml += '</div>';
				 replyHtml += '<div style="width:90%" id="commentContent_'+comment.comment_idx + '">' + comment.comments + '</div>' //댓글 내용   
				 replyHtml += '<div style="color:#D3D3D3;margin-top:3px;">'+comment.comment_date+'</div>'
				 replyHtml += '<input type="button" value="답글" class="btn" onclick="replyComment(' + comment.comment_idx + ')" id="reply' + comment.comment_idx + '"/>';
				 replyHtml += '<div id="replySection_' + comment.comment_idx + '"></div>'; // 대댓글이 표시될 영역
	    		
    			 $("#replySection").append(replyHtml); 
				 
    			// 대댓글 조회
                 updateReReplyList(comment.comment_idx);
                 //getAdminAnswerList(); //관리자 댓글 조회 
			});
		}
	});
}

//관리자 답글 조회 함수 
function getAdminAnswerList(){
	$.ajax({
		url:'${root}/AnswerShow?content_idx=${param.content_idx}', //받아오는 데이터 타입 지정 
		type: 'GET',
		dataType:'Json',
		success: function(response){
			$("#AdminAnswerSection").empty();
			$.each(response, function(index, answer){ //댓글 데이터 반복 처리  
				 console.log("answer.admin_idx",answer.admin_idx);
				 console.log("loginAdminBean.admin_idx",${loginAdminBean.admin_idx});
				 var replyHtml = '<hr><div class="row" style="margin-bottom: 20px;">';
				 replyHtml += '<div class="col-sm-5"><i class="bi bi-person-circle" style="font-size:25px;"></i> &nbsp; ' + answer.admin_name + '&nbsp; (관리자)</div>'; //댓글 단 사람 이름
				 replyHtml += '<div class="col-sm-5"></div>'
				
				 if (${loginAdminBean.admin_idx} == answer.admin_idx) {
				      replyHtml += '<input type="button" class="col-sm-1 btn btn-link" onclick="editAnswer(' + answer.admin_answer_idx + ')" value="수정"/>';
				      replyHtml += '<input type="button" class="col-sm-1 btn btn-link" onclick="deleteAnswer(' + answer.admin_answer_idx + ')" id="deleteBtn' + answer.admin_answer_idx + '" value="삭제"/>';
				    }
				 replyHtml += '</div>';
				 replyHtml += '<div style="width:90%" id="commentContent_'+answer.admin_answer_idx + '">' + answer.amdin_answer + '</div>' //댓글 내용   
				 replyHtml += '<div style="color:#D3D3D3;margin-top:3px;">'+answer.admin_answer_date+'</div>' 
	    		
    			 $("#AdminAnswerSection").append(replyHtml); 
				 
			});
		}
	});
}
 
 
//대댓글(답글) 조회 함수 
function updateReReplyList(commentIdx){
	$.ajax({
		url:'${root}/replyShow?comment_idx='+commentIdx, //받아오는 데이터 타입 지정 
		type: 'GET',
		dataType:'Json',
		success: function(response){
			$("#replySection_" + commentIdx).empty();
			$.each(response, function(index, reply){ //댓글 데이터 반복 처리  
				 console.log("======================================")
				 console.log("reply.user_idx",reply.user_idx);
				 console.log("loginUserBean.user_idx",${loginUserBean.user_idx}); 
				 var replyHtml = '<hr><div class="row" style="margin-bottom: 20px;">';
				 replyHtml += '<span><i class="bi bi-arrow-return-right col-sm-7 "></i> <i class="bi bi-person-circle" style="font-size:25px;"></i> ' + reply.user_name + '</span>'; //댓글 단 사람 이름
				 replyHtml += '<div class="col-sm-8"></div>' 
				 if (${loginUserBean.user_idx} == reply.user_idx) {
					  replyHtml += '<input type="button" class="col-1 btn btn-link" onclick="editReply(' + reply.reply_idx + ', ' + reply.comment_idx + ')" value="답글수정"/>';
				      replyHtml += '<input type="button" class="col-1 btn btn-link" onclick="deleteReply(' + reply.reply_idx + ', ' + reply.comment_idx + ')" id="deleteBtn' + reply.reply_idx + '" value="답글삭제"/>';
				    } 
				 replyHtml += '</div>'; 
				 replyHtml += '<div style="width:90%" id="commentContent_'+reply.reply_idx + '">' + reply.reply + '</div>' //댓글 내용   
				 replyHtml += '<div style="color:#D3D3D3;margin-top:3px;">'+reply.reply_date+'</div>' 
	    		 replyHtml += '</div>';	
    			 //$("#replySection").append(replyHtml);
				 $("#replySection_" + commentIdx).append(replyHtml); // HTML 구조에 맞게 ID 조정
			});
		}, 
		error: function(error){
			console.log(error);
			console.log('댓글 조회 실패했습니다');
		}
	});
}

// 대댓글(답글) 입력창 생성 함수
function replyComment(comment_idx){
	var replyInputHtml = '<div class="reply-input mt-3" id="replyInput_' + comment_idx + '">';
    replyInputHtml += '<textarea id="replyText_' + comment_idx + '" class="form-control" rows="3" placeholder="답글을 입력하세요"></textarea>';
    replyInputHtml += '<div style="text-align: right; margin-top: 10px;">';
    replyInputHtml += '<button class="btn btn-secondary mx-2" onclick="cancelReply(' + comment_idx + ')">취소</button>';
    replyInputHtml += '<button class="btn btn-primary" style="margin-left: 10px;" onclick="submitReply(' + comment_idx + ')">답글 달기</button>';
    replyInputHtml += '</div></div>';

    // 이전에 입력창이 있는 경우 제거
    $(".reply-input").remove();

    // 새로운 입력창 추가
    $("#replySection_" + comment_idx).append(replyInputHtml);
}

//대댓글(답글) 취소 함수
function cancelReply(comment_idx) {
    $("#replyInput_" + comment_idx).remove();
}
  
//대댓글(답글) 제출 함수
function submitReply(comment_idx){
    var replyText = $("#replyText_" + comment_idx).val();
    
    if(replyText.trim() === "") {
        alert("답글을 입력하세요.");
        return;
    }  
    
	if(${boardAllInfo.is_comment==0}){
		alert('관리자만 답글을 남길 수 있습니다.')
		return;
	}
	
	
if(${loginUserBean.userLogin==true &&loginAdminBean.admin_login==false }){ 
    $.ajax({
        url: '${root}/submitReply',
        type: 'POST',
        contentType: 'application/json',
        data:JSON.stringify({
            comment_idx: comment_idx,
            reply: replyText,
            user_idx: ${loginUserBean.user_idx} // 현재 로그인한 사용자의 ID를 포함
        }),
        success: function(response){ 
            	var replyHtml = '<div class="card mt-2"><div class="card-body">' +
                '<p class="card-text"> 답글임 : ' + response.reply + '</p>' + '</div></div>';
            	$("#replySection_").append(replyHtml); 
                alert('답글이 성공적으로 추가되었습니다.');  
                $("#replyText_" + comment_idx).val(''); 
                //답글목록조회
                updateReReplyList(response.comment_idx);     
        },
		error:function(error){
			console.log(error);
			alert('답글 추가에 실패했습니다.')
		}
    });
}else if(${loginUserBean.userLogin==false && loginAdminBean.admin_login==false} ){
	alert("로그인 해주세요"); 
	location.href='${root}/user/login' 	
 
}//댓글 입력 
}
  
 
 
//댓글 삭제 함수 
function deleteComment(comment_idx){
	var isConfirmed=confirm('정말로 이 댓글을 삭제하시겠습니까?');
	
	if(isConfirmed){
		$.ajax({
			url:'${root}/deleteComment',
			type: 'GET',
			data : {comment_idx:comment_idx},
			success: function(response){
				alert('댓글이 성공적으로 삭제되었습니다.')
				updateReplyList();
			}
		});
	} 
}

//대댓글(답글) 삭제 함수 
function deleteReply(reply_idx, comment_idx){
	var isConfirmed=confirm('정말로 이 댓글을 삭제하시겠습니까?');
	
	if(isConfirmed){
		$.ajax({
			url:'${root}/deleteReply',
			type: 'GET',
			data : {reply_idx:reply_idx},
			success: function(response){
				alert('댓글이 성공적으로 삭제되었습니다.')
				updateReReplyList(comment_idx);
			}
		});
	} 
}

//관리자 댓글 삭제 함수 
function deleteAnswer(admin_answer_idx){
	var isConfirmed=confirm('정말로 이 댓글을 삭제하시겠습니까?');
	
	if(isConfirmed){
		$.ajax({
			url:'${root}/deleteAnswer',
			type: 'GET',
			data : {admin_answer_idx:admin_answer_idx},
			success: function(response){
				alert('댓글이 성공적으로 삭제되었습니다.')
				getAdminAnswerList();
			}
		});
	} 
}

//댓글 수정 함수 
function editComment(commentId){
    var currentContent = $('#commentContent_' + commentId).text().trim(); // 댓글 내용 가져오기 (trim()으로 공백 제거)
    console.log("댓글내용 :", currentContent);

    // 수정을 위한 input 태그로 변환
    var inputElement = $('<div class="row"><input type="text" class="form-control edit-comment-input col-11" value="' + currentContent + '"/>'
                        + '<button class="col-1 btn modifyComment">수정</button></div>');
    $('#commentContent_' + commentId).replaceWith(inputElement);

    // 수정 완료 시 업데이트
    inputElement.find('.modifyComment').click(function(){
        var editedText = inputElement.find('input').val();
        console.log("수정된 내용 ", editedText);
        updateComment(commentId, editedText); // 수정된 댓글 내용으로 업데이트 함수 호출
    });
}

//댓글 수정 처리 함수 
function updateComment(commentId, editedText){
	
	$.ajax({
		url:'${root}/modifyComment',
		type:'POST',
		contentType: 'application/json',
		data:JSON.stringify({
			comment_idx: commentId,
			comments : editedText
		}),
		success:function(response){
			alert('댓글이 성공적으로 수정되었습니다');
			updateReplyList();
		}, 
		error: function(error){
			console.log(error);
			alert('댓글 수정이 실패했습니다');
		}
	});
} 

//댓글 수정 처리 함수 
function updateComment(commentId, editedText){
	
	$.ajax({
		url:'${root}/modifyComment',
		type:'POST',
		contentType: 'application/json',
		data:JSON.stringify({
			comment_idx: commentId,
			comments : editedText
		}),
		success:function(response){
			alert('댓글이 성공적으로 수정되었습니다');
			updateReplyList();
		}, 
		error: function(error){
			console.log(error);
			alert('댓글 수정이 실패했습니다');
		}
	});
} 

//관리자 댓글 수정 함수 
function editAnswer(admin_answer_idx){
    var currentContent = $('#commentContent_' + admin_answer_idx).text().trim(); // 댓글 내용 가져오기 (trim()으로 공백 제거)
    console.log("댓글내용 :", currentContent);

    // 수정을 위한 input 태그로 변환
    var inputElement = $('<div class="row"><input type="text" class="form-control edit-comment-input col-11" value="' + currentContent + '"/>'
                        + '<button class="col-1 btn modifyAnswer">수정</button></div>');
    $('#commentContent_' + admin_answer_idx).replaceWith(inputElement);

    // 수정 완료 시 업데이트
    inputElement.find('.modifyAnswer').click(function(){
        var editedText = inputElement.find('input').val();
        console.log("수정된 내용 ", editedText);
        updatAnswer(admin_answer_idx, editedText); // 수정된 댓글 내용으로 업데이트 함수 호출
    });
}


//관리자 답글 수정 처리 함수 
function updatAnswer(admin_answer_idx, editedText){
	
	$.ajax({
		url:'${root}/modifyAnswer',
		type:'POST',
		contentType: 'application/json',
		data:JSON.stringify({
			admin_answer_idx: admin_answer_idx,
			amdin_answer : editedText
		}),
		success:function(response){
			alert('답글이 성공적으로 수정되었습니다');
			getAdminAnswerList();
		}, 
		error: function(error){
			console.log(error);
			alert('댓글 수정이 실패했습니다');
		}
	});
} 
//대댓글(답글) 수정 함수 
function editReply(replyIdx, commentIdx){
    var currentContent = $('#commentContent_' + replyIdx).text().trim(); // 댓글 내용 가져오기 (trim()으로 공백 제거)
    console.log("대댓글내용 :", currentContent);

    // 수정을 위한 input 태그로 변환
    var inputElement = $('<div class="row"><input type="text" class="form-control edit-comment-input col-11" value="' + currentContent + '"/>'
                        + '<button class="col-1 btn modifyReply">등록</button></div>');
    $('#commentContent_' + replyIdx).replaceWith(inputElement);

    // 수정 완료 시 업데이트
    inputElement.find('.modifyReply').click(function(){
        var editedText = inputElement.find('input').val();
        console.log("수정된 내용 ", editedText);
        updateReply(replyIdx, editedText,commentIdx); // 수정된 댓글 내용으로 업데이트 함수 호출
    });
}

//대댓글(답글) 수정 처리 함수 
function updateReply(replyIdx, editedText,commentIdx){
	
	$.ajax({
		url:'${root}/modifyReply',
		type:'POST',
		contentType: 'application/json',
		data:JSON.stringify({
			reply_idx: replyIdx,
			reply : editedText
		}),
		success:function(response){
			alert('답글이 성공적으로 수정되었습니다');
			console.log("받아온 게시판 번호 ", commentIdx)
			updateReReplyList(commentIdx);
		}, 
		error: function(error){
			console.log(error);
			alert('댓글 수정이 실패했습니다');
		}
	});
}

</script> 
<style>
    /* Remove background image from carousel control buttons */
    .carousel-control-prev, .carousel-control-next {
        background: transparent;
        border:none;
        
    }
     
</style>
<body>
	<c:import url="/WEB-INF/views/include/top_menu.jsp" />
	
	
	<div class="container" style="margin-top: 100px">
		<div class="col-sm-12">
			<div class="form-group">
				<label for="board_writer_name">작성자</label> <input type="text"
					id="board_writer_name" name="board_writer_name"
					class="form-control" value="${boardWriterName }"
					disabled="disabled" />
			</div>
			<div class="form-group">
				<label for="board_date">작성날짜</label> <input type="text"
					id="board_date" name="board_date" class="form-control"
					value="${boardInfo.content_date }" disabled="disabled" />
			</div>
			<div class="form-group">
				<label for="board_subject">제목</label>
				<div
					style="border: 1px solid rgba(100, 100, 100, 0.5); padding: 10px; border-radius: 5px">${boardInfo.content_subject }</div>
			</div>
			<div class="form-group">
				<label for="board_content">내용</label>
				<!-- Thymeleaf에서 HTML 태그가 이미 저장된 내용을 출력. -->
				<!--<div th:utext="${boardInfo.content_text}">${boardInfo.content_text}</div>  -->
				<div
					style="border: 1px solid rgba(100, 100, 100, 0.5); padding: 10px; border-radius: 5px">${boardInfo.content_text}</div>
			</div>

			<div class="form-group">
		<%-- 	<c:forEach var="file" items="${boardfileBean }">
				<c:if test="${file.board_file_idx != null}">
					<img src="${root }/upload/${file.file_path}" width="100%"
						style="border-radius: 5px;" class="mt-3" />
				</c:if> 
			</c:forEach>  --%>   
				    <%-- 이미지 파일 캐러셀 --%>
				    <div id="carouselExample" class="carousel slide" data-bs-ride="carousel">
				        <div class="carousel-inner">
				            <c:forEach var="file" items="${boardfileBean}" varStatus="loop">
				                <c:if test="${file.board_file_idx != null}">
				                    <c:set var="extension" value="${fn:substringAfter(file.file_name, '.')}"/> 
			                        <c:if test="${extension eq 'jpg' or extension eq 'jpeg' or extension eq 'png' or extension eq 'bmp' or extension eq 'tiff' or extension eq 'tif' or extension eq 'svg'}">     <div class="carousel-item ${loop.index == 0 ? 'active' : ''}">
			                                <img src="${root}/upload/${file.file_path}" class="d-block w-100" style="height: 500px; border-radius: 5px;" alt="pic">
			                            </div>
			                        </c:if> 
				                </c:if>
				            </c:forEach>
				        </div>
				        <button class="carousel-control-prev" type="button" data-bs-target="#carouselExample" data-bs-slide="prev">
				            <span class="carousel-control-prev-icon" aria-hidden="true"></span>
				            <span class="visually-hidden">Previous</span>
				        </button>
				        <button class="carousel-control-next" type="button" data-bs-target="#carouselExample" data-bs-slide="next">
				            <span class="carousel-control-next-icon" aria-hidden="true"></span>
				            <span class="visually-hidden">Next</span>
				        </button>
				    </div>
				
				    <%-- 첨부된 파일 목록 --%>
				    <c:forEach var="file" items="${boardfileBean}" varStatus="loop">
				        <c:if test="${file.board_file_idx != null}"> 
		                   <div>
		                        파일: ${loop.index+1} &nbsp;
		                        <a href="<c:url value='/resources/upload/${file.file_path}' />" download="${file.file_name}"><i class="bi bi-download"></i>
		                            <span class="glyphicon glyphicon-save" aria-hidden="true"></span> ${file.file_name}
		                        </a> 
		                        &nbsp; &nbsp; Size: ${file.file_size} KByte
		                    </div>
				        </c:if>
				    </c:forEach>
				</div>

				<hr>  
				<div class="form-group">
					<div class="mb-3 mt-2"><h5>댓글 <i class="bi bi-chat-dots"></i></h5></div>
					<div class="row">
						<div class="col-11">
							<input type="text" class="form-control" id="replyText" placeholder="댓글을 입력해주세요."/>
						</div>
						<div class="col-1">
							<button class="btn btn-dark" id="commentSubmit" >등록</button>
						</div>
					</div>
				</div>  
			<div class="form-group"> 
				<div id="AdminAnswerSection"></div>
				<div id="replySection"></div>
			</div>
			<div class="form-group">
				<div class="text-right">
					<a href="${root }/board/main?index=${boardInfo.content_board_idx}"
						class="btn btn-primary">목록보기</a>
					<c:if
						test="${loginUserBean.user_idx==boardInfo.user_idx }">
						<a href="${root }/board/modify?content_idx=${param.content_idx}"
							class="btn btn-info">수정하기</a>
						<a href="#"
							onclick="confirmDelete('${root}/board/delete?content_idx=${param.content_idx}')"
							class="btn btn-danger">삭제하기</a>
					</c:if>
				</div>
			</div>
		</div>
	</div>
	<c:import url="/WEB-INF/views/include/bottom_info.jsp" />

</body>
</html>
