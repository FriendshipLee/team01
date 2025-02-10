<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>채용공고</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <link rel="stylesheet" href="./resources/css/job.css"></link>
</head>
<body>
    <div class="container">
        <h2>채용공고</h2>
        <div class="search-box">
            <input type="text" placeholder="검색어를 입력하세요.">
            <input type="button" id="write-btn" value="글쓰기">
        </div>
        
        <div class="filters">
            <input type="button" id="" value="#프로그래머">
            <input type="button" id="" value="#디자이너">
            <input type="button" id="" value="#기획자">
        </div>
		
		<div class="list">
			<% for(int i = 0; i < 10; i++){ %>
				<div class="content" onclick="location.href='post.jsp'">
					<div>
						<h4>제목<%=i %></h4>
						<span>내용<%= i %></span>
					</div>
					<p> ~ 2025-02-23 <br> 채용중</p>
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
