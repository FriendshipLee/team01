<%@page import="java.util.List"%>
<%@page import="board.boardDAO"%>
<%@page import="board.boardVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="header.jsp" %>
<%
	String pageNum = request.getParameter("page");
	if(pageNum == null){
		pageNum = "1";
	} 
	
	int currentPage = Integer.parseInt(pageNum);
	int startNum = (currentPage-1) * 10;
	int limitperPage = 10;
	
	
	String searchType = request.getParameter("searchType");
	String keyword = request.getParameter("searchKeyword");
	String listArray = request.getParameter("listArray");
	String boardType = request.getParameter("boardType");
	
	if(searchType == null){
		searchType = "";
	}
	if(keyword == null){
		keyword = "";
	}
	if(listArray == null){
		listArray = "desc";
	}
	if(boardType == null){
		response.sendRedirect("board.jsp?boardType=0");
		return;
	}   
	
	boardDAO dao = new boardDAO();
	
	List<boardVO> list = dao.listViewDesc(searchType, keyword, startNum, limitperPage, boardType, listArray);
	
	
	int totalCount = dao.getCount(searchType, keyword, boardType);
	int pageGroupSize = 10;
	int startPage = ((currentPage - 1) / pageGroupSize) * pageGroupSize + 1;
	int totalPage = (int)Math.ceil(totalCount / (double)limitperPage);
	int endPage = Math.min(startPage + pageGroupSize -1, totalPage);
	
	System.out.println(keyword);

%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>게시판</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script>
	  (function(d) {
	    var config = {
	      kitId: 'amw5wcy',
	      scriptTimeout: 3000,
	      async: true
	    },
	    h=d.documentElement,t=setTimeout(function(){h.className=h.className.replace(/\bwf-loading\b/g,"")+" wf-inactive";},config.scriptTimeout),tk=d.createElement("script"),f=false,s=d.getElementsByTagName("script")[0],a;h.className+=" wf-loading";tk.src='https://use.typekit.net/'+config.kitId+'.js';tk.async=true;tk.onload=tk.onreadystatechange=function(){a=this.readyState;if(f||a&&a!="complete"&&a!="loaded")return;f=true;clearTimeout(t);try{Typekit.load(config)}catch(e){}};s.parentNode.insertBefore(tk,s)
	  })(document);
	</script>
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
       	<form action="board.jsp?boardType=<%=boardType %>" method="get" id="form">
       		<input type="hidden"  value="<%=boardType%>" name="boardType">
        	<div class="board-top">
        		<div class="search-con">
		        	<select name="searchType">
		        		<option value="title" <%= searchType.equals("title")? "selected" : "" %>>제목</option>
		        		<option value="content" <%= searchType.equals("content")? "selected" : "" %>>내용</option>
		        		<option value="author" <%= searchType.equals("author")? "selected" : "" %>>작성자</option>
		        	</select>
		        	<div class="search-box">
			            <input type="text" name="searchKeyword" value="<%= keyword %>" placeholder="검색어를 입력하세요.">
						<button type="submit" class="btn-img"></button>
		        	</div>
		        </div>
		      <% 
	            	//로그인 했고, 로그인했는데 userType이 0이고, boardType이 0이고
	            	//공지게시판(boardType == 0)이면 관리자(userType ==0)한테만 글쓰기버튼
	            	//로그인 했을 때
	            	if(user != null){
	            		//게시판 타입이 0(공지) 일 때
	            		if(boardType.equals("0")){
	            			//유저 타입이 0(관리자)이여야만 글쓰기를 보여준다
	            			if(user.getUserType() == 0){
	            				%><input type="button" id="write-btn" value="글쓰기"><%	
	            			}
	            		//게시판 타입이 0(공지)이 아닐 때
	            		}else{
	            			%><input type="button" id="write-btn" value="글쓰기"><%
	            		}
	            	}
	            %>
	        </div>
	        <select name="listArray" id="listArray">
	        	<option value="desc" <%= listArray.equals("desc") ? "selected" : "" %>>최신순</option>
	        	<option value="asc" <%= listArray.equals("asc") ? "selected" : "" %>>오래된순</option>
	        </select>
		</form>
	    <div class="list">
			<% for(int i = 0; i < list.size(); i++){ 
				boardVO vo = list.get(i);
			%>
				<div class="content-box" onclick="location.href='post.jsp?no=<%=vo.getNo()%>&boardType=<%= boardType %><%= searchType != ""? "&searchType="+searchType : "" %><%= keyword != "" ? "&searchKeyword=" + keyword : ""%><%= listArray == null ? "" : "&listArray=" + listArray %>'">
					<div class="content">
						<div>
							<span class="b-type">| <%
								if(boardType.equals("0")){
									%>공지사항<%
								}else if(boardType.equals("1")){
									%>정보공유게시판<%	
								}else if(boardType.equals("2")){
									%>익명게시판<%	
								}
								%> |</span>
							<span class="b-title"><%=vo.getTitle() %></span>
						</div>
						<div class="author">
							<%
								if(!boardType.equals("2")){
									%><p><%=vo.getAuthor() %></p><%
								}
							%>
							<span><%=vo.getCreateDate() %></span>
						</div>
					</div>
				</div>
			<% } %>	
	        <div class="page">
	        <%
	        	if(currentPage > 1){
	        %>
	        	<a href="board.jsp?page=1<%= searchType != "" ? "&searchType=" +searchType : "" %><%= keyword != "" ? "&searchKeyword=" +keyword : "" %><%= "&boardType=" +boardType %><%= listArray == null ? "" : "&listArray=" + listArray %>">&lt;&lt;</a>
        		<a href="board.jsp?page=<%=currentPage -1 %><%= searchType != "" ? "&searchType=" +searchType : "" %><%= keyword != "" ? "&searchKeyword=" +keyword : "" %><%= "&boardType=" +boardType %><%= listArray == null ? "" : "&listArray=" + listArray %>">&lt;</a>
        	<%
	        	}
        	%>
				<% for(int i = startPage; i <= endPage; i++){
						if(i == currentPage){
				%>
					<a class="active" href="board.jsp?page=<%= i %><%= searchType != "" ? "&searchType=" +searchType : "" %><%= keyword != "" ? "&searchKeyword=" +keyword : "" %><%= "&boardType=" +boardType %><%= listArray == null ? "" : "&listArray=" + listArray %>"><%= i %></a>
				<% 
				}else{ 
				%>  
				 <a href="board.jsp?page=<%= i %><%= searchType != "" ? "&searchType=" +searchType : "" %><%= keyword != "" ? "&searchKeyword=" +keyword : "" %><%= "&boardType=" +boardType %><%= listArray == null ? "" : "&listArray=" + listArray %>"><%= i %></a>     	
				<%
				}
			}
			%>
			<%
            	if(currentPage < totalPage){
            %>
            <a href="board.jsp?page=<%=currentPage +1 %><%= searchType != "" ? "&searchType=" +searchType : "" %><%= keyword != "" ? "&searchKeyword=" +keyword : "" %><%= "&boardType=" +boardType %>">&gt;</a>
            <a href="board.jsp?page=<%=totalPage %><%= searchType != "" ? "&searchType=" +searchType : "" %><%= keyword != "" ? "&searchKeyword=" +keyword : "" %><%= "&boardType=" +boardType %>">&gt;&gt;</a>
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
        
        $("#listArray").change(function(){
        	$("#form").submit();
        	
        	
	        <%-- $.ajax({
				url : "listArray.jsp",
				type : "post",
				data : {
					searchType : "<%=searchType%>",
					keyword : "<%=keyword%>",
					listArray : $("#listArray option:selected").val(),
					boardType : "<%=boardType%>"
				},
				success : function(result){
					console.log(result);
				},
				error : function(){
					console.log("에러 발생");
				}
	        }); --%>
        });
        
    </script>
</body>
</html>
