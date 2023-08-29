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

<div class="row my-5">
	<div class="col-lg-12">
		<div class="card">
			<div class="card-header">
				<h4>파일 첨부</h4>
			</div>
			<div class="card-body">
				<div class="uploadDiv">
					<input type="file" name="uploadFile" multiple="multiple">
				</div>
				<div class="uploadResultDiv mt-3"> <!-- 파일업로드 결과 보여주기  -->
					<ul class="list-group">
						<li class="list-group-item" data-uuid="radom-uuid">
							<div class="float-left">
								<div class="thumnail d-inline-block mr-3" style="width:40px">
									<img alt="" src="${ctxPath}/resources/images/attach.bmp" style="width: 100%">
								</div>
								<div class="d-inline-block">
									<a href="#">my_document.txt</a>
								</div>
							</div>
							<div class="float-right">
								<a href="#">삭제</a>
							</div>
						</li>
					</ul>
				</div>
			</div> <!-- panel-body -->
		</div> <!-- panel end -->
	</div> <!-- col end -->
</div><!-- row end -->

<script src="${ctxPath}/resources/js/register.js"></script>

<%@ include file="../includes/footer.jsp" %>

