<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../includes/header.jsp" %>

<div class="container">
	<div class="row">
		<div class="col-12">
			<div class="card">
				<div class="card-header">글 작성</div><!-- card-header end -->
				<div class="card-body">
					<form action="${ctxPath}/board/register" method="post">
					  <div class="form-group">
					    <label>제목
					 		<button type="submit" class="btn btn-default">Submit</button>
					    </label>
					    <input type="text" class="form-control" name="title">
					  </div>
					  <div class="form-group">
					    <label>작성자</label>
					    <input type="text" class="form-control" name="writer">
					  </div>
					  <div class="form-group">
					    <label>내용</label>
					    <textarea class="form-control" rows="10" name="content"></textarea>
					  </div>
					  <input type="hidden" name="boardType" value="BOARD3">
					  <input type="hidden" name="status" value="VISIBLE">
					</form>
				</div><!-- card-body end -->
			</div><!-- card end -->
		</div><!-- col-12 end -->
	</div><!-- row end -->
</div><!-- container end -->

<%@ include file="../includes/footer.jsp" %>
