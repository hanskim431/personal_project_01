$(function(){
	let replyer = memberId;
	let replyContainer = $('.chat');
	let pageNum = 1; // 기본 페이지 번호  
	let paginationWrap = $('.pagination_wrap');
	// 페이지네이션
	
	// showList 함수에서 호출
	let showReplyPage = function(replyCount){
		let endNum = Math.ceil(pageNum/10.0)*10; // 끝페이지
		let startNum = endNum - 9; // 첫페이지
		let tempEndNum = Math.ceil(replyCount/10.0); // 댓글수
			
			let prev = startNum !=1; 
			let next = endNum < tempEndNum;
			if(endNum>tempEndNum) endNum = tempEndNum;
	
		let pagination = '<ul class="pagination">';
		
		if(prev){ // 이전 버튼 
			pagination += `<li class="page-item">
					<a class="page-link" href="${startNum-1}">이전</a></li>`
		} else { // 이전 버튼 비활성화
			pagination += `<li class="page-item disabled">
					<a class="page-link" href="${startNum-1}">이전</a></li>`
		}
		
		for(let pageLink=startNum; pageLink<= endNum ; pageLink++){ // 페이지 버튼
			let active = (pageNum==pageLink) ? 'active':''; // 현재페이지버튼 활성화
			pagination += `<li class="page-item ${active}">
					<a class="page-link" href="${pageLink}">${pageLink}</a></li>`
		}
		
		if(next){ // 다음 버튼 
			pagination += `<li class="page-item">
					<a class="page-link" href="${endNum+1}">다음</a></li>`
		} else { // 다음 버튼 비활성화
			pagination += `<li class="page-item disabled">
					<a class="page-link" href="${endNum+1}">다음</a></li>`
		
		}
		
		pagination += '</ul>'
		paginationWrap.html(pagination);
	}
	
	// 페이지 이동 이벤트 
	paginationWrap.on('click','li a', function(e){
		e.preventDefault();
		let targetPageNum = $(this).attr('href');
		pageNum = targetPageNum;
		showList(pageNum);
	})
	
	
	// 댓글 조회
	let showList = function(page){
		let param = {replyer:replyer, page: page||1};
		replyService.getListByMemberId(param,function(replyCount,list){
			// 글 작성 후 마지막 페이지 호출
			if(page==-1){ // 글 작성후 마지막 페이지 호출
				pageNum = Math.ceil(replyCount/10.0);
				showList(pageNum);
				return;
			}
			
			if(page==-2){ // 글 삭제  
				pageNum = replyCount%10==0 ? pageNum-1 : pageNum;
				showList(pageNum);
				return; 
			}
			
			
			// 댓글이 존재하지 않을 경우 
			if(replyCount==0){
				replyContainer.html('등록된 댓글이 없습니다.');
				return;
			}
			
		
			let replyList = '';
			$.each(list,function(idx,elem){
				replyList += `<li class="list-group-item" data-rno="${elem.rno}">
					<div class="d-flex justify-content-between">
						<div class="d-flex">
							<div class="mr-3">
								<a href="${ctxPath}/board/${boardType}/get/${elem.bno}">
									게시글 보기
								</a>
							</div>
							<div class="comment_wrap">
								<div class="comment_info">
									<span class="userName badge badge-pill badge-info mr-2">${elem.replyer}</span>
									<span class="badge badge-dark">${elem.regdate}</span>
								</div>
								<div class="comment_content py-2">${elem.reply}</div>
							</div>
						</div><!-- d-flex-end -->`;
						
						if(memberId== elem.replyer || auth.includes('ROLE_ADMIN')) {
						replyList += `<div class="reply_modify">
							<a class="btn btn-outline-basic" href="delete">
								<img class="" alt="remove" src="${ctxPath}/resources/images/icon/remove.png" style="width:30px">
								삭제
							</a>
						</div><!-- reply_modify-end -->`;
						}
						
					replyList += `</div><!-- d-flex justify-content-between-end -->
				</li>`;
			});
			replyContainer.html(replyList);
			showReplyPage(replyCount);
		})
	}
	showList(1);
	
	// 댓글 등록 처리
	$('.submit button').click(function(){
		let reply = {
			bno : bnoValue,
			reply : $('.replyContent').val(),
			replyer : $('.replyer').html()
		}
		
		replyService.add(reply,function(result){
			if(result=='success'){
				//alert('댓글을 등록하였습니다.')
			} else {
				alert('댓글 등록 실패')
			}
			$('.replyContent').val('');
			showList(-1);
		});
		
	});
	
	// 댓글 등록 처리
	$('.chat').on('click', '.reply_modify a', function(e){
		e.preventDefault();
		
		let rno = $(this).closest('li').data('rno');
		let operation = $(this).attr('href');
		let replyer = $(this).closest('li').find('.userName').text();
		
		if(replyer != memberId && !auth.includes('ROLE_ADMIN')){
			alert('권한이 없습니다.')
			return;
		}
		
		
		if(operation=='delete'){
			replyService.remove(rno,function(result){
				if(result=='success'){
					alert('댓글을 삭제하였습니다.');
					showList(-2);
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
				
				// 수정 처리 메소드  호출  
				replyService.update(replyVO, function(result){
					alert(result);
					showList(pageNum);
				})
			})
			return;
		}
    });
    
    
})