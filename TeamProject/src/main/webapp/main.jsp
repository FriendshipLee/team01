<%@page import="users.usersVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	usersVO user = (usersVO)session.getAttribute("user");
%>
<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<link rel="stylesheet" href="./resources/css/main.css">
</head>
<body>
	<div class="content-box">
		<div>
			<img alt="채용 고민과 사내 고민을 모두 해결할 수 있는 익명 커뮤니티가 제공되는 구인구직 플랫폼" src="./resources/img/main_text.png">
			<ul class="nav">
			  <li><a href="#" onclick="location.href='job.jsp'">채용정보</a> | </li>
			  <li><a href="#" onclick="location.href='board.jsp?boardType=0'">공지게시판</a> | </li>
			  <li><a href="#" onclick="location.href='board.jsp?boardType=1'">정보공유게시판</a> | </li>
			  <li><a href="#" onclick="location.href='board.jsp?boardType=2'">익명게시판</a></li>
			</ul>
			<%
				if(user == null){
					%>
					<button type="button" onclick="location.href='signup.jsp'">회원가입</button>
					<button type="button" onclick="location.href='login.jsp'">로그인</button>
					<%
				}else{
					%>
					<button type="button" onclick="location.href='mypage.jsp'">마이페이지</button>
					<button type="button" onclick="location.href='logout.jsp'">로그아웃</button>
					<%
				}
			%>
			
		</div>
		<div class="slide">
			<img alt="왼쪽화살표" src="./resources/img/left.png">
			<img alt="" src="./resources/img/content_img.png">
			<img alt="오른쪽화살표" src="./resources/img/right.png">
		</div>
	</div>
	<span>Team A. 김다영, 이우정, 김지선</span>
</body>
</html>