<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<c:set var="root" value="${pageContext.request.contextPath }"/> 

<!DOCTYPE html>
<html>
<head> 
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
            //alert(document.getElementById("editor").value);
        } 
        // 전송 버튼 클릭 이벤트 핸들러 추가
        $('#submit').on('click', function() {
            submitContents(this);
        }); 
    });
</script>  
<script>
	$(function(){
		$('#board_file').on('change', function(event){
			const selectedImageDiv=$('.selected-image')
			const receviedImagDiv=$('.recevied-img')  
			
			receviedImagDiv.remove(); //새로운 파일 선택 시 기존에 받아온 이미지 삭제 
			selectedImageDiv.empty();
			
			const files=event.target.files;
			
			 for (const file of files) {
		            const reader = new FileReader();

		            reader.onload = function (e) {
		                const img = $('<img>').attr('src', e.target.result).addClass('selected-image-item');
		                selectedImageDiv.append(img); 
		            }; 
		            reader.readAsDataURL(file);
		      }
		})
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
			<div class="col-sm-6"></div> 
			<div class="col-sm"> 
						<form:form action="${root }/board/modify_pro" method="post" modelAttribute="modifyPostBean" enctype="multipart/form-data" >
							<form:hidden path="content_idx" value="${param.content_idx }"/>
							<form:hidden path="existingFile" value="${boardInfo.content_file }"/>
							<div class="form-group">
								<label for="board_writer_name"><h4>작성자</h4></label> 
								<input type="text" id="board_writer_name" name="board_writer_name" class="form-control" value="${boardWriterName }" disabled="disabled" />
							</div>
							<div class="form-group">
								<label for="board_date"><h4>작성날짜</h4></label> 
								<input type="text" id="board_date" name="board_date" class="form-control" value="${boardInfo.content_date }" disabled="disabled" />
							</div>
							<div class="form-group">
								<label for="board_subject"><h4>제목</h4></label> 
								<form:input path="content_subject" type="text" id="board_subject" name="board_subject" class="form-control" value="${boardInfo.content_subject }" />
							</div>
							<div class="form-group">
			                <label for="public"><h4>공개여부</h4></label><br>
			                	<input type="radio" name="is_public" value="1" id="public" checked/>공개
			                	<input type="radio" name="is_public" value="0" id="public"/>비공개
			                </div>
							<div class="form-group">
							    <label for="board_content">내용</label>
							    <textarea id="editor" name="content_text" class="form-control" rows="10" style="resize: none">${boardInfo.content_text }</textarea>
							</div>
							<div class="form-group">
							<input type="file" id="board_file" name="uploadFiles" style="display:none;" class="form-control" accept="image/*"  multiple  />
								<form:label path="content_file" for="board_file">첨부 이미지<i class="bi bi-camera-fill mx-2"></i> </form:label>
								<c:if test="${boardInfo.content_file !=null}">
									<div>
									 	<img src="${root }/upload/${boardInfo.content_file}" alt="Uploaded Image" class="recevied-img" style="width:200px; height:200px;" />
									</div> 
								</c:if> 
								<div class="selected-image"></div> 
								
							</div> 
							<div class="form-group">
								<div class="text-right">
									<form:button type="submit" id="submit" class="btn btn-primary">수정완료</form:button> 
									<a href="${root }/board/read?content_idx=${param.content_idx}" class="btn btn-info">취소</a> 
								</div>
							</div> 
							<div class="col-sm-3"></div>
						</form:form>
					</div>
				</div> 
 
<c:import url="/WEB-INF/views/include/bottom_info.jsp" />

</body>
</html>
