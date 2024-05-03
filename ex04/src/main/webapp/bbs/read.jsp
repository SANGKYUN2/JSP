<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div>
	<h1>게시글 정보</h1>
	<div class="text-end mb-2" id="div_update">
		<button class="btn btn-secondary btn-sm px-3 delete">삭제</button>
		<a href="/bbs/update?bid=${bbs.bid}" class="btn btn-success btn-sm px-3">수정</a>
	</div>
	
	<div class="card">
		<div class="card-body">
			<div>[${bbs.bid}] ${bbs.title}</div>
			<hr>
			<div>${bbs.contents}</div>
		</div>
		<div class="card-footer text-muted text-end" style="font-size:12px;">
			<span>${bbs.bdate}</span>
			<span>${bbs.uname} (${bbs.writer})</span>
		</div>
	</div>
</div>

<jsp:include page="/bbs/comments.jsp"/>
<script>
	const writer="${bbs.writer}";
	if(uid==writer) {
		$("#div_update").show();
	}
	else {
		$("#div_update").hide();
	}
	
	//삭제버튼을 클릭한 경우
	$("#div_update").on("click", ".delete", function(){
		const bid="${bbs.bid}";
		if(confirm(bid + "번 게시글을 삭제하실래요?")) {
			//삭제하기
			$.ajax ({
				type : "post",
				data : {bid},
				url : "/bbs/delete",
				success : function(){
					alert("삭제완료!");
					location.href="/bbs/list";
				}
			});
		}
	})
</script>