<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
	String error = request.getParameter("error");
	String userType = request.getParameter("userType");
	
	String id = (String)session.getAttribute("id");
	String bid = (String)session.getAttribute("bid");
	String saveid = (String)session.getAttribute("saveid");
	
	
	session.removeAttribute("id");
	session.removeAttribute("bid");
	
	
	if(userType == null){
		userType = "1";
	}
%>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>로그인</title>
    <link rel="stylesheet" href="./resources/css/login.css"></link>
    <script src="./resources/js/jquery-3.7.1.js"></script>
    <script type="text/javascript">
    (function(d) {
	    var config = {
	      kitId: 'amw5wcy',
	      scriptTimeout: 3000,
	      async: true
	    },
	    h=d.documentElement,t=setTimeout(function(){h.className=h.className.replace(/\bwf-loading\b/g,"")+" wf-inactive";},config.scriptTimeout),tk=d.createElement("script"),f=false,s=d.getElementsByTagName("script")[0],a;h.className+=" wf-loading";tk.src='https://use.typekit.net/'+config.kitId+'.js';tk.async=true;tk.onload=tk.onreadystatechange=function(){a=this.readyState;if(f||a&&a!="complete"&&a!="loaded")return;f=true;clearTimeout(t);try{Typekit.load(config)}catch(e){}};s.parentNode.insertBefore(tk,s)
	  })(document);
    </script>
</head>
<body>
    <div class="container">
     <form onsubmit="return formCheck()" method="post" action="loginok.jsp">
     	<input type="hidden" id="userType" name="userType" value="1">
        <div class="back" onclick="goHome()">&larr;</div>
        <div class="tabs">
            <div class="tab active" id="personalTab" onclick="showTab('personal')">개인회원</div>
            <div class="tab" id="businessTab" onclick="showTab('business')">기업회원</div>
        </div>
        <div id="personalForm">
        
        <div class="input-group">
                <input type="text" id="username" name="username" placeholder="아이디를 입력해주세요." value="<%= id != null ? id : "" %>">
            </div>
            <div class="input-group">
                <input type="password" id="password" name="password" placeholder="비밀번호를 입력해주세요.">
            </div>
            <%
            if(error != null && userType.equals("1")){
            		%>
            			<div id="userPw-feedback" class="feedback" style="display:block">아이디 또는 비밀번호가 일치하지 않습니다.</div>
            		<%
            	}else{
            		%>
        				<div id="userPw-feedback" class="feedback">아이디 또는 비밀번호가 일치하지 않습니다.</div>
        			<%
            	}
            %>
        </div>
        <div id="businessForm" style="display: none;">
            <div class="input-group">
                <input type="text" id="buser" name="buser" placeholder="사업자번호를 입력해주세요." value="<%= bid != null ? bid : "" %>">
            </div>
            <div class="input-group">
                <input type="password" id="bpassword" name="bpassword" placeholder="비밀번호를 입력해주세요.">
            </div>
            <%
            	if(error != null && userType.equals("2")){
            	%>
            		<div id="Bpw-feedback" class="feedback" style="display:block">사업자번호 또는 비밀번호가 일치하지 않습니다.</div>
            	<%
            }else{
            	%>
            		<div id="Bpw-feedback" class="feedback">사업자번호 또는 비밀번호가 일치하지 않습니다.</div>
            	<%
            	}
            	%>
        </div>
        <div class="actions">
            <label><input type="checkbox">아이디 저장</label>
            <span onclick="goSignup()" style="cursor:pointer;">회원가입</span>
        </div>
        <button class="btn" type="submit">로그인</button>
        </form>
    </div>
    
    <script>
    	let userType = "<%= userType %>";
    	
    	document.getElementById('personalForm').style.display = (userType === '1') ? 'block' : 'none';
        document.getElementById('businessForm').style.display = (userType === '2') ? 'block' : 'none';
        document.getElementById('personalTab').classList.toggle('active', userType === '1');
        document.getElementById('businessTab').classList.toggle('active', userType === '2');
        document.getElementById("userType").value = userType;
        
        function showTab(type) {
            document.getElementById('personalForm').style.display = (type === 'personal') ? 'block' : 'none';
            document.getElementById('businessForm').style.display = (type === 'business') ? 'block' : 'none';
            document.getElementById('personalTab').classList.toggle('active', type === 'personal');
            document.getElementById('businessTab').classList.toggle('active', type === 'business');
            
            if(type === "personal"){
            	document.getElementById("userType").value = "1";
            }else{
            	document.getElementById("userType").value = "2";
            }
        }
        
        function formCheck(){
        	//아이디 입력창이 비었는지 확인
        	let type = document.getElementById("userType").value;
        	if(type == "1"){
        		let id = $("#username");
            	if(id.val().trim() == ""){
            		id.focus();
            		id.val("");
            		
            		id.text("아이디를 입력해주세요");
            		return false;
            	}
            	
            	//비밀번호 입력창이 비었는지 확인
            	let pw = $("#password");
            	if(pw.val().trim() == ""){
            		pw.focus();
            		pw.val("");
            		return false;
            	}
            	window.localStorage.setItem("uid", id.val());
            	//window.localStorage.removeItem('uid',id.val());
            	return true;
        	}else{
        		let bid = $("#buser");
            	if(bid.val().trim() == ""){
            		bid.focus();
            		bid.val("");
            		
            		bid.text("사업자 번호를 입력해주세요")
            		return false;
            	}
            	
            	let bpw = $("#bpassword");
            	if(bpw.val().trim() == ""){
            		bpw.focus();
            		bpw.val("");
            		
            		return false;
            	}
            	window.localStorage.setItem("bid", bid.val());
            	//window.localStorage.removeItem('bid',bid.val());
            	return true;
        	}
        }
        
    /*   document.addEventListener("DOMContentLoaded", function(){
    	  var checkbox = document.getElementById(checkBoxId_Y);
    	  var hiddenInput = document.getElementById(checkBoxId_N);
    	  
    	  checkbox.addEventListener("change", function(){
    		  if(this.checked){
    			  hiddenInput.value = "Y";
    		  }else{
    			  hiddenUnput.value = "N";
    		  }
    	  });
      }); */
   
        function goHome() {
            window.location.href = 'main.jsp';
        }
        function goSignup() {
            window.location.href = 'signup.jsp';
        }
   </script>
</body>
</html>
