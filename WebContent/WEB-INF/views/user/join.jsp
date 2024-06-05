<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!--#1  -->
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<c:set var='root' value="${pageContext.request.contextPath }/"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8"> 
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
<script>
	function checkUserIdExist(){
		var user_id = $("#user_id").val()
		console.log("user_id",user_id);
		if(user_id.length == 0){
			alert('아이디를 입력해주세요')
			return
		}//이메일을 입력하지 않았을 때
		
		$.ajax({
			url: '${root}user/checkUserIdExist/' + encodeURIComponent(user_id),
			type : 'get',
			dataType : 'text',
			success: function(result){
				if(result.trim()=='true'){
					alert('사용할 수 있는 아이디입니다.')
					$("#userIdExist").val('true')
				}else if(result.trim()=='false'){
					alert('사용할 수 없는 아이디입니다.')
					$("#userIdExist").val('false')
				}
			}
		})
	}
	function resetUserIdExist(){
		
		$("#userIdExist").val('false')
		
	}//사용자 아이디란에 입력 시 UserIdExist의 값을 false 주입ㄴ

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
				<form:form action="${root }user/join_pro" method='post' modelAttribute="joinUserBean"> 
				<form:hidden path="userIdExist"/>
					<div class="form-group">
						<form:label path="user_name">이름</form:label>
						<form:input path="user_name" placeholder="이름을 입력해 주세요" class='form-control' />  
					</div>
					<div class="form-group">
						<form:label path="user_id">아이디</form:label>
						<div class="input-group">
							<form:input path="user_id" class='form-control' placeholder="아이디를 입력해 주세요" onkeypress="resetUserIdExist()" /> 
							<div class="input-group-append">
								<button type="button" class="btn btn-primary" onclick='checkUserIdExist()'>중복확인</button>
							</div>	
						</div>
						<form:errors path="user_id" style='color:red' />  
					</div>

					<div class="form-group">
						<form:label path="user_pw">비밀번호</form:label>
						<form:password path="user_pw" placeholder="비밀번호를 입력해 주세요" class='form-control' id="password" onkeyup="checkPasswordMatch()" /> 
						<form:errors path='user_pw' style='color:red' /> 
					</div>
 
					<div class="form-group">
						<form:label path="user_pw2">비밀번호 확인</form:label>
						<form:password path="user_pw2" class='form-control' id="confirmPassword" placeholder="비밀번호를 다시 입력해 주세요"  onkeyup="checkPasswordMatch()" />
						<div class="invalid-feedback">비밀번호가 일치하지 않습니다.</div>
					</div>
					<div id="message"></div>
					
					<div class="form-group">
						<div class="text-right">
							<form:button class='btn btn-primary'>회원가입</form:button>
						</div>
					</div>
				</form:form>
				
				</div>
			</div>
		</div>
		<div class="col-sm-3"></div>
	</div>
</div>

<!-- 하단 부분 -->
<c:import url="WEB-INF/views/include/bottom_info" />

</body>
</html>