<%@page import="company.companyDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String num = request.getParameter("num");
	companyDAO dao = new companyDAO();
	
	int result = dao.numberCheck(num);
	out.print(result);
%>