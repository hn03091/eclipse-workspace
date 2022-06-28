<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>과제</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/gh/openlayers/openlayers.github.io@master/en/v6.14.1/css/ol.css" >
    <link rel="stylesheet" href="/resources/css/map.css">

    <script src="https://cdn.jsdelivr.net/gh/openlayers/openlayers.github.io@master/en/v6.14.1/build/ol.js"></script>
    <script src="https://code.jquery.com/jquery-2.2.3.min.js"></script>
    <script src="https://cdn.polyfill.io/v2/polyfill.min.js?features=requestAnimationFrame,Element.prototype.classList,URL"></script>
	<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=2196f8832616f1028c78fef267e345ad"></script>
</head>
<body>
    <div style="font-size:30px;">
		<input type="checkbox" id="mapb" >지도분할
		<br>
		<input type="checkbox" id="map1b" value="map1" checked>지도1
        <label id="mapOn"style="display: none; size:30px;">
            <input type="checkbox" id="map2b" value="map2">지도2
        </label>
    </div>
    
	<form id="searchForm" action="#" class="form_data"
		onsubmit="return false;search();">
		<input type="hidden" name="page" value="1" /> <input type="hidden"
			name="type" value="address" /> <input type="hidden" name="request"
			value="search" /> <input type="hidden" name="size" value="100" /> <input
			type="hidden" name="apiKey"
			value="10036FCE-3940-374C-B2ED-E6FBDF47CFA9" /> <input type="hidden"
			name="domain" value="http://localhost:8080" /> <input type="hidden"
			name="crs" value="EPSG:3857" />
		<div>
			
			
			<input type="text" id="searchValue" name="query"
				value="서울시 은평구 진관1로 77-8" style="width: 300px;" /> <a
				href="javascript:search();">검색</a>
			<!--input type="checkbox" id="onoff" />WMS ON/OFF-->
			<select name="category">
				<option value="road">도로명</option>
				<option value="parcel">지번</option>
			</select><br>
			<label><input type="radio" name="searchMk"id="mkImg" value="http://map.vworld.kr/images/ol3/marker_blue.png" checked="on">
				<img src="http://map.vworld.kr/images/ol3/marker_blue.png" />

				<input type="radio" name="searchMk" id="mkImg" value="http://map.vworld.kr/images/ol3/marker.png"> 
				<img src="http://map.vworld.kr/images/ol3/marker.png" /> 

				<!--input type="radio" name="searchMk" id="mkImg" value="https://openlayers.org/en/v3.20.1/examples/data/icon.png">
				<img src="https://openlayers.org/en/v3.20.1/examples/data/icon.png" /-->

				<input type="radio" name="searchMk" id="mkImg" value="https://developers.google.com/maps/documentation/javascript/examples/full/images/beachflag.png">
				<img src="https://developers.google.com/maps/documentation/javascript/examples/full/images/beachflag.png" />
			</label>
		</div>
	</form>
        <div id="option"
		style="border: solid 0.1px; width: 13%; height: 800px; float: left; overflow: auto;">
		
		<div>
			<p style="background-color: black; color: white;">지도 타입변경
			<p>
				<input type="radio" id="vworldTile" name="tile" value="Base">기본지도
			</p>
			<p>
				<input type="radio" id="vworldTile" name="tile" value="Satelite" checked>항공사진
			</p>
			<!--p><input type="checkbox" id="vworldTile" value="Hybrid">문자 타일</p-->
			<button type="button" onclick="javascript:tileChange()">지도옵션선택</button>
		</div>
		<hr>
		
        
		<div id="map1option">
		<div id="wms">
			<p style="background-color: gray; color: white;">WMS
			<p>
                <input type="checkbox" id="sig" value="sig">지도 1 '시군구 주제도'
                <br>
                <input type="checkbox" id="ctp" value="ctp">지도 1 '시도 주제도'
                <br>
                <input type="checkbox" id="icon" value="icon">지도 1 '졸음쉼터 주제도'
				<div id="wms2" style="display:none;">
					<hr>
					<input type="checkbox" id="sig2" value="sig">지도 2 '시군구 주제도'
					<br>
					<input type="checkbox" id="ctp2" value="ctp">지도 2 '시도 주제도'
					<br>
					<input type="checkbox" id="icon2" value="icon">지도 2 '졸음쉼터 주제도'
				</div>
				
        </div>
		
			
		<div id="selectOption" style="">   
			<p style=" background-color: black; color: white;">1번지도 기능</p>
			<label><input type="radio" name="selcetType" value="0" checked>지도이동</label><br>
				<label><input type="radio" name="selcetType" value="deleteMarker">feature삭제</label><br>
				<label><input type="radio" name="selcetType" value="roadviewOn">로드뷰 보기</label><br>
				<input type="radio" name="selcetType" value="MarkerOn">마커 기능
							<div id="selectMarker" >								
								<br>
								<input type="radio" name="mkType" value="http://map.vworld.kr/images/ol3/marker_blue.png" checked>		<img src="http://map.vworld.kr/images/ol3/marker_blue.png" />
								<input type="radio" name="mkType" value="http://map.vworld.kr/images/ol3/marker.png">		<img src="http://map.vworld.kr/images/ol3/marker.png" />
								<input type="radio" name="mkType" value="https://openlayers.org/en/v3.20.1/examples/data/icon.png">	<img src="https://openlayers.org/en/v3.20.1/examples/data/icon.png" />
								<input type="radio" name="mkType" value="https://developers.google.com/maps/documentation/javascript/examples/full/images/beachflag.png">	<img src="https://developers.google.com/maps/documentation/javascript/examples/full/images/beachflag.png" />
							
							</div>
						<hr>
			</div>
			<div id="marker">
				<p style="background-color: gray; color: white;">1번지도 그리기 기능<br>
					<span id="map1opWrap"><input type="checkbox" id="map1op" value="">'사용시체크'</span></p>
				<form class="form-inline">
					<label>옵션 타입 &nbsp;</label> <select id="type">
						<option value="length">길이</option>
						<option value="area" selected>면적</option>
						
						<!-- <option value="Circle">Circle</option> -->
						<option value="Select" >선택</option>
					</select>
				</form>
				
				
				<hr>
				<button type="button" onclick="javascript:map1_delete();">MAP1
					옵션 전체삭제</button><br>
			</div>
			<hr>
			<p style="background-color: black; color: white;">팝업 내용작성</p>
			<label> 팝업제목 <input type="text" id="subj"
				placeholder="팝업 제목을 입력하세요" />
			</label> <br> <label> 팝업내용 <textarea id="cont"
					placeholder="팝업 내용을 입력하세요"></textarea>
			</label>

		</div>
		<div id="map2option" style="display:none;">
			<p style="background-color: black; color: white;">2번지도 그리기 기능<br></p>
			
				
						<form class="form-inline">
							<label>옵션 타입 &nbsp;</label> <select id="type2">
								<option value="length">길이</option>
								<option value="area" selected>면적</option>
								
								<!-- <option value="Circle">Circle</option> -->
								<option value="Select">선택</option>
							</select>
						</form>
							<hr>
				
						<br>
						<button type="button" onclick="javascript:map2_delete();">MAP2
							옵션 전체삭제</button><br>
		</div>
			
		<div id="selectOption2" style="display:none;">   
		<p style=" background-color: black; color: white;">2번지도 클릭 기능</p>
			<label><input type="radio" name="selcetType" value="0">지도이동</label><br>
			<label><input type="radio" name="selcetType" value="deleteMarker">feature삭제</label><br>
			<input type="radio" name="selcetType" value="MarkerOn">마커 기능
						<div id="selectMarker" >
							
							<br>
							<input type="radio" name="mkType" value="http://map.vworld.kr/images/ol3/marker_blue.png" checked>		<img src="http://map.vworld.kr/images/ol3/marker_blue.png" />
							<input type="radio" name="mkType" value="http://map.vworld.kr/images/ol3/marker.png">		<img src="http://map.vworld.kr/images/ol3/marker.png" />
							<input type="radio" name="mkType" value="https://openlayers.org/en/v3.20.1/examples/data/icon.png">	<img src="https://openlayers.org/en/v3.20.1/examples/data/icon.png" />
							<input type="radio" name="mkType" value="https://developers.google.com/maps/documentation/javascript/examples/full/images/beachflag.png">	<img src="https://developers.google.com/maps/documentation/javascript/examples/full/images/beachflag.png" />
						
						</div>
					<hr>
		</div>

		<div id="allOption">
		<p style="background-color: black; color: white;">Delete기능</p>
			<button type="button" onclick="javascript:all_delete();">전체MAP 옵션 전체삭제</button>
		</div>

</div>

<div id="popupTest" style="width: 300px; display: none;"></div>

    <div id="wrap">
        <div id="map1" class="map"></div>
		<div id="road" style="display:none;"></div>
		<div id="map2" class="map"></div>
    </div>

	<div>
		<!-- 검색 폼  -->
		<!-- 데이터 API 폼  -->
		<form id="dataForm">
			<input type="hidden" name="key"
				value="CEB52025-E065-364C-9DBA-44880E3B02B8"> <input
				type="hidden" name="domain" value="http://localhost:8080"> <input
				type="hidden" name="service" value="data"> <input
				type="hidden" name="version" value="2.0"> <input
				type="hidden" name="request" value="getfeature"> <input
				type="hidden" name="format" value="json"> <input
				type="hidden" name="size" value="1000"> <input type="hidden"
				name="page" value="1"> <input type="hidden" name="data"
				value="LT_C_SPBD"> <input type="hidden" name="geometry"
				value="true"> <input type="hidden" name="attribute"
				value="true"> <input type="hidden" name="crs"
				value="EPSG:900913">
			<!-- <input type="hidden" name="geomfilter" value="BOX(14028876.609587036,3912653.333809428,14151175.854843318,3974414.4526638505)"> -->
			<input type="hidden" name="geomfilter"
				value="POINT(14028876.609587036 3912653.333809428)">
		</form>
	</div>
	<div id="info" style="top: 80%; left: 30%;"></div>
	<div id="result"
		style="overflow: scroll; width: 1500px; height: 500px; ">
		<!-- P class="noticePrev">검색결과 -->

		<p class="notice" style="display: none; color: red;">주소를 클릭 할 시 해당 좌표로
			이동합니다<br>
			<input type="checkbox" id="searchMarker" value="on"> 체크시 이동 장소를 제외한 마커 숨김
		</p>
		<hr>
		

		<p id="result_count" style="text-align: center;"></p>

		<ul id="result_ajax">
			<!--검색결과 ajax 장소, count 개수-->
			<li></li>
		</ul>


		<p id="result_pos"></p>
	
    <script src="/resources/js/function.js"></script>
    <script src="/resources/js/map.js"></script>
</body>
</html>
