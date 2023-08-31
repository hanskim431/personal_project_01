<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="tf" tagdir="/WEB-INF/tags"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<c:set var="ctxPath" value="${pageContext.request.contextPath}" />

<sec:authorize access="isAuthenticated()">
	<sec:authentication property="principal.memberVO" var="authInfo"/>
	<sec:authentication property="principal.memberVO.authList" var="authList"/>
</sec:authorize>

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
	let csrfTokenValue = "${_csrf.token}"
	let csrfHeaderName = "${_csrf.headerName}";

	var ctxPath = '${ctxPath}'
	var duplicateLogin = '${duplicateLogin}'

	let memberId = "${authInfo.memberId}"
	let auth = "${authList}" 

	let boardType = '${boardType}';
	
	$(document).ajaxSend(function(e, xhr, options){
		xhr.setRequestHeader(csrfHeaderName,csrfTokenValue);
	})

	if(duplicateLogin) { // 로그인 중복 제한
		alert(duplicateLogin)
	}
	
	function checkExtension(fileName, fileSize) { // 파일 업로드 제한 
		let regex = new RegExp("(.*?)\.(exe|sh|zip|alz)$"); // 업로드 불가 파일 형식
		let maxSize = 10485760;
		if(fileSize > maxSize){
			alert('파일 크기는 최대 10MB까지 업로드 가능합니다.');
			return false;
		}
		if(regex.test(fileName)){
			alert('해당 파일 형식은 업로드 할 수 없습니다.');
			return false;
		}
		return true;
	}
	
	function checkEmailExtension(email) { // 이메일 형식 검증
		/*
		 ^[0-9a-zA-Z]*([-_\.]?[0-9a-zA-Z])*@([0-9a-zA-Z]+)*[-_\.][a-zA-Z]{2,3}$
			 ^ : 문자열 시작 
			 [0-9a-zA-Z]* : 0-9,a-z,A-Z 0번 또는 그 이상 반복  
			 [-_\.]? : -_. 중 하나 존재할 수도, 존재하지 않을 수도
			 @ : @ 존재
			 [0-9a-zA-Z]+ : [0-9a-zA-Z]가 반드시 한번 이상 반복
			 [-_\.] : -_. 중 하나, 한번 존재
			 [a-zA-Z]{2,3} : [a-zA-Z] 2~3 글자
			 $ : 문자열 끝 
		*/
		let regex = new RegExp("^[0-9a-zA-Z]*([-_\.]?[0-9a-zA-Z])*@([0-9a-zA-Z]+)*[-_\.][a-zA-Z]{2,3}$"); // 이메일 형식
		
		if(!regex.test(email)){
			return false;
		}
		return true;
	}
	
</script>

<div>
	<nav class="navbar navbar-expand-sm bg-light justify-content-between">
		<ul class="navbar-nav">
			<li class="nav-item">
				<a class="nav-link"	href="${ctxPath == '' ? '/': ctxPath}"> 
					<img src="${ctxPath}/resources/images/logo.bmp" class="logo" alt="logo">
				</a>
			</li>
			<li class="nav-item my-auto">
				<a class="btn btn-outline-info nav-link" href="${ctxPath}/board/board1">게시판1</a>
			</li>
			<li class="nav-item my-auto">
				<a class="btn btn-outline-info nav-link" href="${ctxPath}/board/board2">게시판2</a>
			</li>
			<li class="nav-item my-auto">
				<a class="btn btn-outline-info nav-link" href="${ctxPath}/board/board3">게시판3</a>
			</li>
			<li class="nav-item"><a class="nav-link" href="#"></a></li>
		</ul>
		<ul class="navbar-nav">
			<sec:authorize access="isAnonymous()">
				<li class="nav-item">
					<a class="btn btn-outline-info nav-link" href="${ctxPath}/join/step1">회원 가입</a>
				</li>
				<li class="nav-item">
					<a class="btn btn-outline-info nav-link" href="${ctxPath}/login">로그인</a>
				</li>
			</sec:authorize>
			<sec:authorize access="isAuthenticated()">
				<li class="nav-item">
					<div>${authInfo.memberName}님, 어서오세요</div>
				</li>
				<li class="nav-item">
					<a class="btn btn-outline-info nav-link" href="${ctxPath}/mypage">마이페이지</a>
				</li>
				<li class="nav-item">
					<a class="btn btn-outline-info nav-link logout" href="${ctxPath}/user/logout">로그아웃</a>
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