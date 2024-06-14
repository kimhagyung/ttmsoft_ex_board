<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%> 
<c:set var="root" value="${pageContext.request.contextPath }"/> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">  
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="${root}/resources/se2/js/service/HuskyEZCreator.js"></script>
<script>board_file
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
            oEditors.getById["editor"].exec("UPDATE_CONTENTS_FIELD", []); // 에디터의 내용이 html형식으로 저장되도록 하는거??.
            // 에디터의 내용을 출력합니다.
            //alert(document.getElementById("editor").value);
        } 
        // 전송 버튼 클릭 이벤트 핸들러 추가
        $('#submit').on('click', function() {
            submitContents(this);
        }); 
    });
</script>  
<script>
$(function() {
    $('#board_file').on('change', function (event) {
        const selectedImageDiv = $('.selected-image');

        // Count only images, not remove buttons
        if (selectedImageDiv.find('.selected-image-item:not(.remove-button)').length >= 3) {
            alert('최대 5개의 이미지까지만 선택할 수 있습니다.');
            return;
        }

        const files = event.target.files;

        for (const file of files) {
            const reader = new FileReader();

            reader.onload = function (e) {
                const img = $('<img>').attr('src', e.target.result).addClass('selected-image-item');
                selectedImageDiv.append(img);

                const removeButton = $('<button>').text('삭제').addClass('remove-button');
                removeButton.on('click', function () {
                    img.remove();
                    removeButton.remove();
                });

                img.after(removeButton);
            };

            reader.readAsDataURL(file);
        }
    });
});
</script>
<style>
.selected-image-item{
	width:200px;
	height:200px;
}
</style>
</head>
<body> 
<c:import url="/WEB-INF/views/include/top_menu.jsp"/> 
    <div class="container" style="margin-top: 100px"> 
        <div class="col-sm-3"></div>
        <div class="col-sm"> 
            <form action="${root }/board/write_pro" method="post" enctype="multipart/form-data">
                <input type="hidden" name="content_board_idx" value="${param.index}" />
                <input type="hidden" name="user_idx" value="${loginUserBean.user_idx}" /> 
                <div class="form-group">
                    <label for="board_subject"><h4>제목</h4></label> 
                    <input name="content_subject" type="text" id="board_subject" name="board_subject" class="form-control" placeholder="제목을 입력해 주세요" />
                </div>    
                <c:if test="${boardAllInfo.is_public==0 }">
	                <div class="form-group">
	                <label for="public"><h4>공개여부</h4></label><br>
	                	<div class="form-check form-check-inline">
						  <input class="form-check-input" type="radio" name="is_public" id="public1" value="1" checked>
						  <label class="form-check-label" for="public1">공개</label>
						</div>
						<div class="form-check form-check-inline">
						  <input class="form-check-input" type="radio" name="is_public" id="public2" value="0">
						  <label class="form-check-label" for="public2">비공개</label>
						</div>
	                </div>
                </c:if>
                <div class="form-group">
                    <label for="editor"><h4>내용</h4></label>
                    <textarea id="editor" name="content_text" placeholder="내용을 입력해주세요" rows="10" style="resize: none" class="form-control"></textarea> 
                </div>
                <c:if test="${boardAllInfo.file_checked==1 }">
	                <div class="form-group">
	                    <input type="file" id="board_file" name="uploadFiles" style="display: none;" class="form-control" accept="image/*" multiple />
	                    <label for="board_file"><h5>첨부 이미지<i class="bi bi-camera-fill mx-2"></i></h5></label> 
	                    <div class="selected-image"></div>
	                </div>     
                </c:if>                        
                <div class="form-group">
                    <div class="text-right">
                        <button type="submit" id="submit" class="btn btn-primary">작성하기</button>
                    </div>
                </div>                  
                <div class="col-sm-3"></div> 
            </form>
        </div>
    </div> 
<c:import url="/WEB-INF/views/include/bottom_info.jsp" />
</body>
</html>