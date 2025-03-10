<%@page import="info_file.infoFileDAO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="info_file.infoFileVO"%>
<%@page import="board.boardVO"%>
<%@page import="board.boardDAO"%>
<%@page import="java.util.Enumeration"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="java.io.File"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");
	//String boardType = request.getParameter("boardType");

	String savePath = application.getRealPath("/upload");
	
	int maxFileSize = 1024 * 1024 * 10;
	
	File saveDir = new File(savePath);
	if(!saveDir.exists()){
		saveDir.mkdirs();
	}
	
	MultipartRequest multi = new MultipartRequest(
			request,
			savePath,
			maxFileSize,
			"utf-8",
			new DefaultFileRenamePolicy()
		);
	
	String no = multi.getParameter("no");
	String title = multi.getParameter("title");
	String content = multi.getParameter("content");
	String boardType = multi.getParameter("boardType");
	
	if(no == null || title == null || content == null){
		response.sendRedirect("board.jsp");
		return;
	}
	if(no.isEmpty() || title.isEmpty() || content.isEmpty()){
		response.sendRedirect("board.jsp");
		return;
	}
	if(boardType == null || boardType.isEmpty()){
		boardType = "0";
		return;
	}
	
	boardDAO dao = new boardDAO();
	boardVO vo = new boardVO();
	List<infoFileVO> fileList = new ArrayList<>();
	
	
	Enumeration files = multi.getFileNames();
	while(files.hasMoreElements()){
		//modify.jsp에 form안에 file태그가 하나라도 있으면 동작
		
		String name = (String)files.nextElement();
		//form안의 file태그의 name속성 값(file)
		
		System.out.println(name);
		String fileName = multi.getFilesystemName(name);
		//form안의 name이 file인 html태그에 업로드된 파일 이름
		
		System.out.println(fileName);
		if(fileName == null){
			//file 태그는 있지만, file태그 안에 선택된(업로드된) 파일이 없으면
			continue;
			//다음 루프로
		}
		String originName = multi.getOriginalFileName(name);
		
		File uploadFile = new File(savePath + "/"+ fileName);
		long fileSize = uploadFile.length();
		
		infoFileVO fileVO = new infoFileVO();
		fileVO.setAttachLocation(savePath);
		fileVO.setFileSize((int)fileSize);
		fileVO.setAttachOriginName(originName);
		fileVO.setAttachUploadName(fileName);
		fileVO.setFno(no);
		fileList.add(fileVO);
	}
	
	infoFileDAO fileDao = new infoFileDAO();
	
	fileDao.upload(fileList);
	
	vo.setTitle(title);
	vo.setContent(content);
	vo.setNo(no);
	
	dao.modify(vo);
	
	response.sendRedirect("post.jsp?no="+no+"&boardType="+boardType);
%>