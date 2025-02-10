<%@page import="users.usersDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String id = request.getParameter("id");
	usersDAO dao = new usersDAO();
	
	int result = dao.idCheck(id);
	out.print(result);
%>