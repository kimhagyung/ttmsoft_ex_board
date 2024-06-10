<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="root" value="${pageContext.request.contextPath }" />
<!DOCTYPE html>
<!-- <html xmlns:th="http://www.thymeleaf.org"> thymeleaf 선언 -->
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
	$("#commentSubmit").click(function(){
		var replyText = $('#replyText').val();  
		if(replyText.trim() == ''){
			alert("댓글을 입력해 주세요");
			return;
		}
		
		if(${loginUserBean.userLogin==false}){
			alert("로그인 해주세요"); 
			location.href='${root}/user/login' 
		}
		
		console.log("입력한 댓글:", replyText); 
		console.log("게시글 번호:", ${param.content_idx}); 
		console.log("현재 로그인 idx:", ${loginUserBean.user_idx}); 
		
		
		$.ajax({
			url:'${root}/comment',
			type:'POST',
			contentType: 'application/json',
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
                alert('댓글이 성공적으로 추가되었습니다.'); // 이거는 삭제하던가 ㅅ하셈 
                
             // 댓글 목록 조회
                updateReplyList();
			},
			error:function(error){
				console.log(error);
				alert('댓글 추가에 실패했습니다.')
			}
		})
	});
});
</script>

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
				<c:if test="${boardInfo.content_file != null}">
					<img src="${root }/upload/${boardInfo.content_file}" width="100%"
						style="border-radius: 5px;" class="mt-3" />
				</c:if>
			</div>
			<hr>
			<div class="form-group">
				<div class="mb-3 mt-2"><h5>댓글 <i class="bi bi-chat-dots"></i></h5></div>
				<div class="row">
					<div class="col-11">
						<input type="text" class="form-control" id="replyText" placeholder="댓글을 입력해주세요."/>
					</div>
					<div class="col-1">
						<button class="btn btn-dark" id="commentSubmit">등록</button>
					</div>
				</div>
			</div>
			<div class="form-group">
				<div id="replySection"></div>
			</div>
			<div class="form-group">
				<div class="text-right">
					<a href="${root }/board/main?index=${boardInfo.content_board_idx}"
						class="btn btn-primary">목록보기</a>
					<c:if
						test="${loginUserBean.user_idx==boardInfo.content_writer_idx }">
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
