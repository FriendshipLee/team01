<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="header.jsp" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>게시판</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <link rel="stylesheet" href="./resources/css/notice.css"></link>
</head>
<body>
    <div class="container">
        <h2>공지게시판, 익명게시판, 정보공유게시판</h2>
        <div class="search-box">
        	<select name="searchType">
        		<option>제목</option>
        		<option>내용</option>
        		<option>작성자</option>
        	</select>
            <input type="text" placeholder="검색어를 입력하세요.">
            <input type="button" id="write-btn" value="글쓰기">
        </div>
		<div class="list">
			<% for(int i = 0; i < 10; i++){ %>
				<div class="content" onclick="location.href='post.jsp'">
					<div>
						<h4>제목<%=i %></h4>
						<span>작성자<%= i %></span>
						<span>작성일(수정일)</span>
					</div>
				</div>
			<% } %>	
	        <div class="page">
				<% for(int i = 0; i < 10; i++){ %>
					<a href="#"><%= i %></a>
				<% } %>        	
	        </div>
		</div>
    </div>

    <script>
        $(document).ready(function() {
            $('#write-btn').click(function() {
                window.location.href = 'write.jsp';
            });
        });
    </script>
</body>
</html>
