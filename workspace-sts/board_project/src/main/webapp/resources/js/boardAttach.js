$(function(){
	let bnoValue = $('[name="bno"]').val()
	
    $.getJSON(
	    `${ctxPath}/board/${boardType}/getAttachList`,
	    {bno:bnoValue},
	    function(attachList){
			let fileList = '';
			$(attachList).each(function(i,e){
				fileList += `<div class="text-center" data-uuid="${e.uuid}">`
				if(e.fileType){ // 이미지 파일인 경우 사진 표시
					let filePath = e.uploadPath+"/m_"+e.uuid+"_"+e.fileName; 
					let encodingFilePath = encodeURIComponent(filePath);
					
					$('.col-12 .textDiv').attr('class', 'col-6 textDiv')
					$('.uploadResultDiv').attr('class', 'col-6 uploadResultDiv')
					
					fileList +=`
						<div class="thumnail d-inline-block mr-3">
							<img alt="" src="${ctxPath}/files/display?fileName=${encodingFilePath}">	
						</div>				
					`
				} else {
					fileList +=` 
						<div class="thumnail d-inline-block mr-3" style="width:40px">
							<img alt="" src="${ctxPath}/resources/images/attach.png" style="width: 100%">
						</div>`
				}
				/*fileList +=		
					`<div class="d-inline-block">
						${e.fileName}
					</div>
					</div>
					<div class="float-right">`
				
				if(e.fileType){
					fileList += `<a href="${e.uploadPath+"/"+e.uuid+"_"+e.fileName}" class="showIamge">원본보기</a>`
				}else{
					fileList += `<a href="${e.uploadPath+"/"+e.uuid+"_"+e.fileName}" class="download">다운로드</a>`
				} 
				*/
				fileList += `</div>`			
			});
		$('.uploadResultDiv div').html(fileList);
	});
	
	// 원본보기 
	$('.uploadResultDiv ul').on('click','.showIamge',function(e){
		e.preventDefault();
		let filePath = $(this).attr('href');
		let imgSrc = `${ctxPath}/files/display?fileName=${filePath}`
		$('#showImage').find('.modal-body').html($('<img>',{src : imgSrc, class : 'img-fluid'}));
		$('#showImage').modal();
	});
	
	// 파일 다운로드 
	$('.uploadResultDiv ul').on('click','.download',function(e){
		e.preventDefault();
		self.location = `${ctxPath}/files/download?fileName=${$(this).attr('href')}`
	});
    
})