console.log('replyService.js');

var replyService = {
	
	getList : function(param, callback, error){
		console.log('getList');
		
		let bno = param.bno;
		let page= param.page|| 1;
		
		$.ajax({
			type : 'get',
			url : `${ctxPath}/replies/pages/${bno}/${page}`,
			success : function(replyPageDTO){
				if(callback) callback(replyPageDTO.replyCount, replyPageDTO.list);
			},
			error : function(xhr,status,er){
				if(error) error(er);
			}
			
		})
	},
		
	add : function (reply, callback, error){
		console.log('add');	
		
		$.ajax({
			type : 'post', 
			url : `${ctxPath}/replies/new`, 
			data : JSON.stringify(reply), 
			contentType : "application/json; charset=utf-8", 
			beforeSend : function(xhr){
				xhr.setRequestHeader(csrfHeaderName, csrfTokenValue)
			},
			success : function(result){
				if(callback) callback(result);
			}, 
			error : function(xhr, status, er){
				if(error) error(er);
			}
		});
	},
	
	get : function (rno, callback, error){
		console.log('get');
		
		$.getJSON(`${ctxPath}/replies/${rno}`,function(data){
			if(callback) callback(data);
		}). fail(function(xhr, status, er){
			if(error) error(er);
		})
	},
	
	update : function (reply, callback, error){
		console.log('update');
		
		$.ajax({
			type : 'put',
			url : `${ctxPath}/replies/${reply.rno}`,
			data : JSON.stringify(reply),
			contentType : "application/json; charset=utf-8", 
			success : function(result){
				if(callback) callback(result);
			},
			error : function(xhr, status, er){
				if(error) error(er);
			}
		})
	},
	
	remove : function(rno,callback,error){
		console.log('remove');
				
		$.ajax({
			type : 'delete',
			url : `${ctxPath}/replies/${rno}`,
			success : function(result){
				if(callback) callback(result);
			},
			error : function(xhr, status, er){
				if(error) error(er);
			}
		})
	}
}

console.log('replyService.js - end');