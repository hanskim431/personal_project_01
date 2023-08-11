<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../includes/header.jsp" %>

<div class="container">
	<div class="row">
		<div class="col-12">
			<div class="card">
				<div class="card-header"></div><!-- card-header end -->
				<div class="card-body">
					<div class="form-group">
						<label>
							<div class="dropdown">
								제목
							    <button class="btn btn-primary dropdown-toggle" type="button" data-toggle="dropdown">Dropdown
							    <span class="caret"></span></button>
							    <ul class="dropdown-menu">
							      <li><a href="#" class="report">신고</a></li>
							      <li><a href="" class="modify">수정</a></li>
							      <li><a href="" class="remove">삭제</a></li>
							    </ul>
							</div>
						</label>
						<input type="text" class="form-control" name="title" value="${board.title}" readonly="readonly">
					</div>
					<div class="form-group">
						<label>작성자</label>
						<input type="text" class="form-control" name="writer" value="${board.writer}" readonly="readonly">
					</div>
					<div class="form-group">
						<label>내용</label>
						<textarea class="form-control" rows="10" cols="" name=content readonly="true">${board.content}</textarea>
					</div>
					
					
					<form>
						<input type="hidden" name="bno" value="${board.bno}">
					</form>

				</div><!-- card-body end -->
			</div><!-- card end -->
		</div><!-- col-12 end -->
	</div><!-- row end -->
</div><!-- container end -->

<script>
$(function(){
	let getForm = $('form');

	$('.modify').click(function(e){
		e.preventDefault();
		getForm.attr('action','${ctxPath}/board/modify')
				.attr('method','get')
				.submit();
	})

	$('.remove').click(function(e){
		e.preventDefault();
		getForm.attr('action','${ctxPath}/board/remove')
				.attr('method','post')
				.submit();
	})

})

</script>

<%@ include file="../includes/footer.jsp" %>
