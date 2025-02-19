<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="header.jsp" %>
<%
	String searchType = request.getParameter("searchType");
	String keyword = request.getParameter("searchKeyword");
	String boardType = request.getParameter("boardType");
	
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
    <link rel="stylesheet" href="./resources/css/gongo.css"></link>
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
		            <input type="text" placeholder="검색어를 입력하세요.">
					<input type="button" class="btn-img">        	
	        	</div>
        	</div>
        	<%if(user != null && user.getCompanyName() != null){ %>
            <input type="button" id="write-btn" value="글쓰기">
            <%} %>
        </div>
        
        <div class="filters">
            <input type="checkbox" id="cb1" value="#프로그래머">
            <label for="cb1">#프로그래머</label>
            <input type="checkbox" id="cb2" value="#디자이너">
            <label for="cb2">#디자이너</label>
            <input type="checkbox" id="cb3" value="#기획자">
            <label for="cb3">#기획자</label>
            <input type="checkbox" id="cb4" value="#서버관리">
            <label for="cb4">#서버관리</label>
        </div>
		
		<div class="list">
			<% for(int i = 0; i < 10; i++){ %>
				<div class="content" onclick="location.href='post.jsp'">
					<div>
						<span>(주)엑셈</span>
						<h4>플랫폼 백엔드 API 개발자 모집 <%=i %></h4>
						<span>서울 강서구   경력 5~10년   대졸↑   정규직</span>
					</div>
					<div class="deadline">
						<p>접수마감</p>
						<span>~ 03.07 (금)</span>
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
