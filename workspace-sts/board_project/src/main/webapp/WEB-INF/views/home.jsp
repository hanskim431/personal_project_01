<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="includes/header.jsp" %>
<style>
body{
	background-color: darkgray;
}
img {
    width: 200px;
    height: 200px;
}

.col-3 {
    min-width: 17.6%;
    max-width: 17.6%;
}

</style>

<h1>메인페이지</h1>

<div class="container ">
	<div class="row justify-content-md-center">
	    <div class="col-3" >
	        <a href="${ctxPath}/board/Road">
	            <img src="${ctxPath}/resources/images/main/road.jpg" alt="로드">
	        </a>
	    </div>
	    <div class="col-3">
	        <a href="${ctxPath}/board/Mtb">
	            <img src="${ctxPath}/resources/images/main/mountain.jpg" alt="MTB">
	        </a>
	    </div>
	    <div class="col-3">
	        <a href="${ctxPath}/board/Commuter">
	            <img src="${ctxPath}/resources/images/main/commuter.jpg" alt="출퇴근">
	        </a>
	    </div>
	    <div class="col-3">
	        <a href="${ctxPath}/board/Touring">
	            <img src="${ctxPath}/resources/images/main/touring.jpg" alt="여행">
	        </a>
	    </div>
    </div>
	<div class="row justify-content-md-center">
	    <div class="col-3">
	        <a href="${ctxPath}/board/Gears">
	            <img src="${ctxPath}/resources/images/main/gears.jpg" alt="징비">
	        </a>
	    </div>
	    <div class="col-3">
	        <a href="${ctxPath}/board/Items">
	            <img src="${ctxPath}/resources/images/main/repair.jpg" alt="정비">
	        </a>
	    </div>
	    <div class="col-3">
	        <a href="${ctxPath}/board/Shop">
	            <img src="${ctxPath}/resources/images/main/shop.jpg" alt="장터">
	        </a>
	    </div>
	    <div class="col-3">
	        <a href="${ctxPath}/board/Lost-and-Found">
	            <img src="${ctxPath}/resources/images/main/lostandfound.jpg" alt="분실물센터">
	        </a>
	    </div>
	</div>
</div>

<%@ include file="includes/footer.jsp" %>