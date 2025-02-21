<%@page import="gonggo.gonggoVO"%>
<%@page import="java.util.List"%>
<%@page import="gonggo.gonggoDAO"%>
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
	
	if(searchType == null){
		searchType = "";
	}
	if(keyword == null){
		keyword = "";
	}
	if(listArray == null){
		listArray = "desc";
	}
	
	gonggoDAO dao = new gonggoDAO();
	List<gonggoVO> list = dao.gonggoList(searchType, keyword, startNum, limitperPage);
	
	int totalCount = dao.getCount(searchType, keyword);
	
	int pageGroupSize = 10;
	int startPage = ((currentPage - 1) / pageGroupSize) * pageGroupSize + 1;
	int totalPage = (int)Math.ceil(totalCount / (double)limitperPage);
	int endPage = Math.min(startPage + pageGroupSize -1, totalPage);
	
	System.out.println("전체 게시글" + totalCount);
	System.out.println("전체 페이지" + totalPage);
	
%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>채용공고</title>
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
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <link rel="stylesheet" href="./resources/css/gonggo.css"></link>
</head>
<body>
    <div class="container">
        <h2>채용공고</h2>
        <div class="board-top">
        	<div class="search-con">
	        	<select name="searchType">
	        		<option value="title" <%= searchType.equals("title")? "selected" : "" %>>제목</option>
	        		<option value="content" <%= searchType.equals("content")? "selected" : "" %>>내용</option>
	        		<option value="author" <%= searchType.equals("author")? "selected" : "" %>>작성자</option>
	        	</select>
	        	<div class="search-box">
		            <input type="text" value="<%= keyword %>" name="searchkeyword" placeholder="검색어를 입력하세요.">
					<button type="submit" class="btn-img"></button>        	
	        	</div>
        	</div>
        	<%if(user != null && user.getCompanyName() != null){ %>
            <input type="button" id="write-btn" value="글쓰기">
            <%} %>
        </div>
        
        <!-- <div class="filters">
            <input type="checkbox" id="cb1" value="#프로그래머">
            <label for="cb1">#프로그래머</label>
            <input type="checkbox" id="cb2" value="#디자이너">
            <label for="cb2">#디자이너</label>
            <input type="checkbox" id="cb3" value="#기획자">
            <label for="cb3">#기획자</label>
            <input type="checkbox" id="cb4" value="#서버관리">
            <label for="cb4">#서버관리</label>
        </div> -->
		
		<div class="list">
			<% for(int i = 0; i < list.size(); i++){
				gonggoVO vo = list.get(i);
				String no = vo.getNo();
				String title = vo.getTitle();
				String content = vo.getContent();
				String author = vo.getAuthor();
				String career = vo.getCareer();
				String education = vo.getEducation();
				String location = vo.getLocation();
				String deadline = vo.getDeadline();
				String due = vo.getDue();
			%> 
				<%
					if(due.equals("채용중")){
						%>
							<div class="content" onclick="location.href='gonggoPost.jsp?no=<%=no%>'">
						<%
					}else{
						%>
							<div class="content">
						<%
					}
				%>
					<%-- <div class="content" <%= due.equals("채용중") ? `onclick="location.href='gonggoPost.jsp?no=<%=no%>'"` : "" %> > --%>
					<div>
						<span><%= author  %></span>
						<h4><%= title %></h4>
						<span><%= location %><%= career %><%= education %></span>
					</div>
					<div class="deadline">
						<p style="color:<%= due.equals("채용중") ? "blue" : "red" %>"><%=due %></p>
						<span>~<%= deadline %></span>
					</div>
					
				</div>
			<% } %>	
	        <div class="page">
				<%
	        	 if(currentPage > 1){
	        	%>
	        	<a href="gonggo.jsp?page=1<%= searchType != "" ? "&searchType=" +searchType : "" %><%= keyword != "" ? "&searchkeyword=" +keyword : "" %>">&lt;&lt;</a>
        		<a href="gonggo.jsp?page=<%=currentPage -1 %><%= searchType != "" ? "&searchType=" +searchType : "" %><%= keyword != "" ? "&searchkeyword=" +keyword : "" %>">&lt;</a>
        	    <%
	        	 }
        	    %>
        	    <%
        	    	for(int i = startPage; i <= endPage; i++){
        	    		if(i == currentPage){
        	    	%>
        	    	<a class="active" href="gonggo.jsp?page=<%= i %><%= searchType != "" ? "&searchType=" +searchType : "" %><%= keyword != "" ? "&searchkeyword=" +keyword : "" %>"><%= i %></a>
        	    	<%
      	    		}else{
        	    	 	%>
        	    	 	<a href="gonggo.jsp?page=<%= i %><%= searchType != "" ? "&searchType=" +searchType : "" %><%= keyword != "" ? "&searchkeyword=" +keyword : "" %>"><%= i %></a>
        	    	 	<%
      	    			}
      	    		}
        	    %>   	
        	    <%
					if(currentPage < totalPage){        	    
        	    %>
        	    <a href="gonggo.jsp?page=<%=currentPage +1 %><%= searchType != "" ? "&searchType=" +searchType : "" %><%= keyword != "" ? "&searchkeyword=" +keyword : "" %>">&gt;</a>
            	<a href="gonggo.jsp?page=<%=totalPage %><%= searchType != "" ? "&searchType=" +searchType : "" %><%= keyword != "" ? "&searchkeyword=" +keyword : "" %>">&gt;&gt;</a>
            <%
				}
            %>
	        </div>
		</div>
    </div>

    <script>
    	$(document).ready(function() {
            $('#write-btn').click(function() {
                window.location.href = 'gonggoWrite.jsp';
            });
        });
    </script>
</body>
</html>
