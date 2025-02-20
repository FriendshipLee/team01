<%@page import="gonggo.gonggoVO"%>
<%@page import="gonggo.gonggoDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="header.jsp" %>
<%
	String no = request.getParameter("no");
	if(no == null || user == null) {
		response.sendRedirect("main.jsp");
		return;
	}
	
	gonggoDAO dao = new gonggoDAO();
	gonggoVO vo = dao.view(no);
	
	String title = vo.getTitle();
	String author = vo.getAuthor();
	String content = vo.getContent();
	String career = vo.getCareer();
	String education = vo.getEducation();
	String location = vo.getLocation();
	String deadline = vo.getDeadline();
	String link = vo.getLink();
	String createDate = vo.getCreateDate();
	
	String searchType = request.getParameter("searchType");
	String keyword = request.getParameter("searchkeyword");
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<title>Insert title here</title>
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
	    <link rel="stylesheet" href="./resources/css/gonggoPost.css"></link>
	</head>
	<body>
		<div class="container">
	     	<div class="post-box">
	            <div class="post-top">
	            	<div>
	            		<h2><%=title %></h2>
		           		<p>기업명 :<%=author %>  | 작성일 : <%=createDate %> | 마감일: <%=deadline %></p>
	          	  	</div>
		            <hr>
			        <span>경력 : <%=career %></span>    
			        <span>학력 : <%=education %></span>    
			        <p>근무위치 :  <%=location %></p>
		            <p><%=content %></p>
		            <br>
				</div>
				<a href="<%=link %>">접수하러 가기</a>
				<div class="modify">
					<input type="button" onclick="location.href='gonggoModify.jsp?no=<%=no %>'" value="수정">
					<input type="button" onclick="location.href='gonggoDel.jsp?no=<%=no %>'" value="삭제">
				</div>
	       		<input type="button" class="button" onclick="location.href='gonggo.jsp?no=<%=no %><%= searchType != ""? "&searchType="+searchType : "" %><%= keyword != "" ? "&searchkeyword=" + keyword : ""%>" value="뒤로가기">
	   		</div>
	   	</div>
	</body>
</html>