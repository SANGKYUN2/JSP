<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<div>
	<h1>게시판</h1>
	<div class="row">
		<div class="col-6 col-md-4 col-lg-3 mb-2">
			<form name="frm">
				<div class="input-group">
					<input name="query" class="form-control" placeholder="검색어">
					<button class="btn btn-success">검색</button>
				</div>
			</form>
		</div>
		<div class="col">
			<span id="total"></span>
		</div>
		<div class=" col text-end mb-2" id="div_write">
			<a href="/bbs/insert" class="btn btn-success px-3">글쓰기</a>
		</div>
	</div>
	<div id="div_bbs"></div>
	<div id="pagination" class="pagination justify-content-center mt-5"></div>
</div>

<script id="temp_bbs" type="x-handlebars-template">
		<table class="table table-bordered border-success">
		<tr>
			<td width="10%">번호</td>
			<td width="50%">제목</td>
			<td width="20%">닉네임</td>
			<td width="20%">작성 날짜</td>
		</tr>
		{{#each .}}
			<tr>
				<td>{{bid}}</td>
				<td>
					<div class="ellipsis">
						<a href="/bbs/read?bid={{bid}}">{{title}}</a>
					</div>
				</td>
				<td>
					<div class="ellipsis">
						{{uname}} ({{writer}})
					</div>
				</td>
				<td>
					<div class="ellipsis">
						{{bdate}}
					</div>
				</td>
			</tr>
		{{/each}}
	</table>
</script>

<script>
	if(uid) {
		$("#div_write").show();
	}
	else {
		$("#div_write").hide();
	}


	let page=1;
	const size=10;
	let query="";
	
	$(frm).on("submit", function (e) {
		e.preventDefault();
		query=$(frm.query).val();
		page=1;
		getTotal();
	});
	
	getData();
	function getData() {
		$.ajax({
			type : "get",
			url : "/bbs/list.json",
			dataType : "json",
			data : {page, size, query},
			success : function (data) {
				const temp = Handlebars.compile($("#temp_bbs").html());
				$("#div_bbs").html(temp(data));

			}
		});
	}
	
	getTotal();
	function getTotal() {
		$.ajax({
			type : "get",
			url : "/bbs/total",
			data : {query},
			success : function (data) {
				//alert(data);
				if(data==0) {
					alert("검색내용이 없습니다.")
					$(frm.query).val("");
					$("#total").html("검색수 : " + data + "건");
				}
				else {
					const totalPage=Math.ceil(data/size);
					$("#pagination").twbsPagination("changeTotalPages", totalPage, page);
					$("#total").html("검색수 : " + data + "건");
				}
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