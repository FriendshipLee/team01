<%@page import="users.usersVO"%>
<%@page import="company.companyVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	usersVO user = (usersVO)session.getAttribute("user");
	companyVO company = (companyVO)session.getAttribute("company");
%>
<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="UTF-8">
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
	<link rel="stylesheet" href="./resources/css/main.css">
	<script type="text/javascript" src="./resources/js/jquery-3.7.1.js"></script>
</head>
<body>
	<div class="content-box">
		<div>
			<img alt="채용 고민과 사내 고민을 모두 해결할 수 있는 익명 커뮤니티가 제공되는 구인구직 플랫폼" src="./resources/img/main_text.png">
			<ul class="nav">
			  <li><a href="#" onclick="location.href='gonggo.jsp'">채용정보</a> | </li>
			  <li><a href="#" onclick="location.href='board.jsp?boardType=0'">공지게시판</a> | </li>
			  <li><a href="#" onclick="location.href='board.jsp?boardType=1'">정보공유게시판</a> | </li>
			  <li><a href="#" onclick="location.href='board.jsp?boardType=2'">익명게시판</a></li>
			</ul>
			<%
				if(user == null){
					%>
					<button type="button" onclick="location.href='signup.jsp'">회원가입</button>
					<button type="button" onclick="location.href='login.jsp'">로그인</button>
					<%
				}else{
					%>
					<button type="button" onclick="location.href='mypage.jsp'">마이페이지</button>
					<button type="button" onclick="location.href='logout.jsp'">로그아웃</button>
					<%
				}
			%>
		</div>
		<div class="slider__wrap">
	        <div class="slider__img">
	            <div class="slider__inner">
	                <div class="slider s1"><img alt="" src="./resources/img/content_img.png"></div>
	                <div class="slider s2"><img alt="" src="./resources/img/content_img2.png"></div>
	            </div>
	        </div>
	        <div class="slider__btn">
	            <a href="#" class="prev" title="이전이미지"><img alt="왼쪽화살표" src="./resources/img/left.png"></a>
	            <a href="#" class="next" title="다음이미지"><img alt="오른쪽화살표" src="./resources/img/right.png"></a>
	        </div>
		</div>
	</div>
	<!-- <span>Team A. 김다영, 이우정, 김지선</span> -->
</body>
<script type="text/javascript">
    $(document).ready(function () {
        let currentIndex = 0; // 현재 보이는 이미지 인덱스
        let slider = $(".slider"); // 개별 슬라이드 요소
        let sliderCount = slider.length; // 이미지 개수
        let sliderInner = $(".slider__inner"); // 움직이는 영역
        let sliderWidth = $(".slider").width(); // 슬라이드 하나의 너비
        let sliderInterval = 3500; // 자동 슬라이드 변경 시간(ms)

        function gotoSlider(num) {
            sliderInner.css({
                "transition": "all 400ms",
                "transform": "translateX(" + (-sliderWidth * num) + "px)"
            });
            currentIndex = num;
        }

        function nextSlide() {
            let nextIndex = (currentIndex + 1) % sliderCount;
            gotoSlider(nextIndex);
        }

        function prevSlide() {
            let prevIndex = (currentIndex - 1 + sliderCount) % sliderCount;
            gotoSlider(prevIndex);
        }

        // 버튼 클릭 이벤트
        $(".prev").click(function (e) {
            e.preventDefault();
            prevSlide();
            resetAutoSlide();
        });

        $(".next").click(function (e) {
            e.preventDefault();
            nextSlide();
            resetAutoSlide();
        });

        // 자동 슬라이드
        let autoSlide = setInterval(nextSlide, sliderInterval);

        function resetAutoSlide() {
            clearInterval(autoSlide);
            autoSlide = setInterval(nextSlide, sliderInterval);
        }
    });
</script>
</html>