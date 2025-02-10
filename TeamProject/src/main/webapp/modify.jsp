<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>게시판</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <link rel="stylesheet" href="./resources/css/modify.css"></link>
</head>
<body>
    	<h2>게시글 수정</h2>
    <div class="container">
    	<div>
    		<h3>제목</h3>
    		<input type="text" placeholder="제목을 입력하세요">
    	</div>
    	<div>
    		<h3>내용</h3>
    		<textarea placeholder="내용을 입력하세요"></textarea>
    	</div>
    	<div>
    		<h3>첨부파일</h3>
    		<input type="file">
    	</div>
		<div class="modify">
			<input type="button" value="수정">
			<input type="button" value="취소">
		</div>
    </div>
</body>
</html>