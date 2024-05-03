<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <style>
 	span {
		width : 100px;
}
 </style>
<h1>Logitech</h1>
<div class="row my-4 justify-content-center">
	<div class="col-8 col-mb-6 col-lg-4">
		<div class="card">
			<div class="card-body">
				<form name="frm">
					<h5 class="mb-4">ID 로그인</h5>
					<div class="input-group mb-3">
						<input name="uid" class="form-control" placeholder="아이디">
					</div>
					<div class="input-group mb-3">
						<input name="upass" type="password" class="form-control" placeholder="비밀번호">
					</div>
					<div class ="keep_check mb-3">
						<input type = "checkbox" id="keep" name="nvlog" class="input_keep" value="off">
						<label for="keep" class="keep_text">로그인 상태 유지</label>
					</div>
					<button class="btn btn-success w-100">로그인</button>
				</form>
			</div>
		</div>
	</div>
</div>
<div class="text-center mt-2">
	<a target="_blank" class="find_text">비밀번호 찾기</a> | <a target="_blank" class="find_text">아이디 찾기</a> | <a href="/user/join" target="_blank" class="find_text">회원가입</a>
</div>





<script>
	$(frm).on("submit", function (e) {
		e.preventDefault();
		const uid=$(frm.uid).val();
		const upass=$(frm.upass).val();
		if(uid=="") {
			alert("아이디를 입력해 주세요.");
		}
		else if(upass=="") {
			alert("비밀번호를 입력해 주세요.");
		}
		else {
			//로그인체크
			$.ajax({
				type : "post",
				url : "/user/login",
				data : {uid:uid, upass:upass},
				success : function (data) {
					//alert(data);
					if(data==1) {
						//alert("성공")
						let target=sessionStorage.getItem("target");
						if(target) {
							location.href=target;
						}
						else {
							location.href="/";	
						}

					}
					else if(data==2) {
						alert("비밀번호가 일치하지 않습니다.");
						$(frm.upass).val("");
						$(frm.upass).focus();
					}
					else if(data==0) {
						alert("아이디가 존재하지 않습니다.");
						$(frm.uid).val("");
						$(frm.uid).focus();
					}
				}
			
			
			
			})
		}
	});
</script>