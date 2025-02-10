<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>로그인</title>
    <link rel="stylesheet" href="./resources/css/login.css"></link>
</head>
<body>
    <div class="container">
     <form method="post" action="loginok.jsp">
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
        </div>
        <div id="businessForm" style="display: none;">
            <div class="input-group">
                <input type="text" id="buser" name="buser" placeholder="사업자번호를 입력해주세요.">
            </div>
            <div class="input-group">
                <input type="password" id="bpassword" name="bpassword" placeholder="비밀번호를 입력해주세요.">
            </div>
        </div>
        <div class="actions">
            <label><input type="checkbox"> 아이디 저장</label>
            <span onclick="goSignup()" style="cursor:pointer;">회원가입</span>
        </div>
        <button class="btn" onclick="goHome()">로그인</button>
        </form>
    </div>
    

    <script>
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
        function goHome() {
            window.location.href = 'home.jsp';
        }
        function goSignup() {
            window.location.href = 'signup.jsp';
        }
    </script>
</body>
</html>
