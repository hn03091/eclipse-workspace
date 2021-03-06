<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<body>
<head>
<meta charset="UTF-8">
<title>과제</title>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/gh/openlayers/openlayers.github.io@master/en/v6.5.0/css/ol.css"
	type="text/css">
<script
	src="https://cdn.jsdelivr.net/gh/openlayers/openlayers.github.io@master/en/v6.5.0/build/ol.js"></script>
<script src="https://code.jquery.com/jquery-2.2.3.min.js"></script>
<script
	src="https://cdn.polyfill.io/v2/polyfill.min.js?features=requestAnimationFrame,Element.prototype.classList,URL"></script>


<style>
.body{
	position:absolute;
}
#map1Wrap{
	position:relative;
	float:left;	
}
#map2Wrap{
	position:relative;
	float:left;
}
#option{
	position:relative;
	float:right;
}
#result{
	position:relative;
	top:100%;
}
#info {
	opacity: 0.9;
	position: absolute;
	top: 68%;
	z-index: 99;
	border-radius: 10px;
}

table.featureInfo caption {
	display: none;
}

#popupTest {
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

.mposition {
	background-color: green;
	color: white;
	opacity: 0.7;
	text-align: center;
}

.ol-attribution {
	display: none;
}

/*마우스 툴팁*/
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
</style>

</head>

<body>
	<header
		style="text-align: center; font-size: 40px; border-bottom: solid;">신입개발과제
		홍정범</header>
	<div id="wrap">
		<div id="useMap" style="text-align: center; font-size: 25px;"></div>
		<form id="searchForm" action="#" class="form_data"
			onsubmit="return false;search();">
			<input type="hidden" name="page" value="1" /> <input type="hidden"
				name="type" value="address" /> <input type="hidden" name="request"
				value="search" /> <input type="hidden" name="size" value="100" />
			<input type="hidden" name="apiKey"
				value="CEB52025-E065-364C-9DBA-44880E3B02B8" /> <input
				type="hidden" name="domain" value="http://localhost:8080" /> <input
				type="hidden" name="crs" value="EPSG:3857" />
			<div>
				<input type="text" id="searchValue" name="query"
					value="서울시 은평구 진관1로 77-8" style="width: 300px;" /> <a
					href="javascript:search();">검색</a>
				<!--input type="checkbox" id="onoff" />WMS ON/OFF-->
				<select name="category">
					<option value="road">도로명</option>
					<option value="parcel">지번</option>
				</select>
			</div>
		</form>
		<div id="map1Wrap" style="width: 43%; height: 648px; padding: 2px;">
			<p style="text-align: center;">
				<a href="#" onclick="javascript:showMap1();">map1</a>
				<!-- a href="#" onclick="javascript:bigMap1();">전체보기</a-->
			</p>
			<div id="map1" style="width: 100%; height: 100%;"></div>
		</div>
		<div id="map2Wrap" style="width: 43%; height: 648px; padding: 2px;">
			<p style="text-align: center;">
				<a href="#" onclick="javascript:showMap2();">map2</a>
				<!-- a href="#" onclick="javascript:bigMap2();">전체보기</a-->
			</p>
			<div id="map2" style="width: 100%; height: 100%;"></div>
		</div>
		<div id="info" style="top: 80%; left: 30%;"></div>

		<div id="option"
			style="border: solid 0.1px; width: 13%; height: 680px;">
			<div style="">
				<label><input type="checkbox" id="mapId" value="map1">Map1</label>
				<label><input type="checkbox" id="mapId" value="map2">Map2</label>
				<br>
				<br>
				<button type="button" onclick="javascript:mapChange()">지도선택</button>
			</div>
			<hr>
			<div>
				<p>
					<input type="checkbox" id="vworldTile" value="Base">기본지도
				</p>
				<p>
					<input type="checkbox" id="vworldTile" value="Satelite">항공사진
				</p>
				<!--p><input type="checkbox" id="vworldTile" value="Hybrid">문자 타일</p-->
				<button type="button" onclick="javascript:tileChange()">지도옵션선택</button>
			</div>
			<hr>

			<div id="wms" style="">
				<p>
					<button type="button" onclick="javascript:sig();" name="importwms">'시군구'
						주제도</button>
					<button type="button" onclick="javascript:sigdelete();"
						name="importwms">'시군구' 삭제</button>
					<br>
				<p>
					<button type="button" onclick="javascript:ctp();" name="importwms">'시도'
						주제도</button>
					<button type="button" onclick="javascript:ctpdelete();"
						name="importwms">'시도' 삭제</button>
					<br>
				<p>
					<button type="button" onclick="javascript:iconOn();"
						name="importwms">'졸음쉼터 on'</button>
					<button type="button" onclick="javascript:iconOff();"
						name="importwms">'졸음쉼터 off'</button>
			</div>
			<hr>
			<div id="marker" style="">
				<form class="form-inline">
					<label>옵션 타입 &nbsp;</label> <select id="type">
						<option value="length">Length (LineString)</option>
						<option value="area">Area (Polygon)</option>
						<option value="Point" selected>Point</option>
						<!-- <option value="Circle">Circle</option> -->
						<option value="Select">선택</option>
						<Option value="testDelete">삭제</Option>
					</select>
				</form>
				<div id="searchMarker">
					<label><input type="checkbox" id="mkImg"
						value="http://map.vworld.kr/images/ol3/marker_blue.png"
						checked="on"> <img
						src="http://map.vworld.kr/images/ol3/marker_blue.png" /> <input
						type="checkbox" id="mkImg"
						value="http://map.vworld.kr/images/ol3/marker.png"> <img
						src="http://map.vworld.kr/images/ol3/marker.png" />
				</div>
				<label><input type="checkbox" id="roadview" value="1">로드뷰
					보기</label> <label><input type="checkbox" id="deleteMarker"
					value="1">삭제</label>
			</div>
			<button type="button" onclick="javascript:map1_delete();">MAP1
				옵션 전체삭제</button>
			<button type="button" onclick="javascript:map2_delete();">MAP2
				옵션 전체삭제</button>
			<button type="button" onclick="javascript:all_delete();">전체
				MAP 옵션 전체삭제</button>
			<hr>
			<div>
				<p>
					제목 <input type="text" id="subj" />
				<p>
					작업내용
					<textarea id="cont"></textarea>
			</div>
			<div id="popupTest" style="width: 300px; display: none;"></div>

		</div>
		<div>
			<!-- 검색 폼  -->
			<!-- 데이터 API 폼  -->
			<form id="dataForm">
				<input type="hidden" name="key"
					value="CEB52025-E065-364C-9DBA-44880E3B02B8"> <input
					type="hidden" name="domain" value="http://localhost:8080">
				<input type="hidden" name="service" value="data"> <input
					type="hidden" name="version" value="2.0"> <input
					type="hidden" name="request" value="getfeature"> <input
					type="hidden" name="format" value="json"> <input
					type="hidden" name="size" value="1000"> <input
					type="hidden" name="page" value="1"> <input type="hidden"
					name="data" value="LT_C_SPBD"> <input type="hidden"
					name="geometry" value="true"> <input type="hidden"
					name="attribute" value="true"> <input type="hidden"
					name="crs" value="EPSG:900913">
				<!-- <input type="hidden" name="geomfilter" value="BOX(14028876.609587036,3912653.333809428,14151175.854843318,3974414.4526638505)"> -->
				<input type="hidden" name="geomfilter"
					value="POINT(14028876.609587036 3912653.333809428)">
			</form>
		</div>
		<div id="result" style="">
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
	</div>
	<script>
	function bigMap1(){
		
		/*
		$('#map2Wrap').css("width","10%");
		$('map2').css("display:none");
		$('#map1').css("width","100%");
		$('#map1Wrap').css("width","70%");
		*/
	}
	function bigMap2(){
		/*
		$('#map1Wrap').css("width","10%");
		$('map1').css("display:none");
		$('#map2').css("width","100%");
		$('#map2Wrap').css("width","70%");
		*/
		
	}
	function showMap1(){
        $("#map1").css("opacity", "1");
    }
    function showMap2(){
        $("#map2").css("opacity", "1");
    }
	//1번 지도 마커 초기화
	function map1_delete(){
        map1.getLayers().forEach(layer => layer.getSource().refresh());
        map1.getOverlays().getArray().slice(0).forEach(function(MeasureTooltip) {
            map1.removeOverlay(MeasureTooltip);
            });
    }
	function map2_delete(){
        map2.getLayers().forEach(layer => layer.getSource().refresh());
        map2.getOverlays().getArray().slice(0).forEach(function(MeasureTooltip) {
            map2.removeOverlay(MeasureTooltip);
            });
    }
	function all_delete(){
		map1.getLayers().forEach(layer => layer.getSource().refresh());
        map1.getOverlays().getArray().slice(0).forEach(function(MeasureTooltip) {
            map1.removeOverlay(MeasureTooltip);
            });
        
		map2.getLayers().forEach(layer => layer.getSource().refresh());
        map2.getOverlays().getArray().slice(0).forEach(function(MeasureTooltip) {
            map2.removeOverlay(MeasureTooltip);
            });
	}
	
        //지도 소스 생성//
        var VworldBase, VworldSatellite, VworldHybrid;
        var VworldHybrid = new ol.source.XYZ({
            url: 'http://api.vworld.kr/req/wmts/1.0.0/CEB52025-E065-364C-9DBA-44880E3B02B8/Hybrid/{z}/{y}/{x}.png'
        }); //문자 타일 레이어

        var VworldSatellite = new ol.source.XYZ({
            url: 'http://api.vworld.kr/req/wmts/1.0.0/CEB52025-E065-364C-9DBA-44880E3B02B8/Satellite/{z}/{y}/{x}.jpeg'
            
        }); //항공사진 레이어 타일

        var VworldBase = new ol.source.XYZ({
            url: 'http://api.vworld.kr/req/wmts/1.0.0/CEB52025-E065-364C-9DBA-44880E3B02B8/Base/{z}/{y}/{x}.png'

        });
        //지도 선택
        var mouseControlCoordinate = new ol.control.MousePosition({
                            coordinateFormat : new ol.coordinate.createStringXY(4),
                            projection : 'EPSG:3857',//좌표계 설정
                            className : 'mposition', //css 클래스 이름
                            target : document.getElementById('mouseCoordinate'),//좌표를 뿌릴 element
                        });
                        var mouseControlCoordinate2 = new ol.control.MousePosition({
                            coordinateFormat : new ol.coordinate.createStringXY(4),
                            projection : 'EPSG:3857',//좌표계 설정
                            className : 'mposition', //css 클래스 이름
                            target : document.getElementById('mouseCoordinate'),//좌표를 뿌릴 element
                        });

    // map1 마커포인트 및 벡터레이어생성
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
                        width: 2
                        }),
                        image: new ol.style.Icon(({
                        anchor: [0.5, 10],
                        anchorXUnits: 'fraction',
                        anchorYUnits: 'pixels',
                        src: 'http://map.vworld.kr/images/ol3/marker.png'
                        }))
                    })
                    });
                    vector.set("name", "vectorName");
                    vector.setZIndex(1000);
    //map2의 벡터레이어 생성
        var source2 = new ol.source.Vector({
                    id: "sourceId"
                    });
                    source2.set("name", "sourceName");

       var vector2 = new ol.layer.Vector({
                    id: "vectorId",
                    source: source2,
                    style: new ol.style.Style({
                        
                        fill: new ol.style.Fill({
                        color: 'rgba(52, 0, 0, 0.35)'
                        }),
                        stroke: new ol.style.Stroke({
                        color: '#000',
                        width: 2
                        }),
                        image: new ol.style.Icon(({
                        anchor: [0.5, 10],
                        anchorXUnits: 'fraction',
                        anchorYUnits: 'pixels',
                        src: 'http://map.vworld.kr/images/ol3/marker.png'
                        }))
                    })
                    });
                    vector2.set("name", "vectorName");
                    vector2.setZIndex(1000);
        var map;
        function mapChange(){
        	
            var mapLength = $('input:checkbox[id="mapId"]:checked').length;
            map = $('input:checkbox[id="mapId"]:checked').val();
            var userMap='';
        	
        	userMap+="<p>현재 사용중인 지도 : "+map+"번 지도</p>"
            $('#useMap').html(userMap);
            // 마우스 핸들러
            function pointerMoveHandler(event){
            //map.on('pointermove', pointerMoveHandler);
    
            
                var features = map.getFeaturesAtPixel(event.pixel);
                if (!features) {
                    // 마우스 위치에 어떠한 Feature도 없음
                    return;
                }
                // 마우스 포인터 위치에 존재하는 Feature 중 첫번째(features[0])
                var properties = features[0].getProperties();  
                // properties 객체가 object 타입의 Feature에 대한 속성값임
                
            
            }
            
            
                    var sketch;
                    var helpTooltipElement;
                    var helpTooltip;
                    var measureTooltipElement;
                    var measureTooltip;
                    var continuePolygonMsg = 'polygon을 그리는 중입니다.';
                    var continueLineMsg = 'Line을 그리는 중입니다.';

                   
                    var pointerMoveHandler = function (evt) {
                    if (evt.dragging) {
                        return;
                    }
                    
                    var helpMsg ='지도를 이동하세요.';


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
            var typeSelect = document.getElementById('type');
        

        var draw; // global so we can remove it later


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

            if(mapLength ==1){
                
                helpTooltip = new ol.Overlay({
                element: helpTooltipElement,
                offset: [15, 0],
                positioning: 'center-left'
            });
            if(map=='map1'){
            	$("#map1").css("opacity", "1");
                $("#map2").css("opacity", "0.1");
    
            map1.on('pointermove', pointerMoveHandler);
        map1.getViewport().addEventListener('mouseout', function () {
            helpTooltipElement.classList.add('hidden');
        });
        
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
                    condition: ol.events.condition.click
                })
                select.set("이벤트", "선택");
                select.on("select", function (evt) {
                
                    var length = evt.target.getFeatures().getLength();
                    if (length > 0) {
                        var popup_Test ="";
                        subj = evt.target.getFeatures().getArray()[0].get("subj");
                        cont = evt.target.getFeatures().getArray()[0].get("cont");
                        
                        
                        var features = evt.target.getFeatures().getArray();
                        var feature = features[0]
                        
                        
                        var checkroadview=$('input:checkbox[id="roadview"]:checked').length;
                        var deleteMk=$('input:checkbox[id="deleteMarker"]:checked').length;
                        
                        if(deleteMk >0){
                        	
                        	vector.getSource().removeFeature(feature);
                        }
                        if(checkroadview >0){
                        	var xy=features[0].getGeometry().getCoordinates();
                            
                            lon= xy[0];
                            lat= xy[1];
                        	
                            var tansform = ol.proj.transform([lon,lat], 'EPSG:3857', 'EPSG:4326')// 브이월드 좌표계에서 다음 지도 좌표계로 변환 EPSG:3857=>EPSG:4326
                            
                            var roadview="https://map.kakao.com/link/roadview/"+tansform[1]+","+tansform[0];   // 로드뷰 불러오기
                            if(tansform=='NaN,NaN'){
                            	alert('로드뷰는 마커를 선택해주세요');
                            	return false;
                            }
                            window.open(roadview, '로드뷰팝업', 'width=500, height=700, scrollbars=yes, resizable=no')
                            
                            }
                        
                        if(cont != ''){
                            $('#popupTest').show();
                        }else if(cont ==''){
                            $('#popupTest').hide();
                        }
                        popup_Test += subj;
                            $('#popupTest').html(popup_Test);
                            
                        
                    }
                })
                    map1.addInteraction(select);
                    return;
            
            }
            
            draw = new ol.interaction.Draw({
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
           
                map1.addInteraction(draw);
           
            

            createMeasureTooltip();
            createHelpTooltip();

            var listener;
            draw.on('drawstart',
                function (evt) {
                    // set sketch
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
                    
                    sketch = null;
                    
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
            
                map1.addOverlay(helpTooltip); //커서에 달린 도움말

            
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
            
                map1.addOverlay(measureTooltip); //넓이와 길이
            
        
        }


        typeSelect.onchange = function () {
            map1.removeInteraction(draw);
            map1.getInteractions().getArray().forEach(function (i) {
                if (i.get("이벤트") == "선택") {
                    
                        map1.removeInteraction(i);
                    
                }
            })
            addInteraction();
        };

        addInteraction();


            }else if(map=='map2'){
            	$("#map1").css("opacity", "0.1");
                $("#map2").css("opacity", "1");
                map2.on('pointermove', pointerMoveHandler);

        
        

        map2.getViewport().addEventListener('mouseout', function () {
            helpTooltipElement.classList.add('hidden');
        });
    
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
                    condition: ol.events.condition.click
                })
                select.set("이벤트", "선택");
                select.on("select", function (evt) {
                
                    var length = evt.target.getFeatures().getLength();
                    if (length > 0) {
                        var popup_Test ="";
                        subj = evt.target.getFeatures().getArray()[0].get("subj");
                        cont = evt.target.getFeatures().getArray()[0].get("cont");
                        
                        feature = evt.target.getFeatures();
                        
                        var features = evt.target.getFeatures().getArray();
                        var feature = features[0]
                        var xy=features[0].getGeometry().getCoordinates();
                        var checkroadview=$('input:checkbox[id="roadview"]:checked').length;
                        lon= xy[0];
                        lat= xy[1];
                        
                        var deleteMk=$('input:checkbox[id="deleteMarker"]:checked').length;
                        
                        if(deleteMk >0){
                        	
                        	vector2.getSource().removeFeature(feature);
                        }
                        if(checkroadview >0){
                        	
                            var tansform = ol.proj.transform([lon,lat], 'EPSG:3857', 'EPSG:4326')// 브이월드 좌표계에서 다음 지도 좌표계로 변환 EPSG:3857=>EPSG:4326
                            
                            if(tansform=='NaN,NaN'){
                            	alert('로드뷰는 마커를 선택해주세요');
                            	return false;
                            }
                            var roadview="https://map.kakao.com/link/roadview/"+tansform[1]+","+tansform[0];   // 로드뷰 불러오기
                            window.open(roadview, '로드뷰팝업', 'width=500, height=700, scrollbars=yes, resizable=no')
                            
                            }
                        
                        if(cont != ''){
                            $('#popupTest').show();
                        }else if(cont ==''){
                            $('#popupTest').hide();
                        }
                        popup_Test += subj;
                            $('#popupTest').html(popup_Test);
                            
                        
                    }
                })
                    map2.addInteraction(select);
                    return;
            
            }
           
           
            draw = new ol.interaction.Draw({
                source: source2,
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
           
                map2.addInteraction(draw);
           
            

            createMeasureTooltip();
            createHelpTooltip();

            var listener;
            draw.on('drawstart',
                function (evt) {
                    // set sketch
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
                    
                    sketch = null;
                    
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
            
                map2.addOverlay(helpTooltip); //커서에 달린 도움말

            
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
            
                map2.addOverlay(measureTooltip); //측정할때 도움말
            
        
        }


        typeSelect.onchange = function () {
            map2.removeInteraction(draw);
            map2.getInteractions().getArray().forEach(function (i) {
                if (i.get("이벤트") == "선택") {
                    
                        map2.removeInteraction(i);
                    
                }
            })
            addInteraction();
        };

        addInteraction();

            }
            }else if(mapLength !=1){
                alert("한가지의 지도만 선택하세요");
                return false;
                
            }
        }
        
        //배경지도 선택
        function tileChange(){
            var tileLength = $('input:checkbox[id="vworldTile"]:checked').length;
            var tileValue = $('input:checkbox[id="vworldTile"]:checked').val();

            if(map==null ){
                alert("지도를 선택해주세요.");
                return false;
            }else if(tileLength != 1){
                alert("타일을 한가지 선택해 주세요");
                return false;
            }else if(map !=null && tileLength ==1){
                alert(map+" 지도에"+ tileValue+"입니다.");
                
                
               if(tileValue=="Satelite"){
                    if(map=='map1'){
                        map1.getLayers().forEach(function (layer) {
                            if (layer.get("name") == "vworld") {
                                layer.setSource(VworldSatellite)
                            }
                        })
                    }else if(map=='map2'){
                        map2.getLayers().forEach(function(layer){
                            if(layer.get("name") =="vworld"){
                                layer.setSource(VworldSatellite)
                            }
                        })
                    }
                }else if(tileValue=="Base"){
                    if(map=='map1'){
                        map1.getLayers().forEach(function (layer) {
                            if (layer.get("name") == "vworld") {
                                layer.setSource(VworldBase)
                            }
                        })
                    }else if(map=='map2'){
                        map2.getLayers().forEach(function(layer){
                            if(layer.get("name") =="vworld"){
                                layer.setSource(VworldBase)
                            }
                        })
                    }
                }

            }
        }
        //geoserver wms
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
            scale:10,
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
        if(map=='map1'){
            map1.addLayer(sigWms);
        }else if(map=='map2'){
            map2.addLayer(sigWms);
        }
    }
	function ctp(){
        if(map=='map1'){
            map1.addLayer(ctpWms);
        }else if(map=='map2'){
            map2.addLayer(ctpWms);
        }
    }
	function iconOn(){
        if(map=='map1'){
            map1.addLayer(iconWms);
       
                var view = map1.getView();
                map1.on('singleclick', function (evt) {
                document.getElementById('info').innerHTML = '';
                    var viewResolution = /** @type {number} */ (view.getResolution());
                    var source = iconWms.getSource();
                    var url = source.getFeatureInfoUrl(
                        evt.coordinate,
                        viewResolution,
                        'EPSG:3857',
                        {'INFO_FORMAT': 'text/html'}
                    );
                    
                    if (url) {
                        fetch(url)
                        .then((response) => response.text())
                        .then((html) => {
                            document.getElementById('info').innerHTML = html;
                        });
                    }
                });
        }else if(map=='map2'){
            map2.addLayer(iconWms);
       
                var view = map2.getView();
                map2.on('singleclick', function (evt) {
                document.getElementById('info').innerHTML = '';
                    var viewResolution = /** @type {number} */ (view.getResolution());
                    var source = iconWms.getSource();
                    var url = source.getFeatureInfoUrl(
                        evt.coordinate,
                        viewResolution,
                        'EPSG:3857',
                        {'INFO_FORMAT': 'text/html'}
                    );
                    
                    if (url) {
                        fetch(url)
                        .then((response) => response.text())
                        .then((html) => {
                            document.getElementById('info').innerHTML = html;
                        });
                    }
                });
        }
        
    }
    function sigdelete(){
        if(map=='map1'){
            map1.removeLayer(sigWms);  
        }else if(map=='map2'){
            map2.removeLayer(sigWms);
            }
                   
        }
    function ctpdelete(){
        if(map=='map1'){
            map1.removeLayer(ctpWms);  
        }else if(map=='map2'){
            map2.removeLayer(ctpWms);
            }          
      }
    function iconOff(){
        if(map=='map1'){
            map1.removeLayer(iconWms);  
        }else if(map=='map2'){
            map2.removeLayer(iconWms);
            }            
    }

    /////2개의 지도생성 /////


    map1 = new ol.Map({
            controls: ol.control.defaults().extend([
            mouseControlCoordinate2
               ]),
            layers: [
                new ol.layer.Tile({
                    source: new ol.source.OSM(),
                    name: "OSM",
                    
                }), new ol.layer.Tile({
                    source: VworldSatellite,
                    name: "vworld",
                    
                }), new ol.layer.Tile({
                    source: VworldHybrid,
                    name: "hybrid",
                    
                }),
            
                
                vector,
            ],
           
            target: 'map1',
            view: new ol.View({
                center: ol.proj.transform([14324890.296973, 4277891.7105477], 'EPSG:3857', 'EPSG:900913'),
                zoom: 16,
                minZoom: 0,
                maxZoom: 21
            })
        });

        map2 = new ol.Map({
            controls: ol.control.defaults().extend([
            mouseControlCoordinate
               
        ]),
            layers: [
                new ol.layer.Tile({
                    source: new ol.source.OSM(),
                    name: "OSM",
                    
                })
                , new ol.layer.Tile({
                    source: VworldSatellite,
                    name: "vworld",
                    
                }), new ol.layer.Tile({
                    source: VworldHybrid,
                    name: "hybrid",
                    
                }),
            
                
                vector2,
            ],
           // overlays: [overlay],
            target: 'map2',
            view: new ol.View({
                center: ol.proj.transform([14324890.296973, 4277891.7105477], 'EPSG:3857', 'EPSG:900913'),
                zoom: 16,
                minZoom: 0,
                maxZoom: 21
            })
        });
    var markerSource;
    var search = function(){
        if(markerSource==null){
            
            markerSource = new ol.source.Vector();
            
        
        }else if(markerSource !=null){
            
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
                                zindex: 1001
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
					var result_html ="";
                    
					
					for(var o in data.response.result.items){ 
                        var marker_html ="";
						
                        var x = data.response.result.items[o].point.x*1;
                        var y = data.response.result.items[o].point.y*1
                        var point_feature = new ol.Feature({
                            geometry: new ol.geom.Point([x, y]).transform('EPSG:900913', 'EPSG:3857')
                        });
                        
                        var title = data.response.result.items[o].address.bldnm
                        var cont = "2";  //내용이없을경우 팝업 제외하기위하여 추가 검색시 생성되는 마커는 모두 내용이 있음으로 cont 내용을 추가함
						var contents = data.response.result.items[o].address.road
                        marker_html += "<span> 장소 :"+title+"<hr>도로명 :"+ contents+"</span>";
                        point_feature.set("subj",marker_html);
                        point_feature.set("cont",cont);


                            //markerSource에 등록한 point를 담는다. addFeature를 이용해서, 여러개의 point를 source에 담는다.
                            markerSource.addFeature(point_feature);
                            
                            // 마커 레이어 생성
                            markerLayer = new ol.layer.Vector({
                                source: markerSource, //마커 feacture들
                                style: markerStyle //마커 스타일
                            });
                      
                            result_html += "<hr><li><p onclick='move("+data.response.result.items[o].point.x+","+data.response.result.items[o].point.y+
							")'> 도로명: "+ data.response.result.items[o].address.road +
							" 지번: "+ data.response.result.items[o].address.parcel +"  </p></li>";
					}
                    if(map =='map1'){
					    map1.addLayer(markerLayer);
                    }else if(map =='map2'){
                        map2.addLayer(markerLayer);
                    }

				
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
        if(map =='map1'){
            map1.getView().setCenter([ x, y ]); // 지도 이동
		    map1.getView().setZoom(17); // 줌레벨 설정

        }else if(map =='map2'){
            map2.getView().setCenter([ x, y ]); 
		    map2.getView().setZoom(17); 
        }
		
	}

    



    </script>
</html>
