<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<c:set var="root" value="${pageContext.request.contextPath }" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.0/umd/popper.min.js"></script>

<script>
	$(function(){ 
		$('#submitModifyUserInfo').click(function(event){
			event.preventDefault(); //폼제출 막음 
			var password=$('#password').val();
			var cofirmpass=$('#confirmPassword').val();  
			$.ajax({
			    url:'${root}/confirmPassword',
			    type:'GET',
			    data: {user_pw:password, user_idx:${loginUserBean.user_idx}},
			    success:function(response){  
			        if(response) { // 비밀번호 확인 성공 시
			            $('form').submit(); // 폼 제출
			        } else {
			            alert('비밀번호가 틀렸습니다.');
			        }
			    } 
			});
		});
		 
	});
</script>
</head>

<body>
	<c:import url="/WEB-INF/views/include/top_menu.jsp" />

	<div class="container" style="margin-top: 100px">
		<div class="row">
			<div class="col-sm-3"></div>
			<div class="col-sm-6">
				<div class="card shadow">
					<div class="card-body">
						<form:form action="${root }/user/modify_pro" method="post"
							modelAttribute="ModicyUserInfo">
							<form:hidden path="user_idx" value="${param.id }" />
							<div class="form-group">
								<label for="user_name">이름</label>
								<form:input type="text" path="user_name" id="user_name"
									name="user_name" class="form-control"
									value="${loginUserBean.user_name }" />
							</div>
							<div class="form-group">
								<label for="user_id">아이디</label>
								<form:input type="text" path="user_id" id="user_id"
									name="user_id" class="form-control"
									value="${loginUserBean.user_id }" />
							</div>
							<div class="form-group">
								<label for="user_pw">비밀번호</label> <input type="password"
									id="password" name="user_pw" class="form-control" />
							</div>  
							<div class="form-group">
								<div class="text-right">
									<button type="submit" id="submitModifyUserInfo"
										class="btn btn-primary">정보수정</button>
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
