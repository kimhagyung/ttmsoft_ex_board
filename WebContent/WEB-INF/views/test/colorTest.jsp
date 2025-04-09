<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%> 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="root" value="${pageContext.request.contextPath }"/> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ColorTest </title>
</head> 

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script> 
<script src="${root}/resources/js/jquery.mincolors.js"></script>   
<link rel="stylesheet" href="${root}/resources/css/jquery.minicolors.css"> 
<script>
	$(function(){
		$('#bgColor').minicolors({
			animationSpeed: 50,
			animationEasing:'swing',
			changeDelay: 0,
			control:'hue',
			defaultValue:'',
			format:'hex',
			showSpeed: 100,
			hideSpeed: 100,
			inline:false,
			keywords:'',
			letterCase:'lowercase',
			opacity:false,
			position:'bottom left',
			theme:'default',
			swatches: [], 
			change:null,
			hide:null,
			show:null,
		});

	});
</script>
<body>
<h5>배경색상</h5>				
	<div class="left form-inline">
		<input type="text" id="bgColor" name="bgcolor" class="form-control" value="">
	</div>
</body>
</html>