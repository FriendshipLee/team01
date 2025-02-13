<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>회원가입</title>
    <link rel="stylesheet" href="./resources/css/signup.css"></link>
    <script type="text/javascript" src="./resources/js/jquery-3.7.1.js"></script>
</head>
<body>
    <div class="container">
        <div class="back" onclick="goHome()">&larr;</div>
        <div class="tabs">
            <div class="tab active" id="personalTab" onclick="showTab('personal')">개인회원</div>
            <div class="tab" id="businessTab" onclick="showTab('business')">기업회원</div>
        </div>
    	<form action="userSignupok.jsp" method="post" onsubmit="return userFormCheck()">
	        <div id="personalForm">
	            <div class="input-group">
	                <input type="text" id="userId" name="userId" placeholder="아이디">
	                <div id="userId-feedback" class="feedback">아이디 입력은 필수입니다.</div>
	                <input type="password" id="userPw" name="userPw" placeholder="비밀번호">
	                <div id="userPw-feedback" class="feedback">비밀번호 입력은 필수입니다.</div>
	                <input type="text" id="userName" name="userName" placeholder="이름">
	                <div id="userName-feedback" class="feedback">이름 입력은 필수입니다.</div>
	                <input type="text" id="userNick" name="userNick" placeholder="닉네임">
	                <div id="userNick-feedback" class="feedback">닉네임 입력은 필수입니다.</div>
	  				<div class="flex">
		                <input type="text" id="userBirth" name="userBirth" placeholder="생년월일">
		                <div>
			                <input type="radio" name="gender" value="남자" checked>남자
			                <input type="radio" name="gender" value="여자">여자
		                </div>
	  				</div>
	                <div id="userBirth-feedback" class="feedback">생년월일 입력은 필수입니다.</div>
	                <input type="text" id="userNumber" name="userNumber" placeholder="휴대폰번호">
	                <div id="userNumber-feedback" class="feedback">휴대폰번호 입력은 필수입니다.</div>
	                <input type="text" id="userEmail" name="userEmail" placeholder="이메일">
	                <div id="userEmail-feedback" class="feedback">이메일 입력은 필수입니다.</div>
	            </div>
     		    <div class="actions">
		            <span>이미 아이디가 있으신가요? -&gt;</span>
		            <span onclick="location.href='login.jsp'" style="cursor:pointer;">로그인하기</span>
		        </div>
		        <button class="btn" onclick="">회원가입</button>
	        </div>
		</form>
		<form action="companySignupok.jsp" method="post" onsubmit="return companyFormCheck()">
	        <div id="businessForm" style="display: none;">
	            <div class="input-group">
	                <input type="text" id="companyNumber" name="companyNumber" placeholder="사업자등록번호">
	                <div id="companyNumber-feedback" class="feedback">사업자등록번호 입력은 필수입니다.</div>
	                <input type="password" id="pw" name="pw" placeholder="비밀번호">
	                <div id="pw-feedback" class="feedback">비밀번호 입력은 필수입니다.</div>
	                <input type="text" id="ceoName" name="ceoName" placeholder="대표자명">
	                <div id="ceoName-feedback" class="feedback">대표자명 입력은 필수입니다.</div>
	                <input type="text" id="companyName" name="companyName" placeholder="기업명">
	                <div id="companyName-feedback" class="feedback">기업명 입력은 필수입니다.</div>
	                <input type="text" id="number" name="number" placeholder="대표번호">
	                <div id="number-feedback" class="feedback">대표번호 입력은 필수입니다.</div>
	            </div>
		        <div class="actions">
		            <span>이미 아이디가 있으신가요? -&gt;</span>
		            <span onclick="location.href='login.jsp'" style="cursor:pointer;">로그인하기</span>
		        </div>
		        <button class="btn" onclick="goHome()">회원가입</button>
	        </div>
    	</form>
    </div>
    <script>
        function showTab(type) {
            document.getElementById('personalForm').style.display = (type === 'personal') ? 'block' : 'none';
            document.getElementById('businessForm').style.display = (type === 'business') ? 'block' : 'none';
            document.getElementById('personalTab').classList.toggle('active', type === 'personal');
            document.getElementById('businessTab').classList.toggle('active', type === 'business');
        }
        
       	let idRegex = /^[a-zA-Z0-9]{4,12}$/;
       	let idCheckFlag = false;
       	$("#userId").keyup(function(e){
			let id = e.target.value;
			let idFeedback = $("#userId-feedback");
			idFeedback.css("display", "block").text("아이디는 영어 대소문자와 숫자 4~12자리만 사용 가능합니다.").removeClass("success");
			idCheckFlag = false;
			
			if(!idRegex.test(id)) {
				return;
			}
			
			$.ajax({
				url : "userIdCheck.jsp",
				type : "post",
				data : {
					id : id
				},
				success : function(result){
					if(result.trim()=="0"){
						idCheckFlag = true;
						idFeedback.css("display", "block").addClass("success").text("사용 가능한 아이디입니다.");
					}else{
						idCheckFlag = false;
						idFeedback.css("display", "block").removeClass("success").text("사용 불가능한 아이디입니다.");
					}
				},
				error : function(){
					console.log("오류발생");
				}
			});
       	});
       	
       	let nickRegex = /^[a-zA-Z0-9]{3,8}$/;
       	let nickCheckFlag = false;
       	$("#userNick").keyup(function(e){
			let nick = e.target.value;
			let nickFeedback = $("#userNick-feedback");
			nickFeedback.css("display", "block").text("닉네임은 영어 대소문자와 숫자 3~8자리만 사용 가능합니다.").removeClass("success");
			nickCheckFlag = false;
			
			if(!nickRegex.test(nick)) {
				return;
			}
			
			$.ajax({
				url : "userNickCheck.jsp",
				type : "post",
				data : {
					nick : nick
				},
				success : function(result){
					if(result.trim()=="0"){
						nickCheckFlag = true;
						nickFeedback.css("display", "block").addClass("success").text("사용 가능한 닉네임입니다.");
					}else{
						nickCheckFlag = false;
						nickFeedback.css("display", "block").removeClass("success").text("사용 불가능한 닉네임입니다.");
					}
				},
				error : function(){
					console.log("오류발생");
				}
			});
       	});
       	
       	let numRegex = /^\d{3}-\d{3,4}-\d{4}$/;
       	let numCheckFlag = false;
       	$("#userNumber").keyup(function(e){
			let num = e.target.value;
			let numFeedback = $("#userNumber-feedback");
			numFeedback.css("display", "block").text("전화번호는 -를 포함하여 작성하여주세요.").removeClass("success");
			numCheckFlag = false;
			
			if(!numRegex.test(num)) {
				return;
			}
			
			$.ajax({
				url : "userNumCheck.jsp",
				type : "post",
				data : {
					num : num
				},
				success : function(result){
					if(result.trim()=="0"){
						numCheckFlag = true;
						numFeedback.css("display", "block").addClass("success").text("사용 가능한 전화번호입니다.");
					}else{
						numCheckFlag = false;
						numFeedback.css("display", "block").removeClass("success").text("사용 불가능한 전화번호입니다.");
					}
				},
				error : function(){
					console.log("오류발생");
				}
			});
       	});
       	
       	let emailRegex = /^[a-zA-Z0-9+-\_.]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$/;
       	let emailCheckFlag = false;
       	$("#userEmail").keyup(function(e){
			let email = e.target.value;
			let emailFeedback = $("#userEmail-feedback");
			emailFeedback.css("display", "block").text("이메일은 영어 대소문자와 숫자 3~8자리만 사용 가능합니다.").removeClass("success");
			emailCheckFlag = false;
			
			if(!emailRegex.test(email)) {
				return;
			}
			
			$.ajax({
				url : "userEmailCheck.jsp",
				type : "post",
				data : {
					email : email
				},
				success : function(result){
					if(result.trim()=="0"){
						emailCheckFlag = true;
						emailFeedback.css("display", "block").addClass("success").text("사용 가능한 이메일입니다.");
					}else{
						emailCheckFlag = false;
						emailFeedback.css("display", "block").removeClass("success").text("사용 불가능한 이메일입니다.");
					}
				},
				error : function(){
					console.log("오류발생");
				}
			});
       	});
       	
        function userFormCheck(){
        	let id = $("#userId");
			let idFeedback = $("#userId-feedback");
			if(id.val().trim()==""){
				id.focus();
				id.val("");
				idFeedback.css("display", "block").removeClass("success");	
				return false;
			}else {
				idFeedback.css("display", "none");
			}
			
			if(!idRegex.test(id.val())){
				id.focus();
				id.val();
				idFeedback.css("display", "block").text("아이디는 영어 대소문자와 숫자 4~12자리만 사용 가능합니다.").removeClass("success");
				return false;
			}
			
			if(idCheckFlag==false){
				id.focus();
				id.val();
				idFeedback.css("display", "block").text("아이디 중복 확인이 필요합니다.").removeClass("success");
				return false;
			}
			
			idFeedback.css("display", "block").text("아이디 확인이 완료되었습니다.").addClass("success");
			
			let pw = $("#userPw");
			let pwFeedback = $("#userPw-feedback");
			if(pw.val().trim()==""){
				pw.focus();
				pw.val("");
				pwFeedback.css("display", "block");				
				return false;
			}else {
				pwFeedback.css("display", "none");
			}
			
			let name = $("#userName");
			let nameFeedback = $("#userName-feedback");
			if(name.val().trim()==""){
				name.focus();
				name.val("");
				nameFeedback.css("display", "block");				
				return false;
			}else {
				nameFeedback.css("display", "none");
			}
			
			let nick = $("#userNick");
			let nickFeedback = $("#userNick-feedback");
			if(nick.val().trim()==""){
				nick.focus();
				nick.val("");
				nickFeedback.css("display", "block");				
				return false;
			}else {
				nickFeedback.css("display", "none");
			}
			
			if(!nickRegex.test(nick.val())){
				nick.focus();
				nick.val();
				nickFeedback.css("display", "block").text("닉네임은 영어 대소문자와 숫자 4~12자리만 사용 가능합니다.").removeClass("success");
				return false;
			}
			
			if(nickCheckFlag==false){
				nick.focus();
				nick.val();
				nickFeedback.css("display", "block").text("닉네임 중복 확인이 필요합니다.").removeClass("success");
				return false;
			}
			
			let birth = $("#userBirth");
			let birthFeedback = $("#userBirth-feedback");
			let birthRegex = /^(?:[0-9]{2}(?:0[1-9]|1[0-2])(?:0[1-9]|[1,2][0-9]|3[0,1]))$/;
			if(birth.val().trim()==""){
				birth.focus();
				birth.val("");
				birthFeedback.css("display", "block");				
				return false;
			}else {
				birthFeedback.css("display", "none");
			}
			
			let num = $("#userNumber");
			let numFeedback = $("#userNumber-feedback");
			if(num.val().trim()==""){
				num.focus();
				num.val("");
				numFeedback.css("display", "block");				
				return false;
			}else {
				numFeedback.css("display", "none");
			}
		
			if(!numRegex.test(num.val())){
				num.focus();
				num.val();
				numFeedback.css("display", "block").text("이메일은 영어 대소문자와 숫자 4~12자리만 사용 가능합니다.").removeClass("success");
				return false;
			}
			
			if(numCheckFlag==false){
				num.focus();
				num.val();
				numFeedback.css("display", "block").text("이메일 중복 확인이 필요합니다.").removeClass("success");
				return false;
			}
		
			let email = $("#userEmail");
			let emailFeedback = $("#userEmail-feedback");
			if(email.val().trim()==""){
				email.focus();
				email.val("");
				emailFeedback.css("display", "block");				
				return false;
			}else {
				emailFeedback.css("display", "none");
			}
			
			if(!emailRegex.test(email.val())){
				email.focus();
				email.val();
				emailFeedback.css("display", "block").text("이메일은 영어 대소문자와 숫자 4~12자리만 사용 가능합니다.").removeClass("success");
				return false;
			}
			
			if(emailCheckFlag==false){
				email.focus();
				email.val();
				emailFeedback.css("display", "block").text("이메일 중복 확인이 필요합니다.").removeClass("success");
				return false;
			}
			
			let gender = $("input:radio[name='gender']:checked").val();
			$.ajax({
				url : "usersignupok.jsp",
				type : "post",
				data : {
					gender : gender
				},
				success : function(result){
					console.log(result);
				},
				error : function(){
					console.log("에러 발생");
				}
			});
        }
       	
       	let companyNumberRegex = /([0-9]{3})-?([0-9]{2})-?([0-9]{5})/;
       	let companyNumberCheckFlag = false;
       	$("#companyNumber").keyup(function(e){
			let companyNumber = e.target.value;
			let companyNumberFeedback = $("#companyNumber-feedback");
			companyNumberFeedback.css("display", "block").text("-를 포함한 10자리 번호를 입력해주세요.").removeClass("success");
			companyNumberCheckFlag = false;
			
			if(!companyNumberRegex.test(companyNumber)) {
				return;
			}
			
			$.ajax({
				url : "companyNumberCheck.jsp",
				type : "post",
				data : {
					companyNumber : companyNumber
				},
				success : function(result){
					if(result.trim()=="0"){
						companyNumberCheckFlag = true;
						companyNumberFeedback.css("display", "block").addClass("success").text("사용 가능한 사업자번호입니다.");
					}else{
						companyNumberCheckFlag = false;
						companyNumberFeedback.css("display", "block").removeClass("success").text("사용 불가능한 사업자번호입니다.");
					}
				},
				error : function(){
					console.log("오류발생");
				}
			});
       	});
       	
        /* let numberRegex = /([0-9]{3})-?([0-9]{2})-?([0-9]{5})/; */
       	let numberCheckFlag = false;
       	$("#number").keyup(function(e){
			let number = e.target.value;
			let numberFeedback = $("#number-feedback");
			numberFeedback.css("display", "block").text("-를 포함한 10자리 번호를 입력해주세요.").removeClass("success");
			numberCheckFlag = false;
			
			/* if(!numberRegex.test(number)) {
				return;
			} */
			
			$.ajax({
				url : "numberCheck.jsp",
				type : "post",
				data : {
					number : number
				},
				success : function(result){
					if(result.trim()=="0"){
						numberCheckFlag = true;
						numberFeedback.css("display", "block").addClass("success").text("사용 가능한 사업자번호입니다.");
					}else{
						numberCheckFlag = false;
						numberFeedback.css("display", "block").removeClass("success").text("사용 불가능한 사업자번호입니다.");
					}
				},
				error : function(){
					console.log("오류발생");
				}
			});
       	});
        
        function companyFormCheck(){
        	let companyNumber = $("#companyNumber");
			let companyNumberFeedback = $("#companyNumber-feedback");
			if(companyNumber.val().trim()==""){
				companyNumber.focus();
				companyNumber.val("");
				companyNumberFeedback.css("display", "block").removeClass("success");	
				return false;
			}else {
				companyNumberFeedback.css("display", "none");
			}
			
			if(!companyNumberRegex.test(companyNumber.val())){
				companyNumber.focus();
				companyNumber.val();
				companyNumberFeedback.css("display", "block").text("-를 포함한 10자리 번호를 입력해주세요.").removeClass("success");
				return false;
			}
			
			if(companyNumberCheckFlag==false){
				companyNumber.focus();
				companyNumber.val();
				companyNumberFeedback.css("display", "block").text("사업자등록번호 중복 확인이 필요합니다.").removeClass("success");
				return false;
			}
			
			companyNumberFeedback.css("display", "block").text("사업자등록번호 확인이 완료되었습니다.").addClass("success");
			
			let pw = $("#pw");
			let pwFeedback = $("#pw-feedback");
			if(pw.val().trim()==""){
				pw.focus();
				pw.val("");
				pwFeedback.css("display", "block").removeClass("success");	
				return false;
			}else {
				pwFeedback.css("display", "none");
			}
			
			let ceoName = $("#ceoName");
			let ceoNameFeedback = $("#ceoName-feedback");
			if(ceoName.val().trim()==""){
				ceoName.focus();
				ceoName.val("");
				ceoNameFeedback.css("display", "block").removeClass("success");	
				return false;
			}else {
				ceoNameFeedback.css("display", "none");
			}
			
			let companyName = $("#companyName");
			let companyNameFeedback = $("#companyName-feedback");
			if(companyName.val().trim()==""){
				companyName.focus();
				companyName.val("");
				companyNameFeedback.css("display", "block").removeClass("success");	
				return false;
			}else {
				companyNameFeedback.css("display", "none");
			}
			
			let number = $("#number");
			let numberFeedback = $("#number-feedback");
			if(number.val().trim()==""){
				number.focus();
				number.val("");
				numberFeedback.css("display", "block").removeClass("success");	
				return false;
			}else {
				numberFeedback.css("display", "none");
			}
			
		}
        
    </script>
</body>
</html>
