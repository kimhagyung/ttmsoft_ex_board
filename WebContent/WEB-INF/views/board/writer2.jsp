<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<c:set var="root" value="${pageContext.request.contextPath }"/>
<!DOCTYPE html>
<html lang="ko">
<head> 
    <meta charset="UTF-8">
    <title>SmartEditor 적용</title>  
	<script src="<c:url value='${root }/resources/smarteditor/js/HuskyEZCreator.js'/>"></script>
    <script>
	    var oEditors = [];
	    nhn.husky.EZCreator.createInIFrame({
	        oAppRef: oEditors,
	        elPlaceHolder: "editor",
	        sSkinURI: "${root}/resources/smarteditor/SmartEditor2Skin.html",
	        fCreator: "createSEditor2"
	    });

        function submitContents(elClickedObj) {
            oEditors.getById["editor"].exec("UPDATE_CONTENTS_FIELD", []); // 에디터의 내용이 textarea에 적용됩니다.
            // 에디터의 내용을 출력합니다.
            alert(document.getElementById("editor").value);
        }
    </script>
</head>
<body> 
    <h3>Naver Smart Editor 2.0</h3> 
        <textarea name="editor" id="editor" rows="10" cols="100"></textarea>
        <input type="button" value="전송" onclick="submitContents(this)">
    </form> 
</body>
</html>
