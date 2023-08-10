<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../includes/header.jsp" %>

<div class="container">
	<div class="row">
		<div class="col-12">
			<div class="card">
				<div class="card-header">BoardList Page</div><!-- card-header end -->
				<div class="card-body">
					<table>
						<thead>
							<tr>
								<th>썸네일</th>
								<th>제목</th>
								<th>추천</th>
								<th>작성자</th>
								<th>작성일</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach var="board" items="${list}">
								<tr>
									<td>이미지</td>
									<td>${board.title}</td>
									<td>추천수</td>
									<td>${board.writer}</td>
									<td>
										<tf:formatDateTime value="${board.regDate}" pattern="yyyy-MM-dd HH:mm"/>
									</td>
									<td>
										<button class="btn"></button>
									</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</div><!-- card-body end -->
			</div><!-- card end -->
		</div><!-- col-12 end -->
	</div><!-- row end -->
</div><!-- container end -->


<%@ include file="../includes/footer.jsp" %>
