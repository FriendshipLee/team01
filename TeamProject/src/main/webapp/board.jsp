<%@page import="java.util.List"%>
<%@page import="board.boardDAO"%>
<%@page import="board.boardVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="header.jsp" %>
<%
//로그인 안했거나, 관리자 아니면 튕겨내기(다른 페이지로 강제 이동)
/* 	if(user == null || user.getUserType() != 0){
		response.sendRedirect("login.jsp");
		return;
	} */

	String pageNum = request.getParameter("page");
	if(pageNum == null){
		pageNum = "1";
	} 
	
	int currentPage = Integer.parseInt(pageNum);
	int startNum = (currentPage-1) * 10;
	int limitperPage = 10;

	String boardType = request.getParameter("boardType");
	if(boardType == null){
		boardType = "0";
	}
	
	String searchType = request.getParameter("searchType");
	String keyword = request.getParameter("searchKeyword");
	
	boardDAO dao = new boardDAO();
	//List<boardVO> listAll = dao.boardList(boardType);
	List<boardVO> list = dao.listView(searchType, keyword, startNum, limitperPage);
	
	int totalCount = dao.getCount(searchType, keyword);
	int pageGroupSize = 10;
	int startPage = ((currentPage - 1) / pageGroupSize) * pageGroupSize + 1;
	int totalPage = (int)Math.ceil(totalCount / (double)limitperPage);
	int endPage = Math.min(startPage + pageGroupSize -1, totalPage);
	
	if(searchType == null){
		searchType = "";
	}
	if(keyword == null){
		keyword = "";
	}
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
	        		<option value="title" <%= searchType.equals("title")? "selected" : "" %>>제목</option>
	        		<option value="content" <%= searchType.equals("content")? "selected" : "" %>>내용</option>
	        		<option value="author" <%= searchType.equals("author")? "selected" : "" %>>작성자</option>
	        	
	        	</select>
	        	<label class="search">
		            <input type="text" name="searchKeyword" placeholder="검색어를 입력하세요.">
	        	</label>
	            <% 
	            	if(user != null && user.getUserType() != 0){
	            		%><input type="button" id="write-btn" value="글쓰기"><%
	            	}
	            %>
	        </div>
        </form>
		<div class="list">
			<% for(int i = 0; i < list.size(); i++){ 
				boardVO vo = list.get(i);
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
	        <%
	        	if(currentPage > 1){
	        %>
	        	<a href="board.jsp?page=1<%= searchType != "" ? "&searchType=" +searchType : "" %><%= keyword != "" ? "&searchkeyword=" +keyword : "" %><%= "&boardType=" +boardType %>">&lt;&lt;</a>
        		<a href="board.jsp?page=<%=currentPage -1 %><%= searchType != "" ? "&searchType=" +searchType : "" %><%= keyword != "" ? "&searchkeyword=" +keyword : "" %><%= "&boardType=" +boardType %>">&lt;</a>
        	<%
	        	}
        	%>
				<% for(int i = startPage; i <= endPage; i++){
						if(i == currentPage){
				%>
					<a class="active" href="board.jsp?page=<%= i %><%= searchType != "" ? "&searchType=" +searchType : "" %><%= keyword != "" ? "&searchkeyword=" +keyword : "" %><%= "&boardType=" +boardType %>"><%= i %></a>
				<% 
				}else{ 
				%>  
				 <a href="board.jsp?page=<%= i %><%= searchType != "" ? "&searchType=" +searchType : "" %><%= keyword != "" ? "&searchkeyword=" +keyword : "" %><%= "&boardType=" +boardType %>"><%= i %></a>     	
				<%
				}
			}
			%>
			<%
            	if(currentPage < totalPage){
            %>
            <a href="board.jsp?page=<%=currentPage +1 %><%= searchType != "" ? "&searchType=" +searchType : "" %><%= keyword != "" ? "&searchkeyword=" +keyword : "" %><%= "&boardType=" +boardType %>">&gt;</a>
            <a href="board.jsp?page=<%=totalPage %><%= searchType != "" ? "&searchType=" +searchType : "" %><%= keyword != "" ? "&searchkeyword=" +keyword : "" %><%= "&boardType=" +boardType %>">&gt;&gt;</a>
            <%
            	}
            %>	
	        </div>
		</div>
    </div>

    <script>
        $(document).ready(function() {
            $('#write-btn').click(function() {
                window.location.href = 'write.jsp?boardType=<%= boardType %>';
            });
        });
    </script>
</body>
</html>
