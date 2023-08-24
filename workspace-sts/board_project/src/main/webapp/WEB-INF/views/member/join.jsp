<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../includes/header.jsp"%>

<style>
.join_area{
	height: 50vh
}
</style>

<div class="contatiner join_area d-flex justify-content-center align-items-center">
	<div class="w-50">
	<h1 class="text-center py-3">회원가입</h1>
	<form:form action="${ctxPath}/member/join" modelAttribute="memberVO">
		<div class="form-group row">
			<div class="col-9">
				<form:input class="form-control" path="memberId" placeholder="ID"/>
			</div>
			<div class="col-3">
				<button type="button" class="btn btn-outline-info form-control idCheck">ID 중복확인</button>
			</div>
		</div>
		<div class="form-group">
				<form:input class="form-control" path="memberName" placeholder="이름"/>
		</div>
		<div class="form-group">
				<form:input class="form-control" path="email" placeholder="email"/>
		</div>
		<div class="form-group">
				<form:input class="form-control" path="memberPwd" placeholder="비밀번호"/>
		</div>
		<button type="button" class="form-control btn btn-outline-primary join">회원가입</button>
		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
	</form:form>
	</div>
</div>

<%@ include file="../includes/footer.jsp"%>

<script>
$(function(){
	let idCheckFlag = false;
	$('.idCheck').click(function(){
		let idInput = $('#memberId');
		let memberId = idInput.val();
		
		if(idInput.attr('readonly')){
			idInput.attr('readonly',false);
			idInput.focus();
			$(this).html('ID 중복확인');
			idCheckFlag = false;
			return;
		}

		if(memberId==''){
			alert('ID를 입력하세요');
			return;
		}

		$.ajax({
			type :'post',
			url : '${ctxPath}/member/idCheck',
			data : { memberId : memberId},
			async : false,
			success : function(result){
				if(result){
					alert('사용할 수 있는 ID 입니다.');
					idCheckFlag = true;
					$('.idCheck').html('변경');
					idInput.attr('readonly',true);
				} else {
					alert('사용할 수 없는 아이디입니다.');
					idInput.focus();
				}

			}
		})
	})
	

	$('.join').click(function(){
		if(!idCheckFlag){
			alert('ID 중복 체크를 해주세요.');
			return;
		}
		$('#memberVO').submit();
	})

})
</script>