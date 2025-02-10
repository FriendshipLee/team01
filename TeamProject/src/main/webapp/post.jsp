<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>게시판</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <link rel="stylesheet" href="./resources/css/post.css"></link>
</head>
<body>
    <div class="container">
        <div class="post-box">
            <div class="post-top">
            	<div>
            		<h2>제목</h2>
	           		<p>작성자: 김지현 2025.01.24 10:44</p>
          	  	</div>
	            <div class="post-type">공지게시판</div>
            </div>
            <hr>
            <p>국가안전보장회의는 대통령이 주재한다...</p>
			<!-- <div class="filebox">
           		<input id="file" type="file" onchange="fileChange(this)">
				<button id="fileBtn">파일</button>
            	<span id="fileName"></span>
           	</div> 수정펲이지에서 파일등록 -> 이름표시 -->
           	<div class="attachment-item">
				<a href="#" class="attachment-name">이미지2.png</a>
				<span class="attachment-size">(1.1 MB)</span>
			</div>
			<div class="modify">
				<input type="button" value="게시글 수정">
				<input type="button" value="게시글 삭제">
			</div>
        </div>
 			
        <div class="comment-box">
            <input type="text" id="new-comment" class="comment-input" placeholder="댓글을 입력하세요.">
            <input type="button" id="add-comment" value="댓글 작성">
            <div id="comments">
            	<div class="comments-top">
	            	<p>작성자: 김지선 2025.01.24 11:12</p>
	            	<div>
		            	<input type="button" value="수정">
		            	<input type="button" value="삭제">
	            	</div>
	            </div>
            	<hr>
            	<p>댓글내용</p>
            </div>
        </div>
    </div>
</body>
<!-- <script type="text/javascript">
	$("#fileBtn").click(function(){
		$("#file").click();
	});
	function fileChange(e){
		let fileName = e.files[0].name;
		$("#fileName").text(fileName);
		console.log(e.files[0].name);
	}
</script> -->
</html>