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
	String idSaveCheck = request.getParameter("idSaveCheck");
	//null이면 체크박스 해제, on이면 체크 한거
	
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
		}
	
		session.removeAttribute("id");
		session.setAttribute("user", user);
		if(idSaveCheck != null){
			//화면에서 자동로그인 체크 했을 때 아이디 저장
			Cookie cookie = new Cookie("id", "id_"+id);
			cookie.setMaxAge(1 * 60 * 60 * 24 * 10);
			
			response.addCookie(cookie);
		}
		response.sendRedirect("main.jsp");
		return;
	}	
		//기업회원 로그인
		System.out.println("기업회원");
		if(userType.equals("2")){
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
		}
		if(idSaveCheck != null){
			Cookie cookie = new Cookie("id", "id_"+bid);
			cookie.setMaxAge(1 * 60 * 60 * 24 * 10);
			
			response.addCookie(cookie);
		}
		session.removeAttribute("bid");
		session.setAttribute("user", cuser);
		
		response.sendRedirect("main.jsp");
	}
%>