<%@page import="reply.replyVO"%>
<%@page import="reply.replyDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");
	String no = request.getParameter("no");
	String rauthor = request.getParameter("rauthor");
	String rcontent = request.getParameter("content");
	
	if(no == null || rauthor == null || rcontent == null){
		return;
	}
	
	if(no.isEmpty() || rauthor.isEmpty() || rcontent.isEmpty()){
		return;
	}
	
	replyDAO dao = new replyDAO();
	replyVO vo = new replyVO();
	vo.setBno(no);
	vo.setRauthor(rauthor);
	vo.setContent(rcontent);
	
dao.write(vo);
	
%>