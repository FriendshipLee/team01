<%@page import="company.companyDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String number = request.getParameter("number");
	companyDAO dao = new companyDAO();
	
	int result = dao.numberCheck(number);
	out.print(result);
%>