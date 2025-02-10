<%@page import="company.companyDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String companyNumber = request.getParameter("companyNumber");
	companyDAO dao = new companyDAO();
	
	int result = dao.companyNumberCheck(companyNumber);
	out.print(result);
%>