<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<c:set var="root" value="${pageContext.request.contextPath }"/> 

<!DOCTYPE html>
<html>
<head> 
</head>
<body>
<c:import url="/WEB-INF/views/include/top_menu.jsp"/>

	<div class="container" style="margin-top: 100px">
		<div class="row">
			<div class="col-sm-3"></div>
			<div class="col-sm-6">
				<div class="card shadow">
					<div class="card-body"> 
						<form:form action="${root }/board/modify_pro" method="post" modelAttribute="modifyPostBean" enctype="multipart/form-data" >
							<form:hidden path="content_idx" value="${param.content_idx }"/>
							<div class="form-group">
								<label for="board_writer_name">작성자</label> 
								<input type="text" id="board_writer_name" name="board_writer_name" class="form-control" value="${boardWriterName }" disabled="disabled" />
							</div>
							<div class="form-group">
								<label for="board_date">작성날짜</label> 
								<input type="text" id="board_date" name="board_date" class="form-control" value="${boardInfo.content_date }" disabled="disabled" />
							</div>
							<div class="form-group">
								<label for="board_subject">제목</label> 
								<form:input path="content_subject" type="text" id="board_subject" name="board_subject" class="form-control" value="${boardInfo.content_subject }" />
							</div>
							<div class="form-group">
							    <label for="board_content">내용</label>
							    <textarea id="board_content" name="content_text" class="form-control" rows="10" style="resize: none">${boardInfo.content_text }</textarea>
							</div>
							<div class="form-group">
								<form:label path="content_file" for="board_file">첨부 이미지</form:label> 
								<input type="file" id="board_file" name="uploadFiles" class="form-control" accept="image/*" multiple  />
							</div>
							<div class="form-group">
								<div class="text-right">
									<form:button type="submit" class="btn btn-primary">수정완료</form:button> 
									<a href="${root }/board/read?content_idx=${param.content_idx}" class="btn btn-info">취소</a> 
								</div>
							</div>
						</form:form>
					</div>
				</div>
			</div>
			<div class="col-sm-3"></div>
		</div>
	</div>

<!-- #3-4_2 하단 메뉴 부분 지우고, bottom_info.jsp import -->
<!-- 하단 메뉴 부분 -->
<c:import url="/WEB-INF/views/include/bottom_info.jsp" />

</body>
</html>
