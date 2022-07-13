<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="/resources/css/newMap/newmap.css">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/gh/openlayers/openlayers.github.io@master/en/v6.14.1/css/ol.css" >
<script src="https://cdn.jsdelivr.net/gh/openlayers/openlayers.github.io@master/en/v6.14.1/build/ol.js"></script>
<script src="https://code.jquery.com/jquery-2.2.3.min.js"></script>
<script src="https://cdn.polyfill.io/v2/polyfill.min.js?features=requestAnimationFrame,Element.prototype.classList,URL"></script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=2196f8832616f1028c78fef267e345ad"></script>
<meta charset="UTF-8">
<title>지도서비스 구현</title>
</head>
<body>
<div>
	<div id="map" class="map"></div>
	<div id="layerSelect">
		<input type="checkbox">기본지도
		<input type="checkbox">위성지도
		<input type="checkbox">로드뷰
	</div>
	<div class="wrapper">
	<input type="text" id="searchValue" name="query"
				value="서울시 은평구 진관1로 77-8" style="width: 300px;" /> <a
				href="javascript:search();">검색</a>
			<!--input type="checkbox" id="onoff" />WMS ON/OFF-->
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
				<!-- 	<button type="button" onclick="removeMarkingEvent()">선택마커삭제</button> -->
				</p>
				<p class="content" style="display: none;">
					<textarea rows="10" cols="50" class="mkContent"
						placeholder="내용을 입력하세요."></textarea>
				</p>

			</div>
		</li>
		<li class="item" id="about"><a href="#about" class="btn">
		<i class="fas fa-address-card"></i>지도옵션</a>
			<div class="subMenu">
				<p>
					<button type="button"
						onclick="javascript:addThemeLayer('지적도','LP_PA_CBND_BUBUN,LP_PA_CBND_BONBUN');"
						name="addcache">지적도 예시</button>
				</p>
				<button type="button" onclick="javascript:importWMS();"
					name="importwms">'시도' 주제도</button>
					<button type="button" onclick="javascript:importWMS();"
					name="importwms">'시군구' 주제도</button>
					<button type="button" onclick="javascript:importWMS();"
					name="importwms">'졸음쉼터 on'</button>


				<!-- <p>
					<select id="select_wms">
						<option>선택</option>
						<option value='LT_C_UQ112'>관리지역</option>
						<option value='LT_C_DGMAINBIZ'>주요상권</option>
						<option value='LT_C_UQ113'>농림지역</option>
						<option value='LT_C_UQ111'>도시지역</option>
					</select>
				</p>
				<p>
					<select id="delect_wms">
						<option>삭제</option>
						<option value='LT_C_UQ112'>관리지역</option>
						<option value='LT_C_DGMAINBIZ'>주요상권</option>
						<option value='LT_C_UQ113'>농림지역</option>
						<option value='LT_C_UQ111'>도시지역</option>
					</select>
				</p>
				 -->
			</div>
		</li>
	</ui>
	</div>
<script src="/resources/js/newMap/function.js"></script>
<script src="/resources/js/newMap/newMap.js"></script>
</body>
</html>