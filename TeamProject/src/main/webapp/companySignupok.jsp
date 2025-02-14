<%@page import="company.companyVO"%>
<%@page import="company.companyDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");
	
	String companyNumber = request.getParameter("companyNumber");
	String pw = request.getParameter("pw");
	String ceoName = request.getParameter("ceoName");
	String companyName = request.getParameter("companyName");
	String number = request.getParameter("number");
	
	if(companyNumber == null || pw == null || ceoName == null || companyName == null || number == null){
		response.sendRedirect("signup.jsp");
		return;
	}
	
	if(companyNumber.isEmpty() || pw.isEmpty() || ceoName.isEmpty() || companyName.isEmpty() || number.isEmpty()){
		response.sendRedirect("signup.jsp");
		return;
	}
	
	companyDAO dao = new companyDAO();
	
	companyVO vo = new companyVO();
	vo.setCompanyNumber(companyNumber);
	vo.setPw(pw);
	vo.setCeoName(ceoName);
	vo.setCompanyName(companyName);
	vo.setNumber(number);
	
	dao.join(vo);
	
	response.sendRedirect("login.jsp");
%>