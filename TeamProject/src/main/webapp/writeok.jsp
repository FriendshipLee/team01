<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="info_file.infoFileVO"%>
<%@page import="java.util.Enumeration"%>
<%@page import="java.io.File"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="board.boardDAO"%>
<%@page import="board.boardVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");

	String savePath = application.getRealPath("/upload");
	//파일 업로드 경로(webapp/upload)
	
	int maxFileSize = 1024 * 1024 * 10;
	//업로드 파일 크기(10mb)
	
	File saveDir = new File(savePath);
	if(!saveDir.exists()){	//upload 폴더가 없으면
		saveDir.mkdirs();	//폴더를 생성한다.
	}
	
	MultipartRequest multi = new MultipartRequest(
			request,		//요청 객체
			savePath,		//저장 경로
			maxFileSize,	//파일 크기
			"utf-8",		//인코딩
			new DefaultFileRenamePolicy()
	);
	
	String title = multi.getParameter("title");
	String content = multi.getParameter("content");
	
	boardVO vo = new boardVO();
	vo.setTitle(title);
	vo.setContent(content);
	
	boardDAO dao = new boardDAO();
	int no = dao.write(vo);
	
	Enumeration files = multi.getFileNames();
	
	List<infoFileVO> fileList = new ArrayList<>();
	while(files.hasMoreElements()){
		infoFileVO fileVO = new infoFileVO();
		String name = (String)files.nextElement();
		//write.jsp의 input file태그의 name 속성의 값들
		
		String fileName = multi.getFilesystemName(name);
		//업로드된 파일 이름
		
		String originFileName = multi.getOriginalFileName(name);
		//원본파일 이름
		
		fileVO.setAttachLocation(savePath);
		fileVO.setAttachOriginName(originFileName);
		fileVO.setAttachUploadName(fileName);
		fileVO.setNo(no+"");
		
		fileList.add(fileVO);
	}
%>