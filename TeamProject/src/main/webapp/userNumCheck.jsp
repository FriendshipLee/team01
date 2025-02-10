<%@page import="users.usersDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String num = request.getParameter("num");
	usersDAO dao = new usersDAO();
	
	int result = dao.numberCheck(num);
	out.print(result);
%>