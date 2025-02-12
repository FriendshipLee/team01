<%@page import="board.boardVO"%>
<%@page import="board.boardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String no = request.getParameter("no");
	String boardType = request.getParameter("boardType");
	if(no == null){
		response.sendRedirect("post.jsp");
		return;
	}
	
	boardDAO dao = new boardDAO();
	
	dao.delete(no);
	response.sendRedirect("board.jsp?boardType="+boardType);
%>