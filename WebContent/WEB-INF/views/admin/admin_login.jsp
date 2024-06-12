<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<c:set var="root" value="${pageContext.request.contextPath }" />
<!DOCTYPE html>
<html>
<head> 
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">  
    <link href="${root}/resources/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
    <link
        href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
        rel="stylesheet">
    <link href="${root}/resources/css/sb-admin-2.min.css" rel="stylesheet">

</head>
<style>
    .full-height {
        min-height: 100vh;
    }
</style>
<body class="bg-gradient-primary">

    <div class="container">

        <!-- Outer Row -->
        <div class="row justify-content-center align-items-center full-height">
            <div class="col-xl-10 col-lg-12 col-md-9"> 
                <div class="card o-hidden border-0 shadow-lg my-5">
                    <div class="card-body p-0">
                        <!-- Nested Row within Card Body --> 
                                <div class="p-5">
                                    <div class="text-center">
                                        <h1 class="h4 text-gray-900 mb-4">관리자 로그인</h1>
                                    </div>
                                    <form:form action="${root }/admin/admin_loginPro" modelAttribute="AdminLoginBean"  method="post" class="user">
                                        <div class="form-group">
                                            <input type="text" class="form-control form-control-user"  aria-describedby="emailHelp" name="admin_id"
                                                placeholder="Id">
                                        </div>
                                        <div class="form-group">
                                            <input type="password" class="form-control form-control-user" placeholder="Password" name="admin_pw">
                                        </div> 
                                        <button type="submit" class="btn btn-primary btn-user btn-block">
                                            Login
                                        </button> 
                                    </form:form>
                                    <hr> 
                                </div>
                            </div>
                        </div>
                    </div>
                </div> 
            </div>
 

    <!-- Bootstrap core JavaScript-->
    <script src="${root}/resources/vendor/jquery/jquery.min.js"></script>
    <script src="${root}/resources/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

    <!-- Core plugin JavaScript-->
    <script src="${root}/resources/vendor/jquery-easing/jquery.easing.min.js"></script>

    <!-- Custom scripts for all pages-->
    <script src="${root}/resources/js/sb-admin-2.min.js"></script>

</body>

</html>