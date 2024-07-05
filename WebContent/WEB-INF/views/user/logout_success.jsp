<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="root" value="${pageContext.request.contextPath }/"/>
<script>
    alert('로그아웃 되었습니다');
    var prevPage = '${prevPage}';
    if (prevPage && prevPage !== 'null') {
        location.href = prevPage;
    } else {
        location.href = '${root}index';
    }
</script>
