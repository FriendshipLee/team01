<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	Cookie cookie = new Cookie("id" ,"hello");
	cookie.setMaxAge(0);
	response.addCookie(cookie);
	
	session.invalidate();
	response.sendRedirect("main.jsp");
%>