<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../includes/header.jsp"%>

<div class="container">
	<div class="row my-5">
		<div class="col-2">
			<ul class="list-group">
				<li class="list-group-item">이용약관</li>
				<li class="list-group-item">이메일 인증</li>
				<li class="list-group-item active">회원가입작성</li>
			</ul>		
		</div>
		<div class="col-6 mx-auto">
			<form:form action="${ctxPath}/member/join" modelAttribute="memberVO">
				<h1 class="text-center py-3">회원가입</h1>
				<div class="form-group row">
					<div class="col-9">
						<span class="Message"> </span>
						<form:input class="form-control memberId" path="memberId" placeholder="아이디"/>
					</div>
					<div class="col-3">
						<button type="button" class="btn btn-outline-info form-control idCheck">ID중복확인</button>
					</div>
				</div>
				<div class="form-group">
					<span class="Message"> </span>
					<form:input class="form-control memberName" path="memberName" placeholder="이름" />
				</div>
				<div class="form-group">
					<form:input class="form-control" path="email" placeholder="이메일" readonly="true"/>
				</div>
				<div class="form-group">
					<span class="Message"> </span>
					<form:password class="form-control memberPwd"  path="memberPwd" placeholder="비밀번호" />
				</div>
				<button type="button" class="form-control btn btn-outline-primary join" >회원가입</button>
				<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
			</form:form>
		</div>
	</div>
</div>

<script src="${ctxPath}/resources/js/checkExtension.js"></script>

<script>
$(function(){
	let idCheckFlag = false; 
	let formCheckFlag = true;

	let idInput = $('.memberId')
	let memberId = $('.memberId').val();
	
	// ID 유효성 검사
	$('.memberId').on('keyup',function(){
		let Message = $(this).siblings('.message');
		memberId = $(this).val();
		
		if(checkIDExtension(memberId)){
			memberIdMessage.html('');
			memberIdMessage.css('color','');
			$(this).removeClass('border-danger').css('box-shadow','')
		} else {
			memberIdMessage.html('아이디 생성 규칙에 위배됩니다.');
			memberIdMessage.css('color','red');
			$(this).addClass('border border-danger')
				.css('box-shadow','0 0 0 0.2rem rgba(255,0,0,.25)')
			formCheckFlag = false;
		}
	});
	
	
	// 이름 유효성 검사 
	$('.memberName').on('keyup',function(){
		let Message = $(this).siblings('.message');
		let memberName = $(this).val();
		
		if(checkNameExtension(memberName)){
			memberNameMessage.html('');
			memberNameMessage.css('color','');
			$(this).removeClass('border-danger').css('box-shadow','')
		} else {
			memberNameMessage.html('이름 생성 규칙에 위배됩니다.');
			memberNameMessage.css('color','red');
			$(this).addClass('border border-danger')
				.css('box-shadow','0 0 0 0.2rem rgba(255,0,0,.25)')
			formCheckFlag = false;
		}
	});
	
	
	// 비밀번호 유효성 검사 
	$('.memberPwd').on('keyup',function(){
		let Message = $(this).siblings('.message');
		let memberPwd = $(this).val();
		
		if(checkNameExtension(memberPwd)){
			memberNameMessage.html('');
			memberNameMessage.css('color','');
			$(this).removeClass('border-danger').css('box-shadow','')
		} else {
			memberNameMessage.html('이름 생성 규칙에 위배됩니다.');
			memberNameMessage.css('color','red');
			$(this).addClass('border border-danger')
				.css('box-shadow','0 0 0 0.2rem rgba(255,0,0,.25)')
			formCheckFlag = false;
		}
	});
	
	
	
	/// ID 중복 검사
	$('.idCheck').click(function(){
		
		if(idInput.attr('readonly')){ // 이미 값이 입력된 경우 
			idInput.attr('readonly',false);
			idInput.focus();
			$(this).html('ID중복확인');
			idCheckFlag = false;
			return; 
		}
		
		if(memberId=='') {
			alert('아이디를 입력하세요')
			idInput.focus();
			return; 			
		}
		
		$.ajax({ // 중복검사 
			type : 'post', 
			url : '${ctxPath}/member/idCheck',
			data : { memberId : memberId },
			async : false,
			success : function(result){
				if(result){ // 사용할 수 있는 경우
					alert('사용할 수 있는 아이디 입니다.')
					idCheckFlag = true;
					$('.idCheck').html('변경');
					idInput.attr('readonly',true);
					
					idInput.removeClass('border-danger')
						.addClass('border border-success')	
						.css('box-shadow','0 0 0 0.2rem rgba(0,128,0,.25)')
				} else { // 중복되는 경우 
					alert('사용할 수 없는 아이디입니다.');
					idInput.focus();
					idInput.addClass('border border-danger')
						.css('box-shadow','0 0 0 0.2rem rgba(255,0,0,.25)')
				}
			}
		});
	});
	
	// 제출 전 양식 검사
	$('.join').click(
		function() {
			let memberNameInput = $('.memberName');
			let memberName = $('.memberName').val();
			let memberPwdInput = $('.memberPwd');
			let memberPwd = $('.memberPwd').val();

			if (!idCheckFlag) {
				alert('ID 중복체크 바람');
				$('#memberId').addClass('border border-danger').css(
						'box-shadow', '0 0 0 0.2rem rgba(255,0,0,.25)')
				formCheckFlag = false;
			}

			if ((memberName == '')) {
				$('.memberNameMessage').html('이름을 입력해주세요.');
				$('.memberNameMessage').css('color', 'red');
				memberNameInput.addClass('border border-danger').css(
						'box-shadow', '0 0 0 0.2rem rgba(255,0,0,.25)')
				memberNameInput.focus();
				formCheckFlag = false;
			}

			if ((memberPwd == '')) {
				$('.memberPwdMessage').html('비밀번호를 입력해주세요.');
				$('.memberPwdMessage').css('color', 'red');
				memberPwdInput.addClass('border border-danger').css(
						'box-shadow', '0 0 0 0.2rem rgba(255,0,0,.25)')
				memberPwdInput.focus();
				formCheckFlag = false;
			}
			if (formCheckFlag == true) {
				$('#memberVO').submit();
			}
		});

	});
	
</script>