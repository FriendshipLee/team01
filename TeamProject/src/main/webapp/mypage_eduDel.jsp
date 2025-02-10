<%@page import="resume.resumeDAO"%>
<%@page import="resume.resumeVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="header.jsp" %>
<%
	String id = request.getParameter("id");

	if(id == null || id == ""){
		response.sendRedirect("mypage.jsp");
	}

	resumeVO vo = new resumeVO();
	resumeDAO dao = new resumeDAO();
	
	vo.setId(id);
	dao.delete(id);
%>