<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/gh/openlayers/openlayers.github.io@master/en/v6.5.0/css/ol.css"
	type="text/css">
<script
	src="https://cdn.jsdelivr.net/gh/openlayers/openlayers.github.io@master/en/v6.5.0/build/ol.js"></script>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>


<style>
#map {
	width: 50%;
	height: 400px;
}
</style>

<meta charset="UTF-8">
<title>홍정범</title>
</head>
<body>

	<div id="map" class="map">
		<div id="map_mode">
			<button type="button" onclick="">항공사진</button>
		</div>
		<div id="mouseCoordinate"></div>
		<span>
			<button type="button" onclick="javascript:marker();" name="addpin">마커찍기</button>
		</span>
		<div>
			<label><input type="checkbox" id="color" value="blue"
				checked="on">BLUE</label> <label><input type="checkbox"
				id="color" value="red">RED</label> <label><input
				type="checkbox" id="color" value="green">GREEN</label>
		</div>
	</div>
	<script>
		//브이월드 타일레이어 url 설정

		var source = new ol.source.XYZ({
			url : 'https://xdworld.vworld.kr/2d/Base/service/{z}/{x}/{y}.png'
		});

		//타일레이어 생성하기
		var viewLayer = new ol.layer.Tile({
			source : source
		});

		/*overviewmap 생성하기	
		var overViewMapCtrl = new ol.control.OverviewMap({
		    layers: [
		      new ol.layer.Tile({
		        source: source,
		      })],
		    collapsed: false,
		});*/
		//마우스좌표
		var mouseControlCoordinate = new ol.control.MousePosition({
			coordinateFormat : new ol.coordinate.createStringXY(4),
			projection : 'EPSG:4326',//좌표계 설정
			className : 'mposition', //css 클래스 이름
			target : document.getElementById('mouseCoordinate'),//좌표를 뿌릴 element
		});

		var view = new ol.View({
			center : [ 14248656.389982047, 4331624.063626864 ],
			zoom : 8,
		});
		

		//geoserver 설정
		var tileImg = new ol.layer.Tile({
			visible : true,
			source : new ol.source.TileWMS({
				url : 'http://localhost:8090/geoserver/cite/wms',
				params : {
					'VERSION' : '1.1.0',
					'tiled' : true,
					"STYLES" : '',
					"LAYERS" : 'cite:li' // workspace:layer
				}
			})
		});
		///지도생성
		var mapView = new ol.Map({
			target : "map", // 지도를 생성할 element 객체의 id 값,
			layers : [ viewLayer ], //생성한 레이어 추가,
			view : view, //view 설정
			// controls: ol.control.defaults().extend([overViewMapCtrl]), // 맵 오버레이
			controls : new ol.control.defaults()
					.extend([ mouseControlCoordinate ])
		//마우스 좌표
		});

		//맵클릭시 포인트생성

		function marker() {
			mapView.on('click', function(e) {
				//console.log(e.coordinate);
				var x = e.coordinate[0];
				var y = e.coordinate[1];
				let imgLength = $('input:checkbox[id="color"]:checked').length;
				let color = $('input:checkbox[id="color"]:checked').val();

				if (imgLength != 1) {
					alert("색상을 하나만 선택하여주세요");
					return false;
				}

				//point Geometry 객체를 생성한다.
				var point = new ol.geom.Point([ x, y ]);

				var pointSourceLayer = new ol.source.Vector({
					features : [ new ol.Feature(point) ]
				});
				//레이어 생성할 때 스타일을 지정해준다.
				var pointVectorLayer = new ol.layer.Vector({
					source : pointSourceLayer,
					style : new ol.style.Style({
						image : new ol.style.Circle({
							radius : 5,
							fill : new ol.style.Fill({
								color : color
							}),
						})
					})
				});

				this.addLayer(pointVectorLayer);
			})
		}
	</script>
</html>