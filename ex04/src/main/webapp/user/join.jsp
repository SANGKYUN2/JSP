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
					<h5 class="mb-4">회원가입</h5>
					<div class="input-group mb-3">
						<input name="uid" class="form-control" placeholder="아이디">
						<button id="btnCheck" type="button" class="btn btn-danger">중복체크</button>
					</div>
					<div class="input-group mb-3">
						<input name="upass" type="password" class="form-control" placeholder="비밀번호">
					</div>
					<div class="input-group mb-3">
						<input name="uname" class="form-control" placeholder="이름">
					</div>
					<!--<div class="input-group mb-3">
						<input name="birth" class="form-control" placeholder="생년월일 8자리">
					</div>-->
					<div class="text-center">
						<button type="reset" class="btn btn-secondary px-4">취소</button>
						<button class="btn btn-success">회원가입</button>
					</div>
				</form>
			</div>
		</div>
	</div>
</div>

<script>
	let check = false;
	$(frm).on("submit", function (e) {
		e.preventDefault();
		const uid = $(frm.uid).val();
		const upass = $(frm.upass).val();
		const uname = $(frm.uname).val();
		if(uid=="" || upass=="" || uname=="") {
			alert("필수 정보입니다.");
			return;
		}
		if(!check) {
			alert("아이디 중복체크를 하세요.");
			return;
		}
		if(confirm("회원가입을 하시겠습니까?")) {
			//회원가입
			$.ajax({
				type : "post",
				url : "/user/join",
				data : {uid, upass, uname},
				success : function () {
					alert("환영합니다.")
					location.href="/user/login";
				}
			
			})
		}
	});
	
	//중복체크 버튼을 클릭한 경우
	$("#btnCheck").on("click", function () {
		const uid=$(frm.uid).val();
		if(uid=="") {
			alert("아이디를 입력해주세요.")
			return;
		}
		
		$.ajax({
			type : "post",
			url : "/user/login",
			data : {uid},
			success : function (data) {
				if(data==0) {
					alert("사용 가능한 아이디입니다.")
					check=true;
				}
				else{
					alert("이미 존재하는 아이디입니다. 다른 아이디를 입력해주세요.")
				}
			}
		})

	});
	
	//아이디가 바뀐 경우
	$(frm.uid).on("change", function () {
		check=false;
	});
	
</script>
