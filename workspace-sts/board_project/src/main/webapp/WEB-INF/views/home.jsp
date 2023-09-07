<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="includes/header.jsp" %>
<style>
img {
    width: 250px;
    height: 250px;
}

.col-3 {
	max-width: 22%;
	padding : 0px;
}

#hover-text{
	font-size: 100px;
}
</style>

<div class="container ">
	<div class="row justify-content-md-center">
	    <div class="col-3" id="road-div" onmouseover="showText('ROAD')" onmouseout="hideText()">
	        <a href="${ctxPath}/board/road">
	            <img src="${ctxPath}/resources/images/main/road.jpg" alt="로드">
	        </a>
	    </div>
	    <div class="col-3" id="mtb-div" onmouseover="showText('MTB')" onmouseout="hideText()">
	        <a href="${ctxPath}/board/mtb">
	            <img src="${ctxPath}/resources/images/main/mtb.jpg" alt="MTB">
	        </a>
	    </div>
	    <div class="col-3" id="commuter-div" onmouseover="showText('COMMUTER')" onmouseout="hideText()">
	        <a href="${ctxPath}/board/commuter">
	            <img src="${ctxPath}/resources/images/main/commuter.jpg" alt="출퇴근">
	        </a>
	    </div>
	    <div class="col-3" id="touring-div" onmouseover="showText('TOURING')" onmouseout="hideText()">
	        <a href="${ctxPath}/board/touring">
	            <img src="${ctxPath}/resources/images/main/touring.jpg" alt="여행">
	        </a>
	    </div>
    </div>
	<div class="row justify-content-md-center">
	    <div class="col-3" id="gears-div" onmouseover="showText('GEARS')" onmouseout="hideText()">
	        <a href="${ctxPath}/board/gears">
	            <img src="${ctxPath}/resources/images/main/gears.jpg" alt="징비">
	        </a>
	    </div>
	    <div class="col-3" id="repair-div" onmouseover="showText('REPAIR')" onmouseout="hideText()">
	        <a href="${ctxPath}/board/repair">
	            <img src="${ctxPath}/resources/images/main/repair.jpg" alt="정비">
	        </a>
	    </div>
	    <div class="col-3" id="shop-div" onmouseover="showText('장터')" onmouseout="hideText()">
	        <a href="${ctxPath}/board/shop">
	            <img src="${ctxPath}/resources/images/main/shop.jpg" alt="장터">
	        </a>
	    </div>
	    <div class="col-3" id="lostandfound-div" onmouseover="showText('분실물센터')" onmouseout="hideText()">
	        <a href="${ctxPath}/board/lost-and-found">
	            <img src="${ctxPath}/resources/images/main/lost-and-found.jpg" alt="분실물센터">
	        </a>
	    </div>
	</div>
	
	<div class="row justify-content-md-center" id="hover-div">
        <p id="hover-text" style="display:none;">여기에 표시할 텍스트</p>
    </div>
</div>

<%@ include file="includes/footer.jsp" %>

<script>
// 마우스를 올리면 텍스트를 표시하는 함수
function showText(text) {
    var textElement = document.getElementById("hover-text");
    textElement.textContent = text;
    textElement.style.display = "block";
}

// 마우스를 벗어나면 텍스트를 숨기는 함수
function hideText() {
    var textElement = document.getElementById("hover-text");
    textElement.style.display = "none";
}

</script>