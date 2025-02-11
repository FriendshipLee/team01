<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="career.careerDAO"%>
<%@page import="career.careerVO"%>
<%@page import="resume.resumeDAO"%>
<%@page import="resume.resumeVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="header.jsp" %>
<%
	if(user == null){
		response.sendRedirect("login.jsp");
		return;
	}
	
 	resumeVO vo = new resumeVO();
	resumeDAO dao = new resumeDAO();
	String id = user.getId();
	vo = dao.select(id);
	
	careerVO cvo = new careerVO();
	careerDAO cao = new careerDAO();
	String no = vo.getNo();
	List<careerVO> list = new ArrayList<>();
	list = cao.select(no);
	
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
		        <!-- <img src="./resources/img/profile.jpg" alt="프로필 사진" class="profile-img"> -->
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
			            <span class="value detail-item"><%= user.getName() %></span>
			            <span class="label detail-item" >성별</span>
			            <span class="value detail-item"><%= user.getGender() %></span>
			            <span class="label detail-item">생년월일</span>
			            <span class="valuev detail-item"><%= user.getBirth() %></span>
			        
			            <span class="label detail-item">전화번호</span>
			            <span class="value detail-item" id="number"><%= user.getNumber() %></span>
			            <span class="label detail-item">이메일</span>
			            <span class="value detail-item" id="mail"><%= user.getEmail() %></span>
			        
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
					        <% if(vo.getSchool() != null || vo.getSchool() != ""){ %>
					        	<button id="educationDelBtn">삭제</button>
					        <% } %>
					        <button id="educationokBtn">저장</button>
					        <button id="educationCancle">취소</button>
			        	</div>
			        </div>
			        <hr>
			        <div class="lschool">
				        <h3><input id="school" type="text" placeholder="최종 졸업학교"><span><input id="graduationDate" type="text" placeholder="입학 및 졸업 일자"></span></h3>
				        <p><input id="major" type="text" placeholder="전공"></p>
			        </div>
			        <div class="lschool-post">
			        	<% if(vo.getSchool() != null || vo.getGraduation_date() != null || vo.getMajor() != null){ %>
				        <h3> <%= vo.getSchool() %><span> <%= vo.getGraduation_date() %></span></h3>
				        <p><%= vo.getMajor() %></p>
				        <% } %>
			        </div>
		    	</div>
		        <div class="career">
		        	<div class="career-info">
				        <h3>경력사항</h3>
				        <div class="career-action">
				        	<button id="caAddBtn">추가</button>
					        <button id="caokBtn">저장</button>
					        <button id="caCelBtn">취소</button>
			        	</div>
			        </div>
			        <hr>
			        <div class="career-post">
				        <h3><input id="company-name" type="text" placeholder="기업명"><span><input id="workDate" type="text" placeholder="근무 기간"></span></h3>
					        <p><input id="work" type="text" placeholder="담당업무"></p>
		        	</div>
		        	<div class="mycareer">
				        <% if(cvo.getCompany() != null || cvo.getCareer_date() != null || cvo.getWork() != null) { %>
				        <h3> <%= cvo.getCompany() %><span> <%= cvo.getCareer_date() %></span></h3>
					    <p><%= cvo.getWork() %></p>
					    <% } %>
		        	</div>
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
		let edelBtn = $("#educationDelBtn");
		let school = $("#school");
		let gDate = $("#graduationDate");
		let major = $("#major");
		let userId = "<%= user.getId() %>";
		
		mokBtn.hide();
		pw.hide();
		cpw.hide();
		eokBtn.hide();
		ecBtn.hide();
		
		//커리어 추가
		$("#caAddBtn").click(function(){
			$.ajax({
				url : "mypage_caAdd.jsp",
				type : "post",
				data : {
					company : $("#company-name").val(),
					cdate : $("#workDate").val(),
					work : $("#work").val()
				},
				success : function(result){
					console.log(result);
					if(result.trim() != "0"){
						let html = "";
						html += "<h3>"+$("#company-name").val()+"<span>"+$("#workDate").val()+"</span></h3>";
						html += "<p>"+$("#work").val()+"</p>";
						$(".mycareer").prepend(html);
					}
				},
				error : function(){
					console.log("에러 발생");
				}
			});
		});
		
		//삭제버튼
		edelBtn.click(function(){
			$.ajax({
				url : "mypage_eduDel.jsp",
				type : "post",
				data : {
					id : "jeon"
				},
				sucess : function(result){
					console.log(result);
					eBtn.show();
				},
				error : function(){
					console.log("에러 발생");
					eBtn.show();
				}
			});
		});
		
		//수정버튼
		eBtn.click(function(){
			eokBtn.show();
			eBtn.hide();
			ecBtn.show();
			$(".lschool").css("display", "inline");
			$(".lschool-post").css("display", "none");
		});
		
		//취소버튼
		ecBtn.click(function(){
			eokBtn.hide();
			eBtn.show();
			ecBtn.hide();
			$(".lschool").css("display", "none");
			$(".lschool-post").css("display", "inline");
		});
		
		//저장버튼
		eokBtn.click(function(){
			if(school.val().trim() == ""){
				alert("졸업학교를 입력해주세요.");
				return;
			}
			if(gDate.val().trim() == ""){
				alert("졸업날짜를 입력해주세요.");
				return;
			}
			if(major.val().trim() == ""){
				alert("전공을 입력해주세요.");
				return;
			}
			
			$.ajax({
				url : "mypage_eduAdd.jsp",
				type : "post",
				data : {
					school : school.val(),
					gDate : gDate.val(),
					major : major.val(),
					id : "jeon"
				},
				success : function(result){
					console.log(result);
					if(result.trim() != "0"){
						$(".lschool").css("display", "none");
						$(".lschool-post").css("display", "block");
						eokBtn.hide();
						ecBtn.hide();
						eBtn.show();
						$(".lschool-post").html("<h3>"+school.val()+"</h3>")
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
					id : "jeon",
					pw : pw.val()
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
