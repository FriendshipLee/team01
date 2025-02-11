<%@page import="java.util.List"%>
<%@page import="board.boardDAO"%>
<%@page import="board.boardVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="header.jsp" %>
<%
	String boardType = request.getParameter("boardType");
	if(boardType == null){
		boardType = "0";
	}
	
	String searchType = request.getParameter("searchType");
	String keyword = request.getParameter("searchKeyword");
	
	boardDAO dao = new boardDAO();
	List<boardVO> listAll = dao.boardList(boardType);
	
%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>게시판</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <link rel="stylesheet" href="./resources/css/board.css"></link>
</head>
<body>
    <div class="container">
        <h2><%if(boardType.equals("0")){
			%>공지게시판<%        	
        }else if(boardType.equals("1")){
        	%>정보공유게시판<%
        }else if(boardType.equals("2")){
        	%>익명게시판<%
        }%></h2>
       	<form action="board.jsp" method="get">
        	<div class="search-box">
	        	<select name="searchType">
	        		<option value="title">제목</option>
	        		<option value="content">내용</option>
	        		<% 
	        			if(!boardType.equals("2")){
	        				%><option value="author">작성자</option><%
	        			}
	        		%>
	        	</select>
	        	<label>
					        	
		            <input type="text" name="searchKeyword" placeholder="검색어를 입력하세요.">
	        	</label>
	            <% 
	            	if(user != null){
	            		%><input type="button" id="write-btn" value="글쓰기"><%
	            	}
	            %>
	        </div>
        </form>
		<div class="list">
			<% for(int i = 0; i < listAll.size(); i++){ 
				boardVO vo = listAll.get(i);
			%>
				<div class="content" onclick="location.href='post.jsp?no=<%=vo.getNo()%>'">
					<div>
						<h4><%=vo.getTitle() %></h4>
						<%
							if(!boardType.equals("2")){
								%><span><%=vo.getAuthor() %></span><%
							}
						%>
						<span><%=vo.getCreateDate() %></span>
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
