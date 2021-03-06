<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>


<!-- <SCRIPT language="JavaScript" type="text/javascript"
	src="http://map.vworld.kr/js/vworldMapInit.js.do?apiKey=10036FCE-3940-374C-B2ED-E6FBDF47CFA9"></SCRIPT>
 -->

<script type="text/javascript"
	src="http://map.vworld.kr/js/vworldMapInit.js.do?apiKey=10036FCE-3940-374C-B2ED-E6FBDF47CFA9"></script>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/ol3/3.11.1/ol.min.js"></script>
<style>
html, body {
	width: 100%;
	height: 100%;
	background-color: black;
}

body {
	margin: 0;
}

header {
	text-align: center;
	height: 100px;
}

#cont1 {
	width: 100%;
	height: 60%;
}

#map_mode {
	float: right;
}

#search {
	
}

.wrapper {
	position: absolute;
	top: 50%;
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
	border-top: 1px solid #ef584a;
	overflow: hidden;
}

.btn {
	display: block;
	padding: 15px 20px;
	background-color: #ff6f61;
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
	border-top: 10px solid #ff6f61;
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
</style>
<meta charset="UTF-8">
<title>?????????</title>
</head>

<body>
	<header style="text-align: center;">
		<a href=""> <img style="height: 100%;"
			src="<c:url value='/images/egovframework/example/egislogo.PNG'/>"
			alt="" /></a>
			
	</header>
	<textarea>?????? ?????? ??????</textarea>
	<button>??????</button>
	<div id="cont1"></div>
	<!--  <button type="button" onclick="javascript:setPanZoomBar();">??????????????? ???????????? ??????</button>-->
	<div id="map_mode">
		<button type="button" onclick="javascript:vworld.setMode(0);"
			name="mode0">2D????????????</button>
		<!-- setMode(0) ?????? (1) ?????? (2)3D -->
		<button type="button" onclick="javascript:vworld.setMode(1);"
			name="mode1">2D????????????</button>

	</div>
	<hr>
	<br>
	<!-- SAMPLE -->
	<div class="wrapper">
		<ui class="mainMenu">
		<li class="item" id="account"><a href="#account" class="btn"><i
				class="fas fa-user-circle"></i>????????????</a>
			<div class="subMenu">
				<p>
					<button type="button" onclick="javascript:addMarkingEvent();"
						name="addpin">????????????</button>
				</p>
				<p>
					<button type="button" onclick="clearMarkers()">?????? ?????? ??????</button>
				</p>
				<p>
				<!-- 	<button type="button" onclick="removeMarkingEvent()">??????????????????</button> -->
				</p>
				<p class="content" style="display: none;">
					<textarea rows="10" cols="50" class="mkContent"
						placeholder="????????? ???????????????."></textarea>
				</p>

			</div></li>
		<li class="item" id="about"><a href="#about" class="btn"><i
				class="fas fa-address-card"></i>????????????</a>
			<div class="subMenu">
				<p>
					<button type="button"
						onclick="javascript:addThemeLayer('?????????','LP_PA_CBND_BUBUN,LP_PA_CBND_BONBUN');"
						name="addcache">????????? ??????</button>
				</p>
				<button type="button" onclick="javascript:importWMS();"
					name="importwms">'??????' ?????????</button>
					<button type="button" onclick="javascript:importWMS();"
					name="importwms">'?????????' ?????????</button>
					<button type="button" onclick="javascript:importWMS();"
					name="importwms">'???????????? on'</button>


				<!-- <p>
					<select id="select_wms">
						<option>??????</option>
						<option value='LT_C_UQ112'>????????????</option>
						<option value='LT_C_DGMAINBIZ'>????????????</option>
						<option value='LT_C_UQ113'>????????????</option>
						<option value='LT_C_UQ111'>????????????</option>
					</select>
				</p>
				<p>
					<select id="delect_wms">
						<option>??????</option>
						<option value='LT_C_UQ112'>????????????</option>
						<option value='LT_C_DGMAINBIZ'>????????????</option>
						<option value='LT_C_UQ113'>????????????</option>
						<option value='LT_C_UQ111'>????????????</option>
					</select>
				</p>
				 -->
			</div></li>
		</ui>
		<script>
			$("#delect_wms").change(function() {
				var title = $("#delect_wms option:selected").text(); //???????????? text???
				console.log(title);
				map.hideThemeLayer(title); //????????? ?????????		
			});

			$("#select_wms").change(function() {
				//console.log($(this).val());
				//console.log($("#select_wms option:selected").text());
				var title = $("#select_wms option:selected").text();
				var layer = $(this).val(); //???????????? ?????????.

				map.showThemeLayer(title, {
					layers : layer
				});

				/*map.showThemeLayer(title, {
					layers : layer
				});
				 */

			});

			function test(title, layer) {
				map.showThemeLayer(title, {
					layers : layer
				});
			}
		</script>
		<!-- 
            <li class="item" id="support">
                <a href="#support" class="btn"><i class="fas fa-info"></i>Support</a>
                <div class="subMenu">
                    <a href="">item-1</a>
                </div>
            </li>
            <li class="item">
                <a href="#" class="btn"><i class="fas fa-sign-out-alt"></i>Log Out</a>
            </li>
        </ui>
         -->

	</div>



	<div>
		<p
			style="color: white; font-color: white; font-size: 20px; text-align: center;">
			?????? ??????(????????????): <input type="text" name='q' id='mousex' value="0"
				maxlength="20"
				style="ime-mode: active; width: 150px; height: 20px; font-size: 20px; background-color: black; color: white;" />
			<input type="text" name='q' id='mousey' value="0" maxlength="20"
				style="ime-mode: active; width: 150px; height: 20px; font-size: 20px; background-color: black; color: white;" />
		<p>
	</div>
	<hr>
	<div>
		<p style="color:white; font-size:20px;">?????? ?????? ?????? ?????? 1</p>
		<p style="color:white; font-size:20px;">?????? ?????? ?????? ?????? 2</p>
		<p style="color:white; font-size:20px;">?????? ?????? ?????? ?????? 3</p>
		<p style="color:white; font-size:20px;">?????? ?????? ?????? ?????? 4</p>
		<p style="color:white; font-size:20px;">?????? ?????? ?????? ?????? 5</p>
	</div>

	<!-- ??????  ??? ??????--
	
	<button id="button_maker">?????? ??????</button>
	<div id="Maker" >
		<hr>

		<button type="button" onclick="javascript:addMarkingEvent();"
			name="addpin">????????????</button>
		<p class="content" style="display: none;">
			<textarea rows="10" cols="50" class="mkContent"
				placeholder="????????? ???????????????."></textarea>
		</p>
		
		<button type="button" onclick="javascript:testMarker.hide();"
			name="addpin">???????????????1</button>
			
		<button type="button" onclick="javascript:testMarker.show();"
			name="addpin">??????????????????</button>
			
		<button type="button" onclick="clearMarkers()">?????? ?????? ??????</button>
		???????????????(????????????): <input type="text" name='q' id='mousex' value="0"
			maxlength="20" style="ime-mode: active" /> <input type="text"
			name='q' id='mousey' value="0" maxlength="20"
			style="ime-mode: active" />
	</div>
	-->

	<!-- ????????? --
	<div id="Layer" >
	
		<button type="button"
			onclick="javascript:addThemeLayer('?????????','LP_PA_CBND_BUBUN,LP_PA_CBND_BONBUN');"
			name="addcache">?????????On/Off</button>
			
			-->
	<!-- button type="button" onclick="javascript:addTileCache();" name="addcache"> ????????????????????? On/Off</button> -->

	<script>
		/**************???????????? **************/

		var map = null;
		vworld.showMode = false;
		vworld.init("cont1", "raster-first", function() { //raster-first => ?????? ??????, map-first ????????????
			map = this.vmap;
			map.setBaseLayer(map.vworldBaseMap);
			map.setControlsType({
				"simpleMap" : true
			});
			map.setCenterAndZoom(14324819.234423, 4277895.4428245, 20); // ???????????? ???????????? ??????
			map.addVWORLDControl("zoomBar");
			//map.addVWORLDControl("indexMap");
			//map.setIndexMapPosition("right-bottom");
			//map.addMapToolButton("init");
			//map.addMapToolButton("zoomin");
			//map.addMapToolButton("zoomout");
			//map.addMapToolButton("zoominbox");
			//map.addMapToolButton("zoomoutbox");
			//map.addMapToolButton("pan");
			//map.addMapToolButton("prev");
			//map.addMapToolButton("next");
			//map.addMapToolButton("info");
			//map.addMapToolButton("fullext");
			map.addMapToolButton("caldist");
			map.addMapToolButton("calarea");

			/*******?????? ?????? ?????? ?????? *******
			addMarker(
					14324819.234423,
					4277895.4428245,
					'?????????<br>'); //???????????? ?????? ??????*/
		}, function(obj) {
			SOPPlugin = obj;
		}, function(msg) {
			alert('oh my god');
		});

		function setModeCallback() {
			vworld.setModeCallback(modecallback);

		}
		function setPanZoomBar() {
			var pZoomBar = null;
			if (map.getControlsByClass("vworld.PanZoomBar")[0] != null) {
				pZoomBar = map.getControlsByClass("vworld.PanZoomBar")[0];
			} else {
				pZoomBar = new vworld.PanZoomBar();
			}
			pZoomBar.initialize({
				zoomStopWidth : 100,
				zoomStopHeight : 20,
				sliderEvents : null,
				zoombarDiv : null,
				measureDiv : null,
				measurebuttons : null,
				divEvents : null,
				isSimpleBar : false,
				curPosition : 'right',
				zoomWorldIcon : null,
				forceFixedZoomLevel : false,
				mouseDragStart : null,
				deltaY : null,
				zoomStart : null
			});
			pZoomBar.redraw();
		}

		/** ?????? **
		
		$(document).on('click', '#button_maker', function() {
			alert('?????? ??????');
			$("#Maker").show();

		});
		$(document).on('click', '#button_layer', function() {
			alert('?????? ??????');
			$("#Layer").show();

		});
		/*******??????*******/
		var markerControl;
		function addMarkingEvent() {
			$('p.content').show();
			var pointOptions = {
				persist : true
			}
			if (markerControl == null) {
				markerControl = new OpenLayers.Control.Measure(
						OpenLayers.Handler.Point, {
							handlerOptions : pointOptions
						});
				markerControl.events.on({
					"measure" : mapclick
				});
				map.addControl(markerControl);
			}
			map.init();
			markerControl.activate();
		}
		function removeMarkingEvent() {
			map.events.unregister('click', this, mapclick);
		}
		function mapclick(event) {
			map.init();
			var temp = event.geometry;
			var pos = new OpenLayers.LonLat(temp.x, temp.y);
			var content = $('p.content').find('textarea.mkContent').val(); /*?????? ????????????*/

			document.getElementById('mousex').value = pos.lon; /* x??? */
			document.getElementById('mousey').value = pos.lat; /* y??? */

			addMarker(pos.lon, pos.lat, content, null);/* ?????? ?????? x , y ,?????? ??????, ?*/

			if (content == '') { //?????? ?????? ?????????
				alert('??????????????????');
			} else if (content != null) { //?????? ?????? ?????????
				alert('?????????????????? : ' + content);
			}

		}
		function addMarker(lon, lat, message, imgurl) { //?????? ??????
			var marker = new vworld.Marker(
					lon,
					lat,
					message,					
					'<img src="<c:url value='/images/egovframework/example/egislogo.PNG'/>" alt=""/>' //????????? ?????????					
					); 
			if (typeof imgurl == 'string') {
				marker.setIconImage('<img src="<c:url value='/images/egovframework/example/egislogo.PNG'/>" alt=""/>'); //????????? ???????????????
			}
			
			marker.setZindex(3);
			map.addMarker(marker);
			testMarker = marker;
		}
		function clearMarkers() {
			map.clearMarkers();
		}
		/********?????????****/

		function addThemeLayer(title, layer) {
			map.showThemeLayer(title, {
				layers : layer
			});
		}

		function addTileCache() {
			map.showTileCacheLayer('?????????????????????', 'SANSATAI', {
				min : 9,
				max : 15
			});
		}
		function setTestProxy() {
			alert(OpenLayers.ProxyHost);
		}

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

		
	</script>
</body>
</html>