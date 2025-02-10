<%@page import="users.usersDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String email = request.getParameter("email");
	usersDAO dao = new usersDAO();
	
	int result = dao.emailCheck(email);
	out.print(result);
%>
