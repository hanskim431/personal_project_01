<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="tf" tagdir="/WEB-INF/tags"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<c:set var="ctxPath" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Board_project</title>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>

<script>
	var ctxPath = '${ctxPath}'
	var duplicateLogin = '${duplicateLogin}'
	
	if(duplicateLogin) {
		alert(duplicateLogin)
	}
</script>

<sec:authorize access="isAuthenticated()">
	<sec:authentication property="principal.memberVO" var="authInfo"/>
</sec:authorize>

<div>
	<nav class="navbar navbar-expand-sm bg-light justify-content-between">
		<ul class="navbar-nav">
			<li class="nav-item">
				<a class="nav-link"	href="${ctxPath == '' ? '/': ctxPath}"> 
					<img src="${ctxPath}/resources/images/logo.bmp" class="logo" alt="logo">
				</a>
			</li>
			<li class="nav-item my-auto">
				<a class="nav-link" href="${ctxPath}/board/board1">게시판1</a>
			</li>
			<li class="nav-item my-auto">
				<a class="nav-link" href="${ctxPath}/board/board2">게시판2</a>
			</li>
			<li class="nav-item my-auto">
				<a class="nav-link" href="${ctxPath}/board/board3">게시판3</a>
			</li>
			<li class="nav-item"><a class="nav-link" href="#"></a></li>
		</ul>
		<ul class="navbar-nav">
			<sec:authorize access="isAnonymous()">
				<li class="nav-item">
						<a class="nav-link" href="${ctxPath}/login">로그인</a>
				</li>
			</sec:authorize>
			<sec:authorize access="isAuthenticated()">
				<li class="nav-item">
						<a class="nav-link logout" href="${ctxPath}/user/logout">로그아웃</a>
				</li>
			</sec:authorize>
		</ul>
	</nav>
</div>

<script>
$(function(){
	$('.logout').click(function(e){
		e.preventDefault();
		let form = $('<form>',{action:$(this).attr('href'),method:'post'});
		form.append($('<input>',{type:'hidden',name:'${_csrf.parameterName}',value:'${_csrf.token}'}))
			.appendTo('body')
			.submit();
	})
	
})
</script>