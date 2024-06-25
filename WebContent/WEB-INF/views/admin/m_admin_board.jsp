<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="root" value="${pageContext.request.contextPath }" />
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">
<link href="${root}/resources/vendor/fontawesome-free/css/all.min.css"
	rel="stylesheet" type="text/css">
<link
	href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
	rel="stylesheet">
<link href="${root}/resources/css/sb-admin-2.min.css" rel="stylesheet">
<link
	href="${root}/resources/vendor/datatables/dataTables.bootstrap4.min.css"
	rel="stylesheet">
<!-- 
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script
	src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script> -->
<!-- <link
	href="https://maxcdn.bootstrapcdn.com/bootstrap/5.1.3/css/bootstrap.min.css"
	rel="stylesheet"> -->
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p"
	crossorigin="anonymous"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.0/font/bootstrap-icons.css">


<script>
	$(function() {
		$('#CheckFile').change(
			function() {
				var isChecked = $(this).is(":checked"); //파일첨부 기능 체크 여부 
				$("#inputState, #fileSizeInput, .CheckExt").prop("disabled", !isChecked); //체크했으면 확장자 선택과 첨부파일 수, 첨부파일 사이즈 활성화 
			});
		$('#allcheck').change(function() { //전체 선택 버튼 
			var isChecked = $(this).is(":checked");
			$(".CheckExt").prop("checked", isChecked);
		});
	});
</script>
<script>
	$(function(){  
        // 초기 로드 시 파일 확장자 체크박스들 초기화 
         <c:forEach var="boardinfo" items="${CreateBoard}">
             // 값 콘솔에 출력
             //console.log("board_info_idx: ${boardinfo.board_info_idx}, file_ext: ${boardinfo.file_ext}, ${boardinfo.is_public}");

             var fileExts_${boardinfo.board_info_idx} = "${boardinfo.file_ext}".split(',');

             fileExts_${boardinfo.board_info_idx}.forEach(function(ext) {
                 $('.CheckExt2_${boardinfo.board_info_idx}[value="' + ext + '"]').prop('checked', true);
             });

             // 전체 선택 체크박스의 동작 설정
             $('#allcheck2_${boardinfo.board_info_idx}').change(function() {
                 var isChecked = $(this).is(":checked");
                 $('.CheckExt2_${boardinfo.board_info_idx}').prop('checked', isChecked);
             });
             
          // 전체 선택 체크박스의 동작 설정
             $('#CheckFile2_${boardinfo.board_info_idx}').change(function() {
            	 var isChecked = $(this).is(":checked");
                 var modalIdx = $(this).attr('id').split('_')[1]; // board_info_idx 추출
                 $("#inputState2_" + modalIdx + ", #fileSizeInput2_" + modalIdx + ", .CheckExt2_" + modalIdx).prop("disabled", !isChecked);
             });
          
             // is_checked 값에 따른 초기 활성화 상태 설정
             <c:if test="${boardinfo.file_checked == 1}">
                 $('#CheckFile2_${boardinfo.board_info_idx}').prop('checked', true).trigger('change');
             </c:if>
         </c:forEach> 
	});
</script> 
<script>
$(function(){
	$("#SearchBoardInfo").click(function(){
		var searchKeyword=$("#inputBoardName").val();
		var is_Usage=$("#is_Usage").val();
		console.log("검색 키워드 : ", searchKeyword);
		console.log("사용여부 : ", is_Usage);
		
		$.ajax({
			url : '${root}/SearchInfo?board_info_name='+searchKeyword+'&is_usage='+is_Usage,
			type: 'GET',
			dataType:'Json',
			success: function(response){
				console.log("검색 성공 " ,response); 
				$("#board_Info").empty();
				var SearchResult=response.searchResult;
				var ContentCnt=response.contentCnt;
				console.log("SearchResult : ",SearchResult)
				console.log("ContentCnt", ContentCnt)
				if (SearchResult.length > 0) {
					for (var i = 0; i < SearchResult.length; i++) {
						var item=SearchResult[i];  
				            $("#board_Info").append(
				                '<tr>' +
				                '<td>' + i + '</td>' +
				                '<td>' + item.board_info_idx + '</td>' +
				                '<td>' + item.board_info_name + '</td>' +
				                '<td>' + ContentCnt[i] + '</td>' +
				                '<td>' + item.is_usage + '</td>' +
				                '<td>' + item.board_date + '</td>' +
				                '<td><input type="button" value="수정" ' +
				                'data-bs-toggle="modal" ' +
				                'data-bs-target="#BoardModifyModal_' + item.board_info_idx + '" ' +
				                'class="btn btn-info" /></td>' +
				                '</tr>'
				            );
					}
				}else {
					$("#board_Info").append('<tr><td colspan="7"> 검색 결과가 없습니다</td></tr>');
				}
			},
			error : function(error){
				console.log("검색 오류 발생 ", error)
			}
		});
	});
});
	
</script>
<script>
$(function(){
	$('#SubmitForm').submit(function(event) { 
		//event.preventDefault(); 
		const checkboxes = document.querySelectorAll('.CheckExt');
		// 체크된 체크박스들의 값을 배열 담는다.
        const checkedValues = Array.from(checkboxes)
            .filter(checkbox => checkbox.checked)
            .map(checkbox => checkbox.value);
        
        // 콘솔에 체크된 값들을 출력합니다.
		var inputState = $('#inputState').val();
		var fileSizeInput = $('#fileSizeInput').val();
		
		var CheckFile= document.getElementById('CheckFile');
		var isChecked = CheckFile.checked;
		//var allcheck = $('#allcheck').val(); 

        console.log('체크된 값들:', checkedValues);
        console.log('파일첨부기능(isChecked):', isChecked);
        console.log('첨부파일 수(inputState):', inputState);
        console.log('첨부파일 사이즈(fileSizeInput):', fileSizeInput);
        //console.log('전체체크여부:', allcheck);
        
        if (isChecked) {
           if (checkedValues.length === 0 || inputState == 0 || fileSizeInput == 0) {
                alert('파일 옵션을 설정해 주세요');
                return false;
            }else if(fileSizeInput > 8000){
            	alert('첨부파일 사이즈는 8000Kbyte 이하로 입력해 주세요')
            	return false;
            }
        }
         
	});
});

</script>
</head>

<body id="page-top">

	<!-- Page Wrapper -->
	<div id="wrapper">
		<!-- Sidebar -->
		<ul
			class="navbar-nav bg-gradient-primary sidebar sidebar-dark accordion"
			id="accordionSidebar">
			<!-- Sidebar - Brand -->
			<a
				class="sidebar-brand d-flex align-items-center justify-content-center"
				href="${root }/admin/m_admin_board">
				<div class="sidebar-brand-icon rotate-n-15">
					<i class="fas fa-laugh-wink"></i>
				</div>
				<div class="sidebar-brand-text mx-3">
					TTMSoft
				</div>
			</a>
			<!-- Divider -->
			<hr class="sidebar-divider">
			<!-- Heading -->
			<div class="sidebar-heading">사용자 화면 보기</div>
			<!-- Nav Item - Pages Collapse Menu -->
			<li class="nav-item"><a class="nav-link" href="${root }/index">
					<i class="fas fa-fw fa-chart-area"></i> <span>사용자화면보기</span>
			</a></li>
			<!-- Divider -->
			<hr class="sidebar-divider">

			<!-- Heading -->
			<div class="sidebar-heading">통합게시판관리</div>
			<!-- Nav Item - Pages Collapse Menu -->
			<li class="nav-item"><a class="nav-link active"
				href="${root }/admin/m_admin_board"> <i
					class="fas fa-fw fa-chart-area"></i> <span>게시판관리</span></a></li>
			<!-- Nav Item - Tables -->
			<li class="nav-item"><a class="nav-link"
				href="${root }/admin/m_admin_content"> <i
					class="fas fa-fw fa-chart-area"></i> <span>게시물관리</span></a></li>
			<!-- Divider -->
			<hr class="sidebar-divider d-none d-md-block">

			<!-- Sidebar Toggler (Sidebar) -->
			<div class="text-center d-none d-md-inline">
				<button class="rounded-circle border-0" id="sidebarToggle"></button>
			</div>

		</ul>
		<!-- End of Sidebar -->
		<!-- Content Wrapper -->
		<div id="content-wrapper" class="d-flex flex-column">
			<!-- Main Content -->
			<!-- Topbar -->
			<nav
				class="navbar navbar-expand navbar-light bg-white topbar mb-4 static-top shadow">

				<!-- Sidebar Toggle (Topbar) -->
				<form class="form-inline">
					<button id="sidebarToggleTop"
						class="btn btn-link d-md-none rounded-circle mr-3">
						<i class="fa fa-bars"></i>
					</button>
				</form>
 
				<!-- Topbar Navbar -->
				<ul class="navbar-nav ml-auto">
					<div class="topbar-divider d-none d-sm-block"></div>

					<!-- Nav Item - User Information -->
					<li class="nav-item dropdown no-arrow"><a
						class="nav-link dropdown-toggle" href="#" id="userDropdown"
						role="button" data-toggle="dropdown" aria-haspopup="true"
						aria-expanded="false"> <span
							class="mr-2 d-none d-lg-inline text-gray-600 small">${loginAdminBean.admin_name }</span> 
					</a> <!-- Dropdown - User Information -->
						<div
							class="dropdown-menu dropdown-menu-right shadow animated--grow-in"
							aria-labelledby="userDropdown"> 
							<a class="dropdown-item" href="#" data-toggle="modal"
								data-target="#logoutModal"> <i
								class="fas fa-sign-out-alt fa-sm fa-fw mr-2 text-gray-400"></i>
								Logout
							</a>
						</div></li>

				</ul>

			</nav>
			<!-- End of Topbar -->

			<!-- Begin Page Content -->
			<div class="container-fluid">

				<!-- Page Heading -->
				<h1 class="h3 mb-2 text-gray-800">통합게시판관리</h1>
				<p class="mb-4">
					Integrated board management <a target="_blank">
				</p>
				<hr class="mb-3">
				<span class="h5 mb-2 text-gray-800">게시판 관리 &nbsp</span> <span
					class="mb-4">Board Management<a target="_blank"></span>
				<p> 
					<div class="row g-3">
						<div class="col-md-10">
							<label for="inputCity" class="form-label">게시판명</label> 
							<input type="text" class="form-control" id="inputBoardName">
						</div>
						<div class="col-md-2">
							<label for="is_Usage" class="form-label">사용여부</label> <select
								class="form-select form-control" id="is_Usage" 
								aria-label="Default select example">
								<option value="All" selected>전체</option>
								<option value="Y">사용</option>
								<option value="N">미사용</option>
							</select>
						</div>
					</div>
					<div class="text-right mt-4 mb-4">
						<span>
							<button type="button" class="btn btn-primary"
								data-bs-toggle="modal" data-bs-target="#exampleModal">게시판
								생성</button>
						</span> <span>
							<button type="submit" class="btn btn-primary" id="SearchBoardInfo">검색</button>
						</span>
					</div> 
				<!-- DataTales Example -->
				<div class="card shadow mb-4">
					<div class="card-header py-3">
						<h6 class="m-0 font-weight-bold text-primary">게시판 목록</h6>
					</div>
					<div class="card-body">
						<div class="table-responsive">
							<table class="table table-bordered" id="dataTable" width="100%"
								cellspacing="0">
								<thead>
									<tr>
										<th>번호</th>
										<th>게시판코드</th>
										<th>게시판명</th>
										<th>총게시물</th>
										<th>사용여부</th>
										<th>등록일</th>
										<th>수정</th>
									</tr>
								</thead>
								<tfoot>
									<tr>
										<th>번호</th>
										<th>게시판코드</th>
										<th>게시판명</th>
										<th>총게시물</th>
										<th>사용여부</th>
										<th>등록일</th>
										<th>수정</th>
									</tr>
								</tfoot>
								<tbody id="board_Info">
									<c:forEach var="boardinfo" items="${CreateBoard }" varStatus="var">   
										<tr>
											<td>${(var.index+1)}</td>
											<td>${boardinfo.board_info_idx }</td>
											<td>${boardinfo.board_info_name }</td> 
											<td>${contentCnt[var.index] }</td>  
											<td>${boardinfo.is_usage }</td>
											<td>${boardinfo.board_date }</td>
											<td><input type="button" value="수정"
												data-bs-toggle="modal"
												data-bs-target="#BoardModifyModal_${boardinfo.board_info_idx }"
												class="btn btn-info" /></td>
										</tr>   
									</c:forEach>
								</tbody>
							</table>
						</div>
					</div>
				</div>

			</div>
			<!-- /.container-fluid -->
		</div>
		<!-- End of Main Content -->

	</div>
	<!-- End of Content Wrapper -->

	</div>
	<!-- End of Page Wrapper -->

	<!-- Scroll to Top Button-->
	<a class="scroll-to-top rounded" href="#page-top"> <i
		class="fas fa-angle-up"></i>
	</a>

	<!-- 게시판 수정 모달 -->
		<c:forEach var="boardinfo" items="${CreateBoard }" varStatus="var">
			<form:form action="${root }/admin/modifyBoardPro" method="post" modelAttribute="ModifyCreateBoardBean" >  
				<div class="modal fade"
					id="BoardModifyModal_${boardinfo.board_info_idx }"
					tabindex="-1" aria-labelledby="BoardModifyModalLabel"
					aria-hidden="true">
					<div class="modal-dialog modal-xl">
						<div class="modal-content">
							<div class="modal-header">
								<h1 class="modal-title fs-5" id="BoardModifyModal">게시판 수정</h1>
								<button type="button" class="btn-close" data-bs-dismiss="modal"
									aria-label="Close"></button>
							</div> 
							<div class="modal-body"> 
								<table class="table table-bordered">
									<tbody>
										<tr>
											<th scope="row">게시판 코드</th>
											<td>
												<input type="hidden" name="board_info_idx" value="${boardinfo.board_info_idx}">
											</td>
										</tr>
										<tr>
											<th scope="row">게시판명</th>
											<td>
											<input type="text" class="form-control "
												name="board_info_name" value="${boardinfo.board_info_name }" />
											</td>
										</tr>
										<tr>
											<th scope="row">게시판 설명</th>
											<td colspan="2"><textarea class="form-control"
													name="board_explanation">${boardinfo.board_explanation }</textarea></td>
										</tr>
										<tr>
											<th scope="row">게시판 기능</th>
											<td>
												<div class="row">
													<div class="col-6"> 
														<div class="form-check">
															<input class="form-check-input" type="checkbox" value="1"
																id="CheckComment2_${boardinfo.board_info_idx}"
																name="is_comment"
																${boardinfo.is_comment == 1 ? 'checked' : ''}> 
																<label class="form-check-label" for="CheckComment2_${boardinfo.board_info_idx}">
																댓글기능 </label>
														</div>
														<div class="form-check">
														    <input class="form-check-input" type="checkbox" value="1"
														        id="IsPublic2_${boardinfo.board_info_idx}"
														        name="is_public"
														        ${boardinfo.is_public == 1 ? 'checked' : ''}>
														    <label class="form-check-label" for="IsPublic2_${boardinfo.board_info_idx}">
														        비공개 여부
														    </label>
														</div>
														<div class="form-check">
															<input class="form-check-input" type="checkbox" value="1"
																name="file_checked"
																id="CheckFile2_${boardinfo.board_info_idx}"
																${boardinfo.file_checked == 1 ? 'checked' : ''}> <label
																class="form-check-label"
																for="CheckFile2_${boardinfo.board_info_idx}">
																파일 첨부기능 </label>
														</div>
													</div>
													<div class="col-6">
														<div class="d-flex align-items-center">
															첨부파일 수 : &nbsp;
															<select class="form-select form-control"
																style="width: 15%;" id="inputState2_${boardinfo.board_info_idx}"
																aria-label="Default select example" name="is_file"
																disabled>
																<option value="0" ${boardinfo.is_file == 0 ? 'selected' : ''}>0</option>
													            <option value="1" ${boardinfo.is_file == 1 ? 'selected' : ''}>1</option>
													            <option value="2" ${boardinfo.is_file == 2 ? 'selected' : ''}>2</option>
													            <option value="3" ${boardinfo.is_file == 3 ? 'selected' : ''}>3</option>
															</select> &nbsp;개
														</div>
														 <div class="d-flex align-items-center  mt-2">
		                                                첨부파일 사이즈 : <input type="text" name="file_size"
		                                                                      id="fileSizeInput2_${boardinfo.board_info_idx}"
		                                                                      value="${boardinfo.file_size}" 
		                                                                      class="form-control mx-2"
		                                                                      style="width: 15%;"
		                                                                      placeholder="8000" disabled/> KByte
		                                            </div>
													</div>
												</div>
												<div class="row-col12">
													첨부파일 확장자(선택) <i class="bi bi-chevron-compact-down"></i>
												</div>
												<div class="row-col12">
													<div class="form-check">
														<input class="form-check-input CheckExt2_${boardinfo.board_info_idx}" type="checkbox"
															id="allcheck2_${boardinfo.board_info_idx}" disabled> <label
															class="form-check-label" for="allcheck2_${boardinfo.board_info_idx}">전체선택</label>
													</div>
												</div>
												<div class="row mt-2">
													<div class="col-3 ">
														<div class="form-check">
															<input class="form-check-input CheckExt2_${boardinfo.board_info_idx}" type="checkbox"
																value="image/svg+xml" id="jpg2" name="file_ext" disabled> <label
																class="form-check-label" for="jpg2"> *.svg </label>
														</div>
														<div class="form-check">
															<input class="form-check-input CheckExt2_${boardinfo.board_info_idx}" type="checkbox"
																value="image/jpeg" id="jpeg2" name="file_ext" disabled>
															<label class="form-check-label" for="jpeg2"> *.jpeg
															</label>
														</div>
														<div class="form-check">
															<input class="form-check-input CheckExt2_${boardinfo.board_info_idx}" type="checkbox"
																value="image/png" id="png2" name="file_ext" disabled> <label
																class="form-check-label" for="png2"> *.png </label>
														</div>
														<div class="form-check">
															<input class="form-check-input CheckExt2_${boardinfo.board_info_idx}" type="checkbox"
																value="image/bmp" id="bmp2" name="file_ext" disabled> <label
																class="form-check-label" for="bmp2"> *.bmp </label>
														</div>
													</div>
													<div class="col-3">
														<div class="form-check">
															<input class="form-check-input CheckExt2_${boardinfo.board_info_idx}" type="checkbox"
																value="image/tif" id="tif2" name="file_ext" disabled> <label
																class="form-check-label" for="tif2"> *.tif </label>
														</div>
														<div class="form-check">
															<input class="form-check-input CheckExt2_${boardinfo.board_info_idx}" type="checkbox"
																value="image/tiff" id="tiff2" name="file_ext" disabled>
															<label class="form-check-label" for="tiff2"> *.tiff
															</label>
														</div>
														<div class="form-check">
															<input class="form-check-input CheckExt2_${boardinfo.board_info_idx}" type="checkbox"
																value="application/vnd.ms-excel" id="xls2" name="file_ext" disabled> <label
																class="form-check-label" for="xls2"> *.xls </label>
														</div>
													</div>
													<div class="col-3">
														<div class="form-check">
															<input class="form-check-input CheckExt2_${boardinfo.board_info_idx}" type="checkbox"
																value="application/vnd.openxmlformats-officedocument.spreadsheetml.sheet" id="xlsx2" name="file_ext" disabled>
															<label class="form-check-label" for="xlsx2"> *.xlsx
															</label>
														</div>
														<div class="form-check">
															<input class="form-check-input CheckExt2_${boardinfo.board_info_idx}" type="checkbox"
																value="text/csv" id="csv2" name="file_ext" disabled> <label
																class="form-check-label" for="csv2"> *.csv </label>
														</div>
														<div class="form-check">
															<input class="form-check-input CheckExt2_${boardinfo.board_info_idx}" type="checkbox"
																value="application/x-hwp" id="hwp2" name="file_ext" disabled> <label
																class="form-check-label" for="hwp2"> *.hwp </label>
														</div>
		
													</div>
													<div class="col-3">
														<div class="form-check">
															<input class="form-check-input CheckExt2_${boardinfo.board_info_idx}" type="checkbox"
																value="application/msword" id="doc2" name="file_ext" disabled> <label
																class="form-check-label" for="doc2"> *.doc </label>
														</div>
														<div class="form-check">
															<input class="form-check-input CheckExt2_${boardinfo.board_info_idx}" type="checkbox"
																value="application/vnd.openxmlformats-officedocument.wordprocessingml.document" id="docx2" name="file_ext" disabled>
															<label class="form-check-label" for="docx2"> *.docx
															</label>
														</div>
														<div class="form-check">
															<input class="form-check-input CheckExt2_${boardinfo.board_info_idx}" type="checkbox"
																value="text/plain" id="txt2" name="file_ext" disabled> <label
																class="form-check-label" for="txt2"> *.txt </label>
														</div>
		
													</div>
												</div>
											</td>
										</tr>
										<tr>
											<th scope="row">사용여부</th>
											<td colspan="2">
												<select class="form-select form-control usage_${boardinfo.board_info_idx}" aria-label="Default select example" name="is_usage">
														<option value="Y" ${boardinfo.is_usage == 'Y'?'selected':'' }>사용</option>
														<option value="N" ${boardinfo.is_usage =='N'?'selected':'' }>미사용</option>
												</select>
											</td>
										</tr>
									</tbody>
								</table>
							</div>
							<div class="modal-footer">
								<button type="submit" class="btn btn-primary">수정</button>
								<button type="button" class="btn btn-secondary"
									data-bs-dismiss="modal">닫기</button>
							</div> 
						</div>
					</div>
				</div> 
			</form:form>
		</c:forEach> 
	
		<!-- board Modify Modal End  -->
	
	
	
		<!-- 게시판 생성 모달 -->
		<form:form action="${root }/admin/admin_boardPro" method="post"
			modelAttribute="CreateBoardBean" id="SubmitForm">
			<div class="modal fade" id="exampleModal" tabindex="-1"
				aria-labelledby="exampleModalLabel" aria-hidden="true">
				<div class="modal-dialog modal-xl">
					<div class="modal-content">
						<div class="modal-header">
							<h1 class="modal-title fs-5" id="exampleModalLabel">게시판 생성</h1>
							<button type="button" class="btn-close" data-bs-dismiss="modal"
								aria-label="Close"></button>
						</div>
						<div class="modal-body">
							<table class="table table-bordered">
								<tbody>
									<tr>
										<th scope="row">게시판 코드</th>
									</tr>
									<tr>
										<th scope="row">게시판명</th>
										<td><input type="text" class="form-control"
											name="board_info_name" /></td>
									</tr>
									<tr>
										<th scope="row">게시판 설명</th>
										<td colspan="2"><textarea class="form-control"
												name="board_explanation"></textarea></td>
									</tr>
									<tr>
										<th scope="row">게시판 기능</th>
										<td>
											<div class="row mb-2">
												<div class="col-6"> 
													<div class="form-check">
														<input class="form-check-input" type="checkbox" value="1"
															id="CheckComment" name="is_comment"> <label
															class="form-check-label" for="CheckComment"> 댓글기능
														</label>
													</div> 
													<div class="form-check">
														<input class="form-check-input" type="checkbox" value="1"
															id="IsPublic" name="is_public"> <label class="form-check-label"
															for="IsPublic">비공개 여부 </label>
													</div>
													<div class="form-check">
														<input class="form-check-input CheckFile" type="checkbox" value="1"
															id="CheckFile" name="file_checked"> <label class="form-check-label"
															for="CheckFile"> 파일 첨부기능 </label>
													</div>
												</div>
												<div class="col-6">
													<div class="d-flex align-items-center">
														첨부파일 수 : &nbsp;<select class="form-select form-control"
															style="width: 15%;" id="inputState"
															aria-label="Default select example" name="is_file"
															disabled>
															<option value="0" selected>0</option>
															<option value="1">1</option>
															<option value="2">2</option>
															<option value="3">3</option>
														</select> &nbsp;개
													</div>
													<div class="d-flex align-items-center  mt-2">
														첨부파일 사이즈 : <input type="text" name="file_size"
															id="fileSizeInput" value="0"
														class="form-control mx-2" style="width: 25%;"
														placeholder="8000" disabled /> KByte
												</div>
											</div> 
										</div>
										<div class="row-col12">
											첨부파일 확장자(선택) <i class="bi bi-chevron-compact-down"></i>
										</div>
										<div class="row-col12">
											<div class="form-check">
												<input class="form-check-input CheckExt" type="checkbox"
													id="allcheck" disabled> <label
													class="form-check-label" for="allcheck">전체선택</label>
											</div>
										</div>
										<div class="row mt-2">
											<div class="col-3 ">
												<div class="form-check">
													<input class="form-check-input CheckExt" type="checkbox"
														value=" image/svg+xml"  id="jpg" name="file_ext" disabled> <label
														class="form-check-label" for="jpg"> *.svg </label>
												</div>
												<div class="form-check">
													<input class="form-check-input CheckExt" type="checkbox"
														value="image/jpeg"  id="jpeg" name="file_ext" disabled>
													<label class="form-check-label" for="jpeg"> *.jpeg
													</label>
												</div>
												<div class="form-check">
													<input class="form-check-input CheckExt" type="checkbox"
														value="image/png" id="png" name="file_ext" disabled> <label
														class="form-check-label" for="png"> *.png </label>
												</div>
												<div class="form-check">
													<input class="form-check-input CheckExt" type="checkbox"
														value="image/bmp"  id="bmp" name="file_ext" disabled> <label
														class="form-check-label" for="bmp"> *.bmp </label>
												</div>
											</div>
											<div class="col-3">
												<div class="form-check">
													<input class="form-check-input CheckExt" type="checkbox"
														value="image/tif" id="tif" name="file_ext" disabled> <label
														class="form-check-label" for="tif"> *.tif </label>
												</div>
												<div class="form-check">
													<input class="form-check-input CheckExt" type="checkbox"
														value="image/tiff" id="tiff" name="file_ext" disabled>
													<label class="form-check-label" for="tiff"> *.tiff
													</label>
												</div>
												<div class="form-check">
													<input class="form-check-input CheckExt" type="checkbox"
														value="application/vnd.ms-excel"  id="xls" name="file_ext" disabled> <label
														class="form-check-label" for="xls"> *.xls </label>
												</div>
											</div>
											<div class="col-3">
												<div class="form-check">
													<input class="form-check-input CheckExt" type="checkbox"
														value="application/vnd.openxmlformats-officedocument.spreadsheetml.sheet" id="xlsx" name="file_ext" disabled>
													<label class="form-check-label" for="xlsx"> *.xlsx
													</label>
												</div>
												<div class="form-check">
													<input class="form-check-input CheckExt" type="checkbox"
														value="text/csv"  id="csv" name="file_ext" disabled> <label
														class="form-check-label" for="csv"> *.csv </label>
												</div>
												<div class="form-check">
													<input class="form-check-input CheckExt" type="checkbox"
														value="application/x-hwp" id="hwp" name="file_ext" disabled> <label
														class="form-check-label" for="hwp"> *.hwp </label>
												</div>

											</div>
											<div class="col-3">
												<div class="form-check">
													<input class="form-check-input CheckExt" type="checkbox"
														value="application/msword" id="doc" name="file_ext" disabled> <label
														class="form-check-label" for="doc"> *.doc </label>
												</div>
												<div class="form-check">
													<input class="form-check-input CheckExt" type="checkbox"
														value="application/vnd.openxmlformats-officedocument.wordprocessingml.document" id="docx" name="file_ext" disabled>
													<label class="form-check-label" for="docx"> *.docx
													</label>
												</div>
												<div class="form-check">
													<input class="form-check-input CheckExt" type="checkbox"
														value="text/plain" id="txt" name="file_ext" disabled> <label
														class="form-check-label" for="txt"> *.txt </label>
												</div> 
											</div>
										</div>
									</td>
								</tr>
								<tr>
									<th scope="row">사용여부</th>
									<td colspan="2"><select class="form-select form-control"
										aria-label="Default select example" name="is_usage">
											<option value="Y" selected>사용</option>
											<option value="N">미사용</option>
									</select></td>
								</tr>
							</tbody>
						</table>
					</div>
					<div class="modal-footer">
						<button type="submit" class="btn btn-primary">생성</button>
						<button type="button" class="btn btn-secondary"
							data-bs-dismiss="modal">닫기</button>
					</div>
				</div>
			</div>
		</div>
		<!-- board Create Modal End  -->
	</form:form> 

	<!-- Logout Modal-->
	<div class="modal fade" id="logoutModal" tabindex="-1" role="dialog"
		aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					 <h5 class="modal-title" id="exampleModalLabel">로그아웃</h5>
                    <button class="close" type="button" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">×</span>
                    </button>
                </div>
                <div class="modal-body">로그아웃 하시겠습니까?</div>
				<div class="modal-footer">
					<button class="btn btn-secondary" type="button"
						data-dismiss="modal">Cancel</button>
					<a class="btn btn-primary" href="${root }/admin/admin_logout">Logout</a>
				</div>
			</div>
		</div>
	</div>
	<!-- Footer -->
	<footer class="sticky-footer bg-white">
		<div class="container my-auto">
			<div class="copyright text-center my-auto">
				<span>Copyright &copy; Your Website 2020</span>
			</div>
		</div>
	</footer>
	<!-- End of Footer --> 
	<!-- Bootstrap core JavaScript-->
	<script src="${root}/resources/vendor/jquery/jquery.min.js"></script>
	<script
		src="${root}/resources/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

	<!-- Core plugin JavaScript-->
	<script
		src="${root}/resources/vendor/jquery-easing/jquery.easing.min.js"></script>

	<!-- Custom scripts for all pages-->
	<script src="${root}/resources/js/sb-admin-2.min.js"></script>

	<!-- Page level plugins -->
	<script
		src="${root}/resources/vendor/datatables/jquery.dataTables.min.js"></script>
	<script
		src="${root}/resources/vendor/datatables/dataTables.bootstrap4.min.js"></script>

	<!-- Page level custom scripts -->
	<script src="${root}/resources/js/demo/datatables-demo.js"></script>

</body>

</html>