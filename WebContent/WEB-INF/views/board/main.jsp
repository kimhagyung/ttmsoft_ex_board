<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="root" value="${pageContext.request.contextPath }" />
<!DOCTYPE html>
<html>
<head>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script> 
	function SecretWrite(){
		alert("접근할 수 없는 글입니다")
	}
 
	function confirm(is_public){
		console.log(("공개(1)?비공개(0)?" ,is_public));
	}
</script>
</head>
<body> 
<c:import url="/WEB-INF/views/include/top_menu.jsp" />

	<!-- 게시글 리스트 -->
<div class="container" style="margin-top: 100px">
	<div class="card shadow">
		<div class="card-body">
				<h4 class="card-title">${boardAllInfo.board_info_name}</h4>
			<hr>
			<div style="font-size:15px;">${boardAllInfo.board_explanation }</div>
			<table class="table table-hover mt-2" id='board_list'>
				<thead>
					<tr>
						<th class="text-center d-none d-md-table-cell">글번호</th>
						<th class="w-50">제목</th>
						<th class="text-center d-none d-md-table-cell">작성자</th>
						<th class="text-center d-none d-md-table-cell">작성날짜</th>
					</tr>
				</thead> 
				<tbody>
					<c:forEach var="obj" items="${MainBoardInfo }" varStatus="loop"> 
						<c:if test="${param.index == obj.content_board_idx}">  
							<c:if test="${obj.is_deleted=='N' }"> 
									<tr>
										<td class="text-center d-none d-md-table-cell">${obj.content_idx }</td>
										<td>
											<c:choose>
											    <c:when test="${obj.content_is_public == 1}">
											        <a href="${root}/board/read?content_idx=${obj.content_idx}" onclick="confirm(${obj.content_is_public})">${obj.content_subject}</a>
											    </c:when>
											    <c:when test="${obj.content_is_public == 0}">
											        <c:choose> 
											            <c:when test="${loginUserBean.user_idx == obj.user_idx or loginAdminBean.admin_login==true}">
											                <a href="${root}/board/read?content_idx=${obj.content_idx}">${obj.content_subject}</a>
											            </c:when>
											            <c:when test="${empty loginUserBean.user_idx or loginUserBean.user_idx != obj.user_idx}">
											                <a href="${root}/board/read?content_idx=${obj.content_idx}" onclick="SecretWrite(); return false;">${obj.content_subject}</a>
											            </c:when>
											        </c:choose>
											    </c:when>
											</c:choose> 
										</td>
										<td class="text-center d-none d-md-table-cell">${boardWriterName[loop.index] }</td>
										<td class="text-center d-none d-md-table-cell">${obj.content_date }</td>
									</tr>
								</c:if>
							</c:if>  
					</c:forEach>
				</tbody>
			</table>
			
			<!-- 페이징 처리-->
			<div class="d-none d-md-block">
				<ul class="pagination justify-content-center">
					<c:choose>
						<c:when test="${pageBean.prevPage <= 0 }">
							<li class="page-item disabled"><a href="#"
								class="page-link">이전</a></li>
						</c:when>
						<c:otherwise>
							<li class="page-item"><a
								href="${root }/board/main?index=${param.index }&page=${pageBean.prevPage}"
								class="page-link">이전</a></li>
						</c:otherwise>
					</c:choose>

					<c:forEach var="idx" begin="${pageBean.min }"
						end="${pageBean.max }">
						<c:choose>
							<c:when test="${idx==pageBean.currentPage }">
								<li class="page-item active">
									<!-- 현재페이지 활성화 --> <a
									href="${root }/board/main?index=${param.index }&page=${idx}"
									class="page-link"> ${idx } </a>
								</li>
							</c:when>
							<c:otherwise>
								<li class="page-item"><a
									href="${root }/board/main?index=${param.index }&page=${idx}"
									class="page-link"> ${idx } </a></li>
							</c:otherwise>
						</c:choose>
					</c:forEach>

					<c:choose>
						<c:when test="${pageBean.max >= pageBean.pageCnt }">
							<li class="page-item disabled"><a href="#"
								class="page-link">다음</a></li>
						</c:when>
						<c:otherwise>
							<li class="page-item"><a
								href="${root }/board/main?index=${param.index }&page=${pageBean.nextPage}"
								class="page-link">다음</a></li>
						</c:otherwise>
					</c:choose>

				</ul>
			</div>

			<div class="d-block d-md-none">
				<ul class="pagination justify-content-center">
					<li class="page-item"><a href="#" class="page-link">이전</a></li>
					<li class="page-item"><a href="#" class="page-link">다음</a></li>
				</ul>
			</div> 
			<div class="text-right">
			 <a href="${root }/board/write?index=${param.index}"
					class="btn btn-primary">글쓰기</a> 
			<!--	<a href="${root }/board/naverEditor?index=${param.index}"
					class="btn btn-primary">글쓰기</a>-->
			</div> 
		</div>
	</div>
</div>
 
	<c:import url="/WEB-INF/views/include/bottom_info.jsp" />
 
</body>


</html>