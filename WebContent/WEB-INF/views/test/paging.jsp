<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="root" value="${pageContext.request.contextPath }" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script> 
<script src="https://cdnjs.cloudflare.com/ajax/libs/free-jqgrid/4.15.5/jquery.jqgrid.min.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/free-jqgrid/4.15.5/css/ui.jqgrid.min.css">
<!-- 아 이거 걍 알아서 해주는게 아니라 떠먹여?줘야됨 ㅡㅡ 걍 프로젝트 할 때 쓰셈  -->
<script>
$(function(){ 
	$("#list").jqGrid({
		url : '${root}/test/pagingDo', 
		mtype : 'GET',
		dataType:'Json',
		colNames : [
					'',
					'제목',
					'내용',
					'날짜', 
		],
		colModel : [
					{name:'content_idx', 			index:'${pagingTestAll.content_idx}',		align:"center",			hidden: true},
					{name:'content_subject', 		index:'${pagingTestAll.content_subject}', 	align:"center"},
					{name:'content_text', 			index:'${pagingTestAll.content_text}', 		align:"center"},
					{name:'content_date', 			index:'${pagingTestAll.content_date}', 		align:"center"}, 
		],
		pager: $('#pager'),
		rowNum:10,
		rowList:[10,20,30],
		jsonReader: {
			root : 'rows',
	        total : 'total',
	        page : 'page',
	       repeatitems : false
		},
		viewrecords: true,
		imgpath : '',
		caption : '',	
		autowidth: true,
		height : 'auto',
		shrinkToFit:true,
		multiboxonly : true,
		rownumbers : true,
		loadComplete: function(){	
	        $('#list').jqGrid( 'setGridWidth', $(".contents").width()-30 );
	        $(window).on('resize.jqGrid', function () {
	           $('#list').jqGrid( 'setGridWidth', $(".contents").width()-30 );
	        });  
		}//END loadComplete1
	});	// jqgrid 끝 
});
</script>
<body>
<div class="contents">
	<div class="content_wrap">
		<div id="gridWrapper" class="mTop30">
			<table id="list" class="scroll" cellpadding="0" cellspacing="0"></table>
			<div id="pager" class="scroll"></div>
		</div>
	</div>
</div>
</body>
</html>