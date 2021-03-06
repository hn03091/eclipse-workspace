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

	<div id="map" class="map"></div>
		<div id="map_mode">
			<button type="button" onclick="javascript:addInteraction();">거리재기</button>
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
	
				<!--div>
				<p>
					<select id="select_option">
						<option>선택</option>
						<option value='marker'>마커</option>
						<option value='line'>거리재기</option>
						<option value='LT_C_UQ113'>?</option>
						
					</select>
				</p>
				</div-->

	<script>
	//예제
	var sketch; //라인스트링 이벤트 시 geometry객체를 담을 변수
	var measureTooltipElement;//draw 이벤트가 진행 중일 때 담을 거리 값 element
	var measureTooltip; //툴팁 위치
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
		//예제
		var lineSource = new ol.source.Vector();
		var lineVector = new ol.layer.Vector({
		        source:lineSource
		})
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
			layers : [ viewLayer], //생성한 레이어 추가,
			view : view, //view 설정
			// controls: ol.control.defaults().extend([overViewMapCtrl]), // 맵 오버레이
			controls : new ol.control.defaults()
					.extend([ mouseControlCoordinate ])
		//마우스 좌표
		});
		function addInteraction() {
		    draw = new ol.interaction.Draw({
		        source: lineSource,
		        type: 'LineString',
		        style: new ol.style.Style({
		            fill: new ol.style.Fill({
		                color: 'rgba(255, 255, 255, 0.2)',
		            }),
		            stroke: new ol.style.Stroke({
		                color: 'rgba(0, 0, 0, 0.5)',
		                lineDash: [10, 10],
		                width: 2,
		            }),
		            image: new ol.style.Circle({
		                radius: 5
		            }),
		        }),
		    })
		    mapView.addInteraction(draw);
		    createMeasureTooltip();

		    var listener;
		    draw.on('drawstart', function(evt) {
		        console.log(evt)
		        sketch = evt.feature;
		        //var tooltipCoord = evt.coordinate;

		        listener = sketch.getGeometry().on('change', function(evt) {
		            var geom = evt.target;
		            var output = formatLength(geom);
		            tooltipCoord = geom.getLastCoordinate();

		            measureTooltipElement.innerHTML = output;
		            measureTooltip.setPosition(tooltipCoord);
		        })
		    })

		    draw.on('drawend', function() {
		        measureTooltipElement.className = 'ol-tooptip ol-tooltip-static';
		        measureTooltip.setOffset([0, -7]);

		        //unset sketch
		        sketch = null;
		        measureTooltipElement = null;
		        createMeasureTooltip();
		        new ol.Observable(listener)
		    })
		}
		function createMeasureTooltip() {
		    if (measureTooltipElement) {
		        measureTooltipElement.parentNode.removeChild(measureTooltipElement);
		    }
		    measureTooltipElement = document.createElement('div');
		    measureTooltipElement.className = 'ol-tooltip ol-tooltip-measure';
		    measureTooltip = new ol.Overlay({
		        element: measureTooltipElement,
		        offset: [0, -15],
		        positioning: 'bottom-center',
		    });
		    mapView.addOverlay(measureTooltip);
		}

		function formatLength(line) {
		    var length = ol.sphere.getLength(line);
		    var output;
		    if (length > 100) {
		        output = Math.round((length / 1000) * 100) / 100 + ' ' + 'km';
		    } else {
		        output = Math.round(length * 100) / 100 + ' ' + 'm';
		    }

		    return output;
		};
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
		/*
		$("#select_option").change(function() {
			var option = $(this).val(); //선택값의 text값
			console.log(option);
			if(option == 'marker'){
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

			}else(option == 'line');{
				
				draw = new ol.interaction.Draw({
			        source: lineSource,
			        type: 'LineString',
			        style: new ol.style.Style({
			            fill: new ol.style.Fill({
			                color: 'rgba(255, 255, 255, 0.2)',
			            }),
			            stroke: new ol.style.Stroke({
			                color: 'rgba(0, 0, 0, 0.5)',
			                lineDash: [10, 10],
			                width: 2,
			            }),
			            image: new ol.style.Circle({
			                radius: 5
			            }),
			        }),
			    })
			    mapView.addInteraction(draw);
			    createMeasureTooltip();

			    var listener;
			    draw.on('drawstart', function(evt) {
			        console.log(evt)
			        sketch = evt.feature;
			        //var tooltipCoord = evt.coordinate;

			        listener = sketch.getGeometry().on('change', function(evt) {
			            var geom = evt.target;
			            var output = formatLength(geom);
			            tooltipCoord = geom.getLastCoordinate();

			            measureTooltipElement.innerHTML = output;
			            measureTooltip.setPosition(tooltipCoord);
			        })
			    })

			    draw.on('drawend', function() {
			        measureTooltipElement.className = 'ol-tooptip ol-tooltip-static';
			        measureTooltip.setOffset([0, -7]);

			        //unset sketch
			        sketch = null;
			        measureTooltipElement = null;
			        createMeasureTooltip();
			        new ol.Observable(listener)

			    })
			}

		});*/

	</script>
</html>