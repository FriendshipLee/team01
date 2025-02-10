<%@page import="users.usersDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="header.jsp" %>
<%
	String pw = request.getParameter("pw");
	
	if(pw == "" || pw == null){
		response.sendRedirect("mypage.jsp");
		return;
	}
	
	/* usersVO vo = new usersVO();
	usersDAO dao = new usersDAO();
	
	vo.setId("hong");
	vo.setPw(pw);
	dao.modify(vo); */
	
	
%>