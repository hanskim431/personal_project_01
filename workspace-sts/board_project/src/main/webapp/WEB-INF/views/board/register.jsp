<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../includes/header.jsp" %>

<div class="container">
	<div class="row">
		<div class="col-12">
			<div class="card">
				<div class="card-header"></div>
				<!-- card-header end -->
				<div class="card-body">
					<form action="${ctxPath}/board/${boardType}/register" method="post">
						<div class="form-group">
							<label>작성자 <span class="float-right d-flex">
									<button class="btn btn-primary register">Submit</button>
									<button type="button" class="btn btn-primary list">list</button>
							</span>
							</label> <input type="text" class="form-control" name="writer" value="${authInfo.memberId}" readonly="readonly">
							<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"> 
						</div>
						<div class="form-group">
							<h5>제목</h5> <input type="text" class="form-control"
								name="title">
						</div>
						<div class="form-group">
							<h5>내용</h5>
							<textarea class="form-control" rows="10" name="content"></textarea>
						</div>
						<div class="form-group">
						</div>

						<h5>파일 첨부</h5>
						<div class="uploadDiv">
							<input type="file" name="uploadFile" multiple="multiple">
						</div>
						<div class="uploadResultDiv">
							<!-- 파일업로드 결과 보여주기  -->
							<ul class="list-group"></ul>
						</div>
						
						<input type="hidden" name="status" value="VISIBLE">
						<input type="hidden" name="pageNum" value="${param.pageNum }">
						<input type="hidden" name="amount" value="${param.amount }">
						<input type="hidden" name="type" value="${param.type}">
						<input type="hidden" name="keyword" value="${param.keyword }">
						<input type="hidden" name="boardType"  value="${boardType}">
					</form>
				</div>	<!-- card-body END -->
			</div> <!-- card END -->
		</div> <!-- col END -->
	</div> <!-- row END -->
</div> <!-- container END -->


<script src="${ctxPath}/resources/js/register.js"></script>

<%@ include file="../includes/footer.jsp" %>

