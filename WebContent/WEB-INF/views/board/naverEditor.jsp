<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<c:set var="root" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html lang="ko">
<head> 
    <meta charset="UTF-8">
    <title>SmartEditor 적용</title>   
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="${root}/resources/se2/js/service/HuskyEZCreator.js"></script>
    <script>
    let oEditors = [];
	smartEditor=function(){
        nhn.husky.EZCreator.createInIFrame({
            oAppRef: oEditors,
            elPlaceHolder: "editor",
            sSkinURI: "${root}/resources/se2/SmartEditor2Skin.html",
            fCreator: "createSEditor2" 
        })
    }
    $(document).ready(function() {
    	
    		smartEditor();
            function submitContents(elClickedObj) {
                oEditors.getById["editor"].exec("UPDATE_CONTENTS_FIELD", []); // 에디터의 내용이 textarea에 적용됩니다.
                // 에디터의 내용을 출력합니다.
                alert(document.getElementById("editor").value);
            }

            // 전송 버튼 클릭 이벤트 핸들러 추가
            $('#submit').on('click', function() {
                submitContents(this);
            }); 
        });
    </script>
     
</head>
<body>   
    <c:import url="/WEB-INF/views/include/top_menu.jsp" />
	<div class="container" style="margin-top: 100px; ">
		<div class="col-sm-6"></div> 
		<div class="col-sm">
			<form:form action="${root }/board/WriteNaverEditorPro" method="post" modelAttribute="naverEditorBean" enctype="multipart/form-data">
				<form:hidden path="board_info_idx" value="${param.index}" />
        		<form:hidden path="user_idx" value="${loginUserBean.user_idx}" /> 
							
				<div class="form-group">
					<label for="naverEditor_subject"><h4>제목</h4></label> 
					<input type="text" id="naverEditor_subject" name="naverEditor_subject"
							class="form-control" placeholder="제목을 입력해 주세요" />
				</div>
				<div class="form-group">
					<label for="uploadFiles"><h4>첨부이미지</h4></label>
					<input type="file" id="naverEditor_file" name="uploadFiles" class="form-control" accept="image/*" multiple  />
				</div>
				<div class="selected-image"></div>
				
				<div class="form-group">
					<label for="editor"><h4>내용</h4></label>
					<textarea id="editor" name="naverEditor_text" placeholder="내용을 입력해주세요" rows="20" style="width:100%;" class="form-control"></textarea> 
				</div>
				<div class="form-group">
					<div class="text-right">
						<button type="submit" class="btn btn-primary" id="submit">작성하기</button>
					</div>
				</div> 
				<div class="col-sm-3"></div> 
			</form:form>
		</div>
	</div>
</body>
</html>
