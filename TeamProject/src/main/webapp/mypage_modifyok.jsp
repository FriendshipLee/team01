<%@page import="users.usersVO"%>
<%@page import="users.usersDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String pw = request.getParameter("pw");
	String id = request.getParameter("id");	

	if(pw == "" || pw == null){
		out.print("fail");
		return;
	}
	
	usersVO vo = new usersVO();
	usersDAO dao = new usersDAO();
	
	vo.setId(id);
	vo.setPw(pw);
	dao.modify(vo);
	
	out.print("success");
	
%>