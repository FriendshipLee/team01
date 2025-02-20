<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="header.jsp" %>
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
	    <link rel="stylesheet" href="./resources/css/gonggoPost.css"></link>
	</head>
	<body>
		<div class="container">
	     	<div class="post-box">
	            <div class="post-top">
	            	<div>
	            		<h2>제목</h2>
		           		<p>기업명 :  | 작성일 : | 마감일: 2025-11-10</p>
	          	  	</div>
		            <hr>
			        <span>경력 : 무관</span>    
			        <span>학력 : 고졸이상</span>    
			        <p>근무위치 :  전북특별자치도 전주시 덕진구 123-123 2</p>
		            <p>본문</p>
		            <br>
				</div>
				
				<a href="#">접수하러 가기</a>
					<div class="modify">
						<input type="button" value="수정">
						<input type="button" value="삭제">
					</div>
	       	<input type="button" class="button" value="뒤로가기">
	   		</div>
	   	</div>
	</body>
</html>