<%@page import="board.boardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String searchType = request.getParameter("searchType");
	String keyword = request.getParameter("keyword");
	String listArray = request.getParameter("listArray");
	String boardType = request.getParameter("boardType");
	
	String pageNum = request.getParameter("page");
	if(pageNum == null){
		pageNum = "1";
	} 
	
	int currentPage = Integer.parseInt(pageNum);
	int startNum = (currentPage-1) * 10;
	int limitperPage = 10;
	
	boardDAO dao = new boardDAO();
	int totalCount = dao.getCount(searchType, keyword, boardType);
	int pageGroupSize = 10;
	int startPage = ((currentPage - 1) / pageGroupSize) * pageGroupSize + 1;
	int totalPage = (int)Math.ceil(totalCount / (double)limitperPage);
	int endPage = Math.min(startPage + pageGroupSize -1, totalPage);
	
	if(listArray.equals("desc")){
		dao.listViewDesc(searchType, keyword, startNum, limitperPage, boardType);
	}else {
		dao.listViewAsc(searchType, keyword, startNum, limitperPage, boardType);
	};
	
	out.print("success");
%>