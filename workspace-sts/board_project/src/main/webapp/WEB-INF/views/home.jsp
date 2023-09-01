<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="includes/header.jsp" %>
<style>
.board{
    display: grid;
    grid-template-columns: repeat(auto-fill, minmax(200px, 1fr)); /* 열의 크기를 조절합니다 */
    grid-gap: 20px; /* 열 간격 설정 */
    background-color: yellow;
}
.board-link{
.board-link {
    text-align: center; /* 텍스트를 중앙 정렬합니다 */
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
    height: 100%; /* 링크 영역의 높이를 100%로 설정하여 내용을 수직으로 정렬합니다 */
    text-decoration: none;
    color: #333;
}
.board-link .board-icon{
	font-size: 40px;
}
.board-link .board-name{
    font-size: 24px; /* 텍스트 크기를 조절합니다 */
}
.board-link .follow-button{
}
</style>


<h1>메인페이지</h1>
<div class="container">
	<div class="row my-auto">
		<c:forEach items="">
			<div class="board mx-auto text-center">
				<a href="${ctxPath}/board/board1" class="board-link">
					<span class="board-icon">😮</span>
					<span class="board-name">게시판 1</span>
					<button class="follow-button btn">🖤</button>
				</a>
			</div><!-- board END -->
		</c:forEach>

	</div><!-- row END -->
</div><!-- container END -->

<%@ include file="includes/footer.jsp" %>