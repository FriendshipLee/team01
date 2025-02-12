<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
	String error = request.getParameter("error");
	String userType = request.getParameter("userType");
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
                <input type="text" id="username" name="username" placeholder="아이디를 입력해주세요.">
            </div>
            <div class="input-group">
                <input type="password" id="password" name="password" placeholder="비밀번호를 입력해주세요.">
            </div>
            <%
            if(error != null && userType.equals("1")){
            		%>
            			<div id="userPw-feedback" class="feedback" style="display:block">비밀번호가 일치하지 않습니다.</div>
            		<%
            	}else{
            		%>
        				<div id="userPw-feedback" class="feedback">비밀번호가 일치하지 않습니다.</div>
        			<%
            	}
            %>
        </div>
        <div id="businessForm" style="display: none;">
            <div class="input-group">
                <input type="text" id="buser" name="buser" placeholder="사업자번호를 입력해주세요.">
            </div>
            <div class="input-group">
                <input type="password" id="bpassword" name="bpassword" placeholder="비밀번호를 입력해주세요.">
            </div>
            <%
            	if(error != null && userType.equals("2")){
            	%>
            		<div id="Bpw-feedback" class="feedback" style="display:block">비밀번호가 일치하지 않습니다.</div>
            	<%
            }else{
            	%>
            		<div id="Bpw-feedback" class="feedback">비밀번호가 일치하지 않습니다.</div>
            	<%
            	}
            	%>
        </div>
        <div class="actions">
            <label><input type="checkbox"> 아이디 저장</label>
            <span onclick="goSignup()" style="cursor:pointer;">회원가입</span>
        </div>
        <button class="btn" type="submit">로그인</button>
        </form>
    </div>
    

    <script>
    	let uid = window.localStorage.getItem("uid");
    	let bid = window.localStorage.getItem("bid");
    	
    	let userType = "<%= userType %>";
    	
    	document.getElementById('personalForm').style.display = (userType === '1') ? 'block' : 'none';
        document.getElementById('businessForm').style.display = (userType === '2') ? 'block' : 'none';
        document.getElementById('personalTab').classList.toggle('active', userType === '1');
        document.getElementById('businessTab').classList.toggle('active', userType === '2');
        document.getElementById("userType").value = userType;
        
        if(userType == "1"){
        	if(uid != null){
        		$("#username").val(uid);
        	}
        }else{
        	if(bid != null){
        		$("#buser").val(bid);
        	}
        }
        
        
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
            	return true;
        	}
        }
        
        function goHome() {
            window.location.href = 'home.jsp';
        }
        function goSignup() {
            window.location.href = 'signup.jsp';
        }
   </script>
</body>
</html>
