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
					<form action="${ctxPath}/board/${boardType}/modify" class="modifyForm" method="post">
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
						<input type="hidden" name="bno" value="${board.bno}"> 
						<input type="hidden" name="boardType" value="BOARD3"> 
						<input type="hidden" name="status" value="VISIBLE">
						<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
					</form>
				</div><!-- card-body END -->
			</div><!-- card END -->
		</div><!-- col-12 END -->
	</div><!-- row END -->

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
					<div class="uploadResultDiv mt-3">
						<!-- 파일업로드 결과 보여주기  -->
						<ul class="list-group"></ul>
					</div>
				</div><!-- card-body -->
			</div><!-- card END -->
		</div><!-- col END -->
	</div><!-- row END -->

	<!-- 원본 이미지 -->
	<div class="modal fade" id="showImage">
		<div class="modal-dialog modal-lg">
			<div class="modal-content">
				<div class="modal-header">
					<h4 class="modal-title">원본 이미지 보기</h4>
					<button type="button" class="close" data-dismiss="modal">&times;</button>
				</div>
				<div class="modal-body"></div>
			</div><!-- modal-content END -->
		</div><!-- modal-dialog END -->
	</div><!-- modal END -->

</div><!-- container END -->

<%@ include file="../includes/footer.jsp"%>

<script>
let formObj = $('.modifyForm');
let type = '${criteria.type}'
let keyword = '${criteria.keyword}'
let addCriteria = function(){
	formObj.append($('<input/>',{type : 'hidden', name : 'pageNum', value : '${criteria.pageNum}'}))
		   .append($('<input/>',{type : 'hidden', name : 'amount', value : '${criteria.amount}'}))
	if(type&&keyword){
		formObj.append($('<input/>',{type : 'hidden', name : 'type', value : '${criteria.type}'}))
			.append($('<input/>',{type : 'hidden', name : 'keyword', value : '${criteria.keyword}'}))
	}
}
</script>

<script src="${ctxPath}/resources/js/modify.js"></script>
