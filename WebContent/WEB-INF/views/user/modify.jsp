<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<c:set var="root" value="${pageContext.request.contextPath }"/> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1"> 
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.0/umd/popper.min.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script> 
	$(function() { 
	    // 비밀번호 일치 여부 확인
	    $('#password, #confirmPassword').on('keyup', function() {
	        var password = $('#password').val();
	        var confirmPassword = $('#confirmPassword').val();
	        var message = $('#message');
	
	        // 사용자가 입력한 password 값이 비어있거나 confirmPassword 값이 비어있으면 메시지를 표시하지 않음
	        if (!password || !confirmPassword) {
	            message.html('');
	            return;
	        }
	
	        if (password === confirmPassword) {
	            message.html('비밀번호가 일치합니다.').css('color', 'green');
	        } else {
	            message.html('비밀번호가 일치하지 않습니다.').css('color', 'red');
	        }
	    });
	}); 
	function checkPasswordMatch() {
	    var password = $("#password").val();
	    var confirmPassword = $("#confirmPassword").val();
	
	    if (password != confirmPassword) {
	        $("#confirmPassword")[0].setCustomValidity("비밀번호가 일치하지 않습니다.");
	    } else {
	        $("#confirmPassword")[0].setCustomValidity("");
	    }
	}
</script>
</head>

<body> 
<c:import url="/WEB-INF/views/include/top_menu.jsp"/>

<div class="container" style="margin-top:100px">
	<div class="row">
		<div class="col-sm-3"></div>
		<div class="col-sm-6">
			<div class="card shadow">
				<div class="card-body">
					<form:form action="${root }/user/modify_pro" method="post" modelAttribute="ModicyUserInfo">
					<form:hidden path="user_idx" value="${param.id }"/>
					<div class="form-group">
						<label for="user_name">이름</label>
						<form:input type="text" path="user_name" id="user_name" name="user_name" class="form-control" value="${loginUserBean.user_name }"/>
					</div>
					<div class="form-group">
						<label for="user_id">아이디</label>
						<form:input type="text" path="user_id" id="user_id" name="user_id" class="form-control" value="${loginUserBean.user_id }"/>
					</div>
					<div class="form-group">
						<label for="user_pw">비밀번호</label>
						<input type="password" id="password" name="user_pw" class="form-control"/>
					</div>
					<div class="form-group">
						<label for="user_pw2">비밀번호 확인</label>
						<input type="password" id="confirmPassword" name="user_pw2" class="form-control"/>
					</div>
					<div id="message"></div>
					<div class="form-group">
						<div class="text-right">
							<button type="submit" class="btn btn-primary">정보수정</button>
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
    