<%@page import="gonggo.gonggoVO"%>
<%@page import="gonggo.gonggoDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="header.jsp" %>
<%
	if(user == null){
		response.sendRedirect("gonggo.jsp");
		return;
	}
	if(user.getCompanyName() == null || user.getCompanyNumber() == ""){
		response.sendRedirect("gonggo.jsp");
		return;
	}
	
	String no = request.getParameter("no");
	
	if(no == null || no.isEmpty()){
		response.sendRedirect("gonggo.jsp");
		return;
	}
	
	gonggoDAO dao = new gonggoDAO();
	gonggoVO vo = dao.view(no);
	
	String career = vo.getCareer();
	String education = vo.getEducation();
	
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<title>Insert title here</title>
	    <script>
		  (function(d) {
		    var config = {
		      kitId: 'amw5wcy',
		      scriptTimeout: 3000,
		      async: true
		    },
		    h=d.documentElement,t=setTimeout(function(){h.className=h.className.replace(/\bwf-loading\b/g,"")+" wf-inactive";},config.scriptTimeout),tk=d.createElement("script"),f=false,s=d.getElementsByTagName("script")[0],a;h.className+=" wf-loading";tk.src='https://use.typekit.net/'+config.kitId+'.js';tk.async=true;tk.onload=tk.onreadystatechange=function(){a=this.readyState;if(f||a&&a!="complete"&&a!="loaded")return;f=true;clearTimeout(t);try{Typekit.load(config)}catch(e){}};s.parentNode.insertBefore(tk,s)
		  })(document);
		</script>
	    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	    <link rel="stylesheet" href="./resources/css/gonggoModify.css"></link>
	</head>
	<body>
		<div class="board-container">
			<h2>채용공고 수정</h2>
			<form method="post" action="gonggoModifyok.jsp" onsubmit="return formCheck();">
				<input type="hidden" value="<%= no %>" name="no">
				<div class="title">
					<label for="title">제목</label>
		            <input type="text" id="title" name="title" placeholder="제목을 입력하세요" value="<%= vo.getTitle() %>"><br>
				</div>
				<div class="radio">
	       	  		<div>
	       	  			<span>경력</span>
		       	  		<label for="cnothing">
			       	  		<input type="radio" id="cnothing" name="career" value="0">
			       	  		<span>무관</span>
		       	  		</label>
		       	  		<label for="new">
			       	  		<input type="radio" id="new" name="career" value="1">
			       	  		<span>신입</span>
		       	  		</label>
		       	  		<label for="old">
			       	  		<input type="radio" id="old" name="career" value="2">
			       	  		<span>경력</span>
		       	  		</label>
	       	  		</div>
	       	  		<br>
	       	  		<div>
		       	  		<span>학력</span>
		       	  		<label for="enothing">
			       	  		<input type="radio" id="enothing" name="education" value="0">
			       	  		<span>무관</span>
		       	  		</label>
		       	  		<label for="associate">
			       	  		<input type="radio" id="associate" name="education" value="1">
			       	  		<span>초대졸</span>
		       	  		</label>
		       	  		<label for="bachelors">
			       	  		<input type="radio" id="bachelors" name="education" value="2">
			       	  		<span>대졸</span>
		       	  		</label>
					</div>
				</div>
				<div>
		            <label for="content">내용</label><br>
		            <textarea id="content" name="content" placeholder="내용을 입력하세요"><%= vo.getContent() %></textarea><br>
				</div>
	       	  	<div class="location">
	       	  		<label for="location">근무위치</label>
	       	  		<input type="text" id="location" name="location" placeholder="근무위치를 입력하세요" value="<%= vo.getLocation() %>">
	       	  	</div>
	       	  	<div class="deadline">
	       	  		<label for="deadline">공고 마감일</label>
	       	  		<input type="date" id="deadline" name="deadline" value="<%= vo.getDeadline() %>">
	       	  	</div>
	       	  	<div class="link">
	       	  		<label for="link">접수 링크 주소</label>
	       	  		<input type="text" id="link" name="link" placeholder="채용접수 링크를 입력하세요" value="<%= vo.getLink() %>">
	       	  	</div>
	            <div class="action">
	                <button type="submit">등록</button>
	                <button type="button" onclick="history.back();">취소</button>
	            </div>
			</form>
	    </div>
	</body>
	<script>
		$(":radio[name='career']").each(function(){
			let career = "<%= career %>";
			var $this = $(this);
			if(career == '0'){
				$("#cnothing").attr('checked', true);
			}else if(career == '1'){
				$("#new").attr('checked', true);
			}else {
				$("#old").attr('checked', true);
			}
		});
		
		$(":radio[name='education']").each(function(){
			let education = "<%= education %>";
			var $this = $(this);
			if(education == '0'){
				$("#enothing").attr('checked', true);
			}else if(education == '1'){
				$("#associate").attr('checked', true);
			}else {
				$("#bachelors").attr('checked', true);
			}
		});
	
		function formCheck(){
			let career = $("input:radio[name='career']:checked").val();
			let education = $("input:radio[name='education']:checked").val();
			$.ajax({
				url : "gonggoModifyok.jsp",
				type : "post",
				data : {
					career : career,
					educatoin : education
				},
				success : function(result){
					console.log(result);
				},
				error : function(){
					console.log("에러 발생");
				}
			});
		}
	</script>
</html>