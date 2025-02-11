<%@page import="resume.resumeVO"%>
<%@page import="career.careerDAO"%>
<%@page import="career.careerVO"%>
<%@page import="resume.resumeDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="header.jsp" %>
<%
	String companyName = request.getParameter("company");
	String cdate = request.getParameter("cdate");
	String work = request.getParameter("work");
	String id = user.getId();
	
	if(companyName == null || cdate == null || work == null){
		response.sendRedirect("mypage.jsp");
		return;
	}
	
	if(id == null || id.isEmpty()){
		response.sendRedirect("login.jsp");
		return;
	}
	
	if(companyName.isEmpty() || cdate.isEmpty() || work.isEmpty()){
		response.sendRedirect("mypage.jsp");
		return;
	}
	
	resumeDAO dao = new resumeDAO();
	resumeVO vo = dao.select(id);
	String no = vo.getNo();
	
	careerVO cvo = new careerVO();
	careerDAO cao = new careerDAO();
	
	cvo.setNo(no);
	cvo.setCompany(companyName);
	cvo.setCareer_date(cdate);
	cvo.setWork(work);

	int result = cao.write(cvo);
	
%>