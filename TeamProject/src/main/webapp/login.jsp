<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
	String error = request.getParameter("error");
	String userType = request.getParameter("userType");
	
	String id = (String)session.getAttribute("id");
	String bid = (String)session.getAttribute("bid");
	
	session.removeAttribute("id");
	session.removeAttribute("bid");
	
	
	if(userType == null){
		userType = "1";
	}
	
	//아이디저장이 체크되었을 때 쿠키에 저장한 아이디 꺼내오기
	Cookie[] cookies = request.getCookies();
	
	String savedId = null;
    
    for(int i=0; i<cookies.length; i++) {
    	if(cookies[i].getValue().contains("id")){
    		savedId = cookies[i].getValue();
    	}
    }
    
    String showId = "";
	
    //savedId가 null이면 로그인 할 때 저장 안헀거나, 로그인 실패, 로그인 안해봤거나
    //id가 null이면 로그인 성공했거나, 로그인 실패를 안했거나
    //만약 id가 null이면
    if(id == null){
    	//로그인 성공 , 로그인 안함
    	if(savedId != null){
    		showId = savedId.replace("id_", "");
    	}else{
    		//로그인 안함
    	}
    }else{
    	showId = id;
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
                <input type="text" id="username" name="username" placeholder="아이디를 입력해주세요." value="<%= showId %>">
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
                <input type="text" id="buser" name="buser" placeholder="-를 포함한 12자리를 입력해주세요." value="<%= bid != null ? bid : "" %>">
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
	            <label for="idSaveCheck">
		            <input type="checkbox" name="idSaveCheck" id="idSaveCheck" value="off" <%= savedId != null ? "checked" : "" %>>아이디 저장
	         	</label>
	         	<span onclick="goSignup()" style="cursor:pointer;">회원가입</span>
	        </div>
	        <button class="btn" type="submit">로그인</button>
        </form>
    </div>
    
    <script>
    	//체크박스의 체크, 해제 할 때 동작하는 이벤트
    	$("#idSaveCheck").change(function(e){
    		if(e.target.checked == true){
    			$("#idSaveCheck").val("on");
    		}else{
    			$("#idSaveCheck").val("off");
    		}
    	});
   		 
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
        
      
        function goHome() {
            window.location.href = 'main.jsp';
        }
        function goSignup() {
            window.location.href = 'signup.jsp';
        }
   </script>
</body>
</html>
