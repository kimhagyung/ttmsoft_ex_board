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
	<!-- 상단메뉴 -->
	<c:import url="/WEB-INF/views/include/top_menu.jsp" />
 
	<div class="container" style="margin-top: 100px">
		<c:forEach var="obj" items="${topMenuList }" varStatus="status">
			<c:if test="${status.index % 2 == 0}">
				<div class="row">
			</c:if>
			<div class="col-lg-6" style="margin-top: 20px">
				<div class="card shadow">
					<div class="card-body">
						<h4 class="card-title">${obj.board_info_name}</h4>
						<table class="table table-hover" id='board_list'>
							<thead>
								<tr>
									<th class="text-center w-25">글번호</th>
									<th>제목</th>
									<th class="text-center w-25 d-none d-xl-table-cell">작성날짜</th>
								</tr>
							</thead>
							<tbody> 
								<c:forEach var="info" items="${MainBoardInfo}">
									<c:if test="${info.content_board_idx == obj.board_info_idx}">  
										<c:if test="${info.is_public==1 }"> 
			                                <tr>
			                                    <td class="text-center">${info.content_idx}</td>
			                                    <td><a href="${root }/board/read?content_idx=${info.content_idx }" >${info.content_subject}</a></td>
			                                    <td class="text-center d-none d-xl-table-cell">${info.content_date}</td>
			                                </tr>
			                            </c:if> 	 
		                            </c:if>	  
								</c:forEach>
							</tbody>
						</table>
						<a href="${root }/board/main?index=${obj.board_info_idx}"
							class="btn btn-primary">더보기</a>
					</div>
				</div>
			</div>
			<c:if test="${status.index % 2 == 1 || status.last}">
		</div>
			</c:if>
	</c:forEach>
</div>



	<!-- 하단메뉴 -->
	<c:import url="/WEB-INF/views/include/bottom_info.jsp" />

</body>
</html>