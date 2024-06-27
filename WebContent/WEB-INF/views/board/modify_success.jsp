<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="root" value="${pageContext.request.contextPath }/"/>
<script>
	alert('게시글이 성공적으로 수정이 완료 되었습니다.')
	//location.href='${root}board/read?content_idx=${content_idx}'
	location.href='${root}board/read?content_idx=${param.hiddenContent_idx}'
</script>