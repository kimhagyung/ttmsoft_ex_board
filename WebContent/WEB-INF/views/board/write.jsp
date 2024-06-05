<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<c:set var="root" value="${pageContext.request.contextPath }"/> 

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8"> 
</head>
<body> 
<c:import url="/WEB-INF/views/include/top_menu.jsp"/>

	<div class="container" style="margin-top: 100px">
		<div class="row">
			<div class="col-sm-3"></div>
			<div class="col-sm-6">
				<div class="card shadow">
					<div class="card-body"> 
						<form:form action="${root }/board/write_pro" method="post" modelAttribute="boardPostBean" enctype="multipart/form-data">
							<form:hidden path="content_board_idx" value="${param.index}" />
        					<form:hidden path="content_writer_idx" value="${loginUserBean.user_idx}" /> 
							<div class="form-group">
								<label for="board_subject">제목</label> 
									<form:input path="content_subject" type="text" id="board_subject" name="board_subject" class="form-control" placeholder="제목을 입력해 주세요" />
							</div>
							<div class="form-group">
								<label for="board_content">내용</label>
								<form:textarea path="content_text" id="board_content" name="board_content"
									class="form-control" rows="10" style="resize: none"></form:textarea>
							</div>
							<div class="form-group">
								<form:label path="content_file" for="board_file">첨부 이미지</form:label> 
								<input type="file" id="board_file" name="uploadFiles" class="form-control" accept="image/*" multiple  />
							</div>
							  
							
							<div class="form-group">
								<div class="text-right">
									<button type="submit" class="btn btn-primary">작성하기</button>
								</div>
							</div>

						</form:form>
					</div>
				</div>
			</div>
			<div class="col-sm-3"></div>
		</div>
	</div>
 
<c:import url="/WEB-INF/views/include/bottom_info.jsp" />
	
</body>
</html>
