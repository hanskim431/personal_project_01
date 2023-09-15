<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../includes/header.jsp"%>

<div class="container">
	<div class="row">
		<div class="col-12">
			<h1 class="page-header"></h1>
		</div>
	</div>

	<div class="row">
		<div class="col-12">
			<ul class="list-group chat"><li></li>
			</ul>
			<div class="card">
				<div class="row mt-2">
					<div class="col-12 pagination_wrap d-flex justify-content-center"></div>
				</div>
			</div>
		</div> <!-- col-12-end -->
	</div> <!-- row-end -->
</div><!-- container end -->

<script>
	console.log('${criteria.type}')
	console.log('${boardType}')
	//페이지 이동 
	let listForm = $('#listForm');
	$('.pagination a').click(function(e) {
		e.preventDefault();
		let pageNum = $(this).attr('href');
		listForm.find('input[name="pageNum"]').val(pageNum)
		listForm.submit();
	})
	
// 조회 페이지로 이동 
	$('.move').click(function(e){
		e.preventDefault();
		let bnoValue = $(this).attr('href');
	    let boardType = $(this).closest('tr').find('td:eq(1)').text();
		listForm.append($('<input/>',{type : 'hidden', name : 'bno', value : bnoValue}))
				.attr('action','${ctxPath}/board/'+boardType+'/get')
				.submit();
	});
	
	// 게시물 수 변경 
	$('.amount').change(function(){
		let amount = $(this).val();
		listForm.find('input[name="amount"]').val(amount)
		listForm.find('input[name="pageNum"]').val(1)
		listForm.submit();		
	})
	
	
	// 검색 이벤트 처리 
	let searchForm = $('#searchForm');
	$('#searchForm button').click(function(e){
		e.preventDefault();
		if(!searchForm.find('[name="keyword"]').val()){
			alert('키워드를 입력하세요');
			return; 
		}
		searchForm.submit();
	});
</script>

<%@ include file="../includes/footer.jsp"%>


<script src="${ctxPath}/resources/js/replyService.js"></script>
<script src="${ctxPath}/resources/js/memberReply.js"></script>