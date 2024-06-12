<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
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
	rel="stylesheet"><!-- 
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script
	src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script> -->
<link
	href="https://maxcdn.bootstrapcdn.com/bootstrap/5.1.3/css/bootstrap.min.css"
	rel="stylesheet">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p"
	crossorigin="anonymous"></script>
 <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
 
<script>
	$(function(){
		$('#CheckFile').change(function(){
			var isChecked=$(this).is(":checked");
			 $("#inputState, #fileSizeInput").prop("disabled", !isChecked);
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
					SB Admin <sup>2</sup>
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
			<li class="nav-item"><a class="nav-link"
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

				<!-- Topbar Search -->
				<form
					class="d-none d-sm-inline-block form-inline mr-auto ml-md-3 my-2 my-md-0 mw-100 navbar-search">
					<div class="input-group">
						<input type="text" class="form-control bg-light border-0 small"
							placeholder="Search for..." aria-label="Search"
							aria-describedby="basic-addon2">
						<div class="input-group-append">
							<button class="btn btn-primary" type="button">
								<i class="fas fa-search fa-sm"></i>
							</button>
						</div>
					</div>
				</form>

				<!-- Topbar Navbar -->
				<ul class="navbar-nav ml-auto">
					<div class="topbar-divider d-none d-sm-block"></div>

					<!-- Nav Item - User Information -->
					<li class="nav-item dropdown no-arrow"><a
						class="nav-link dropdown-toggle" href="#" id="userDropdown"
						role="button" data-toggle="dropdown" aria-haspopup="true"
						aria-expanded="false"> <span
							class="mr-2 d-none d-lg-inline text-gray-600 small">Douglas
								McGee</span> <img class="img-profile rounded-circle"
							src="${root}/resources/upload/logo.png">
					</a> <!-- Dropdown - User Information -->
						<div
							class="dropdown-menu dropdown-menu-right shadow animated--grow-in"
							aria-labelledby="userDropdown">
							<!-- <div class="dropdown-divider"></div> -->
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
						<label for="inputCity" class="form-label">게시판명</label> <input
							type="text" class="form-control" id="inputCity">
					</div>
					<div class="col-md-2">
						<label for="inputState2" class="form-label">사용여부</label> <select
							class="form-select form-control" id="inputState2"
							aria-label="Default select example">
							<option selected>전체</option>
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
						<button type="submit" class="btn btn-primary">검색</button>
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
								<tbody>
									<tr>
										<td>Colleen Hurst</td>
										<td>Javascript Developer</td>
										<td>San Francisco</td>
										<td>39</td>
										<td>2009/09/15</td>
										<td>$205,500</td>
										<td>$205,500</td>
									</tr>
									<tr>
										<td>Sonya Frost</td>
										<td>Software Engineer</td>
										<td>Edinburgh</td>
										<td>23</td>
										<td>2008/12/13</td>
										<td>$103,600</td>
										<td>$103,600</td>
									</tr>
									<tr>
										<td>Jena Gaines</td>
										<td>Office Manager</td>
										<td>London</td>
										<td>30</td>
										<td>2008/12/19</td>
										<td>$90,560</td>
										<td>$90,560</td>
									</tr>
									<tr>
										<td>Quinn Flynn</td>
										<td>Support Lead</td>
										<td>Edinburgh</td>
										<td>22</td>
										<td>2013/03/03</td>
										<td>$342,000</td>
										<td>$342,000</td>
									</tr>
									<tr>
										<td>Charde Marshall</td>
										<td>Regional Director</td>
										<td>San Francisco</td>
										<td>36</td>
										<td>2008/10/16</td>
										<td>$470,600</td>
										<td>$470,600</td>
									</tr>
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
	
	<!-- 게시판 생성 모달 -->
	<form:form action="${root }/admin/admin_boardPro" method="post" modelAttribute="CreateBoardBean">
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
								<td><input type="text" class="form-control" name="board_name"/></td>
							</tr>
							<tr>
								<th scope="row">게시판 설명</th>
								<td colspan="2"><textarea class="form-control" name="board_explanation" ></textarea></td>
							</tr>
							<tr>
								<th scope="row">게시판 기능</th>
								<td>
									<div class="row">
										<div class="col-6">
											<div class="form-check">
												<input class="form-check-input" type="checkbox" value="1"
													id="CheckAnswer" name="is_answer"> <label
													class="form-check-label" for="CheckAnswer">
													답변기능 </label>
											</div>
											<div class="form-check">
												<input class="form-check-input" type="checkbox" value="1"
													id="CheckComment" name="is_comment"> <label
													class="form-check-label" for="CheckComment">
													댓글기능 </label>
											</div>
											<div class="form-check">
												<input class="form-check-input" type="checkbox" value="1"
													id="CheckFile"> <label
													class="form-check-label" for="CheckFile">
													파일 첨부기능 </label>
											</div>
										</div>
										<div class="col-6">
											<div class="d-flex align-items-center">
											  첨부파일 수 : &nbsp;<select class="form-select form-control" style="width:15%;"
															id="inputState" aria-label="Default select example" name="is_file" disabled>
																<option value="0" selected>0</option>
																<option value="1">1</option>
																<option value="2">2</option>
																<option value="3">3</option>
														</select> &nbsp;개
											</div>
											<div class="d-flex align-items-center  mt-2">
											  첨부파일 사이즈 : <input type="text" name="file_size" id="fileSizeInput" class="form-control mx-2" style="width: 15%;" placeholder="5000" disabled/> KByte
											</div> 
										</div>
									</div>
									<div class="row mt-2">
										<div class="d-flex align-items-center col-12">
											  첨부파일 확장자 : <input type="text" class="form-control mx-2" name="file_ext" style="width: 70%;" placeholder="예)*.jpg,*.gif (컴마로 구분)"/> 
										</div>
									</div>
								</td>
							</tr>
							<tr>
								<th scope="row">사용여부</th>
								<td colspan="2">
									<select class="form-select form-control" aria-label="Default select example" name="is_usage">
											<option value="Y" selected>사용</option>
											<option value="N">미사용</option>
									</select>
								</td>
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
					<h5 class="modal-title" id="exampleModalLabel">Ready to Leave?</h5>
					<button class="close" type="button" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">×</span>
					</button>
				</div>
				<div class="modal-body">Select "Logout" below if you are ready
					to end your current session.</div>
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