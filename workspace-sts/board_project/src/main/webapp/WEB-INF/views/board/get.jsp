<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../includes/header.jsp" %>

<div class="container">
	<div class="row">
		<div class="col-12">
			<div class="card">
				<div class="card-header"></div><!-- card-header end -->
				<div class="card-body">
					<div class="">
						<label>
							<img src="${ctxPath}/resources/images/profile.bmp" class=profile alt="profile">
							
							${board.writer}
							
							<tf:formatDateTime value="${board.regDate}" pattern="yyyy-MM-dd HH:mm"/>
							
							<span class="dropdown">
							  <button class="btn btn-primary" type="button" data-toggle="dropdown">
							  <span class="caret"></span></button>
							  <ul class="dropdown-menu">
							    <li><a href="#">신고</a></li>
							    <li><a href="#">수정</a></li>
							    <li><a href="#">삭제</a></li>
							  </ul>
							</span>
						</label>
					</div>
					<div>
						<div>
							<textarea rows="10" cols="50" readonly="readonly">${board.content}</textarea>
						</div>
						<div>
							<label>
								👍 						
							</label>
						</div>
					</div>
					<div>
						<label>
						</label>
					</div>
				</div><!-- card-body end -->
			</div><!-- card end -->
		</div><!-- col-12 end -->
	</div><!-- row end -->
</div><!-- container end -->


<%@ include file="../includes/footer.jsp" %>
