<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<style>
*{
	color:white;
}
body{
	background-color:black;
	margin:0;
}
header{
	text-align:center;
	font-size:50px;
}
#studyList{
	width: 40%;
	font-size: 30px;
	margin-top: 50px;
}
</style>
<body>
	<header> HJB STUDY HOME</header>
	<div id="wrap">
		<div id="studyList">
			<ul>
				<li><a href="/map.do">첫 과제</a>
					<p>지도 분할, openlayer 기능,배경지도 옵션, 카카오 로드뷰, Vworld 지도 검색</p>
					<p>DB에 저장후 레이어 표출</p>
					<p style="color:red;">완료</p>
				</li>
				<li><a href="/newMap.do">지도서비스 구현 </a>
					<p>1개의 지도, 3D 지도 연동, openlayer 기능, 카카오 로드뷰</p>
					<p>실무 - DB값을 XML로 가져와서 저장-> 레이어의 정보와 마커 는 GEOSERVER에서 모든 작업을 함.</p>
					<p style="color:blue;">개발중</p>
				</li>
				<li><a href="">개발 메모</a>
					<p>공부 한 내용 메모</p>
				</li>
				<li>참고 자료
					<p>자바스크립트</p>
					<p>/poiemaweb.com</a></p>
					<p>ko.javascript.info/</p>
				</li>
			</ul>
		</div>
	</div>
</body>
</html>