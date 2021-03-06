<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<title>2D MAP 기능구현 홍정범</title>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/gh/openlayers/openlayers.github.io@master/en/v6.5.0/css/ol.css"
	type="text/css">
<script
	src="https://cdn.jsdelivr.net/gh/openlayers/openlayers.github.io@master/en/v6.5.0/build/ol.js"></script>
<script src="https://code.jquery.com/jquery-2.2.3.min.js"></script>

<script
	src="https://cdn.polyfill.io/v2/polyfill.min.js?features=requestAnimationFrame,Element.prototype.classList,URL"></script>

<style type="text/css">
* {
	margin: 0;
	padding: 0;
	list-style: none;
	text-decoration: none;
}

body {
	
}
/*지오서버 정보표출창*/
#info {
	opacity: 0.7;
	position: absolute;
	top: 68%;
	z-index: 99;
	border-radius: 10px;
}
/* 지오서버의 정보표출 테이블*/
table.featureInfo {
	
}

table.featureInfo caption {
	display: none;
}
/*팝업옵션*/
#pop {
	position: absolute;
	top: 15%;
	left: 83%;
	border-radius: 10px;
	z-index: 99;
	background-color: #696868;
	height: 250px;
	opacity: 0.85;
	color: white;
}

/*메뉴옵션*/
.wrapper {
	opacity: 0.7;
	position: absolute;
	top: 55%;
	left: 90%;
	transform: translate(-50%, -50%);
	z-index: 99;
}

.mainMenu {
	width: 250px;
	display: block;
	border-radius: 10px;
	overflow: hidden;
}

.item {
	border-top: 1px solid #696868;
	overflow: hidden;
}

.btn {
	display: block;
	padding: 15px 20px;
	background-color: #696868;
	color: #fff;
	position: relative;
}

.btn:before {
	content: '';
	position: absolute;
	width: 0;
	height: 0;
	border-left: 8px solid transparent;
	border-right: 8px solid transparent;
	border-top: 10px solid #696868;
	right: 15px;
	bottom: -10px;
	z-index: 9;
}

.btn i {
	margin-right: 10px;
}

.subMenu {
	background: #273057;
	overflow: hidden;
	transition: max-height 0.7s;
	max-height: 0;
}

.subMenu a {
	display: block;
	padding: 15px 20px;
	color: #fff;
	font-size: 14px;
	border-bottom: 1px solid #394c7f;
	position: relative;
}

.subMenu a:before {
	content: '';
	opacity: 0;
	transition: opacity 0.3s;
}

.subMenu a:hover:before {
	content: '';
	position: absolute;
	height: 0;
	width: 6px;
	left: 0;
	top: 0;
	opacity: 1;
	/* background-color: #d8d824; */
	border-top: 24px solid transparent;
	border-left: 11px solid #fcdc29;
	border-bottom: 24px solid transparent;
}

.subMenu a:after {
	content: '';
	opacity: 0;
	transition: opacity 0.3s;
}

.subMenu a:hover:after {
	content: '';
	position: absolute;
	height: 0;
	width: 6px;
	right: 0px;
	top: 0;
	opacity: 1;
	/* background-color: #d8d824; */
	border-top: 24px solid transparent;
	border-right: 11px solid #fcdc29;
	border-bottom: 24px solid transparent;
}

.subMenu a:hover {
	background: #273057;
	background: -moz-linear-gradient(top, #273057 0%, #273057 50%, #394c7f 51%, #394c7f
		100%);
	background: -webkit-linear-gradient(top, #273057 0%, #273057 50%, #394c7f 51%,
		#394c7f 100%);
	background: linear-gradient(to bottom, #273057 0%, #273057 50%, #394c7f 51%, #394c7f
		100%);
	filter: progid:DXImageTransform.Microsoft.gradient( startColorstr='#273057',
		endColorstr='#394c7f', GradientType=0);
	transition: all 0.3s;
	border-bottom: 1px solid #394c7f;
}

.subMenu a:last-child {
	border: none;
}

.item:target .subMenu {
	max-height: 10em;
}
/*마우스 옵션*/
.tooltip {
	position: relative;
	background: rgba(0, 0, 0, 0.5);
	border-radius: 4px;
	color: white;
	padding: 4px 8px;
	opacity: 0.7;
	white-space: nowrap;
}

.tooltip-measure {
	opacity: 1;
	font-weight: bold;
}

.tooltip-static {
	background-color: #ffcc33;
	color: black;
	border: 1px solid white;
}

.tooltip-measure:before, .tooltip-static:before {
	border-top: 6px solid rgba(0, 0, 0, 0.5);
	border-right: 6px solid transparent;
	border-left: 6px solid transparent;
	content: "";
	position: absolute;
	bottom: -6px;
	margin-left: -7px;
	left: 50%;
}

.tooltip-static:before {
	border-top-color: #ffcc33;
}
/* 지도 */
.ol-mycontrol {
	background-color: rgba(241, 12, 43, 0.4);
	border-radius: 4px;
	padding: 4px;
	margin-left: 10px;
	position: block;
	width: 85px;
	top: 30px;
	left: 60px;
}

.ol-mycontrol button {
	float: left;
}

.ol-mycontrol button.on {
	background-color: rgba(124, 60, 55, .5);
}

.ol-attribution {
	display: none;
}
</style>

</head>
<body>
	<header style="text-align: center; font-size: 50px;"> 신입개발과제 -
		홍정범 </header>
	<hr>

	<div id="map" style="width: 100%; height: 700px; left: 0px; top: 0px">
		<!-- 검색 폼  -->
		<div style="z-index: 99;">
			<form id="searchForm" action="#" class="form_data"
				onsubmit="return false;search();">
				<input type="hidden" name="page" value="1" /> <input type="hidden"
					name="type" value="address" /> <input type="hidden" name="request"
					value="search" /> <input type="hidden" name="size" value="100" />
				<input type="hidden" name="apiKey"
					value="10036FCE-3940-374C-B2ED-E6FBDF47CFA9" /> <input
					type="hidden" name="domain" value="http://localhost:8080" /> <input
					type="hidden" name="crs" value="EPSG:3857" />
				<div>
					<input type="text" id="searchValue" name="query"
						value="대구광역시 수성구 알파시티1로 31길 2" style="width: 300px;" />
					<button type="button" onclick="javascript:search();">검색</button>
					<select name="category">
						<option value="road">도로명</option>

						<option value="parcel">지번</option>
					</select>
				</div>
			</form>
		</div>
		<div id="searchMarker" style="margin-left: 60px;">
			<label><input type="checkbox" id="mkImg"
				value="http://map.vworld.kr/images/ol3/marker_blue.png" checked="on">
				<img src="http://map.vworld.kr/images/ol3/marker_blue.png" /> <input
				type="checkbox" id="mkImg"
				value="http://map.vworld.kr/images/ol3/marker.png"> <img
				src="http://map.vworld.kr/images/ol3/marker.png" /> </label>
		</div>
	</div>
	<div id="info" style="top: 75%; left: 50%;"></div>
	<!-- form class="form-inline">
		<label>Measurement type &nbsp;</label> <select id="type">
			<option value="length">Length (LineString)</option>
			<option value="area">Area (Polygon)</option>
			<option value="Point">Point</option>
			<option value="Circle">Circle</option>
			<option value="Select">선택</option>
		</select>
	</form-->
	<div class="wrapper">
		<ui class="mainMenu">
		<li class="item" id="account"><a href="#account" class="btn"><i
				class="fas fa-user-circle"></i>OPENLAYERS</a>
			<div class="subMenu">
				<form class="form-inline">
					<!-- <label>Measurement type &nbsp;</label>  -->
					<select id="type">
						<option value="length">거리측정</option>
						<option value="area">면적측정</option>
						<option value="Point" selected>마커</option>
						<!-- <option value="Circle">Circle</option> -->
						<option value="Select">선택</option>
					</select>
				</form>
				<span style="color: white;"> 작업제목 <input type="text"
					id="subj" /> 작업내용 <textarea id="cont"></textarea>
				</span>
				<button type="button" onclick="javascript:all_delete();">모두삭제</button>

			</div></li>
		<li class="item" id="about"><a href="#about" class="btn"><i
				class="fas fa-address-card"></i>GEOSERVER</a>
			<div class="subMenu">

				<button type="button" onclick="javascript:sig();" name="importwms">'시군구'
					주제도</button>
				<button type="button" onclick="javascript:sigdelete();"
					name="importwms">'시군구' 삭제</button>
				<br>
				<button type="button" onclick="javascript:ctp();" name="importwms">'시도'
					주제도</button>
				<button type="button" onclick="javascript:ctpdelete();"
					name="importwms">'시도' 삭제</button>
				<br>
				<button type="button" onclick="javascript:iconOn();"
					name="importwms">'졸음쉼터 on'</button>
				<button type="button" onclick="javascript:iconOff();"
					name="importwms">'졸음쉼터 off'</button>
				<br>
			</div></li>
		</ui>
	</div>
	<!-- div>
		작업제목 <input type="text" id="subj" /> 작업내용
		<textarea id="cont"></textarea>
	</div-->
	<div id="mouseCoordinate" style="text-align: center; margin-top: 70px;">현재
		마우스좌표</div>
	<div id="pop" style="width: 300px; display: none;"></div>
	<!-- div>
      <label><input type="checkbox" id="mkImg"
			value="<c:url value='http://map.vworld.kr/images/ol3/marker_blue.png'/>"
			checked="on"> 
			<img style="width: 50px; height: 50px;"src="<c:url value='http://map.vworld.kr/images/ol3/marker_blue.png'/>"
			alt="" /> </label>
			<label><input type="checkbox" id="mkImg"
			value="<c:url value='http://map.vworld.kr/images/ol3/marker.png'/>">
			<img style="width: 50px; height: 50px;"src="<c:url value='http://map.vworld.kr/images/ol3/marker.png'/>"
			alt="" /> </label>
			<label><input type="checkbox" id="mkImg"
			value="<c:url value='https://openlayers.org/en/v3.20.1/examples/data/icon.png'/>">
			<img style="width: 50px; height: 50px;"src="<c:url value='https://openlayers.org/en/v3.20.1/examples/data/icon.png'/>"
			alt="" /> </label>
      </div-->
	<div>

		<!-- 데이터 API 폼  -->
		<form id="dataForm">
			<input type="hidden" name="key"
				value="10036FCE-3940-374C-B2ED-E6FBDF47CFA9"> <input
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
	<div style="padding: 10px;">
		<!-- P class="noticePrev">검색결과 -->
		<p class="notice" style="display: none; color: red;">클릭시 해당 좌표로
			이동합니다
		<hr>
		</p>
		<p id="result_count" style="text-align: center;"></p>
		<ul id="result_ajax">
			<!--검색결과 ajax 장소, count 개수-->
			<li></li>
		</ul>

		<p id="result_pos"></p>
	</div>
	<label><input type="checkbox" id="loadview" value="1">로드뷰
		보기</label>
	<button type="button" onclick="javascript:test2();">ㅅㄷㄴㅅ2</button>
	



	<script>
	
	function test2(){
		
		
        var checkloadview=$('input:checkbox[id="loadview"]:checked').length;
        console.log(checkloadview);
        if(checkloadview >0){
            map.on('singleclick', function(event) {
    
            // 마우스 커서 아래의 좌표값 구하기
            var coordinate = event.coordinate;
            lon = coordinate[0];
            lat = coordinate[1];
            var tansform = ol.proj.transform([lon,lat], 'EPSG:3857', 'EPSG:4326')// 브이월드 좌표계에서 다음 지도 좌표계로 변환 EPSG:3857=>EPSG:4326
            console.log(tansform);
            var loadview="https://map.kakao.com/link/roadview/"+tansform[1]+","+tansform[0];   // 로드뷰 불러오기
            window.open(loadview, '로드뷰팝업', 'width=500, height=700, scrollbars=yes, resizable=no')
            
            });
            
            
        }else if(checkloadview=0){
        	
        }
    }
	// 지오서버 wms//
	var sigWms = new ol.layer.Tile({
            opacity:0.5,
            
            source : new ol.source.TileWMS({
                url : 'http://localhost:8090/geoserver/cite/wms?service=WMS', // 1. 레이어 URL
                params : {
                    'VERSION' : '1.1.0', // 2. 버전
                    'LAYERS' : 'cite:Sigoracle', // 3. 작업공간:레이어 명
                    
                    'SRS' : 'EPSG:3857', // SRID
                    'FORMAT' : 'image/png' // 포맷
                },
                
                serverType : 'geoserver',
            })
        });
        var ctpWms = new ol.layer.Tile({
            opacity:0.5,
            source : new ol.source.TileWMS({
                url : 'http://localhost:8090/geoserver/cite/wms?service=WMS', // 1. 레이어 URL
                params : {
                    'VERSION' : '1.1.0', // 2. 버전
                    'LAYERS' : 'cite:CTPRVN_INFO', // 3. 작업공간:레이어 명
                    
                    'SRS' : 'EPSG:3857', // SRID
                    'FORMAT' : 'image/png' // 포맷
                },
                
                serverType : 'geoserver',
            })
        });
        var iconWms = new ol.layer.Tile({
            opacity:1,
            
            
            source : new ol.source.TileWMS({
                url : 'http://localhost:8090/geoserver/cite/wms?service=WMS', // 1. 레이어 URL
                params : {
                    'VERSION' : '1.1.0', // 2. 버전
                    'LAYERS' : 'cite:SQLicon', // 3. 작업공간:레이어 명
                    
                    'SRS' : 'EPSG:3857', // SRID
                    'FORMAT' : 'image/png' // 포맷
                },
                
                serverType : 'geoserver',
            })
        });
           

    function sig(){
        map.addLayer(sigWms);
    }
	function ctp(){
       
        map.addLayer(ctpWms);
    }
	function iconOn(){
        
        map.addLayer(iconWms);
        //icon 의 정보 불러오기
            var view = map.getView();	
            map.on('singleclick', function (evt) {	//클릭할시
            document.getElementById('info').innerHTML = ''; //html에 생성된 info라는 div에 정보를 표출함.
                var viewResolution = /** @type {number} */ (view.getResolution());
                var source = iconWms.getSource();	//표출되어있는 wms의 소스를 저장
                var url = source.getFeatureInfoUrl(	//getFeautreInfoUrl을 통하여 정보를 url로 뽑아냄 
                    evt.coordinate,
                    viewResolution,
                    'EPSG:3857',
                    {'INFO_FORMAT': 'text/html'}
                );
                //console.log(url);
                if (url) {
                    fetch(url)
                    .then((response) => response.text())
                    .then((html) => {
                        document.getElementById('info').innerHTML = html;
                    });
                }
            });


        
    }
    function sigdelete(){
            map.removeLayer(sigWms);            
    }
    function ctpdelete(){
            map.removeLayer(ctpWms);            
    }
    function iconOff(){
            map.removeLayer(iconWms);            
    }
	
	
	function all_delete(){
        map.getLayers().forEach(layer => layer.getSource().refresh());
        map.getOverlays().getArray().slice(0).forEach(function(overlay) {
            map.removeOverlay(overlay);
            });
    }
	
	var VworldBase,VworldSatellite,/*VworldGray,VworldMidnight,*/VworldHybrid;
	var attr = '&copy; <a href="">EGIS홍정범</a>';
	var VworldHybrid = new ol.source.XYZ({
		url: 'http://api.vworld.kr/req/wmts/1.0.0/10036FCE-3940-374C-B2ED-E6FBDF47CFA9/Hybrid/{z}/{y}/{x}.png'
	}); //문자 타일 레이어
	
	var VworldSatellite = new ol.source.XYZ({
		url: 'http://api.vworld.kr/req/wmts/1.0.0/10036FCE-3940-374C-B2ED-E6FBDF47CFA9/Satellite/{z}/{y}/{x}.jpeg'
		,attributions : attr
	}); //항공사진 레이어 타일

	var VworldBase = new ol.source.XYZ({
		url: 'http://api.vworld.kr/req/wmts/1.0.0/10036FCE-3940-374C-B2ED-E6FBDF47CFA9/Base/{z}/{y}/{x}.png'
		,attributions : attr
	}); // 기본지도 타일

	/*
		control 설정
	*/
	
	var base_button = document.createElement('button');
	base_button.innerHTML = 'B';
	var hybrid_button = document.createElement('button');
	hybrid_button.innerHTML = 'H';
	hybrid_button.className='on';
	var sate_button = document.createElement('button');
	sate_button.innerHTML = 'S';
    var element = document.createElement('div');
    element.className = 'rotate-north ol-unselectable ol-control ol-mycontrol';
    
    base_button.onclick=function(){
        map.getLayers().forEach(function(layer){
			if(layer.get("name")=="vworld"){
				layer.setSource(VworldBase)
			}
	    })
    }
    sate_button.onclick=function(){
        map.getLayers().forEach(function(layer){
			if(layer.get("name")=="vworld"){
				layer.setSource(VworldSatellite)
			}
	    })
    }
    hybrid_button.onclick=function(){
    	var _this = this;
   		map.getLayers().forEach(function(layer){
   			if(layer.get("name")=="hybrid"){
   				if(_this.className == "on"){
    				layer.setSource(null)
    				_this.className ="";
   				}else{
   					_this.className ="on";
   					
   					layer.setSource(VworldHybrid)
   				}
   			}
   	    })
    }
    
    
    element.appendChild(base_button);
    element.appendChild(sate_button);
    element.appendChild(hybrid_button);
    
    
    var layerControl = new ol.control.Control({element: element});
////////////////////////////////////////////////
    var source = new ol.source.Vector({
          id: "sourceId"
        });
        source.set("name", "sourceName");

        var vector = new ol.layer.Vector({
          id: "vectorId",
          source: source,
          style: new ol.style.Style({
            fill: new ol.style.Fill({
              color: 'rgba(52, 0, 0, 0.35)'
            }),
            stroke: new ol.style.Stroke({
              color: '#000',
              width: 4
            }),
            image: new ol.style.Icon(({
              anchor: [0.5, 10],
              anchorXUnits: 'fraction',
              anchorYUnits: 'pixels',
              src: 'http://map.vworld.kr/images/ol3/marker_blue.png' //'https://openlayers.org/en/v3.20.1/examples/data/icon.png' 'http://map.vworld.kr/images/ol3/marker.png'
            }))

          })
        });
        vector.set("name", "vectorName");
        vector.setZIndex(1000);

        var sketch;

        var helpTooltipElement;

        var helpTooltip;

        var measureTooltipElement;

        var measureTooltip;

        var continuePolygonMsg = '폴리곤을 그리시오(두번클릭시 종료)';

        var continueLineMsg = '선을 그리시오(두번클릭시 종료)';


        var pointerMoveHandler = function (evt) {
          if (evt.dragging) {
            return;
          }
          var helpMsg = '지도를 움직이세요.';

          if (sketch) {
            var geom = (sketch.getGeometry());
            if (geom instanceof ol.geom.Polygon) {
              helpMsg = continuePolygonMsg;
            } else if (geom instanceof ol.geom.LineString) {
              helpMsg = continueLineMsg;
            }
          }

          helpTooltipElement.innerHTML = helpMsg;
          helpTooltip.setPosition(evt.coordinate);

          helpTooltipElement.classList.remove('hidden');
        };

            ///////////////////////////////////////////////
            var mouseControlCoordinate = new ol.control.MousePosition({
			coordinateFormat : new ol.coordinate.createStringXY(4),
			projection : 'EPSG:3857',//좌표계 설정
			className : 'mposition', //css 클래스 이름
			target : document.getElementById('mouseCoordinate'),//좌표를 뿌릴 element
		});
            /////////////////////////////////////////////
            
    
	map = new ol.Map({
		controls: ol.control.defaults().extend([
			layerControl,mouseControlCoordinate/*new ol.control.OverviewMap(),new ol.control.ZoomSlider()*/
		]),
		layers: [
			new ol.layer.Tile({
				source: new ol.source.OSM(),
				name:"OSM"
			})
			,new ol.layer.Tile({
				source: VworldSatellite,
				name:"vworld"
			}),new ol.layer.Tile({
				source: VworldHybrid,
				name:"hybrid"
			}),
			vector
		],
		target: 'map',
		view: new ol.View({
			center: ol.proj.transform([14251786.1081, 4326774.9796], 'EPSG:3857', 'EPSG:900913'),
			zoom: 7,
			minZoom : 7,
			maxZoom : 21
		})
	});
            
//////////////////////////////////////////////////
	var markerSource; //검색시 생성되는 마커 -> 기존에 마커를 삭제하기 위하여 search function 밖에서 값 생성
	
	var search = function(){
		
        
        if(markerSource==null){ //첫 검색시 마커소스가 null 임으로 새로운 벡터레이어 생성
            markerSource = new ol.source.Vector();
        }else if(markerSource !=null){ //전에 검색해서 생성된 레이어 모두 삭제
            markerLayer.getSource().clear();
        }
        markerSource.set("name","마커레이어");
		
        let imgLength = $('input:checkbox[id="mkImg"]:checked').length;
        let imgsrc = $('input:checkbox[id="mkImg"]:checked').val();
        if(imgLength != 1){
            alert('마커를 한개만 선택하여주세요.');
            return false;
        }else if(imgLength =1){
            //style을 활용해서, point의 style을 변경한다.
            var markerStyle = new ol.style.Style({
                image: new ol.style.Icon({ //마커 이미지
                    opacity: 1, //투명도 1=100% 
                    scale: 1, //크기 1=100%

                    //marker 이미지, 해당 point를 marker로 변경한다.
                    src: imgsrc
                    //'https://openlayers.org/en/v3.20.1/examples/data/icon.png'
                }),
                //html의 css, z-index 기능이다.
                zindex: 1300
            });
        }
        
			$.ajax({
				type: "get",
				url: "https://api.vworld.kr/req/search",
				data : $('#searchForm').serialize(),
				dataType: 'jsonp',
				async: false,
				success: function(data) {
					var features = new Array();
					if(data.response.status =="NOT_FOUND"){
						alert("검색결과가 없습니다.");
					}else{
						$('p.notice').show();
						//$('p.noticePrev').hide();
						var result_html ="";
						var marker_html ="";
						for(var o in data.response.result.items){ 
							var marker_html ="";
							/*if(o==0){			//검색 결과가있을시 검색결과의 첫번째 값 좌표로 이동
								move(data.response.result.items[o].point.x*1,data.response.result.items[o].point.y*1);
							}*/
							var x = data.response.result.items[o].point.x*1;
	                        var y = data.response.result.items[o].point.y*1
	                        var point_feature = new ol.Feature({
	                            geometry: new ol.geom.Point([x, y]).transform('EPSG:900913', 'EPSG:3857')
	                        });
	                        
	                        var title = data.response.result.items[o].address.bldnm
							var contents = data.response.result.items[o].address.road
							var cont = "2"; //내용이없을경우 팝업 제외하기위하여 추가 검색시 생성되는 마커는 모두 내용이 있음으로 cont 내용을 추가함
	                        marker_html += "<span> 장소 :"+title+"<hr>도로명 :"+ contents+"</span>";
	                        point_feature.set("subj",marker_html);
	                        point_feature.set("cont",cont);
	                       
	                        /*let imgLength = $('input:checkbox[id="mkImg"]:checked').length;
	                        let imgsrc = $('input:checkbox[id="mkImg"]:checked').val();
	                        if(imgLength != 1){
	                            alert('마커를 한개만 선택하여주세요.');
	                            return false;
	                        }else if(imgLength =1){
	                            //style을 활용해서, point의 style을 변경한다.
	                            var markerStyle = new ol.style.Style({
	                                image: new ol.style.Icon({ //마커 이미지
	                                    opacity: 1, //투명도 1=100% 
	                                    scale: 1, //크기 1=100%

	                                    //marker 이미지, 해당 point를 marker로 변경한다.
	                                    src: imgsrc
	                                    //'https://openlayers.org/en/v3.20.1/examples/data/icon.png'
	                                }),
	                                //html의 css, z-index 기능이다.
	                                zindex: 1001
	                            });
	                        }*/
	                       /*
	                        var subj = data.response.result.items[o].address.road
	                        var cont = data.response.result.items[o].address.parcel
	                        marker_html += "<span> <hr>도로명 :" + subj + "<hr>지번 :"+ cont + "</span>";
	                        console.log(marker_html);
	                        point_feature.set("subj", marker_html);
	                        */
	                        //point_feature.set("cont", cont);
	                        
	                        //markerSource에 등록한 point를 담는다. addFeature를 이용해서, 여러개의 point를 source에 담는다.
	                            markerSource.addFeature(point_feature);
	                       
	                            // 마커 레이어 생성
	                            markerLayer = new ol.layer.Vector({
	                                source: markerSource, //마커 feacture들
	                                style: markerStyle, //마커 스타일
	                                zindex: 1300
	                            });
	                           
							
							result_html += "<hr><li><p onclick='move("+data.response.result.items[o].point.x+","+data.response.result.items[o].point.y+
									")'> 도로명: "+ data.response.result.items[o].address.road +
									" 지번: "+ data.response.result.items[o].address.parcel +"  </p></li>";
							
						}
						map.addLayer(markerLayer);
						
						//console.log(result_html);
						$('#result_ajax').html(result_html);  //result_ajax 라는 id 값이 있는곳의 html을 수정한다 
						$('#result_count').text(data.response.record.total+"건이 검색되었습니다.");
						alert(data.response.record.total+"건이 검색되었습니다.");
						
					}
					
					
				},
				complete:function(){
					
				},
				error: function(xhr, stat, err) {}
			});
			
			
		}

		var move = function(x,y){
			map.getView().setCenter([ x, y ]); // 지도 이동
			map.getView().setZoom(17); // 줌레벨 설정
			//검색마커생성
			//console.log(test);
			
		}



//////////////////////////////////////////////////
    map.on('pointermove', pointerMoveHandler);

    map.getViewport().addEventListener('mouseout', function () {
        helpTooltipElement.classList.add('hidden');
    });

    var typeSelect = document.getElementById('type');

    var draw; 


    var formatLength = function (line) {
        var length = ol.sphere.getLength(line);
        var output;
        if (length > 100) {
            output = (Math.round(length / 1000 * 100) / 100) +
                ' ' + 'km';
        } else {
            output = (Math.round(length * 100) / 100) +
                ' ' + 'm';
        }
        return output;
    };


    var formatArea = function (polygon) {
        var area = ol.sphere.getArea(polygon);
        var output;
        if (area > 10000) {
            output = (Math.round(area / 1000000 * 100) / 100) +
                ' ' + 'km<sup>2</sup>';
        } else {
            output = (Math.round(area * 100) / 100) +
                ' ' + 'm<sup>2</sup>';
        }
        return output;
    };

    function addInteraction() {
        var type = '';
        if (typeSelect.value == 'area') {
            type = 'Polygon';
        } else if (typeSelect.value == 'length') {
            type = 'LineString';
        } else if (typeSelect.value == 'Circle') {
            type = 'Circle';
        } else if (typeSelect.value == 'Point') {
            type = 'Point';
        } else if (typeSelect.value == 'Select') {
            var select; 
            select = new ol.interaction.Select({
                //condition: ol.events.condition.pointerMove
                condition: ol.events.condition.click
                
            })
            select.set("이벤트", "선택");
            select.on("select", function (evt) {
                var length = evt.target.getFeatures().getLength();
                var popContent="";
                if (length > 0) {
                    //console.log(length);
                    subj = evt.target.getFeatures().getArray()[0].get("subj"); //객체에 저장된 제목과 내용 찾은후 저장
                    cont = evt.target.getFeatures().getArray()[0].get("cont");	//내용이없을 경우를 위하여 추가
                    //document.getElementById('subj').value = subj; //저장된 내용을 표출
                    //document.getElementById('cont').value = cont;
                    //var test=select.condition();
                    var features = evt.target.getFeatures().getArray();
                    var xy=features[0].getGeometry().getCoordinates();
                    var checkloadview=$('input:checkbox[id="loadview"]:checked').length;
                    lon= xy[0];
                    lat= xy[1];
                    console.log(lon+'test'+lat);
                    if(checkloadview >0){
                    	
                        var tansform = ol.proj.transform([lon,lat], 'EPSG:3857', 'EPSG:4326')// 브이월드 좌표계에서 다음 지도 좌표계로 변환 EPSG:3857=>EPSG:4326
                        console.log(tansform);
                        var loadview="https://map.kakao.com/link/roadview/"+tansform[1]+","+tansform[0];   // 로드뷰 불러오기
                        window.open(loadview, '로드뷰팝업', 'width=500, height=700, scrollbars=yes, resizable=no')
                        
                        }
                        
                        
                    }
                    if(cont !=''){
                        $('#pop').show();
                    }else if(cont ==''){
                        $('#pop').hide();
                    }
                    popContent += subj;
                        $('#pop').html(popContent);
                
            })

            map.addInteraction(select);
            return;
        }

        draw = new ol.interaction.Draw({ //맵에 그리기 완료 후 맵에 표기
            source: source,
            type: type,
            style: new ol.style.Style({
                fill: new ol.style.Fill({
                    color: 'rgba(255, 255, 255, 0.2)'
                }),
                stroke: new ol.style.Stroke({
                    color: 'rgba(0, 0, 0, 0.5)',
                    lineDash: [10, 10],
                    width: 5
                }),
                image: new ol.style.Circle({
                    radius: 5,
                    stroke: new ol.style.Stroke({
                        color: 'rgba(0, 0, 0, 0.7)'
                    }),
                    fill: new ol.style.Fill({
                        color: 'rgba(255, 255, 255, 0.2)'
                    })
                })
            })
        });
        map.addInteraction(draw);

        createMeasureTooltip();
        createHelpTooltip();

        var listener;
        draw.on('drawstart',
            function (evt) {
                sketch = evt.feature;

                var tooltipCoord = evt.coordinate;

                listener = sketch.getGeometry().on('change', function (evt) {
                    var geom = evt.target;
                    var output;
                    if (geom instanceof ol.geom.Polygon) {
                        output = formatArea(geom);
                        tooltipCoord = geom.getInteriorPoint().getCoordinates();
                    } else if (geom instanceof ol.geom.LineString) {
                        output = formatLength(geom);
                        tooltipCoord = geom.getLastCoordinate();
                    } else if (geom instanceof ol.geom.Circle) {//거리계산 구현
                        var length = ol.sphere.getDistance(ol.proj.transform(geom.getCenter(), 'EPSG:900913', 'EPSG:3857'), ol.proj.transform(geom.getLastCoordinate(), 'EPSG:900913', 'EPSG:3857'), 6378137)
                        if (length > 100) {
                            output = (Math.round(length / 1000 * 100) / 100) +
                                ' ' + 'km';
                        } else {
                            output = (Math.round(length * 100) / 100) +
                                ' ' + 'm';
                        }
                        tooltipCoord = geom.getLastCoordinate();
                    }
                    measureTooltipElement.innerHTML = output;
                    measureTooltip.setPosition(tooltipCoord);
                });
            }, this);

        draw.on('drawend',
            function (evt) {
                feature = evt.feature;
                var subj = document.getElementById('subj').value
                var cont = document.getElementById('cont').value

                var marker_html="";
                marker_html+= "<span>작업 제목 :"+subj+"<hr>작업 내용 :"+cont+"<span>";
                
                
                feature.set("subj",marker_html);
                feature.set("cont",cont);
                
                measureTooltipElement.className = 'tooltip tooltip-static';
                measureTooltip.setOffset([0, -7]);
                // unset sketch
                sketch = null;
                // unset tooltip so that a new one can be created
                measureTooltipElement = null;
                createMeasureTooltip();
                ol.Observable.unByKey(listener);
            }, this);


    }


    function createHelpTooltip() {
        if (helpTooltipElement) {
            helpTooltipElement.parentNode.removeChild(helpTooltipElement);
        }
        helpTooltipElement = document.createElement('div');
        helpTooltipElement.className = 'tooltip hidden';
        helpTooltip = new ol.Overlay({
            element: helpTooltipElement,
            offset: [15, 0],
            positioning: 'center-left'
        });
        map.addOverlay(helpTooltip);
    }


    function createMeasureTooltip() {
        if (measureTooltipElement) {
            measureTooltipElement.parentNode.removeChild(measureTooltipElement);
        }
        measureTooltipElement = document.createElement('div');
        measureTooltipElement.className = 'tooltip tooltip-measure';
        measureTooltip = new ol.Overlay({
            element: measureTooltipElement,
            offset: [0, -15],
            positioning: 'bottom-center'
        });
        map.addOverlay(measureTooltip);
    }


    typeSelect.onchange = function () {
        map.removeInteraction(draw);
        map.getInteractions().getArray().forEach(function (i) {
            if (i.get("이벤트") == "선택") {
                map.removeInteraction(i);
            }
        })
        addInteraction();
    };

    addInteraction();
    </script>
</body>
</html>