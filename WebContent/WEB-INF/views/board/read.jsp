<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="root" value="${pageContext.request.contextPath }"/> 
<!DOCTYPE html>
<html>
<head> 
<title>미니 프로젝트</title> 
</head>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script> 
	function confirmDelete(deletUrl){
		if(confirm("삭제하시겠습니까??")){
			window.location.href=deletUrl; 
		}
	} 
</script>
<body> 
<c:import url="/WEB-INF/views/include/top_menu.jsp"/> 
<div class="container" style="margin-top:100px">
	<div class="row">
		<div class="col-sm-3"></div>
		<div class="col-sm-6">
			<div class="card shadow">
				<div class="card-body">
					<div class="form-group">
						<label for="board_writer_name">작성자</label>
						<input type="text" id="board_writer_name" name="board_writer_name" class="form-control" value="${boardWriterName }" disabled="disabled"/>
					</div>
					<div class="form-group">
						<label for="board_date">작성날짜</label>
						<input type="text" id="board_date" name="board_date" class="form-control" value="${boardInfo.content_date }" disabled="disabled"/>
					</div>
					<div class="form-group">
						<label for="board_subject">제목</label>
						<input type="text" id="board_subject" name="board_subject" class="form-control" value="${boardInfo.content_subject }" disabled="disabled"/>
					</div>
					<div class="form-group">
						<label for="board_content">내용</label>
						<textarea id="board_content" name="board_content" class="form-control" rows="10" style="resize:none" disabled="disabled">${boardInfo.content_text }</textarea>
					</div> 
					<div class="form-group"> 
						<c:if test="${boardInfo.content_file != null}">
							<img src="${root }/upload/${boardInfo.content_file}" width="100%"/> 			
						</c:if>
					</div>
					<div class="form-group">
						<div class="text-right"> 
							<a href="${root }/board/main?index=${boardInfo.content_board_idx}" class="btn btn-primary">목록보기</a> 
							<a href="${root }/board/modify?content_idx=${param.content_idx}" class="btn btn-info">수정하기</a> 
							<a href="#" onclick="confirmDelete('${root}/board/delete?content_idx=${param.content_idx}')" class="btn btn-danger">삭제하기</a>
						</div>
					</div>
				</div>
			</div>
		</div>
		<div class="col-sm-3"></div>
	</div>
</div> 
<c:import url="/WEB-INF/views/include/bottom_info.jsp" />

</body>
</html>
