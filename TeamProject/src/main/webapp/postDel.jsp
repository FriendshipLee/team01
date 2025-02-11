<%@page import="board.boardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String no = request.getParameter("no");
	if(no == null){
		response.sendRedirect("board.jsp");
		return;
	}
	
	boardDAO dao = new boardDAO();
	dao.delete(no);
	response.sendRedirect("board.jsp");
%>