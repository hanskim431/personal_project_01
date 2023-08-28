$(function(){
	let uploadResultList = [];
	let showUploadResult = function(attachList){
		let fileList = '';
		$.each(attachList,function(i,e){
			uploadResultList.push(e); // 첨부파일 배열의 요소로 추가
			fileList += `
			<li class="list-group-item" data-uuid="${e.uuid}">
				<div class="float-left">
					<div class="thumnail d-inline-block mr-3" style="width:40px">
						<img alt="" src="${ctxPath}/resources/images/attach.bmp" style="width: 100%">
					</div>
					<div class="d-inline-block">
						<a href="#">${e.fileName}</a>
					</div>
				</div>
				<div class="float-right">
					<a href="#">삭제</a>
				</div>
			</li>`				
		});
		$('.uploadResultDiv ul').append(fileList);
	}
	
	// 게시물 목록
	$('.list').click(function(e){
		e.preventDefault();
		let form = $('<form/>')
		let type = $('[name="type"]');
		let keyword = $('[name="keyword"]');
		
		if(type.val()&&keyword.val()){
			form.append(type).append(keyword);				
		}
		
		form.attr('action',`${ctxPath}/board/${boardType}/list`)
			.append($('[name="pageNum"]'))
			.append($('[name="amount"]'))
			.appendTo('body')
			.submit();
			
	})
	
	// 파일 업로드 이벤트 
	$('input[type="file"]').change(function(){
		let formData = new FormData(); 
		let files = this.files;
		
		for(let f of files){
			formData.append('uploadFile', f);
		}
		
		$.ajax({
			url : `${ctxPath}/files/upload`, 
			type : 'post', 
			processData : false, 
			contentType : false, 
			data : formData, 
			dataType : 'json', 
			success : function(attachList){
				uploadResultList = attachList;
				showUploadResult(attachList);
			}
		});
	});
	
	$('.register').click(function(e){
		e.preventDefault();
		let form = $('form');
		if(uploadResultList.length>0){ // 첨부파일이 있으면 
			$.each(uploadResultList, function(i,e){
				let uuid = $('<input/>',{type:'hidden', name:`attachList[${i}].uuid`, value:`${e.uuid}`})
				let fileName = $('<input/>',{type:'hidden', name:`attachList[${i}].fileName`, value:`${e.fileName}`})
				let fileType = $('<input/>',{type:'hidden', name:`attachList[${i}].fileType`, value:`${e.fileType}`})
				let uploadPath = $('<input/>',{type:'hidden', name:`attachList[${i}].uploadPath`, value:`${e.uploadPath}`})
				form.append(uuid)
					.append(fileName)
					.append(fileType)
					.append(uploadPath)
			})
		}
		form.submit();	
	})
})