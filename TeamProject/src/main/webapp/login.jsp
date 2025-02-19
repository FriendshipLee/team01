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
        
        /* $(document).ready(function(){
            // 저장된 쿠키값을 가져와서 ID 칸에 넣어준다. 없으면 공백
            var userInputId = getCookie("userInputId");
            $("input[name='username']").val(userInputId); 
             
            if($("input[name='username']").val().toString().length){ 
                $("#idSaveCheck").attr("checked", true); // ID 저장하기를 체크 상태로 두기.
            }
             
            $("#idSaveCheck").change(function(){ // 체크박스에 변화가 있을때,
                if($("#idSaveCheck").is(":checked")){ // ID 저장하기 체크했을때,
                    var userInputId = $("input[name='username']").val();
                    setCookie("userInputId", userInputId, 10); // 10일 동안 쿠키 보관
                }else{ // ID 저장하기 체크 해제 시,
                    deleteCookie("userInputId");
                }
            });
             
            // ID 저장하기를 체크한 상태에서 ID를 입력하는 경우, 쿠키 저장.
            $("input[name='username']").keyup(function(){ // ID 입력 칸에 ID를 입력할 때,
                if($("#idSaveCheck").is(":checked")){ // ID 저장하기를 체크한 상태라면,
                    var userInputId = $("input[name='username']").val();
                    setCookie("userInputId", userInputId, 10); // 10일 동안 쿠키 보관
                }
            });
        });

        function setCookie(cookieName, value, exdays){
            var exdate = new Date();
            exdate.setDate(exdate.getDate() + exdays);
            var cookieValue = escape(value) + ((exdays==null) ? "" : "; expires=" + exdate.toGMTString());
            document.cookie = cookieName + "=" + cookieValue;
        }
         
        function deleteCookie(cookieName){
            var expireDate = new Date();
            expireDate.setDate(expireDate.getDate() - 1);
            document.cookie = cookieName + "= " + "; expires=" + expireDate.toGMTString();
        }
         
        function getCookie(cookieName) {
            cookieName = cookieName + '=';
            var cookieData = document.cookie;
            var start = cookieData.indexOf(cookieName);
            var cookieValue = '';
            if(start != -1){
                start += cookieName.length;
                var end = cookieData.indexOf(';', start);
                if(end == -1)end = cookieData.length;
                cookieValue = cookieData.substring(start, end);
            }
            return unescape(cookieValue);
        } */
      
        function goHome() {
            window.location.href = 'main.jsp';
        }
        function goSignup() {
            window.location.href = 'signup.jsp';
        }
   </script>
</body>
</html>
