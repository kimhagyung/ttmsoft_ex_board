<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>테스트 파일</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script> 
<link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.min.js"></script>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.0/font/bootstrap-icons.css">
<script>
	$(function(){
		initDatePicker([$('#strDate'), $('#endDate')]); 
	}); 
	
	function initDatePicker(tag){

		tag.forEach(function(dataPicker){
			$(dataPicker).datepicker({
				showOn: "button",
				buttonImage: "../images/admin/ico/icon_calendar1.png",
				buttonImageOnly: true, // 버튼에 있는 이미지만 표시한다.
				nextText: '다음 달', // next 아이콘의 툴팁.
				prevText: '이전 달', // prev 아이콘의 툴팁.
				stepMonths: 1, // next, prev 버튼을 클릭했을때 얼마나 많은 월을 이동하여 표시하는가. 
				dateFormat: "yy-mm-dd", // 텍스트 필드에 입력되는 날짜 형식.
				showAnim: "slide", //애니메이션을 적용한다.
				showMonthAfterYear: true, // 월, 년순의 셀렉트 박스를 년,월 순으로 바꿔준다. 
				dayNamesMin: ['일','월', '화', '수', '목', '금', '토'], // 요일의 한글 형식.
				monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'] // 월의 한글 형식.
			});
		});		
	}

</script> 
</head>
<body>  
<div class="contents">
	<div class="content_wrap">
		<!-- contents -->
		<div class="well searchDetail">
		   	<table class="table1" >
					<tr>
						<th>접속일자</th>
						<td class="form-inline">
							<input type="text" id="strDate" class="form-control">
							~
							<input type="text" id="endDate" class="form-control">
						</td> 
					</tr>
			</table>
		</div>
	</div>
</div>

</body>
</html>
<!-- 사용하지 않는 파일임  -->