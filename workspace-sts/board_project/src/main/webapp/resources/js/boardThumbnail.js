$(function(){
    // 각 게시글 썸네일 이미지를 가져와서 썸네일로 표시
    $('.thumbnail.uploadResultDiv').each(function() {
        let thumbnailContainer = $(this);
        let bnoValue = thumbnailContainer.find('a.move').attr('href');
        
        $.getJSON(
            `${ctxPath}/board/${boardType}/getAttachList`,
            {bno: bnoValue},
            function(attachList) {
                // 첫 번째 사진 정보 가져오기
                let firstImage = attachList[0];
                
                if (firstImage) { // 첫 번째 사진이 존재하는 경우
                    let filePath = firstImage.uploadPath + "/m_" + firstImage.uuid + "_" + firstImage.fileName;
                    let encodingFilePath = encodeURIComponent(filePath);
                	console.log(filePath)
                    
                    // 첫 번째 사진을 썸네일로 표시
                    thumbnailContainer.find('img.thumbnail-image').attr('src', `${ctxPath}/files/display?fileName=${encodingFilePath}`);
                } else { // 첫 번째 사진이 없는 경우 기본 이미지를 표시하거나 아무 작업 없이 유지할 수 있음
                    // 기본 이미지를 표시하거나 아무 작업 없이 유지
                }
            }
        );
    });
});
