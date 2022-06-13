<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script type="text/javascript"
	src="http://map.vworld.kr/js/vworldMapInit.js.do?version=2.0&apiKey=10036FCE-3940-374C-B2ED-E6FBDF47CFA9"></script>
<!-- wms --><script src="https://cdn.jsdelivr.net/gh/openlayers/openlayers.github.io@master/en/v6.14.1/build/ol.js"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/gh/openlayers/openlayers.github.io@master/en/v6.14.1/css/ol.css">

<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>

<style>
</style>
<meta charset="UTF-8">
<title>ㅅ</title>
</head>
<body>
	<div>
		<span style="text-align: center;">3. 수행과제<br> - 원하는 위치 클릭
			시 Marker 표시 기능 o<br> -마커 내용 입력 O (원하는사진?)<br> -선택 마커삭제<br>
			-마커 색상?모양? 선택<br> 2) 지오서버를 이용하여 주제도 표출 (지오서버는 로컬에 설치하여 진행)<br>
			- 시도, 시군구, 졸음쉼터<br> - 각 주제도 스타일 편집(색상 및 포인트 이미지)<br> - 지도에
			주제도 표출 후 클릭 시 정보 표출<br> 3) vworld 검색 api 를 이용하여 원하는 장소 검색 후 결과
			보여주고 선택 시 위치 이동
		</span>
	</div>

	<div id="map" style="width: 100%; height: 640px; left: 0px; top: 0px"></div>
	<div id="map_mode">
		<button type="button"
			onclick="javascript:setMode(vw.ol3.BasemapType.GRAPHIC);">배경지도</button>
		<button type="button"
			onclick="javascript:setMode(vw.ol3.BasemapType.PHOTO_HYBRID);">항공사진</button>
	</div>
	<button id="mKadd" onclick="javascript:mKadd();">마커찍기</button>
	<button id="mKstop" onclick="javascript:mKstop();">마커정지</button>
	<div id="mk_option" style="display: none;">
		<label><input type="checkbox" id="mkImg"
			value="<c:url value='/images/egovframework/example/marker1.png'/>"
			checked="on"> <img style="width: 50px; height: 50px;"
			src="<c:url value='/images/egovframework/example/marker1.png'/>"
			alt="" /> </label> <label><input type="checkbox" id="mkImg"
			value="<c:url value='/images/egovframework/example/marker3.png'/>">
			<img style="width: 50px; height: 50px;"
			src="<c:url value='/images/egovframework/example/marker3.png'/>"
			alt="" /> </label>
		<!-- <button type="button" id="mkOption">마커 옵션 변경</button>  -->
	</div>


	<p style="color: black; font-size: 20px; text-align: center;">
		클릭 좌표: <input type="text" name='q' id='mousex' value="0"
			maxlength="20"
			style="ime-mode: active; width: 400px; height: 20px; font-size: 20px; background-color: black; color: white;" />
		<input type="text" name='q' id='mousey' value="0" maxlength="20"
			style="ime-mode: active; width: 400px; height: 20px; font-size: 20px; background-color: black; color: white;" />
	</p>

	<button type="button" onclick="javascript:importWMS();"
		name="importwms">'리' 지적도</button>


	<script type="text/javascript">
		////////////////////////지도 불러오기///////////////////////////////////
		vw.ol3.MapOptions = {
			basemapType : vw.ol3.BasemapType.GRAPHIC,
			controlDensity : vw.ol3.DensityType.EMPTY,
			interactionDensity : vw.ol3.DensityType.BASIC,
			controlsAutoArrange : true,
			homePosition : vw.ol3.CameraPosition,
			initPosition : vw.ol3.CameraPosition,

		};

		var map = new vw.ol3.Map("map", vw.ol3.MapOptions);
		//////////////////////지도 옵션/////////////////////////////////////////
		function setMode(basemapType) {
			map.setBasemapType(basemapType);
		}
		///////////////////////지도 메뉴바/////////////////////////////////////
		var options = {
			map : map, //메뉴생성할 맵
			site : vw.ol3.SiteAlignType.TOP_LEFT //메뉴바 위치
			,
			vertical : true,
			collapsed : false,
			collapsible : false
		};

		var _toolBtnList = [ new vw.ol3.button.Init(map),
				new vw.ol3.button.Distance(map), new vw.ol3.button.Area(map) ];
		var toolBar = new vw.ol3.control.Toolbar(options);
		toolBar.addToolButtons(_toolBtnList);
		map.addControl(toolBar);

		/* 마커옵션
		$(document).on('click','#mkOption',function(){
				$("#mk_option").each(function (a){		
					$(this).find('input:checked').each(function(){
						let imgCnt = $('input:checkbox[id="mkImg"]:checked').length;
						var imgsrc= $(this).val();
						if(imgCnt==1){
							console.log(imgsrc);
						}else if(imgCnt>1){
							alert('1개만 선택 해주세요.');
						}
					});
				});
			});
		 */
		//////////////////////클릭하는 맵 좌표///////////////////////////////////
		map.on('click', function(evt) {
			//var lonlat = ol.proj.transform(evt.coordinate, 'EPSG:3857', 'EPSG:4326');
			let coordinate = evt.coordinate;

			document.getElementById('mousex').value = coordinate[0]; /* x축 */
			document.getElementById('mousey').value = coordinate[1]; /* y축 */
		})

		var markerSource = new ol.source.Vector();
		function mKstop() {
			alert('마커 종료');
			map.on();

		}
		function mKadd(event) {
			$("#mk_option").show();
			alert('마커 옵션을 선택 해주세요');
			//var test = document.getElementById('mousex').value;
			//var testy = document.getElementById('mousey').value;

			xyv();
		}
		function xyv() {
			map.on('click', function(evt) {
				//var lonlat = ol.proj.transform(evt.coordinate, 'EPSG:3857', 'EPSG:4326');
				let xyv = evt.coordinate;
				addMarker(xyv);
			})
		}
		//마커 등록하기 함수
		function addMarker(xyv) {

			let imgLength = $('input:checkbox[id="mkImg"]:checked').length;
			let imgsrc = $('input:checkbox[id="mkImg"]:checked').val();

			if (imgLength != 1) {
				alert("1개만 선택해주세요, 다중선택시 검정마커로 적용됩니다.");
			}
			//Point 좌표 등록
			var point_feature = new ol.Feature({
				geometry : new ol.geom.Point([ xyv[0], xyv[1] ])
			});

			//markerSource에 등록한 point를 담는다. addFeature를 이용해서, 여러개의 point를 source에 담는다.
			markerSource.addFeature(point_feature);
			//style을 활용해서, point의 style을 변경한다.
			var markerStyle = new ol.style.Style({
				image : new ol.style.Icon({ //마커 이미지
					opacity : 1, //투명도 1=100% 
					scale : 0.060,
					//marker 이미지, 해당 point를 marker로 변경한다.
					src : imgsrc
				//src : "<c:url value='/images/egovframework/example/marker1.png'/>"
				}),
				zindex : 10
			});
			// 마커 레이어 생성
			markerLayer = new ol.layer.Vector({
				source : markerSource, //마커 feacture들
				style : markerStyle
			//마커 스타일
			});

			// 지도에 마커가 그려진 레이어 추가
			map.addLayer(markerLayer);
		}

		$(function () {
			var wmsSource = new ol.source.TileWMS({
			    url: 'http://localhost:8090/geoserver/cite/wms',
			    params: { 'LAYERS': 'cite:li'},
			    serverType: 'geoserver',
			    crossOrigin: 'anonymous'
			});
		
		
			var wmsLayer = new ol.layer.Tile({
			    source: wmsSource
			});
			
			var view = new ol.View({
			    center: [0, 0],
			    zoom: 3
			});
			
			var map = new ol.Map({
			    layers: [wmsLayer],
			    target: 'map',
			    view: view
			});
			
			map.on('singleclick', function (evt) {
			    document.getElementById('info').innerHTML = '';
			    
			    var viewResolution = view.getResolution();
			    var url = wmsSource.getGetFeatureInfoUrl(
			        evt.coordinate, viewResolution, 'EPSG:3857',
			        { 'INFO_FORMAT': 'text/html' }
			    );
			    
			    if (url) {
			        document.getElementById('info').innerHTML =
			            '<iframe width="100%" seamless="" src="' + url + '"></iframe>';
			    }
			});
		});
		
		//

		/*
				
		function importWMS() {
			hMap = map.ImportWMSLayer('li', {
				url : 'http://localhost:8090/geoserver/cite/wms',
				layers : 'cite:li',
				version : '1.1.0',
				style : '',
				crs : 'EPSG:900913',
				srs : 'ESPG:3857',
				format : 'image/png'
			});
			alert('test');
			map.addLayer(hMap);
			console.log(hMap);
		}
		
		//addMarker();
		 function mKadd(event){
		 $("#mk_option").show();
		 alert('마커 옵션을 선택 해주세요');
		
		 var xy = map.on('click', function(evt) {
		 //var lonlat = ol.proj.transform(evt.coordinate, 'EPSG:3857', 'EPSG:4326');
		 let xyv = evt.coordinate;
		 addMarker(xyv);
		 })	
		 }

		 //마커 등록하기 함수
		 function addMarker(xyv) {			
		 let imgLength = $('input:checkbox[id="mkImg"]:checked').length;
		 let imgsrc = $('input:checkbox[id="mkImg"]:checked').val();
		 //console.log('imgLength+'+imgLength);
		 if(imgLength != 1){
		 alert("1개만 선택해주세요, 다중선택시 검정마커로 적용됩니다.");
		 }
		 //Point 좌표 등록
		 var point_feature = new ol.Feature({
		 geometry : new ol.geom.Point([ xyv[0], xyv[1] ])
		 });
		
		 //markerSource에 등록한 point를 담는다. addFeature를 이용해서, 여러개의 point를 source에 담는다.
		 markerSource.addFeature(point_feature);
		 //style을 활용해서, point의 style을 변경한다.
		 var markerStyle = new ol.style.Style({
		 image : new ol.style.Icon({ //마커 이미지
		 opacity : 1, //투명도 1=100% 
		 scale:0.065,
		 //marker 이미지, 해당 point를 marker로 변경한다.
		 src : imgsrc					
		 //src : "<c:url value='/images/egovframework/example/marker1.png'/>"
		 }),
		 zindex : 10
		 });
		 // 마커 레이어 생성
		 markerLayer = new ol.layer.Vector({
		 source : markerSource, //마커 feacture들
		 style : markerStyle			//마커 스타일
		 });

		 // 지도에 마커가 그려진 레이어 추가
		 map.addLayer(markerLayer);
		 }
		 */
	</script>
</html>