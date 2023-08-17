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
						<div class="reply_modify">
							<button type="button" class="btn btn-light dropdown-toggle" 
							data-toggle="dropdown">변경</button>
							<div class="dropdown-menu">
						      <a class="dropdown-item" href="modify">수정</a>
						      <a class="dropdown-item" href="delete">삭제</a>
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
	$('.chat').on('click', '.reply_modify a', function(e){
	    console.log('수정 삭제 버튼 클릭');
		e.preventDefault();
		
		let rno = $(this).closest('li').data('rno');
		let operation = $(this).attr('href')
		
		if(operation=='delete'){
			replyService.remove(rno,function(result){
				if(result=='success'){
					alert('댓글을 삭제하였습니다.');
					showList(1);
				} else {
					alert('댓글 삭제 실패');
				}
			});
			return;
		}
		
		if(operation=='modify'){
			let replyUpdateForm = $('.replyWriterForm').clone();
			replyUpdateForm.attr('class','replyUpdateForm');
			let updateBtn = replyUpdateForm.find('.submit button').html('수정');
			
			let listTag = $(this).closest('li');
			let replyUpdateFormLength = listTag.find('.replyUpdateForm').length;
			if(replyUpdateFormLength>0){
				listTag.find('.replyUpdateForm').remove();
				$(this).html('수정');
				$(this).next().show();
				return;
			}
			
			replyService.get(rno,function(data){
				replyUpdateForm.find('.replyContent').val(data.reply);
				replyUpdateForm.find('.replyer').html(data.replyer);
			})
			
			$(this).closest('li').append(replyUpdateForm);
			$(this).html('취소');
			$(this).next().hide();
			
			updateBtn.click(function(){
				let replyVO = {
					rno : rno,
					reply : replyUpdateForm.find('.replyContent').val()
				}
				
				// 수정 처리 메소드 호출
				replyService.update(replyVO, function(result){
					alert(result);
					showList(1);
				})
			})
			return;
		}
    });
})