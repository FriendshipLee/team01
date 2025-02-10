<%@page import="resume.resumeVO"%>
<%@page import="users.usersVO"%>
<%@page import="users.usersDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");

	String userId = request.getParameter("userId");
	String userPw = request.getParameter("userPw");
	String userName = request.getParameter("userName");
	String userNick = request.getParameter("userNick");
	String userBirth = request.getParameter("userBirth");
	String gender = request.getParameter("gender");
	String userNumber = request.getParameter("userNumber");
	String userEmail = request.getParameter("userEmail");
	
	if(userId == null || userPw == null || userName == null || userNick == null || userBirth == null || gender == null || userNumber == null || userEmail == null){
		response.sendRedirect("signup.jsp");
		return;
	}
	if(userId.isEmpty() || userPw.isEmpty() || userName.isEmpty() || userNick.isEmpty() || userBirth.isEmpty() || gender.isEmpty() || userNumber.isEmpty()|| userEmail.isEmpty()){
		response.sendRedirect("signup.jsp");
		return;
	}
	
	usersDAO dao = new usersDAO();
	
	usersVO vo = new usersVO();
	vo.setId(userId);
	vo.setPw(userPw);
	vo.setName(userName);
	vo.setNick(userNick);
	vo.setBirth(userBirth);
	vo.setGender(gender);
	vo.setNumber(userNumber);
	vo.setEmail(userEmail);
	
	dao.join(vo);
	
	response.sendRedirect("login.jsp");
%>