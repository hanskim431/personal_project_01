<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../includes/header.jsp" %>

<div class="container">
	<div class="row">
		<div class="col-12">
			<div class="card">
				<div class="card-header"></div><!-- card-header end -->
				<div class="card-body">
					<div>
						<label>
							<img src="${ctxPath}/resources/images/profile.bmp" class=profile alt="profile">
							${board.writer}
							${board.regDate}
						</label>
					</div>
					<div>
						<div>
							<textarea rows="10" cols="50">${board.content}</textarea>
						</div>
						<div>
							<label>
								👍 						
							</label>
						</div>
					</div>
					<div>
						<label>
							${board.content}
						</label>
					</div>
				</div><!-- card-body end -->
			</div><!-- card end -->
		</div><!-- col-12 end -->
	</div><!-- row end -->
</div><!-- container end -->


<%@ include file="../includes/footer.jsp" %>
