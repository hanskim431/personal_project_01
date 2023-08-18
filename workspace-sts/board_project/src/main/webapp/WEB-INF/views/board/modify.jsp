<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../includes/header.jsp"%>

<div class="container">
	<div class="row">
		<div class="col-12">
			<div class="card">
				<div class="card-header"></div>
				<!-- card-header end -->
				<div class="card-body">
					<form action="${ctxPath}/board/${boardType}/modify" method="post">
						<div class="form-group">
							<label>작성자
								<button type="fileAttach" class="btn btn-default">file</button>
								<button type="submit" class="btn btn-default">Submit</button>
							</label> <input type="text" class="form-control" name="writer"
								value="${board.writer}" readonly="readonly">
						</div>
						<div class="form-group">
							<label>제목</label> <input type="text" class="form-control"
								name="title" value="${board.title}">
						</div>
						<div class="form-group">
							<label>내용</label>
							<textarea class="form-control" rows="10" name="content">${board.content}</textarea>
						</div>
						<div class="form-group">
							<label>첨부파일 목록</label>

						</div>
						<input type="hidden" name="bno" value="${board.bno}"> <input
							type="hidden" name="boardType" value="BOARD3"> <input
							type="hidden" name="status" value="VISIBLE">
					</form>
				</div>
				<!-- card-body end -->
			</div>
			<!-- card end -->
		</div>
		<!-- col-12 end -->
	</div>
	<!-- row end -->
</div>
<!-- container end -->

<%@ include file="../includes/footer.jsp" %>
