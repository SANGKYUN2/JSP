<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<style>
	.delete {
		font-size : 20px;
		cursor:pointer;
		color: red;
		
		}
		
	.card-body img {
		border-radius: 50%;
		border: 1px solid gray;
		cursor: pointer; 
	}
</style>
<div class = "mt-5 text-end" id="div_insert">
	<textarea id="contents" rows="5" class="form-control" placeholder="댓글 내용을 입력하세요."></textarea>
	<button class="btn btn-success px-5 mt-2 insert">등록</button>
</div>
<div class="mt-2 text-end" id="div_login">댓글을 쓰려면 로그인하세요 =>
      <button  class="btn btn-success login">로그인</button>
   </div>
<div class="card mt-2">
		<div class="card-header">
			<span id="total"></span>
		</div>
		<div class="card-body">
			<img id="imgPhoto" src="" width="50">
			<div id="div_comments"></div>
		</div>
</div>
<div id="pagination" class="pagination justify-content-center mt-3"></div>


<script id="temp_comments" type="x-handlebars-template">
	{{#each .}}
		<div class="text-muted">
			<span>{{cdate}}</span>
			<span>{{uname}} ({{writer}})<span>
			<i class="bi bi-trash-fill ms-2 delete" style="{{delete writer}}" cid="{{cid}}"></i>
		</div>
		<div class="mb-5 ellipsis2"><b>{{cid}}</b>: {{contents}}</div>
	{{/each}}
</script>

<script>
	Handlebars.registerHelper("delete", function(writer) {
		if(uid!=writer) {
			return "display:none;";
		}
	});
</script>

<script>
	const bid="${bbs.bid}";
	let page=1;
	let size=5;
	
	if(uid) {
		$("#div_insert").show();
		$("#div_login").hide();
	}
	else {
		$("#div_insert").hide();
		$("#div_login").show();
	}
	
	//로그인 버튼을 눌렀을때
	$("#div_login").on("click", ".login", function () {
		sessionStorage.setItem("target", "/bbs/read?bid=" + bid);
		location.href="/user/login";
	});
	
	//등록 버튼을 눌렀을때
	$("#div_insert").on("click", ".insert", function () {
		const contents=$("#contents").val();
		if(contents=="") {
			alert("댓글 내용을 입력하세요!");
			$("#contents").focus();
			return;
		}
		$.ajax({
			type : "post",
			url : "/com/insert",
			data : {bid, contents, uid},
			success : function () {
				page=1;
				getTotal();
				contents=$("#contents").val("");
			} 
		});

	});
	
	//삭제버튼을 클릭한 경우
	$("#div_comments").on("click", ".delete", function () {
		const cid=$(this).attr("cid");
		if(confirm(cid + "번 댓글을 삭제하실래요?")) {
			//삭제하기
			$.ajax({
				type : "post",
				url : "/com/delete",
				data : {cid},
				success : function () {
					alert("삭제완료!");
					getTotal();
				} 
			});
		}
	})
	
	getData();
	function getData() {
		$.ajax({
			type : "get",
			url : "/com/list.json",
			data : {bid, page, size},
			dataType : "json",
			success : function (data) {
				const temp = Handlebars.compile($("#temp_comments").html());
				$("#div_comments").html(temp(data));
			}
		
		
		
		})
	}
	
	getTotal();
	function getTotal() {
		$.ajax({
			type : "get",
			url : "/com/total",
			data : {bid},
			success : function (data) {
				const totalPage=Math.ceil(data/size);
				$("#pagination").twbsPagination("changeTotalPages", totalPage, page);
				$("#total").html("댓글수 : " + data + "건");
			}
		});
	}
	
	//페이지네이션 출력
	$('#pagination').twbsPagination({
    	totalPages:100, 
      	visiblePages: 5, 
      	startPage : 1,
      	initiateStartPageClick: false, 
      	first:'<i class="bi bi-skip-backward-fill"></i>', 
     	prev :'<i class="bi bi-skip-start-fill"></i>',
      	next :'<i class="bi bi-skip-end-fill"></i>',
      	last :'<i class="bi bi-skip-forward-fill"></i>',
      	onPageClick: function (event, clickPage) {
          	page=clickPage; 
         	 getData();
      	}
   	});
	
</script>

<script>
	const photo ="${user.photo}";
	if(photo) {
		$("#imgPhoto").attr("src", photo);
		$("#photo").attr("src", photo);
	}
	else {
		$("#imgPhoto").attr("src", "http://via.placeholder.com/50x50");
		$("#photo").attr("src", "http://via.placeholder.com/200x200");
	}
	</script>