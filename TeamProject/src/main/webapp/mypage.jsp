<%@page import="resume_file.resumeFileVO"%>
<%@page import="resume_file.resumeFileDAO"%>
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
	String path = request.getContextPath();
	//톰캣의 contextPath -> 톰캣 경로
	System.out.println(path);
	if(user == null){
		response.sendRedirect("login.jsp");
		return;
	}

	String id = user.getId();
	
 	resumeVO vo = new resumeVO();
	resumeDAO dao = new resumeDAO();
	vo = dao.select(id);
	
	String no = vo.getNo();
	
	careerVO cvo = new careerVO();
	careerDAO cao = new careerDAO();
	List<careerVO> list = new ArrayList<>();
	list = cao.select(no);
	
	resumeFileDAO fdao = new resumeFileDAO();
	List<resumeFileVO> flist = fdao.list(no);
	
	
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
				                <button class="cancleBtn">취소하기</button>
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
					        <% if(vo.getSchool() != null && vo.getSchool() != ""){ %>
					        	<button id="educationDelBtn">삭제</button>
					        <% } %>
					        <button id="educationokBtn">저장</button>
					        <button id="educationCancle">취소</button>
			        	</div>
			        </div>
			        <hr>
			        <div class="lschool">
				        <h3>
					        <input id="school" type="text" placeholder="최종 졸업학교">
					        <span>
					        	<!-- <input id="graduationDate" type="text" placeholder="입학 및 졸업 일자"> -->
					        	<label>입학 일자 : <input id="enterDate" type="month" max="2040-12" min="1920-12" value="2025-03"></label>
					        	<label>졸업 일자 : <input id="graduationDate" type="month" max="2040-12" min="1920-12" value="2025-02"></label>
					        </span>
				        </h3>
				        <p><input id="major" type="text" placeholder="전공"></p>
			        </div>   
			        <div class="lschool-post">
			        	<% if(vo.getSchool() != null && vo.getEnter_date() != null && vo.getGraduation_date() != null && vo.getMajor() != null){ %>
					        <h3> <%= vo.getSchool() %><span> <%= vo.getEnter_date() %> ~ <%= vo.getGraduation_date() %> </span></h3>
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
				        <h3>
				        	<input id="company-name" type="text" placeholder="기업명">
				        	<span>
				        		<!-- <input id="workDate" type="text" placeholder="근무 기간"> -->
				        		<label>입사년월 : <input id="workStartDate" type="month" max="2040-12" min="1920-12" value="2025-03"></label>
				        		<label>퇴사년월 : <input id="workEndDate" type="month" max="2040-12" min="1920-12" value="2025-03"></label>
				        	</span>
				        </h3>
					    <p><input id="work" type="text" placeholder="담당업무"></p>
		        	</div>
		        	<div class="mycareer-container">
		        		<% 
		        			for(int i = 0; i < list.size(); i++){
		        				cvo = list.get(i);
		        		%>
		        			<div>
					        	<div class="mycareer">
					        		<div>
								        <% if(cvo.getCompany() != null || cvo.getCareer_start_date() != null || cvo.getWork() != null) { %>
									        <h3> <%= cvo.getCompany() %> <span> <%= cvo.getCareer_start_date() %> ~ <%= cvo.getCareer_end_date() %></span></h3>
										    <p><%= cvo.getWork() %></p>
								    </div>
								    <button onclick="deleteBtn(<%= cvo.getCno() %>, this)" id="caDelBtn">삭제</button>
					        	</div>
					        	<hr class="hr">
				        	</div>
							    <% } %>
						    <% } %>
		       		</div>
		        <div>
		        <div class="selfinfo">
		        	<h3>자기소개서</h3>
					<!-- <button id="selfinfo-add">추가</button> -->
					<form id="uploadForm">
						<label for="file">추가</label>
	           			<input type="file" multiple="multiple" id="file" name="file">
					</form>
				</div>
		        <hr id=hr>
		        <%-- <% if(originName != null && !uploadName.equals("null")) { %> --%>
		        	<% 
		        		for(int i = 0; i < flist.size(); i++){ 
		        			resumeFileVO rfvo = flist.get(i);
		        			int fileSize = rfvo.getFileSize();
		        			String data = "";
		        			if(fileSize < 1024){
		        				data = fileSize + "B";
		        			}else if(fileSize < 1024 * 1024){
		        				double kb = fileSize / (double)1024;
		        				kb = Math.round(kb * 100) / 100.0;
		        				data = kb + "kb";
		        			}else if(fileSize < 1024 * 1024 * 1024){
		        				double mb = fileSize / (double)(1024 * 1024);
		        				mb = Math.round(mb * 100) / 100.0;
		        				data = mb + "mb";
		        			}else if(fileSize < 1024 * 1024 * 1024 * 1024){
		        				double gb = fileSize / (double)(1024 * 1024 * 1024);
		        				gb = Math.round(gb * 100) / 100.0;
		        				data = gb + "gb";
		        			}
		        	%>
				        <div class="attachment-item">
							<div>
								<a download="<%= rfvo.getAttachOriginName() %>" href="<%= rfvo.getAttachUploadName() %>" class="attachment-name"><%= rfvo.getAttachOriginName() %></a>
								<span class="attachment-size">(<%= data %>)</span>
							</div>
							<button id="selfinfoDel" onclick="selfinfoDel(<%= rfvo.getFno() %>, this)">삭제</button>
						</div>
					<% } %>
				<%-- <% } %> --%>
				</div>
			</div>
		</div>
		<div class="back">
			<input type="button" onclick="history.back();" value="뒤로가기">
		</div>
	</div>
</body>
<script>
	
	//경력 삭제 함수
	function deleteBtn(cno, obj){
		$.ajax({
			url : "mypage_caDel.jsp",
			type : "post",
			data : {
				cno : cno
			},
			success : function(result){
				console.log(result);
				if(result.trim() == "success"){
					$(obj).parent().parent().remove();
				}
			},
			error : function(){
				console.log("에러 발생");
			}
		});
	}
	
	//첨부파일 삭제 함수
	function selfinfoDel(fno, obj){
		$.ajax({
			url : "mypageFileDel.jsp",
			type : "post",
			data : {
				fno : fno
			},
			success : function(result){
				console.log(result);
				if(result.trim() == "success"){
					$(obj).parent().remove();
				}
			},
			error : function(){
				console.log("에러 발생");
			}
		});
	}
	
	
	$(document).ready(function(){
		
		$("#file").on("change", fileCheck);
		
		function fileCheck(){
			<%-- var form = $("#uploadForm")[0];
			var formData = new FormData(form);
			formData.append("rno", <%= no %>); --%>
			
			var formData = new FormData();
			formData.append("rno", <%= no %>)
			//rno는 form에 한번만 추가
			
			/* console.log($("#file")[0].files); */
			//file 태그에 업로드된 파일들
			for(let i = 0; i < $("#file")[0].files.length; i ++){
				//file 태그에 업로드된 파일 길이만큼 순회
				formData.append("file"+i, $("#file")[0].files[i]);
				//file 태그에 업로드된 파일을 하나씩 가져와서 form에 추가
			}
			
			/* for(let i = $("#file")[0].files.length - 1; i >= 0; i --){
				//file 태그에 업로드된 파일 길이만큼 순회
				formData.append("file"+i, $("#file")[0].files[i]);
				//file 태그에 업로드된 파일을 하나씩 가져와서 form에 추가
			} */
			
			/* for (var [key, value] of formData.entries()) { 
		  		console.log(key, value);
			} */
			
			$.ajax({
				url : "mypageFileOk.jsp",
				type : "post",
				enctype: 'multipart/form-data',
				data : formData,
				contentType : false,
				processData : false,
				success : function(response){
					console.log(response.trim());
					//fno가 추가된 파일정보 문자열
					if(response.trim() == "fail"){
						
					}else{
						const result = JSON.parse(response);
						console.log(result);
						//문자열을 json형태로 변환
						result.sort((a, b) => {
						    if (parseInt(a.fno) > parseInt(b.fno)) return -1;
						    if (parseInt(a.fno) < parseInt(b.fno)) return 1;

						    return 0;
						});
						/* console.log("정렬 후 : ", result); */
						
						for(let i = 0; i < result.length; i ++){
							const obj = result[i];
							
							let html = 	'<div class="attachment-item">';
							html +=			'<div>';
							html += 			'<a download="'+obj.attachOriginName+'" href="<%= path %>/upload/'+obj.attachUploadName+'" class="attachment-name">'+obj.attachOriginName+'</a>'
							html += 			'<span class="attachment-size">('+obj.fileSize+')</span>'
							html += 		'</div>';
							html +=			'<button id="selfinfoDel" onclick="selfinfoDel('+obj.fno+', this)">삭제</button>'
							html +=		'</div>'
							$("#hr").after(html);
						}
					}
				},
				error : function(a, b, c){
					//에러도 파라미터가 있다.
					//첫번째가 요청 객체
					//두번째가 요청상태(메시지)
					//세번째가 오류(없을 수 있음)
					console.log(a, b, c);
				}
			});
		}
		
		
		let mokBtn = $(".modifyokBtn");
		let mBtn = $(".modifyBtn");
		let celBtn = $(".cancleBtn");
		let pw = $(".password");
		let cpw = $(".confirm-password");
		let eBtn = $("#educationBtn");
		let eokBtn = $("#educationokBtn");
		let ecBtn = $("#educationCancle");
		let edelBtn = $("#educationDelBtn");
		//페이지 로딩되었을 때 삭제버튼 없으면 객체 못찾음
		
		let school = $("#school");
		let eDate = $("#enterDate");
		let gDate = $("#graduationDate");
		let major = $("#major");
		let userId = "<%= user.getId() %>";
		let caDelBtn = $("#caDelBtn");
		let caAddBtn = $("#caAddBtn");
		let caokBtn = $("#caokBtn");
		let caCelBtn = $("#caCelBtn");
		
		
		mokBtn.hide();
		pw.hide();
		cpw.hide();
		eokBtn.hide();
		ecBtn.hide();
		celBtn.hide();
		caokBtn.hide();
		caCelBtn.hide();
		
		//커리어 추가 취소 버튼
		caCelBtn.click(function(){
			caokBtn.hide();
			caCelBtn.hide();
			caAddBtn.show();
			$(".career-post").css("display", "none");
		});
		
		//커리어 추가
		caAddBtn.click(function(){
			$(".career-post").css("display", "inline");
			caokBtn.show();
			caCelBtn.show();
			caAddBtn.hide();
		});
		
		//커리어 저장버튼
		caokBtn.click(function(){
			if($("#company-name").val().trim() == ""){
				alert("기업명을 입력해주세요.");
				return;
			}
			if($("#workStartDate").val().trim() == "" || $("#workEndDate").val().trim() == ""){
				alert("입사/퇴사 날짜를 입력해주세요.");
				return;
			}
			if($("#work").val().trim() == ""){
				alert("담당업무를 입력해주세요.");
				return;
			}
			
			$.ajax({
				url : "mypage_caAdd.jsp",
				type : "post",
				data : {
					company : $("#company-name").val(),
					cStartDate : $("#workStartDate").val(),
					cEndDate : $("#workEndDate").val(),
					work : $("#work").val(),
					id : userId
				},
				success : function(result){
					if(result.trim() != "0"){
						let html = "";
						html += "<div>";
						html += 	"<div class='mycareer'>";
						html +=			"<div>";
						html +=				"<h3>"+$("#company-name").val()+" <span> "+$("#workStartDate").val()+" ~ "+$("#workEndDate").val()+" </span></h3>";
						html +=				"<p>"+$("#work").val()+"</p>";
						html +=			"</div>";
						html +=			"<button onclick='deleteBtn("+result.trim()+", this)' id='caDelBtn'>삭제</button>";
						html +=		"</div>";
						html +=		"<hr class='hr'>";
						html += "</div>";
						$(".mycareer-container").prepend(html);
						caokBtn.hide();
						caCelBtn.hide();
						caAddBtn.show();
						$(".career-post").css("display", "none");
						console.log(result);
					}
				},
				error : function(){
					console.log("에러 발생");
				}
			});
		});
		
		//최종학력 삭제버튼
		//페이지 로딩 되었을 때 삭제버튼 없으면 클릭 이벤트 X
		edelBtn.click(function(){
			$.ajax({
				url : "mypage_eduDel.jsp",
				type : "post",
				data : {
					id : userId
				},
				success : function(result){
					if(result.trim() == "success"){
						eBtn.show();
						let html = "";
						$(".lschool-post").html(html);
						edelBtn.hide();
					}
				},
				error : function(){
					console.log("에러 발생");
					eBtn.show();
				}
			});
		});
		
		//최종학력 수정버튼
		eBtn.click(function(){
			eokBtn.show();
			eBtn.hide();
			ecBtn.show();
			edelBtn.hide();
			$(".lschool").css("display", "inline");
			$(".lschool-post").css("display", "none");
		});
		
		//최종학력 취소버튼
		ecBtn.click(function(){
			eokBtn.hide();
			eBtn.show();
			ecBtn.hide();
			if(true){
				edelBtn.show();
			}
			$(".lschool").css("display", "none");
			$(".lschool-post").css("display", "inline");
		});
		
		//최종학력 저장버튼
		eokBtn.click(function(){
			if(school.val().trim() == ""){
				alert("졸업학교를 입력해주세요.");
				return;
			}
			if(eDate.val().trim() == ""){
				alert("입학날짜를 입력해주세요.");
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
					eDate : eDate.val(),
					gDate : gDate.val(),
					major : major.val(),
					id : userId
				},
				success : function(result){ //?
					console.log(result);
					if(result.trim() != "0"){
						$(".lschool").css("display", "none");
						$(".lschool-post").css("display", "block");
						eokBtn.hide();
						ecBtn.hide();
						eBtn.show();
						
						let html = "";
						html += "<h3>"+school.val()+" <span> "+eDate.val()+" ~ "+gDate.val()+" </span></h3>";
						html += "<p>"+major.val()+"</p>";
						$(".lschool-post").html(html);
						
						if(edelBtn.length > 0){
							edelBtn.remove();
						}
						
						//최종학력 저장 확인버튼 누를 때 educationDelBtn아이디를 가진 버튼 생성
						$("<button id='educationDelBtn'>삭제</button>").insertAfter("#educationBtn");
						
						//금방 생성한 educationDelBtn아이디를 가진 버튼을 찾아서 edelBtn 변수 재할당
						edelBtn = $("#educationDelBtn");
						
						//educationDelBtn아이디를 가진 버튼에 새로운 클릭 이벤트 등록
						edelBtn.click(function(){
							$.ajax({
								url : "mypage_eduDel.jsp",
								type : "post",
								data : {
									id : userId
								},
								success : function(result){
									if(result.trim() == "success"){
										eBtn.show();
										let html = "";
										$(".lschool-post").html(html);
										edelBtn.hide();
										
									}
								},
								error : function(){
									console.log("에러 발생");
									eBtn.show();
								}
							});
						});
					}
				},
				error : function(){
					console.log("에러 발생");
				}
			});
		});
		
		//비밀번호 변경버튼
		mBtn.click(function(){
			celBtn.show();
			mokBtn.show();
			pw.show();
			cpw.show();
			mBtn.hide();
		});
		
		//비밀번호 변경 취소버튼
		celBtn.click(function(){
			mokBtn.hide();
			mBtn.show();
			celBtn.hide();
			pw.hide();
			cpw.hide();
		});

		
		//비밀번호 변경 저장버튼
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
					id : userId,
					pw : pw.val()
				},
				success : function(result){
					alert("비밀번호 변경이 완료되었습니다.");
					celBtn.hide();
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
