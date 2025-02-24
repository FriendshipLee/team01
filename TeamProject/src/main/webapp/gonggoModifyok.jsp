<%@page import="users.User"%>
<%@page import="users.usersVO"%>
<%@page import="gonggo.gonggoDAO"%>
<%@page import="gonggo.gonggoVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");
	
	User user = (User)session.getAttribute("user");
	
	if(user == null){
		response.sendRedirect("login.jsp");
		return;
	}
	
	String title = request.getParameter("title");
	String career = request.getParameter("career");
	String education = request.getParameter("education");
	String content = request.getParameter("content");
	String location = request.getParameter("location");
	String deadline = request.getParameter("deadline");
	String link = request.getParameter("link");
	String no = request.getParameter("no");
	
	if(no == null || no.isEmpty()){
		response.sendRedirect("gonggo.jsp");
		return;
	}
	if(title == null || career == null || education == null || content == null || location == null || deadline == null || link == null){
		response.sendRedirect("gonggoPost.jsp?no="+no);
		return;
	}
	if(title.isEmpty() || career.isEmpty() || education.isEmpty() || content.isEmpty() || location.isEmpty() || deadline.isEmpty() || link.isEmpty()){
		response.sendRedirect("gonggoPost.jsp?no="+no);
		return;
	}
	
	gonggoVO vo = new gonggoVO();
	gonggoDAO dao = new gonggoDAO();
	
	vo.setTitle(title);
	vo.setCareer(career);
	vo.setEducation(education);
	vo.setContent(content);
	vo.setLocation(location);
	vo.setDeadline(deadline);
	vo.setLink(link);
	vo.setNo(no);
	
	dao.modify(vo);
	
	response.sendRedirect("gonggoPost.jsp?no="+no);
%>