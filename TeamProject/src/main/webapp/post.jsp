<%@page import="info_file.infoFileDAO"%>
<%@page import="info_file.infoFileVO"%>
<%@page import="users.usersVO"%>
<%@page import="reply.replyVO"%>
<%@page import="java.util.List"%>
<%@page import="reply.replyDAO"%>
<%@page import="board.boardVO"%>
<%@page import="board.boardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="header.jsp" %>
<%
	String no = request.getParameter("no");
	String path = request.getContextPath();
	
	if(no == null || user == null){
		response.sendRedirect("login.jsp");
		return;
	} 

	boardDAO dao = new boardDAO();
	boardVO vo = dao.view(no);
	String author = vo.getAuthor(); 
	String title = vo.getTitle();
	String content = vo.getContent();
	String createDate = vo.getCreateDate();
	String updateDate = vo.getUpdateDate();
	String deleteDate = vo.getDeleteDate();
	
	replyDAO rdao = new replyDAO();
	List<replyVO> list = rdao.select(no);
	
	infoFileDAO fdao = new infoFileDAO();
	List<infoFileVO> flist = fdao.list(no);
	
	
	
	//board.jsp에서 전달해준 searchType과 searchTypw를 받아
	//뒤로 가기 버튼을 클릭했을 때 board.jsp의 파라미터로 다시 넘겨준다.
	String searchType = request.getParameter("searchType");
	String keyword = request.getParameter("searchkeyword");
	String boardType = request.getParameter("boardType");
	
	if(searchType == null){
		searchType="";
	}
	
	if(keyword == null){
		keyword = "";
	}
	
	if(boardType == null){
		boardType="0";
	}
%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>게시판 상세보기</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <link rel="stylesheet" href="./resources/css/post.css"></link>
</head>
<body>
    <div class="container">
     	 <div class="post-box">
            <div class="post-top">
            	<div>
            		<h2><%= title %></h2>
	           		<p>작성자 : <%= !boardType.equals("2") ? author : "익명" %> | <%= createDate %></p>
          	  	</div>
	            <div class="post-type">
	            <%if(boardType.equals("0")){
					%>공지게시판<%        	
		        }else if(boardType.equals("1")){
		        	%>정보공유게시판<%
		        }else if(boardType.equals("2")){
		        	%>익명게시판<%
		        }%></div>
            </div>
            <hr>
            <p><%= content %></p>
            <br>
              	<h3>첨부파일</h3>
           	<%
           		for(int i = 0; i < flist.size(); i++){
           			infoFileVO fvo = flist.get(i);
           			long fileSize = fvo.getFileSize(); 
           			
           			String data = "";
           			//fileSize의 크기에 따라서 kb, mb, gb 단위 변환
           			if(fileSize < 1024){
           				//바이트(b)
           				data = fileSize + "B";
           			}else if(fileSize < 1024 * 1024){
           				//키로바이트(kb)
           				double kb = fileSize / (double)1024;
           				kb = Math.round(kb * 100) / 100.0;
           				data = kb + "kb";
           			}else if(fileSize < 1024 * 1024 * 1024){
           				//메가바이트(mb)
           				double mb = fileSize / (double)(1024 * 1024);
           				mb = Math.round(mb * 100) / 100.0;
           				data = mb+"mb";
           			}else if(fileSize < 1024 * 1024 * 1024 * 1024){
           				//기가바이트(gb)
           				double gb = fileSize / (double)(1024*1024*1024);
           				gb = Math.round(gb * 100) / 100.0;
           				data = gb + "gb";
           			}
        			if(fvo.getAttachOriginName() != null && !fvo.getAttachOriginName().equals("null")){
        	%>
           	<div class="attachments">
	           	<div class="attachment-item">
					<a download="<%= fvo.getAttachOriginName() %>" href="<%= path %>/upload/<%= fvo.getAttachUploadName() %>" class="attachment-name"><%= fvo.getAttachOriginName() %></a>
					<span class="attachment-size">(<%= data %>)</span>
				</div>
			</div>
			<%
					}
           		}
           	%>
			
			<%
        	//로그인을 하였고, 로그인한 사용자의 아이디(user.getId())와 
        	//게시글을 작성한 작성자 아이디(author)가 같으면 수정 삭제 버튼 표출
        	if(user != null && (user.getId().equals(author) || user.getUserType() == 0)){
        	%>
			<div class="modify">
				<input type="button" onclick="location.href='modify.jsp?no=<%=no %>&boardType=<%=boardType %>'" value="수정">
				<input type="button" onclick="location.href='postDel.jsp?no=<%=no %>&boardType=<%=boardType %>'" value="삭제">
			</div>
			<% } %>
		</div>
		<%
			//if(user != null && ((user.getId().equals(author) || vo.getBoardType() == 0)){
 			if(user != null && !boardType.equals("0")){
 		%>
        <div class="comment-box">
 			<input type="text" id="new-comment" class="comment-input" placeholder="댓글을 입력하세요.">
            <input type="button" id="add-comment" value="댓글 작성">
        <% } %>
	       <%
	       	for(int i = 0; i < list.size(); i ++){
	       		replyVO rvo = list.get(i);
	       		String rno = rvo.getRno();
	       		String rcontent = rvo.getContent();
	       		String rauthor = rvo.getRauthor();
	       		String rcreateDate = rvo.getCreateDate();
	       %>
           	<div class="comments">
            	<div class="comments-top">
	            	<p>작성자: <%= !boardType.equals("2") ? author : author.equals(rauthor) ? "작성자" : "익명" %> | <%= rcreateDate %></p>
	         <%
               	//댓글 목록을 반복하며 댓글의 작성자가 로그인한 사용자의 아이디와
               	//동일하면 수정 삭제 버튼을 보여준다.
               	if(user != null && (user.getId().equals(rauthor) || user.getUserType() == 0)){
             %>
            	<div>
            		<input type="hidden" value="">
	            	<input type="button" onclick="replyBtn(this)" value="수정">
	            	<input type="button" class="dpnone" onclick="modifyReply(<%= rno %>, this)" value="확인">
	            	<input type="button" class="dpnone" onclick="cancelBtn(this, '<%= rcontent %>')" value="취소">
	            	<input type="button" onclick="deleteReply(<%= rno %>, this)" value="삭제">
            	</div>
          	<% } %>
	          	</div>
            	<hr>
            	<div class="comment-content"><%= rcontent %></div>
            </div>
          <% } %>
       	</div>
       	<input type="button" class="button" onclick="location.href='board.jsp?no=<%=no %><%= searchType != ""? "&searchType="+searchType : "" %><%= keyword != "" ? "&searchkeyword=" + keyword : ""%>&boardType=<%=boardType %>'" value="뒤로가기">
   	</div>
</body>

<script>
	//로그인한 사용자 아이디
	let userId = "<%= user != null ? user.getId() : "" %>";
	let boardType = "<%= boardType %>";
	console.log(userId);
	
	function cancelBtn(obj){
		$(obj).prev().prev().css("display", "inline");
		$(obj).parent().children(".dpnone").css("display", "none");
		$(obj).parent().parent().parent().children(".comment-content").attr("contenteditable", "false");
		let input = $(obj).prev().prev().prev().val();
		$(obj).parent().parent().parent().children(".comment-content").text(input);
	}
	
	function replyBtn(obj){
		let div = $(obj).parent().parent().parent().children(".comment-content");
		$(obj).prev().val(div.text())
		
		$(obj).css("display", "none");
		$(obj).parent().children(".dpnone").css("display","inline");
		$(obj).parent().parent().parent().children(".comment-content").attr("contenteditable", "true");
	}
	
	//댓글 수정 함수
	function modifyReply(rno, obj){
		console.log(rno);
	
	//다른 jsp한테 rno를 전달하여 reply 테이블에서 수정요청
	let div = $(obj).parent().parent().parent().children(".comment-content");
	let reply = div.text();
	if(reply != null && reply.trim() != ""){
		let cresult = confirm("댓글을 수정하시겠습니까?");
		if(cresult == true){
			//ajax로 다른 jsp에 댓글 수정 요청
			$.ajax({
				url : "replyModifyok.jsp",
				type : "post",
				data : {
					rno : rno,
					content : reply
				},
				success : function(result){
					console.log(result);
					if(result.trim() == "success"){
						div.attr("contenteditable", "false");
						$(obj).parent().children(".dpnone").css("display", "none");
						$(obj).prev().css("display", "inline");
						$(obj).next().attr("onclick", "cancelBtn(this,'"+reply+"')");
					}
				},
				error : function(){
					console.log("에러 발생");
				}
			});
		}
	}
}
	
	//댓글 삭제 함수
	function deleteReply(rno, obj){
		console.log("rno번 댓글 삭제", rno)
		//다른 jsp한테 rno를 전달하여 reply테이블에서 삭제 요청
		$.ajax({
			url : "replyDeleteok.jsp",
			type : "post",
			data : {
				rno : rno
			},
			success : function(result){
				if(result.trim() == "success"){
					$(obj).parent().parent().parent().remove();
				}
			},
			error : function(){
				console.log("에러 발생");
			}
		});
	}
	
	function getTime(){
		let date = new Date();
		console.log(date);
		
		let year = date.getFullYear();
		let month = (date.getMonth() + 1).toString().padStart(2,"0");
		let day = date.getDate().toString().padStart(2,"0");
		let hour = date.getHours().toString().padStart(2,"0");
		let minute = date.getMinutes().toString().padStart(2,"0");
		let second = date.getSeconds().toString().padStart(2,"0");
		
		let time = year + "-" + month + "-" + day + " " + hour + ":" + minute + ":" + second
		return time;
	}
	
	function deletePost(no){
		console.log(no);
		let result = confirm("삭제하시겠습니까?");
		if(result == true){
			location.href="delete.jsp?no="+no;
		}
	}
	
	$("#add-comment").click(function(){
		let rcontent = $("#new-comment").val();
		if(rcontent == "" || rcontent == null){
			$("#new-comment").focus();
			alert("댓글 내용을 입력해주세요.");
			return;
		}
		let no = "<%= no %>";
		$.ajax({
			url : "replyWriteok.jsp",
			type : "post",
			data : {
				no : <%= no %>,
				rauthor : userId,
				rcontent : rcontent,
				replyType : boardType
			},
			success : function(result){
				console.log(result);
				let time = getTime();
				let anonyAuthor = "<%= !boardType.equals("2") ? author : user.getId().equals(author) ? "작성자" : "익명" %>";
				if(result != "0"){
					let html = "";
					html += "<div class='comments'>";
					html += 	"<div class='comments-top'>";
					html +=			"<p>작성자 : "+anonyAuthor+" | "+time+"</p>";
					html +=			"<div>";
					html +=				"<input type='button' onclick='replyBtn(this)' value='수정'>";
					html +=				"<input type='button' class='dpnone' onclick='modifyReply("+no+", this)' value='확인'>";
					html +=				"<input type='button' class='dpnone' onclick='cancelBtn(this, '"+rcontent+"')' value='취소'>";
					html +=				"<input type='button' onclick='deleteReply("+no+",this)' value='삭제'>";
					html +=			"</div>";
					html +=		"</div>"
					html +=		"<hr>"
					html +=		"<div class='comment-content'>"+rcontent+"</div>"
					html += "</div>"
					$("#add-comment").after(html);
					$("#new-comment").val("").focus();
				}
			},
			error : function(){
				console.log("에러 발생");
			}
		});
	});
</script>
</html>