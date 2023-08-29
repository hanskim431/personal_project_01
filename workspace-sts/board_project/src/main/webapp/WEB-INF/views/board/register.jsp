<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../includes/header.jsp"%>
<div class="container">
	<div class="row">
		<div class="col-12">
			<h1 class="page-header">Tables</h1>
		</div>
	</div>
	
	<div class="row">
		<div class="col-12">
			<div class="card">
				<div class="card-header">Board Register</div>
				<div class="card-body">
					<form action="${ctxPath}/board/${boardType}/register" method="post">
						<div class="form-group">
							<label>Title </label>
							<input class="form-control" name="title"/>
						</div>
						<div class="form-group">
							<label>Text area </label>
							<textarea class="form-control" rows="10" name="content"></textarea>
						</div>
						<div class="form-group">
							<label>Writer </label>
							<input class="form-control" name="writer" value="${authInfo.memberId}" readonly="readonly"/>
							<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/> 
						</div>	
						
						<input type="hidden" name="boardType"  value="${boardType}">
						<input type="hidden" name="status" value="VISIBLE">		
						
						<button class="btn btn-outline-primary register">Submit Button</button>
						<button type="button" class="btn btn-outline-info list">List</button>		
					</form>
				</div>
			</div>
		</div>
	</div>
	
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
						<ul class="list-group"></ul>
					</div>
				</div> <!-- card-body -->
			</div> <!-- card end -->
		</div> <!-- col end -->
	</div><!-- row end -->
</div>

<input type="hidden" name="pageNum" value="${param.pageNum }" >
<input type="hidden" name="amount" value="${param.amount }" >
<input type="hidden" name="type" value="${param.type }" >
<input type="hidden" name="keyword" value="${param.keyword }" >

<%@ include file="../includes/footer.jsp" %>

<script src="${ctxPath}/resources/js/register.js"></script>