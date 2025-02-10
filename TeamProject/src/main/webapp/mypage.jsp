<%@page import="resume.resumeVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="header.jsp" %>
<%
	/* if(user == null){
		response.sendRedirect("login.jsp");
		return;
	} */
	
	resumeVO vo = new resumeVO();
	System.out.println("hi");
%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>마이페이지</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <link rel="stylesheet" href="./resources/css/mypage.css"></link>
</head>
<body>
	<div class="container">
        <div class="aa">
	        <img src="./resources/img/profile.jpg" alt="프로필 사진" class="profile-img">
		   	<div class="profile-container">
			    <div class="profile-header">
			        <div class="profile-info">
			            <h3>개인정보</h3>
			            <div>
			                <button class="modifyBtn">비밀번호 변경</button>
			                <button class="modifyokBtn">저장하기</button>
			            </div>
			        </div>
			    </div>
			    <div class="profile-details">
		            <span class="label detail-item">이름</span>
		            <span class="value detail-item">우지서니<%-- <%= user.getName() %> --%></span>
		            <span class="label detail-item" >성별</span>
		            <span class="value detail-item"><%-- <%= user.getGender() %> --%></span>
		            <span class="label detail-item">생년월일</span>
		            <span class="valuev detail-item"><%-- <%= user.getBirth() %> --%></span>
		        
		            <span class="label detail-item">전화번호</span>
		            <span class="value detail-item" id="number"><%-- <%= user.getNumber() %> --%></span>
		            <span class="label detail-item">이메일</span>
		            <span class="value detail-item" id="mail"><%-- <%= user.getEmail() %> --%></span>
		        
		            <span class="label detail-item">비밀번호</span>
		            <span class="detail-item" id="password"><input type="password" class="password" placeholder="새 비밀번호 입력"></span>
		            <span class="label detail-item">비밀번호 확인</span>
		            <span class="detail-item" id="confirm-password"><input type="password" class="confirm-password" placeholder="새 비밀번호를 다시 입력"></span>
			    </div>
			</div>
		</div>
		<div class="info">
	    	<div class="education">
		        <div class="education-info">
			        <h3>최종학력</h3>
			        <div class="education-action">
				        <button id="educationBtn">수정</button>
				        <button id="educationokBtn">저장</button>
				        <button id="educationCancle">취소</button>
		        	</div>
		        </div>
		        <hr>
		        <div class="lschool">
			        <h3><input id="school" type="text" placeholder="최종 졸업학교"><span><input id="graduationDate" type="text" placeholder="입학 및 졸업 일자"></span></h3>
			        <p><input id="major" type="text" placeholder="전공"></p>
		        </div>
	    	</div>
	        <div>
		        <h3>경력사항</h3>
		        <hr>
		        <h3>애니스마트 <span>2021.06 ~ 2022.05 (1년)</span></h3>
		        <p>보안관제</p>
	        </div>
	        <div>
		        <h3>자기소개서</h3>
		        <hr>
		        <div class="attachment-item">
					<a href="#" class="attachment-name">자기소개서.hwp</a>
					<span class="attachment-size">(1.1 MB)</span>
				</div>
			</div>
		</div>
	</div>
</body>
<script>
	$(document).ready(function(){
		let mokBtn = $(".modifyokBtn");
		let mBtn = $(".modifyBtn");
		let pw = $(".password");
		let cpw = $(".confirm-password");
		let eBtn = $("#educationBtn");
		let eokBtn = $("#educationokBtn");
		let ecBtn = $("#educationCancle");
		let deBtn = $("#deleteeducationBtn");
		let school = $("#school");
		let gDate = $("#graduationDate");
		let major = $("#major");
		let userId = "<%= user != null ? user.getId() : "" %>";
		
		mokBtn.hide();
		pw.hide();
		cpw.hide();
		eokBtn.hide();
		ecBtn.hide();
		deBtn.hide();
		
		
		eBtn.click(function(){
			eokBtn.show();
			eBtn.hide();
			ecBtn.show();
			$(".lschool").css("display", "inline");
		});
		
		ecBtn.click(function(){
			eokBtn.hide();
			eBtn.show();
			ecBtn.hide();
			$(".lschool").css("display", "none");
		});
		
		eokBtn.click(function(){
			if(school.val().trim() == ""){
				alert("졸업학교를 입력해주세요.");
			}
			if(gDate.val().trim() == ""){
				alert("졸업날짜를 입력해주세요.");
			}
			if(major.val().trim() == ""){
				alert("전공을 입력해주세요.");
			}
			
			$.ajax({
				url : "mypage_eduAdd.jsp",
				type : "post",
				data : {
					school : school.val(),
					gDate : gDate.val(),
					major : major.val(),
					id : userId
				},
				success : function(result){
					console.log(result);
					if(result.trim() != "0"){
						let html = "";
						html += "<h3>"+school.val()+" <span>"+gDate+" </span></h3>";
						html += "<p>"+major+"</p>";
						$(".lschool").html(html);
						eokBtn.hide();
						ecBtn.hide();
						eBtn.show();
					}
				},
				error : function(){
					console.log("에러 발생");
				}
			});
		});
		
		mBtn.click(function(){
			mokBtn.show();
			pw.show();
			cpw.show();
			mBtn.hide();
		});
		
		mokBtn.click(function(){
			if(pw.val().trim() == ""){
				pw.focus();
				alert("비밀번호를 입력해주세요.");
				return;
			}
			
			if(pw.val().trim() != cpw.val().trim()){
				alert("비밀번호 확인이 일치하지 않습니다.");
				return;
			}
			pw.hide();
			cpw.hide();
			mokBtn.hide();
			mBtn.show();
			$.ajax({
				url : "mypage_modifyok.jsp",
				type : "post",
				data : {
					pw : pw.val(),
				},
				success : function(result){
					alert("비밀번호 변경이 완료되었습니다.");
				},
				error : function(){
					alert("에러 발생");
					console.log("에러 발생");
				}
            });
		});
	});
</script>
</html>
