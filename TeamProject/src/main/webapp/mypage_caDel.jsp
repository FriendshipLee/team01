<%@page import="career.careerVO"%>
<%@page import="career.careerDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String cno = request.getParameter("cno");

	if(cno == null || cno.isEmpty()){
		out.print("fail");
		return;
	}
	
	careerDAO dao = new careerDAO();
	dao.delete(cno);
	out.print("success");
%>