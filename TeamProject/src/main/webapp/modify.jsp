<%@page import="board.boardVO"%>
<%@page import="board.boardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="header.jsp" %>
<%
	String no = request.getParameter("no");
	String boardType = request.getParameter("boardType");

	if(no == null || no.isEmpty()){
		response.sendRedirect("board.jsp");
		return;
	}
	
	boardDAO dao = new boardDAO();
	boardVO vo = dao.view(no);
	String title = vo.getTitle();
	String content = vo.getContent();
%>
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
    <form action="modifyOk.jsp" method="post" enctype="multipart/form-data">
	    <input type="hidden" name="no" value="<%= no %>">
	    <input type="hidden" name="boardType" value="<%= boardType %>">
	    	<div>
	    		<h3>제목</h3>
	    		<input type="text" id="title" name="title" placeholder="제목을 입력하세요" value="<%= title %>">
	    	</div>
	    	<div>
	    		<h3>내용</h3>
	    		<textarea id="content" name="content" placeholder="내용을 입력하세요"><%= content %></textarea>
	    	</div>
	    	<div>
	    		<h3>첨부파일</h3>
	    		<input type="file" id="file" name="file">
	    	</div>
			<div class="modify">
				<input type="submit" value="수정">
				<input type="button" onclick="history.back()" value="취소">
			</div>
		</form>
	</div>
</body>
</html>
