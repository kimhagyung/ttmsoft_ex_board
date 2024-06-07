<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var='root' value='${pageContext.request.contextPath }/' />

<!-- Bootstrap CDN -->
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.0/umd/popper.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1"> 
<nav
	class="navbar navbar-expand-md bg-dark navbar-dark fixed-top shadow-lg">
	<a class="navbar-brand" href="${root }index">TTMSoft</a>
	<button class="navbar-toggler" type="button" data-toggle="collapse"
		data-target="#navMenu">
		<span class="navbar-toggler-icon"></span>
	</button>
 
	<div class="collapse navbar-collapse" id="navMenu">
		<ul class="navbar-nav">
			<c:forEach var='obj' items='${topMenuList }'>
				<li class="nav-item"><a
					href="${root }board/main?index=${obj.board_info_idx }" class="nav-link">${obj.board_info_name }</a>
				</li>
			</c:forEach>
		</ul>
		<c:choose>
			<c:when test="${loginUserBean.userLogin==false }">

				<ul class="navbar-nav ml-auto">
					<li class="nav-item"><a href="${root }user/login"
						class="nav-link">로그인</a></li>
					<li class="nav-item"><a href="${root }user/join"
						class="nav-link">회원가입</a></li>  
				</ul>
			</c:when>
			<c:when test="${loginUserBean.userLogin==true }">
				<ul class="navbar-nav ml-auto"> 
					<li class="nav-item"><a href="${root }user/modify?id=${loginUserBean.user_idx}"
						class="nav-link">정보수정</a></li>
					<li class="nav-item"><a href="${root }user/logout"
						class="nav-link">로그아웃</a></li>
				</ul>
			</c:when>
		</c:choose>
	</div>
</nav>