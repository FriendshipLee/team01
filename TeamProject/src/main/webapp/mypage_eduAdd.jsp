<%@page import="resume.resumeDAO"%>
<%@page import="resume.resumeVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String school = request.getParameter("school");
	String eDate = request.getParameter("eDate");
	String gDate = request.getParameter("gDate");
	String major = request.getParameter("major");
	String id = request.getParameter("id");
	
	if(school == null || school == "" || gDate == null || gDate == "" || major == null || major == "" || eDate == null || eDate == ""){
		out.print("fail");
		return;
	}
	
	resumeVO vo = new resumeVO();
	resumeDAO dao = new resumeDAO();
	
	vo.setSchool(school);
	vo.setGraduation_date(gDate);
	vo.setMajor(major);
	vo.setId(id);
	vo.setEnter_date(eDate);
	
	int result = dao.addEducation(vo);
	
	out.print(result); //success 넘겨줘도 가능한 이유?
	
%>