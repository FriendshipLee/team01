<%@page import="com.fasterxml.jackson.databind.ObjectMapper"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.lang.reflect.Array"%>
<%@page import="java.util.List"%>
<%@page import="resume.resumeVO"%>
<%@page import="resume_file.resumeFileVO"%>
<%@page import="resume_file.resumeFileDAO"%>
<%@page import="java.util.Enumeration"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="java.io.File"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");
	
	//파일 업로드 경로
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
		
		String rno = multi.getParameter("rno");
		if(rno == null){
			out.println("fail");
			return;
		}
		
		resumeFileDAO dao = new resumeFileDAO();
		
		Enumeration files = multi.getFileNames();
		
		int index = 10000;
		
		List<resumeFileVO> fileList = new ArrayList<>();
		while(files.hasMoreElements()){
			resumeFileVO fvo = new resumeFileVO();
			String name = (String)files.nextElement();
			/* System.out.println(name); */
			//이전 페이지에서 넘어온 첨부파일 키(name)
			String fileName = multi.getFilesystemName(name);
			String originFileName = multi.getOriginalFileName(name);
			
			File uploadFile = new File(savePath + "/"+ fileName);
			long fileSize = uploadFile.length();
			
			fvo.setAttachLocation(savePath);
			fvo.setAttachOriginName(originFileName);
			fvo.setAttachUploadName(fileName);
			fvo.setFileSize((int)fileSize);
			fvo.setRno(rno+"");
			fileList.add(fvo);
		}
		ObjectMapper mapper = new ObjectMapper();
		
		int[] fnoList = dao.upload(fileList);
		//업로드된 파일의 개수와 동일한 길이로 파일의 fno를 반환
		
		for(int i = 0; i < fileList.size(); i ++){
			fileList.get(i).setFno(fnoList[i] + "");
		}
		//jackson 라이브러리를 이용한 list 객체를 json형태의 문자열로 변환
		String jsonList = mapper.writeValueAsString(fileList);
		//"[{'fileSize' : '500', 'attachOriginName' : '복구키', 'fno' : 97}, {}...]"
				
		out.print(jsonList);
%>