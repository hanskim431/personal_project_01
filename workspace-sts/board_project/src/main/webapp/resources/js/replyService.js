console.log('replyService.js');

var replyService = {
	
	getList : function(param, callback, error){
		console.log('getList');
		
		let bno = param.bno;
		let pageNum = param.pageNum
		
		$.ajax({
			type : 'get',
			url : `${ctxPath}/replies/pages/${bno}/${pageNum}`,
			success : function(result){
				if(callback) callback(result);
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