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
					<form action="${ctxPath}/board/register" method="post">
						<div class="form-group">
							<label>작성자 <span class="float-right d-flex">
									<button type="fileAttach" class="btn btn-primary">file</button>
									<button type="submit" class="btn btn-primary">Submit</button>
									<button type="button" class="btn btn-primary list">list</button>
							</span>
							</label> <input type="text" class="form-control" name="writer">
						</div>
						<div class="form-group">
							<label>제목</label> <input type="text" class="form-control"
								name="title">
						</div>
						<div class="form-group">
							<label>내용</label>
							<textarea class="form-control" rows="10" name="content"></textarea>
						</div>
						<div class="form-group">
							<label>첨부파일 목록</label>

						</div>
						<input type="hidden" name="boardType" value="BOARD3"> 
						<input type="hidden" name="status" value="VISIBLE">
						<input type="hidden" name="pageNum" value="${param.pageNum }">
						<input type="hidden" name="amount" value="${param.amount }">
						<input type="hidden" name="type" value="${param.type}">
						<input type="hidden" name="keyword" value="${param.keyword }">
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

<script>
$(function(){
	$('.list').click(function(e){
		e.preventDefault();
		let form = $('<form/>')
		let type = $('[name="type"]');
		let keyword = $('[name="keyword"]');
		if(type.val()&&keyword.val()){
			form.append(type).append(keyword);				
		}
		form.attr('action','${ctxPath}/board/${boardType}/list')
			.append($('[name="pageNum"]'))
			.append($('[name="amount"]'))
			.appendTo('body')
			.submit();
	})
})
</script>
