 <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%> 
<c:set var="root" value="${pageContext.request.contextPath }" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script> 
<style>
.insert {
   padding: 20px 30px;
   display: block;
   width: 600px;
   margin: 5vh auto;
   height: 90vh;
   border: 1px solid #dbdbdb;
   -webkit-box-sizing: border-box;
   -moz-box-sizing: border-box;
   box-sizing: border-box;
}
.insert .file-list {
    height: 200px;
    overflow: auto;
    border: 1px solid #989898;
    padding: 10px;
}
.insert .file-list .filebox p {
    font-size: 14px;
    margin-top: 10px;
    display: inline-block;
}
.insert .file-list .filebox .delete i{
    color: #ff5353;
    margin-left: 5px;
}
</style>
<script>
	var fileNo = 0;
	var filesArr = new Array();
	
	
	/* 첨부파일 추가 */
	function addFile(obj){
	    var maxFileCnt = 5;   // 첨부파일 최대 개수
	    var attFileCnt = document.querySelectorAll('.filebox').length;    // 기존 추가된 첨부파일 개수
	    var remainFileCnt = maxFileCnt - attFileCnt;    // 추가로 첨부가능한 개수
	    var curFileCnt = obj.files.length;  // 현재 선택된 첨부파일 개수
	
	    // 첨부파일 개수 확인
	    if (curFileCnt > remainFileCnt) {
	        alert("첨부파일은 최대 " + maxFileCnt + "개 까지 첨부 가능합니다.");
	    }
	
	    for (var i = 0; i < Math.min(curFileCnt, remainFileCnt); i++) {
	
	        const file = obj.files[i];
	
	        // 첨부파일 검증
	        if (validation(file)) {
	            // 파일 배열에 담기
	            var reader = new FileReader();
	            reader.onload = function () {
	                filesArr.push(file);
	            };
	            reader.readAsDataURL(file)
	
	            // 목록 추가
	            let htmlData = '';
	            htmlData += '<div id="file' + fileNo + '" class="filebox">';
	            htmlData += '   <p class="name">' + file.name + '</p>';
	            htmlData += '   <a class="delete" onclick="deleteFile(' + fileNo + ');"><i class="bi bi-dash"></i></a>';
	            htmlData += '</div>';
	            $('.file-list').append(htmlData);
	            fileNo++;
	        } else {
	            continue;
	        }
	    }
	    // 초기화
	    document.querySelector("input[type=file]").value = "";
	}
	
	/* 첨부파일 검증 */
	function validation(obj){
	    const fileTypes = ['application/pdf', 'image/gif', 'image/jpeg', 'image/png', 'image/bmp', 'image/tif', 'application/haansofthwp', 'application/x-hwp'];
	    if (obj.name.length > 100) {
	        alert("파일명이 100자 이상인 파일은 제외되었습니다.");
	        return false;
	    } else if (obj.size > (100 * 1024 * 1024)) {
	        alert("최대 파일 용량인 100MB를 초과한 파일은 제외되었습니다.");
	        return false;
	    } else if (obj.name.lastIndexOf('.') == -1) {
	        alert("확장자가 없는 파일은 제외되었습니다.");
	        return false;
	    } else if (!fileTypes.includes(obj.type)) {
	        alert("첨부가 불가능한 파일은 제외되었습니다.");
	        return false;
	    } else {
	        return true;
	    }
	}
	
	/* 첨부파일 삭제 */
	function deleteFile(num) {
	    document.querySelector("#file" + num).remove();
	    filesArr[num].is_delete = true;
	}
	
	/* 폼 전송 */
$(function(){
 	$('#uploadForm').submit(function(event) {
			event.preventDefault(); 
		    // 폼데이터 담기
		    var form = document.querySelector("form");
		    var formData = new FormData(form);
		    for (var i = 0; i < filesArr.length; i++) {
		        // 삭제되지 않은 파일만 폼데이터에 담기
		        if (!filesArr[i].is_delete) {
		            formData.append("uploadFiles", filesArr[i]);
		            console.log("filesArr[i] :",filesArr[i])
		        }
		    }
		
		    $.ajax({
		        url: '${root}/register',
		        method: 'POST',
		        //dataType: 'json',
		        data: formData,   
		        processData: false,  
	            contentType: false,
		        headers: {'cache-control': 'no-cache', 'pragma': 'no-cache'},
		        success: function () {
		            alert("파일업로드 성공");
		        },
		        error: function (xhr, desc, err) {
		            alert('에러가 발생 하였습니다.');
		            console.log(xhr);
	                console.log(desc);
	                console.log(err);
		            return;
		        }
		    })
		});
});
</script>
</head>
<body>
<c:import url="/WEB-INF/views/include/top_menu.jsp" />
<div class="container" style="margin-top: 50px; text-align: center;">
	  <div class="insert">
	    <form method="post" action="${root }/register" enctype="multipart/form-data" id="uploadForm">
	        <input type="file"  id="uploadFiles" name="uploadFiles"  onchange="addFile(this);" multiple />
	        <div class="file-list"></div>
	        <input type="submit" value="제출" />
	    </form>
	</div>
</div> 
 
</body>
</html>


