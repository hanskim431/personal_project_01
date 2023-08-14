<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../includes/header.jsp"%>
<div class="container">
	<div class="row">
		<div class="col-12">
			<h1 class="page-header">
				<button data-oper="list" class="btn btn-info list">목록으로</button>		
				${board.title}
			</h1>
		</div>
	</div>
	
	<div class="row">
		<div class="col-12">
			<div class="card">
				<div class="card-header">
					Board Read Page
				</div>
				<div class="card-body">
					<div class="form-group">
						<label>번호</label>	
						<input class="form-control" name="bno" value="${board.bno}" readonly="readonly"/>
					</div>
					<div class="form-group">
						<label>제목</label>
						<input class="form-control" name="title" value="${board.title}" readonly="readonly"/>
					</div>
					<div class="form-group">
						<label>내용</label>
						<textarea class="form-control" rows="10" name="content" readonly="readonly">${board.content}</textarea>
					</div>
					<div class="form-group">
						<label>작성자</label>
						<input class="form-control" name="writer" value="${board.writer }" readonly="readonly"/>
					</div>
					<button data-oper="modify" class="btn btn-light modify">수정페이지</button>				
					<button data-oper="remove" class="btn btn-danger remove">게시글삭제</button>		
					
				</div>
			</div>
		</div>
	</div>
</div>

<form>
	<input type="hidden" name="bno"  value="${board.bno}">
</form>

<%@ include file="../includes/footer.jsp" %>

<script>
$(function(){
	// 목록 or 수정 페이지로
	let form = $('form')
	$('button').click(function(){
		let operration = $(this).data('oper');
		form.append($('<input/>',{type : 'hidden', name : 'pageNum', value : '${criteria.pageNum}'}))
			.append($('<input/>',{type : 'hidden', name : 'amount', value : '${criteria.amount}'}))
			.append($('<input/>',{type : 'hidden', name : 'type', value : '${param.type}'}))
			.append($('<input/>',{type : 'hidden', name : 'keyword', value : '${param.keyword}'}))
			.attr('method','get')
		if(operration=='list'){
			form.find('#bno').remove();
			form.attr('action','${ctxPath}/board/list')
		} else if(operration=='modify'){
			form.attr('action','${ctxPath}/board/modify')
		} else if(operration=='remove'){
			form.attr('action','${ctxPath}/board/remove')
				.attr('method','post')
		}
		form.submit();
	});
});
</script>