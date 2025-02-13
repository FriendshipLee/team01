<%@page import="resume.resumeDAO"%>
<%@page import="resume.resumeVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String school = request.getParameter("school");
	String gDate = request.getParameter("gDate");
	String major = request.getParameter("major");
	String id = request.getParameter("id");
	
	if(school == null || school == "" || gDate == null || gDate == "" || major == null || major == ""){
		out.print("fail");
		return;
	}
	
	resumeVO vo = new resumeVO();
	resumeDAO dao = new resumeDAO();
	
	vo.setSchool(school);
	vo.setGraduation_date(gDate);
	vo.setMajor(major);
	vo.setId(id);
	
	int result = dao.addEducation(vo);
	
	out.print("success");
	
%>