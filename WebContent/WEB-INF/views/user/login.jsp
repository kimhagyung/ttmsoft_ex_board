<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<c:set var="root" value="${pageContext.request.contextPath }" />

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
</head>
<body>
	<!-- 상단 메뉴 부분 -->
	<c:import url="/WEB-INF/views/include/top_menu.jsp" />

	<div class="container" style="margin-top: 100px">
		<div class="row">
			<div class="col-sm-3"></div>
			<div class="col-sm-6">
				<div class="card shadow">
					<div class="card-body">
						<c:if test="${fail==true }">
							<div class="alert alert-danger">
								<h3>로그인 실패</h3>
								<p>아이디 비밀번호를 확인해주세요</p>
							</div>
						</c:if>
						<form:form action="${root }/user/login_pro" method="post"
							modelAttribute="LoginUserBean">
							<div class="form-group">
								<label for="user_id">아이디(rlagkrud90)</label>
								<form:input path="user_id" type="text" id="user_id"
									name="user_id" class="form-control" />
							</div>
							<div class="form-group">
								<label for="user_pw">비밀번호(gkrud98657)</label>
								<form:input path="user_pw" type="password" id="user_pw"
									name="user_pw" class="form-control" />
							</div>
							<div class="form-group text-right">
								<form:button type="submit" class="btn btn-primary">로그인</form:button>
								<a href="${root }/user/join" class="btn btn-danger">회원가입</a>
							</div>
						</form:form>
					</div>
				</div>
			</div>
			<div class="col-sm-3"></div>
		</div>
	</div>

	<!-- 하단 메뉴 부분 -->
	<c:import url="/WEB-INF/views/include/bottom_info.jsp" />

</body>
</html>








