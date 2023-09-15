<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../includes/header.jsp"%>
<div class="container">
	<div class="row">
		<div class="col-1 text-center getBtns" style="padding:0;">
			<a data-oper="back" class="btn btn-light back" href="#">
				<img alt="←" src="${ctxPath}/resources/images/icon/arrow-back.png" style="width: 35px; height: 35px;"/>
			</a>
		</div>
		<div class="col-11">
			<h1 class="page-header">글 작성</h1>
		</div>
	</div>
	
	<div class="row">
		<div class="col-12">
			<div class="card">
				<div class="card-body">
					<form action="${ctxPath}/board/${boardType}/register" method="post">
						<div class="form-group">
							<label>제목 </label>
							<input class="form-control" name="title"/>
						</div>
						<div class="form-group">
							<label>내용 </label>
							<textarea class="form-control" rows="10" name="content"></textarea>
						</div>
						<div class="form-group">
							<input type="hidden" class="form-control" name="writer" value="${authInfo.memberId}" readonly="readonly"/>
							<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/> 
						</div>	
						
						<input type="hidden" name="boardType"  value="${boardType}">
						<input type="hidden" name="status" value="VISIBLE">		
						
						<button class="btn btn-outline-primary register">Submit Button</button>
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

<script>
$(function(){
	// 목록 or 수정 페이지로
	let form = $('form');
	
	$('.getBtns a').click(function(e){
		e.preventDefault();
		let operation = $(this).data('oper');
		let type = '${criteria.type}'
		let keyword = '${criteria.keyword}'
			
		form.append($('<input/>',{type : 'hidden', name : 'pageNum', value : '${criteria.pageNum}'}))
			.append($('<input/>',{type : 'hidden', name : 'amount', value : '${criteria.amount}'}))
			.append($('<input/>',{type : 'hidden', name : 'boardType', value : '${boardType}'}))
			.append($('<input/>',{type : 'hidden', name : '${_csrf.parameterName}', value : '${_csrf.token}'}))
			.append($('<input/>',{type : 'hidden', name : 'bno', value : '${board.bno}'}))
			.append($('<input/>',{type : 'hidden', name : 'writer', value : '${board.writer}'}))
		.attr('method','get')
		
		if(type&&keyword){
			form.append($('<input/>',{type : 'hidden', name : 'type', value : '${criteria.type}'}))
				.append($('<input/>',{type : 'hidden', name : 'keyword', value : '${criteria.keyword}'}))
		}
		
		if(operation=='back'){
			history.back();
		} 
	});
});
</script>

<script src="${ctxPath}/resources/js/checkExtension.js"></script>
<script src="${ctxPath}/resources/js/register.js"></script>