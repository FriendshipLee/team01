<%@page import="gonggo.gonggoVO"%>
<%@page import="gonggo.gonggoDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String no = request.getParameter("no");
	if(no == null){
		response.sendRedirect("gonggoPost.jsp");
		return;
	}
	
	gonggoDAO dao = new gonggoDAO();
	dao.delete(no);
	
	response.sendRedirect("gonggoPost.jsp");
%>