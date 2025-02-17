<%@page import="board.boardVO"%>
<%@page import="company.companyVO"%>
<%@page import="users.usersVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	usersVO user = (usersVO)session.getAttribute("user");
	companyVO company = (companyVO)session.getAttribute("company");
	/* boardVO bType = (boardVO)session.getAttribute("boardType"); */
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
	<title>Insert title here</title>
	<link rel="stylesheet" href="./resources/css/header.css"></link>
</head>
<body>
	<div class="wrap">
		<div class="header">
			<ul class="nav">
				<li><a href="#" onclick="location.href='main.jsp'">홈</a></li>
				<li><a href="#" onclick="location.href='gonggo.jsp'">채용공고</a></li>
				<li><a href="#" onclick="location.href='board.jsp?boardType=0'">공지게시판</a></li>
				<li><a href="#" onclick="location.href='board.jsp?boardType=1'">정보공유게시판</a></li>
				<li><a href="#" onclick="location.href='board.jsp?boardType=2'">익명게시판</a></li>
			</ul>
			<%
				if(user == null){
					%><a href="#" onclick="location.href='login.jsp'">로그인</a><%
				}else{
					%>
						<a href="mypage.jsp"><span><%=user.getName() %></span>님</a>
						<a href="logout.jsp">로그아웃</a>
					<%
				}
			%>
		</div>
	</div>
</body>
</html>