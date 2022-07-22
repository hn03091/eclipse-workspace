<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="/resources/css/newMap/newmap.css?v=<%=System.currentTimeMillis() %>">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/gh/openlayers/openlayers.github.io@master/en/v6.4.3/css/ol.css" >
<script src="https://cdn.jsdelivr.net/gh/openlayers/openlayers.github.io@master/en/v6.4.3/build/ol.js"></script>
<script src="https://code.jquery.com/jquery-2.2.3.min.js"></script>
<script src="https://cdn.polyfill.io/v2/polyfill.min.js?features=requestAnimationFrame,Element.prototype.classList,URL"></script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=2196f8832616f1028c78fef267e345ad"></script>
<title>지도서비스 구현</title>
</head>
<body>
<div>
	<div id="map" class="map"></div>
	
	<div class="wrapper">
		<p style="background-color:black; margin:0; height:50px; text-align:center;"> 
		<img style="height: 100%; width:50%;"
		src="<c:url value='/images/egovframework/example/egislogo.PNG'/>"
			alt="" /></p>
		<input type="text" id="searchValue" name="query"
					value="서울시 은평구 진관1로 77-8" style="width: 300px;" /> <a
					href="javascript:search();" style="color:white;">검색</a>
				<select name="category">
					<option value="road">도로명</option>
					<option value="parcel">지번</option>
				</select>
		<ui class="mainMenu">
			<li class="item" id="account"><a href="#account" class="btn"><i
					class="fas fa-user-circle"></i>마커옵션</a>
				<div class="subMenu">
					<p>
						<button type="button" onclick="javascript:addMarkingEvent();"
							name="addpin">마커찍기</button>
					</p>
					<p>
						<button type="button" onclick="clearMarkers()">전체 마커 삭제</button>
					</p>
					<p>
				</div>
			</li>
			<li class="item" id="about"><a href="#about" class="btn">
			<i class="fas fa-address-card"></i>layer 표출</a>
				<div class="subMenu">
					<p>
						<input type="checkbox" id="Aed" value="Aed"> 자동심장충격기(AED)
	                <br>
	                <p>
						<input type="checkbox" id="Accident" value="Accident"> 대형차량사고
					<br>
	                <p>
						<input type="checkbox" id="Pharmacy" value="Pharmacy"> 약국 조회
	                
				</div>
			</li>
			<li class="item" id="test"><a href="#test" class="btn">
			<i class="fas fa-address-card"></i>지도 옵션,로드뷰</a>
				<div class="subMenu">
					<input type="checkbox">기본지도<br>
					<input type="checkbox">위성지도<br>
					<input type="checkbox">로드뷰<br>
				</div>
			</li>
		</ui>
	</div>
	<!-- <div class="pointEx" style="">
		<p>범례보기</p>
		<p style="border-top:solid 1px;background-color:white; margin:0; height:50px; text-align:center;"> 
		<img style="height: 50%; width:50%;"src="<c:url value='/images/egovframework/example/egislogo.PNG'/>" alt="" /></p>
		
	</div>
	 -->
	<div class="popup-bar" style="display:none;">
	<div id="info"></div>
	<br><br>
		<div style="border-bottom:solid 2px; width:100%;">
			<span>레이어 명: </span>
			<br>
		</div>
		<div style="border-bottom:solid 2px; width:100%;">
			<br>
			<span>상세 정보: </span>
		</div>
		<div id="result" style="overflow:scroll;">
			<p id="result_count" style="text-align:center;"></p>
			<ul id="result_ajax">
				<li></li>
			</ul>
		</div>
	</div>
</div>
<script src="/resources/js/newMap/function.js?v=<%=System.currentTimeMillis() %>"></script>
<script src="/resources/js/newMap/newMap.js?v=<%=System.currentTimeMillis() %>"></script>
</body>
</html>