<%@page import="resume.resumeVO"%>
<%@page import="career.careerDAO"%>
<%@page import="career.careerVO"%>
<%@page import="resume.resumeDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String companyName = request.getParameter("company");
	String cStartDate = request.getParameter("cStartDate");
	String cEndDate = request.getParameter("cEndDate");
	String work = request.getParameter("work");
	String id = request.getParameter("id");
	
	if(companyName == null || cStartDate == null || work == null || cEndDate == null){
		out.print("fail");
		return;
	}
	
	
	if(companyName.isEmpty() || cStartDate.isEmpty() || work.isEmpty() || cEndDate.isEmpty()){
		out.print("fail");
		return;
	}
	
	resumeDAO dao = new resumeDAO();
	resumeVO rvo = dao.select(id);
	String no = rvo.getNo();
	
	careerVO vo = new careerVO();
	careerDAO cao = new careerDAO();
	
	vo.setNo(no);
	vo.setCompany(companyName);
	vo.setCareer_start_date(cStartDate);
	vo.setWork(work);
	vo.setCareer_end_date(cEndDate);

	int result = cao.write(vo);
	out.print(result);
%>