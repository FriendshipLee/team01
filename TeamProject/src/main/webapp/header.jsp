<%@page import="users.User"%>
<%@page import="board.boardVO"%>
<%@page import="company.companyVO"%>
<%@page import="users.usersVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	User user = (User)session.getAttribute("user");
	
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
	<title>Insert title here</title>
	<link rel="stylesheet" href="./resources/css/header.css"></link>
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
</head>
<body>
	<div class="wrap">
		<div class="header">
		
			<%
				if(user != null){
			%>
			<ul class="nav">
				<li><a onclick="location.href='main.jsp'">홈</a></li>
				<li><a onclick="location.href='gonggo.jsp'">채용공고</a></li>
				<li><a onclick="location.href='board.jsp?boardType=0'">공지게시판</a></li>
				<%
					if(user.getCompanyNumber() != null){
						%>
						<li><a onclick="alert('개인회원 전용 게시판입니다.')">정보공유게시판</a></li>
						<li><a onclick="alert('개인회원 전용 게시판입니다.')">익명게시판</a></li>
						<%
					}else{
						%>
						<li><a onclick="location.href='board.jsp?boardType=1'">정보공유게시판</a></li>
						<li><a onclick="location.href='board.jsp?boardType=2'">익명게시판</a></li>
						<%
					}
				%>
			</ul>
			<%
			}else{
				%>
			<ul class="nav">
				<li><a onclick="location.href='main.jsp'">홈</a></li>
				<li><a onclick="location.href='gonggo.jsp'">채용공고</a></li>
				<li><a onclick="location.href='board.jsp?boardType=0'">공지게시판</a></li>
				<li><a onclick="alert('개인회원 로그인 시 이용 가능합니다.')">정보공유게시판</a></li>
				<li><a onclick="alert('개인회원 로그인 시 이용 가능합니다.')">익명게시판</a></li>
			</ul>
			<%} %>
			<div>
			<% 
				if(user == null){
					%><a href="#" onclick="location.href='login.jsp'">로그인</a><%
				}else{
					%>
						<a <%=user.getCompanyNumber() != null ? "class='none'" : "href='mypage.jsp'" %>><span><%=user.getName() != null ? user.getName() : user.getCompanyName() %></span>님</a>
						<a href="logout.jsp">로그아웃</a>
					<%
				}
			%>
			</div>
		</div>
	</div>
</body>
</html>