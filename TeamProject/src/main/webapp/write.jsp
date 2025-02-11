<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="header.jsp" %>
<%
	if(user == null){
		response.sendRedirect("board.jsp");
		return;
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>게시글 작성</title>
 	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <link rel="stylesheet" href="./resources/css/board_write.css"></link>
</head>
<body>
	<div class="board-container">
		<h2>새 게시글 작성</h2>
		<form method="post" action="writeok.jsp" enctype="multipart/form-data">
<!-- 			<input type="radio" name="boardtype">공지게시판
			<input type="radio" name="boardtype" checked>자유게시판
			<input type="radio" name="boardtype">익명게시판 -->
			<div>
				<label for="title">제목</label><br>
	            <input type="text" id="title" name="title" placeholder="제목을 입력하세요"><br>
			</div>
			<div>
	            <label for="content">내용</label><br>
	            <textarea id="content" name="content" placeholder="내용을 입력하세요"></textarea><br>
			</div>
			<div>
	            <label for="file">첨부파일</label><br>
	            <input type="file" id="file" name="file"><br>
			</div>
            <div class="action">
                <button type="submit" onclick="location.href='post.jsp'">등록</button>
                <button type="button" onclick="location.href='board.jsp'">취소</button>
            </div>
        </form>
    </div>
</body>
</html>