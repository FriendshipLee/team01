<%@page import="company.companyVO"%>
<%@page import="users.usersVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	usersVO user = (usersVO)session.getAttribute("user");
	companyVO company = (companyVO)session.getAttribute("company");
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
		<ul class="nav">
			<li><a href="#" onclick="location.href='main.jsp'">홈</a></li>
			<li><a href="#" onclick="location.href='job.jsp'">채용공고</a></li>
			<li><a href="#" onclick="location.href='board.jsp'">공지게시판</a></li>
			<li><a href="#" onclick="location.href='board.jsp'">정보공유게시판</a></li>
			<li><a href="board.jsp">익명게시판</a></li>
		</ul>
		<a href="mypage.jsp"><span>김지선 </span>님</a>
	</div>
	<hr>
</body>
</html>