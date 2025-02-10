<%@page import="users.usersDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String nick = request.getParameter("nick");
	usersDAO dao = new usersDAO();
	
	int result = dao.nickCheck(nick);
	out.print(result);
%>