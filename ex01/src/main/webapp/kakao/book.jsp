<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div>
	<h1>도서검색</h1>
	<div class="row mb-3">
		<div class="col-6 col-md-3">
			<form name="frm">
				<div class="input-group">
					<input class="form-control" name="query" value="JSP" placeholder="검색어">
					<button class="btn btn-success">검색</button>
				</div>
			</form>
		</div>
	</div>
	<div id="div_book" class="row"></div>
	<div class="text-center my-3">
		<button class="btn btn-success" id="prev">이전</button>
		<span class="mx-3" id="page">1</span>
		<button class="btn btn-success" id="next">다음</button>
	</div>

</div>
<script id="temp_book" type="x-handlebars-template">
	{{#each documents}}
		<div class="col-6 col-md-4 col-lg-2 mb-2">
			<div class="card">
				<div class="card-body">
					<img src={{check thumbnail}}>
				</div>
				<div class="card-footer">
					<div class="ellipsis">{{title}}</div>
				</div>
			</div>
		</div>
	{{/each}}
</script>

<script>
Handlebars.registerHelper("check", function (thumbnail) {
    if(thumbnail) {
        return thumbnail;
    }
    else {
        return "http://via.placeholder.com/125x180";
    }
});
</script>

<script>
	let query = $(frm.query).val();
	let page = 1;
	getData();
	
	//다음 버튼을 클릭한 경우
	$("#next").on("click", function () {
		page++;
		getData();
	});
	
	//이전 버튼을 클릭한 경우
	$("#prev").on("click", function () {
		page--;
		getData();
	});
	
	$(frm).on("submit", function(e) {
		e.preventDefault();
		query=$(frm.query).val();
		if(query=='') {
			alert("검색어를 입력하세요!");
		}
		else{
			page=1;
			getData();
		}
	}); 
	
	function getData() {
		$.ajax({
			type : "get",
			url : "https://dapi.kakao.com/v3/search/book?target=title",
			headers : {"Authorization":"KakaoAK 9a5fa7c035339e405f49a5347ceb488f"},
			dataType : "json",
			data : {query:query, page:page, size:12},
			success : function (data) {
				console.log(data);
				const temp = Handlebars.compile($("#temp_book").html());
				$("#div_book").html(temp(data));
				
				const last = Math.ceil(data.meta.pageable_count/6);
				$("#page").html(page + '/' + last);
				if(page==1) {
					$("#prev").attr("disabled", true);
				}
				else {
					$("#prev").attr("disabled", false);
				}
				
				if(data.meta.is_end) {
					$("#next").attr("disabled", true);
				}
				else {
					$("#next").attr("disabled", false);
				}
			}
		});
	}
</script>