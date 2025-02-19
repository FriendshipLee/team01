<%@page import="info_file.infoFileDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String fno = request.getParameter("fno");

	if(fno == null || fno.isEmpty()){
		out.print("fail");
		return;
	}
	
	infoFileDAO dao = new infoFileDAO();
	dao.delete(fno);
	out.print("success");
%>