<%@page import="users.usersDAO"%>
<%@page import="company.companyVO"%>
<%@page import="company.companyDAO"%>
<%@page import="users.usersVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String id = request.getParameter("username");
	String pw = request.getParameter("password");
	String bid = request.getParameter("buser");
	String bpw = request.getParameter("bpassword");
	String userType = request.getParameter("userType");
	String rememberId = request.getParameter("rememberId");
	//로그인 타입. 1이면 일반회원, 2면 기업회원
	
	if(userType == null){
		response.sendRedirect("login.jsp");
		return;
	}
	
	//userType == "1"
	if(userType.equals("1")){
		System.out.println("일반회원");
		//일반회원 로그인
		if(id == null || pw == null){
			System.out.println("아이디 비밀번호 null?");
			response.sendRedirect("login.jsp");
			return;
		}else {
        	if( remember == null){  // 체크 안하면 null, 공백 넣어서 비교
                remember = "";
            }
		
		if(id.isEmpty() || pw.isEmpty()){
			response.sendRedirect("login.jsp");
			return;
		}
		
		usersDAO dao = new usersDAO();
		usersVO vo = new usersVO();
		vo.setId(id);
		vo.setPw(pw);
		
		usersVO user = dao.login(vo);
		if(user == null){
			session.setAttribute("id", id);
			response.sendRedirect("login.jsp?error=pe"+"&userType="+userType);
			return;
		}else if(rememberId != null && rememberId.equals("true")){
			session.setAttribute("id", id);
		}else{
			session.removeAttribute("Id");
			response.sendRedirect("login.jsp");
		}
		
		session.setAttribute("user", user);
		response.sendRedirect("main.jsp");
	
		
		//기업회원 로그인
		System.out.println("기업회원");
		if(bid == null || bpw == null){
			response.sendRedirect("login.jsp");
			return;
		}
		
		if(bid.isEmpty() || bpw.isEmpty()){
			response.sendRedirect("login.jsp");
			return;
		}
		
		companyDAO cdao = new companyDAO(); 
		companyVO cvo = new companyVO();
		cvo.setCompanyNumber(bid);
		cvo.setPw(bpw);
		
		companyVO cuser = cdao.login(cvo);
		if(cuser == null){
			session.setAttribute("bid", bid);
			response.sendRedirect("login.jsp?error=pe"+"&userType="+userType);
			return;
		}else if(rememberId != null && rememberId.equals("true")){
			session.setAttribute("bid", bid);
		}else{
			session.removeAttribute("bId");
			response.sendRedirect("login.jsp");
		}
		
		session.setAttribute("user", cuser);
		
		response.sendRedirect("main.jsp");
	}
%>