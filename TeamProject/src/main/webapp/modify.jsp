<%@page import="java.util.List"%>
<%@page import="info_file.infoFileVO"%>
<%@page import="info_file.infoFileDAO"%>
<%@page import="board.boardVO"%>
<%@page import="board.boardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="header.jsp" %>
<%
	String no = request.getParameter("no");
	String boardType = request.getParameter("boardType");

	if(no == null || no.isEmpty()){
		response.sendRedirect("board.jsp");
		return;
	}
	
	boardDAO dao = new boardDAO();
	boardVO vo = dao.view(no);
	String title = vo.getTitle();
	String content = vo.getContent();
	
	infoFileDAO fdao = new infoFileDAO();
	List<infoFileVO> flist = fdao.list(no);
	
	
%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>게시판</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <link rel="stylesheet" href="./resources/css/modify.css"></link>
</head>
<body>
    	<h2>게시글 수정</h2>
    <div class="container">
    <form id="modify-form" action="modifyOk.jsp" method="post" enctype="multipart/form-data">
	    <input type="hidden" name="no" value="<%= no %>">
	    <input type="hidden" name="boardType" value="<%= boardType %>">
	    	<div>
	    		<h3>제목</h3>
	    		<input type="text" id="title" name="title" placeholder="제목을 입력하세요" value="<%= title %>">
	    	</div>
	    	<div>
	    		<h3>내용</h3>
	    		<textarea id="content" name="content" placeholder="내용을 입력하세요"><%= content %></textarea>
	    	</div>
	    	<div>
	    		<h3>첨부파일</h3>
	    		<input type="file" id="file" name="file">
	    	</div>
	    	<% 
		    	for(int i = 0; i < flist.size(); i++){ 
		    		infoFileVO fvo = flist.get(i);
		    		long fileSize = fvo.getFileSize();
		    		String data = "";
		    		if(fileSize < 1024){
        				data = fileSize + "b";
        			}else if(fileSize < 1024 * 1024){
        				double kb = fileSize / (double)1024;
        				kb = Math.round(kb * 100) / 100.0;
        				data = kb + "kb";
        			}else if(fileSize < 1024 * 1024 * 1024){
        				double mb = fileSize / (double)(1024 * 1024);
        				mb = Math.round(mb * 100) / 100.0;
        				data = mb + "mb";
        			}else if(fileSize < 1024 * 1024 * 1024 * 1024){
        				double gb = fileSize / (double)(1024 * 1024 * 1024);
        				gb = Math.round(gb * 100) / 100.0;
        				data = gb + "gb";
        			}
	    	%>
	    		<% if(fvo.getAttachOriginName() != null || fvo.getAttachOriginName() == ""){ %>
			    	<div class="attachment-item">
						<div>
							<a download="<%= fvo.getAttachOriginName() %>" href="<%= fvo.getAttachUploadName() %>" class="attachment-name"><%= fvo.getAttachOriginName() %></a>
							<span class="attachment-size">(<%= data %>)</span>
						</div>
						<button type="button" onclick="infoFileDel(<%= fvo.getFno() %>, this)">삭제</button>
					</div>
				<% } %>
	    	<% } %>
			<div class="modify">
				<input type="submit" value="수정">
				<input type="button" onclick="history.back()" value="취소">
			</div>
		</form>
	</div>
</body>
<script>

	/* $("#file").on("change", function(e){
		console.log(e);
		for(let i = 0; i < e.target.files.length; i ++){
			let html = "";
			html += '<div>';
			html += 	'<h3>첨부파일</h3>';
			html += 	'<input type="file" id="file" name="file">';
			html += '</div>';
			$("#modify-form").append(html);	
		}
		
	}); */
	
	/* document.getElementById("file").addEventListener("change", function(event) {
        const files = event.target.files;
        const form = document.getElementById("modify-form");

        for (let i = 0; i < files.length; i++) {
            const newFileInput = document.createElement("input");
            newFileInput.type = "file";
            newFileInput.name = "file"+(i + 1); // file1, file2, file3 형식으로 설정
            newFileInput.classList.add("dynamic-file");

            // FileList는 직접 할당할 수 없기 때문에 DataTransfer를 사용
            const dataTransfer = new DataTransfer();
            dataTransfer.items.add(files[i]);
            newFileInput.files = dataTransfer.files;

            form.appendChild(newFileInput);
            
            //
        }
    }); */
	
	function infoFileDel(fno, obj){
		$.ajax({
			url : "modifyFileDel.jsp",
			type : "post",
			data : {
				fno : fno
			},
			success : function(result){
				if(result.trim() == "success"){
					$(obj).parent().remove();
				}
			},
			error : function(){
				console.log("에러 발생");
			}
		});
	};
</script>
</html>
