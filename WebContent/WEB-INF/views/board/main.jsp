<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<c:set var="root" value="${pageContext.request.contextPath }" />

<!DOCTYPE html>
<html>
<head>
<title>미니 프로젝트</title>
</head>
<body>

	<!-- #3-1_1 상단메뉴 지우고, top_menu.jsp import -->
	<!-- 상단 메뉴 부분 -->
	<c:import url="/WEB-INF/views/include/top_menu.jsp" />

	<!-- 게시글 리스트 -->
	<div class="container" style="margin-top: 100px">
		<div class="card shadow">
			<div class="card-body">
				<h4 class="card-title">${topMenuList[param.index-1].board_info_name }</h4>
				<table class="table table-hover" id='board_list'>
					<thead>
						<tr>
							<th class="text-center d-none d-md-table-cell">글번호</th>
							<th class="w-50">제목</th>
							<th class="text-center d-none d-md-table-cell">작성자</th>
							<th class="text-center d-none d-md-table-cell">작성날짜</th>
						</tr>
					</thead>
					
					<tbody>
						<c:forEach var="obj" items="${MainBoardInfo }" varStatus="loop" >
							<c:if test="${param.index == obj.content_board_idx}">
								<tr>
									<td class="text-center d-none d-md-table-cell">${obj.content_idx }</td>
									<td>
										<a href="${root }/board/read?content_idx=${obj.content_idx}">${obj.content_subject }</a>
									</td>
									<td class="text-center d-none d-md-table-cell">${boardWriterName[loop.index] }</td>
									<td class="text-center d-none d-md-table-cell">${obj.content_date }</td>
								</tr>
							</c:if> 
						</c:forEach>
					</tbody>
				</table>

				<div class="d-none d-md-block">
					<ul class="pagination justify-content-center">
						<li class="page-item"><a href="#" class="page-link">이전</a></li>
						<li class="page-item"><a href="#" class="page-link">1</a></li>
						<li class="page-item"><a href="#" class="page-link">2</a></li>
						<li class="page-item"><a href="#" class="page-link">3</a></li>
						<li class="page-item"><a href="#" class="page-link">4</a></li>
						<li class="page-item"><a href="#" class="page-link">5</a></li>
						<li class="page-item"><a href="#" class="page-link">6</a></li>
						<li class="page-item"><a href="#" class="page-link">7</a></li>
						<li class="page-item"><a href="#" class="page-link">8</a></li>
						<li class="page-item"><a href="#" class="page-link">9</a></li>
						<li class="page-item"><a href="#" class="page-link">10</a></li>
						<li class="page-item"><a href="#" class="page-link">다음</a></li>
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
				</div>

			</div>
		</div>
	</div>

	<!-- #3-1_2 하단 메뉴 부분 지우고, bottom_info.jsp import -->
	<!-- 하단 메뉴 부분 -->
	<c:import url="/WEB-INF/views/include/bottom_info.jsp" />

</body>
</html>