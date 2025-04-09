<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="root" value="${pageContext.request.contextPath }" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="${root}/resources/ckeditor/ckeditor.js"></script>
<script> 
  $(document).ready(function(){
    CKEDITOR.replace('editor1');
  });
</script>
</head>
<body> 
<textarea name="editor1" id="editor1" rows="10" cols="40"> 
</textarea>
</body>
</html>