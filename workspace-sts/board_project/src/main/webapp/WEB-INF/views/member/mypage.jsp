<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../includes/header.jsp"%>

<div class="container">
	<div class="d-flex justify-content-center">
		<div class="w-50 my-5">
			<div class="jumbotron">
				<h3>회원 정보</h3>
			</div> <!-- jumbotron END -->
			<div class="userImage d-flex justify-content-center my-5">
				<label for="imageUpload"> <img alt="userImage"
					src="${ctxPath}/resources/images/profile.bmp" style="width: 120px">
				</label>
				<input type="text" name="userImage" id="imageUpload" style="display:none; width:100%; height:100%">
			</div> <!-- userImage END -->
			<form action="${ctxPath}/member/modify" method="post">
				<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
				<div class="form-group">
					ID
					<input type="text" name="memberId" class="form-control form-control-lg" readonly="readonly" value="${vo.memberId}">
				</div>
				<div class="form-group">
					이름
					<input type="text" name="memberName" class="form-control form-control-lg" value="${vo.memberName}">
				</div>
				<div class="form-group">
					EMAIL
					<input type="text" name="email" class="form-control form-control-lg" readonly="readonly" value="${vo.email}">
				</div>
				<div class="form-group">
					주소
					<input type="text" name="address" class="form-control form-control-lg" value="${vo.address}">
				</div>
				<div class="form-group">
					<button class="btn btn-outline-primaty btn-lg form-control">정보수정</button>
				</div>
				<div class="form-group">
					<button type="button" class="btn btn-outline-primaty btn-lg form-control changePwdForm">비밀번호 변경</</button>
				</div>
			</form>
		</div> <!-- w-50 my-5 END -->
	</div> <!-- d-flex END -->
</div> <!-- container END -->

<!-- Trigger the modal with a button -->

<!-- Modal -->
<div class="modal" id="changePwdModal">
  <div class="modal-dialog">

    <!-- Modal content-->
    <div class="modal-content">
      <div class="modal-header">
        <h4 class="modal-title">비밀번호 변경</h4>
        <button type="button" class="close" data-dismiss="modal">&times;</button>
      </div>
      <div class="modal-body">
      	<form>
      		<input type="text" autocomplete="username" style="display:none"/>
      		<div class="form-group">
      			현재 비밀번호 : <input type="password" class="form-control currentPwd" autocomplete="new-password">      		
      		</div>
      		<div class="form-group">
      			변경할 비밀번호 : <input type="password" class="form-control newPwd" autocomplete="new-password">      		
      		</div>
      	</form>
      </div>
      <div class="modal-footer">
        <button class="btn btn-outline-info showPwd">비밀번호 보기</button>
        <button class="btn btn-outline-danger changePwd">변경</button>
      </div>
    </div>

  </div>
</div>

<%@ include file="../includes/footer.jsp"%>

<script type="text/javascript">
let result = "${result}";
$(function(){
	
	console.log(result);
	if(result=='modify'){
		alert('회원 정보를 수정하였습니다.')
	}
	$('.changePwdForm').click(function(){
		$('#changePwdModal').find('input').val('');
		$('#changePwdModal').modal();
	})

	// 비밀번호 변경 처리 
	$('.changePwd').click(function(){
		console.log('비밀번호 변경-변경')
		$.ajax({
			type : 'post', 
			url : '${ctxPath}/mypage/changePwd',
			data : {
				memberId : $('[name="memberId"]').val(),
				currentPwd : $('.currentPwd').val(),
				newPwd: $('.newPwd').val()
			},
			success : function(result){
				alert(result);
				$('#changePwdModal').modal('hide');
			},
			error : function(xhr, status, er){
				alert(xhr.responseText)
			}
		});
	});
	
	
	// 비밀번호 보기
	$('.showPwd').click(function(){
		console.log('비밀번호 보기')

		let passwordInput = $('[autocomplete="new-password"]');
		
		passwordInput.toggleClass('active');
		if(passwordInput.hasClass('active')){
			$(this).html('비밀번호 가리기')	
			passwordInput.attr('type','text');
		} else {
			$(this).html('비밀번호 보기')	
			passwordInput.attr('type','password');
		}
	})
	
	
})
</script>


