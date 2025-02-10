<%@page import="reply.replyVO"%>
<%@page import="reply.replyDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%

request.setCharacterEncoding("utf-8");

String rno = request.getParameter("rno");
String rcontent = request.getParameter("content");

if(rno == null || rcontent == null){
	out.print("fail");
	return;
}

if(rno.isEmpty() || rcontent.isEmpty()){
	out.print("fail");
	return;
}

replyDAO dao = new replyDAO();
replyVO vo = new replyVO();
vo.setRno(rno);
vo.setContent(rcontent);

dao.modify(vo);

out.print("success");
%>
