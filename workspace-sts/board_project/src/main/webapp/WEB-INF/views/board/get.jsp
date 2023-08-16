<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../includes/header.jsp"%>
<div class="container">
	<div class="row">
		<div class="col-12">
			<h1 class="page-header">
				<div class="getBtns">
					<button data-oper="list" class="btn btn-info list">목록으로</button>		
					${board.title}
				</div>
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
					<div class="getBtns">
						<button data-oper="modify" class="btn btn-light modify">수정페이지</button>				
						<button data-oper="remove" class="btn btn-danger remove">게시글삭제</button>		
						<button class="btn btn-warning back-to-top-css" data-toggle="collapse" data-target=".reply">댓글</button>		
					</div>
					
				</div>
			</div>
		</div>
	</div>
</div>

<div class="container reply collapse">
	<h3 class="mt-5">댓글</h3>
	<div class="row">
		<div class="col-12">
			<ul class="list-group chat">
				<li class="list-group-item" data-rno="댓글번호">
					<div class="d-flex justify-content-between">
						<div class="d-flex">
							<div class="user_image mr-3" style="width: 75px">
								<img class="rounded-circle" alt="userImg" 
								src="${ctxPath}/resources/images/profile.bmp" style="max-width:70%">
							</div>
							<div class="comment_wrap">
								<div class="comment_info">
									<span class="userName badge badge-pill badge-info mr-2">홍길동</span>
									<span class="badge badge-dark">작성시간</span>
								</div>
								<div class="comment_content py-2">댓글 내용입니다.</div>
							</div>
						</div><!-- d-flex-end -->
						<div class=reply_modify"">
							<button type="button" class="btn btn-light dropdown-toggle" 
							data-toggle="dropdown">변경</button>
							<div class="dropdown-menu">
								<a class="dropdown-item" href="modify">수정</a>
								<a class="dropdown-item" href="delete">삭제</a>
							</div>
						</div><!-- reply_modify-end -->
					</div><!-- d-flex justify-content-between-end -->
				</li>
			</ul>
		</div><!-- col-12-end -->
	</div><!-- row-end -->

	<div class="replyWriterForm my-3">
		<textarea rows="6" placeholder="댓글을 작성해 주세요." maxlength="400" 
		class="replyContent form-control"></textarea>
		<div class="text-right">
			<div class="submit p-2">
				<span class="btn btn-outline-info col-2 replyer">admin1</span>
				<button class="btn btn-outline-primary col-3">등록</button>
			</div>
		</div><!-- text-right-end --
	</div><!-- replyWriterForm-end -->
</div><!-- container-end -->

<!-- <button class="btn btn-danger addBtn">댓글 추가 테스트</button>		 -->
<!-- <button class="btn btn-danger updateBtn">댓글 수정 테스트</button>		 -->
<!-- <button class="btn btn-danger deleteBtn">댓글 삭제 테스트</button>		 -->

<form>
	<input type="hidden" name="bno"  value="${board.bno}">
</form>

<%@ include file="../includes/footer.jsp" %>

<script src="${ctxPath}/resources/js/replyService.js"></script>
<script src="${ctxPath}/resources/js/reply.js"></script>
<script>
$(function(){
	
	$('.addBtn').click(function(){
		var replyVO = {
			bno : '1', 
			reply: 'ajax : 댓글 추가 테스트 ', 
			replyer : 'admin1'
		};
		var callback = function(result){
			alert("실행 결과 : " + result)
		};
		var error = function(er){
			alert("실행 결과 : " + er)
		}; 
		replyService.add(replyVO,callback,error);
	});
	
	let param = {bno : 1, pageNum : 1}
	replyService.getList(param, function(list){
		console.log(list);
	});
	
	replyService.get(1,function(data){
		console.log(data);
	}); 
	
	$('.updateBtn').click(function(){
		var replyVO = {
			rno : '2', 
			reply: 'ajax : 댓글 수정 테스트 ', 
			status : 'HIDDEN' 
		};
		var callback = function(result){
			alert("실행 결과 : " + result)
		};
		var error = function(er){
			alert("실행 결과 : " + er)
		}; 
		replyService.update(replyVO,callback,error);
	});
	
	$('.deleteBtn').click(function(){
		var callback = function(result) {
			alert("실행 결과 : " + result)
		};
		var error = function(er){
			alert("실행 결과 : " + er)
		};
		replyService.remove(3,callback,error);
	})
	
})
</script>

<script>
$(function(){
	// 목록 or 수정 페이지로
	let form = $('form')
	$('.getBtns button').click(function(){
		let operration = $(this).data('oper');
		form.append($('<input/>',{type : 'hidden', name : 'pageNum', value : '${criteria.pageNum}'}))
			.append($('<input/>',{type : 'hidden', name : 'amount', value : '${criteria.amount}'}))
			.append($('<input/>',{type : 'hidden', name : 'type', value : '${param.type}'}))
			.append($('<input/>',{type : 'hidden', name : 'keyword', value : '${param.keyword}'}))
			.attr('method','get')
		if(operration=='list'){
			form.find('#bno').remove();
			form.attr('action','${ctxPath}/board/list')
			form.submit();
		} else if(operration=='modify'){
			form.attr('action','${ctxPath}/board/modify')
			form.submit();
		} else if(operration=='remove'){
			form.attr('action','${ctxPath}/board/remove')
				.attr('method','post')
			form.submit();
		}
	});
});
</script>