$(function(){
	let bno = $('[name="bno"]').val()
	let replyContainer = $('.chat');
	
	// 댓글 조회
	let showList = function(pageNum){
		let param = {bno:bno, pageNum : pageNum||1};
		replyService.getList(param,function(list){
			let replyList = '';
			$.each(list,function(idx,elem){
				replyList += `<li class="list-group-item" data-rno="${elem.rno}">
					<div class="d-flex justify-content-between">
						<div class="d-flex">
							<div class="user_image mr-3" style="width: 75px">
								<img class="rounded-circle" alt="userImg" 
								src="${ctxPath}/resources/images/profile.bmp" style="max-width:70%">
							</div>
							<div class="comment_wrap">
								<div class="comment_info">
									<span class="userName badge badge-pill badge-info mr-2">${elem.replyer}</span>
									<span class="badge badge-dark">${elem.regdate}</span>
								</div>
								<div class="comment_content py-2">${elem.reply}</div>
							</div>
						</div><!-- d-flex-end -->
						<div class=reply_modify"">
							<button type="button" class="btn btn-light dropdown-toggle" 
							data-toggle="dropdown">변경</button>
							<div class="dropdown-menu">
								<button class="btn dropdown-item modify" href="">수정</button>
								<button class="btn dropdown-item delete" href="">삭제</button>
							</div>
						</div><!-- reply_modify-end -->
					</div><!-- d-flex justify-content-between-end -->
				</li>`;
			});
			replyContainer.html(replyList);
		})
	}
	showList(1);
	
	// 댓글 등록 처리
	$('.submit button').click(function(){
		let reply = {
			bno : bno,
			reply : $('.replyContent').val(),
			replyer : $('.replyer').html()
		}
		
		replyService.add(reply,function(result){
			if(result=='success'){
				alert('댓글을 등록하였습니다.')
			} else {
				alert('댓글 등록 실패')
			}
			$('.replyContent').val('');
			showList(1);
		});
		
	});
	
	// 댓글 등록 처리
	$('.dropdown-item .modify').click(function(){
		e.preventDefault();// a태그  기본동작 금지
		console.log('test');
	});
	
})