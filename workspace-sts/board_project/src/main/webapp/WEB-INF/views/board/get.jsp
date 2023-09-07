<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../includes/header.jsp"%>

<style>
.userimage img {
	width: 45px;
	height: 45px;
}
.menu img{
	height: 30px;
}

</style>

<div class="container">
	<!-- 본문 -->
	<div class="row">
		<div class="col-12">
			<div class="card">
				<div class="card-header">
					<div class="row my-2"> <!-- row1 -->
						<div class="col-1 text-center getBtns" style="padding:0;">
							<a data-oper="list" class="btn btn-light list dropdown-item" href="#">
								<img alt="←" src="${ctxPath}/resources/images/icon/arrow-back.png" style="width: 35px; height: 35px;"/>
							</a>
						</div>
						<div class="col-11" style="padding:0;">
							<h2 class="float-left" style="margin:0;">${board.title}</h2>
						</div>
					</div>
				
				</div>
				<div class="card-header">
					<div class="row">
						<div class="col-1 userimage text-center" style="margin:auto; padding:0px">
							<a class="userpage" href="#">
								<img class="rounded-circle" alt="userimage" src="${ctxPath}/resources/images/member/userImage.png">
							</a>
						</div>
						<div class="col-10 text-left" style="margin:auto; padding:0px">
							<span style="font-size:18px;">${board.writer }</span>
							<span class="mx-2" style="font-size:12px;">
								<tf:formatDateTime value="${board.regDate}" pattern="yy-MM-dd HH:mm" />
							</span>
						</div>
						<div class="col-1 menu text-center" style="margin:auto; padding:0px">
							<div class="dropdown">
								<img alt="menu" src="${ctxPath}/resources/images/icon/menu-kebab.png" 
									class="btn dropdown-toggle" type="button" id="dropdownMenuButton" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
								<div class="dropdown-menu getBtns" aria-labelledby="dropdownMenuButton">
									<a class="dropdown-item" href="#">
										<img class="" alt="report" src="${ctxPath}/resources/images/icon/report.png">
										신고
									</a>
									<sec:authorize access="isAuthenticated() and principal.username== #board.writer or hasRole('ROLE_ADMIN')">
										<a data-oper="modify" class="btn btn-light modify dropdown-item" href="#">
											<img class="" alt="edit" src="${ctxPath}/resources/images/icon/edit.png">
											수정
										</a>
										<a data-oper="remove" class="btn btn-light remove dropdown-item" href="remove">
											<img class="" alt="remove" src="${ctxPath}/resources/images/icon/remove.png">
											삭제
										</a>
									</sec:authorize>
								</div>
							</div>
						</div>
					</div>
				</div>
				<div class="card-body">
					<div class="row">
						<div class="col-6 uploadResultDiv"><!-- 파일업로드 결과 보여주기  -->
								<div></div>
						</div>
						<div class="col-6">
							<div class="form-group">
								<textarea class="form-control" rows="10" name="content" readonly="readonly">${board.content}</textarea>
							</div>
							<div class="getBtns text-right">
								<button class="btn btn-warning back-to-top-css"
									data-toggle="collapse" data-target=".reply">댓글
									${board.replyCnt==0?'':board.replyCnt}</button>
								<sec:authorize access="isAuthenticated()">
									<button class="btn btn-danger like">추천 ${board.likeHit == 0 ? '' : board.likeHit}</button>
								</sec:authorize>
								<sec:authorize access="!isAuthenticated()">
									<button class="btn btn-danger" onclick="alert('로그인이 필요한 서비스입니다.'); location.href='${ctxPath}/login'">
										추천 ${board.likeHit == 0 ? '' : board.likeHit}
									</button>
								</sec:authorize>
							</div> <!-- getBtns END -->
						</div>
					</div>
					
					
				</div><!-- card-body END -->
			</div><!-- card END -->
		</div><!-- col END  -->
	</div><!-- row END -->
	
<!-- 댓글 -->
<div class="container reply collapse">
	<div class="replyWriterForm my-3">
		<sec:authorize access="isAnonymous()"> 
			<div class="text-right">
				<div class="submit p-2">
					<a class="btn btn-outline-primary col-3" href="${ctxPath}/login">로그인</a>
				</div>
			</div><!-- text-right-end -->
			<textarea rows="2" placeholder="로그인한 사용자만 댓글을 쓸 수 있습니다.." onclick="alert('로그인이 필요한 서비스입니다.'); location.href='${ctxPath}/login'"
			maxlength="400" class="replyContent form-control" readonly="readonly"></textarea>
		</sec:authorize>
		<sec:authorize access="isAuthenticated()"> 
			<div class="text-right">
				<div class="submit p-2">
					<span class="btn btn-outline-info col-2 replyer">admin1</span>
					<button class="btn btn-outline-primary col-3">등록</button>
				</div>
			</div><!-- text-right-end -->
			<textarea rows="2" placeholder="댓글을 작성해 주세요." maxlength="400" class="replyContent form-control"></textarea>
		</sec:authorize>
	</div><!-- replyWriterForm-end -->

	<div class="row">
		<div class="col-12">
			<ul class="list-group chat">
				<li class="list-group-item" data-rno="댓글번호">
					<div class="d-flex justify-content-between">
						<div class="d-flex">
							<div class="user_image mr-3" style="width: 75px">
								<img class="rounded-circle" alt="userImg"
									src="${ctxPath}/resources/images/profile.bmp"
									style="max-width: 70%">
							</div>
							<div class="comment_wrap">
								<div class="comment_info">
									<span class="userName badge badge-pill badge-info mr-2">홍길동</span>
									<span class="badge badge-dark">작성시간</span>
								</div>
								<div class="comment_content py-2">댓글 내용입니다.</div>
							</div>
						</div>
						<!-- d-flex-end -->
							<div class="reply_modify">
								<button type="button" class="btn btn-light dropdown-toggle"
									data-toggle="dropdown">변경</button>
								<div class="dropdown-menu">
									<a class="dropdown-item" href="modify">수정</a> 
									<a class="dropdown-item" href="delete">삭제</a>
								</div>
							</div> <!-- reply_modify-end -->
					</div> <!-- d-flex justify-content-between-end -->
				</li>
			</ul>
			<div class="card">
				<div class="row mt-2">
					<div class="col-12 pagination_wrap d-flex justify-content-center"></div>
				</div>
				<button class="btn btn-warning back-to-top-css" data-toggle="collapse" data-target=".reply">댓글 닫기</button>
			</div>
		</div> <!-- col-12-end -->
	</div> <!-- row-end -->


</div><!-- container-end -->


<form>
	<input type="hidden" name="bno"  value="${board.bno}">
	<input type="hidden" name="boardType"  value="${boardType}">
<%-- 	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"> --%>
</form>

<%@ include file="../includes/footer.jsp" %>

<script>
$(function(){
	// 목록 or 수정 페이지로
	let form = $('form')
	
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
		
		if(operation=='list'){
			form.find('#bno').remove();
			form.attr('action','${ctxPath}/board/${boardType}/list')
			//form.submit();
			history.back();
		} else if(operation=='modify'){
			form.attr('action','${ctxPath}/board/${boardType}/modify')
			form.submit();
		} else if(operation=='remove'){
			form.attr('action','${ctxPath}/board/${boardType}/remove')
				.attr('method','post')
			form.submit();
			history.back();
		}
	});
});

$(function() {

	$('.back-to-top-css').click(function() {
		// 댓글 영역으로 스크롤 이동
		$('html, body').animate({scrollTop : $(document).height()}, 'slow');
	});

});

$(function() {

	$('.like').click(function(e) {
		e.preventDefault();
		let bno = $('[name="bno"]').val();

		$.ajax({
			type : 'post',
			url : '${ctxPath}/board/${boardType}/like',
			data : {
				memberId : memberId,
				bno : bno
			},
			success : function(message) {
				alert(message);
				isLike();
			}
		})
	})
});

function isLike(){
	let bno = $('[name="bno"]').val();
	$.ajax({
		type : 'post',
		url : '${ctxPath}/board/${boardType}/islike',
		data : {memberId : memberId , bno : bno},
		success : function(result){
			if(result){
				$('.like').html('추천취소')
			} else {
				$('.like').html('추천')
			}
		}
	})
}

if(memberId!=''){
	isLike();
}
</script>

<script src="${ctxPath}/resources/js/replyService.js"></script>
<script src="${ctxPath}/resources/js/reply.js"></script>
<script src="${ctxPath}/resources/js/boardAttach.js"></script>
