<%@page import="resume_file.resumeFileVO"%>
<%@page import="resume_file.resumeFileDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String fno = request.getParameter("fno");
	
	System.out.println(fno);
	
	if(fno == null || fno.isEmpty()){
		out.print("fail");
		return;
	}
	
	resumeFileDAO dao = new resumeFileDAO();
	dao.delete(fno);
	out.print("success");
%>