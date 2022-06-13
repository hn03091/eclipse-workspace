<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
    <title>2D 지도생성 2.0</title>
<script type="text/javascript" src="https://map.vworld.kr/js/vworldMapInit.js.do?version=2.0&apiKey=10036FCE-3940-374C-B2ED-E6FBDF47CFA9&domain=http://localhost:8080"></script>
</head>

<body>

<div id="vmap" style="width:100%;height:370px;left:0px;top:0px"></div>
<div>
	<!-- 검색 폼  -->
	<form id="searchForm" action="#" class="form_data" onsubmit="return false;search();">
		<input type="hidden" name="page" value="1" />
		<input type="hidden" name="type" value="address" />
		<input type="hidden" name="request" value="search" />
		<input type="hidden" name="size" value="100" />
		<input type="hidden" name="apiKey" value="10036FCE-3940-374C-B2ED-E6FBDF47CFA9" />
		<input type="hidden" name="domain" value="http://localhost:8080" />
		<input type="hidden" name="crs" value="EPSG:3857" />
		<div>
			<input type="text"  id="searchValue" name="query" value="서울시 은평구 진관1로 77-8" style="width: 300px;" /> <a href="javascript:search();" >검색</a> 
			<input type="checkbox" id="onoff" />WMS ON/OFF
			<select name="category">
			<option value="road">도로명</option>
			<option value="parcel">지번</option>
		</select>
		</div>
		
	</form>
	<!-- 데이터 API 폼  -->
	<form id="dataForm">
		<input type="hidden" name="key" value="10036FCE-3940-374C-B2ED-E6FBDF47CFA9">
		<input type="hidden" name="domain" value="http://localhost:8080">
		<input type="hidden" name="service" value="data">
		<input type="hidden" name="version" value="2.0">
		<input type="hidden" name="request" value="getfeature">
		<input type="hidden" name="format" value="json">
		<input type="hidden" name="size" value="1000">
		<input type="hidden" name="page" value="1">
		<input type="hidden" name="data" value="LT_C_SPBD">
		<input type="hidden" name="geometry" value="true">
		<input type="hidden" name="attribute" value="true">
		<input type="hidden" name="crs" value="EPSG:900913">
		<!-- <input type="hidden" name="geomfilter" value="BOX(14028876.609587036,3912653.333809428,14151175.854843318,3974414.4526638505)"> -->
		<input type="hidden" name="geomfilter" value="POINT(14028876.609587036 3912653.333809428)">
	</form>
</div>
<div>
	<ul id="result_ajax">
		<li></li>
	</ul>
	<p id="result_count"></p>
	<p id="result_pos"></p>
</div>
<div id="data_result"></div>

<script type="text/javascript">
	vw.ol3.MapOptions = {
	    basemapType: vw.ol3.BasemapType.GRAPHIC
	  , controlDensity: vw.ol3.DensityType.EMPTY
	  , interactionDensity: vw.ol3.DensityType.BASIC
	  , controlsAutoArrange: true
	  , homePosition: vw.ol3.CameraPosition
	  , initPosition: vw.ol3.CameraPosition
	}; 
	vmap = new vw.ol3.Map("vmap",  vw.ol3.MapOptions); 
	
	var search = function(){
		
		var markerLayer; // 마커를 담을 레이어 선언
		if(markerLayer==null){
			markerLayer = new vw.ol3.layer.Marker(vmap);
		}
		markerLayer.set("name","마커레이어"); //마커레이어에 이름을 적용하여 검색 결과 초기화
		
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
					
					var result_html ="";
					
					
					for(var o in data.response.result.items){ 
						if(o==0){
							move(data.response.result.items[o].point.x*1,data.response.result.items[o].point.y*1);
						}
						vw.ol3.markerOption = {
							x : data.response.result.items[o].point.x,
							y : data.response.result.items[o].point.y,
							epsg : "EPSG:3857",
							title : data.response.result.items[o].address.bldnm,
							contents : data.response.result.items[o].address.road,
							iconUrl : 'http://map.vworld.kr/images/ol3/marker_blue.png'
							
						}; //마커 옵션 설정
						
						result_html += "<li><p onclick='move("+data.response.result.items[o].point.x+","+data.response.result.items[o].point.y+")'> road: "+ data.response.result.items[o].address.road +" parcel: "+ data.response.result.items[o].address.parcel +" </p></li>";
						
						markerLayer.addMarker(vw.ol3.markerOption);// 마커를 레이어에 등록
						markerLayer.getSource().getFeatures()[o].set("식별자","ID_"+o);
					}
					
					
					$('#result_ajax').html(result_html);  //result_ajax 라는 id 값이 있는곳의 html을 수정한다 
					$('#result_count').text(data.response.record.total+"건이 검색되었습니다.");
					
				}
				
				
			},
			complete:function(){
				
			},
			error: function(xhr, stat, err) {}
		});
		
		
		vmap.removeLayer(vmap.getLayerByName("마커레이어")) //vmap.getLayerByName(레이어명)
		vmap.addLayer(markerLayer) //마커를 vmap에 등록
	}

	var move = function(x,y){
		vmap.getView().setCenter([ x, y ]); // 지도 이동
		vmap.getView().setZoom(17); // 줌레벨 설정
	}
	
	
	/* 폴리곤의 스타일 설정 */
	var vectorStyle = function(feature) {
	    var style = new ol.style.Style({
		    stroke: new ol.style.Stroke({
		        color: [0, 256, 0, 1],
		        width: 5
		    }),
		    fill: new ol.style.Fill({
		        color: [256, 0, 0, .7]
		    })
	    });
	    return [style];
	}
	
	vmap.on('singleclick', function(evt) {
		var coordinate = evt.coordinate //좌표정보
		var pixel = evt.pixel // 픽셀정보
		
		
		 // 클릭한 지점이 feature나 layer 일 경우 이벤트를줌 
		vmap.forEachFeatureAtPixel(pixel, function(feature, layer) {
        	var title = feature.get("title");
        	if(title.length>0){ // 도로명주소 건물 정보가 있으면 Data API 호출
        		console.log(title);
        		
        		var point = coordinate[0]+" "+coordinate[1];
     			$('[name=geomfilter]').val('POINT('+point+')');
     			
     			$.ajax({
    		    	type: "get",
    		    	url: "http://api.vworld.kr/req/data",
    		    	data : $('#dataForm').serialize(),
    		    	dataType: 'jsonp',
    		    	async: false,
    		    	success: function(data) {
    		    		if(data.response.status =="NOT_FOUND"){
    						console.log(" Data API 결과가 없습니다.");
    					}else{
	    		    	    var vectorSource = new ol.source.Vector({features: (new ol.format.GeoJSON()).readFeatures(data.response.result.featureCollection)})
	    		    	    
	    		    		vmap.getLayers().forEach(function(layer){
	    		    			if(layer.get("name")=="search_result"){
	    		    				vmap.removeLayer(layer);//기존결과 삭제
	    		    			}
	    		    		})
	    		    	    var vector_layer = new ol.layer.Vector({
	    		    	  	  source: vectorSource,
	    		    	  	  style: vectorStyle
	    		    	  	})
	    		    	    
	    		    	    vector_layer.set("name","search_result");
	    		    	 	vmap.addLayer(vector_layer);
	    		    	 	
	    		    	 	var resultFeature = vectorSource.getFeatures()[0]
	    		    	 	if(typeof resultFeature == "object"){
	    			        	var featurehtml="";
	    			        	for(var i in resultFeature.getKeys()){ 
	    			        		featurehtml += resultFeature.getKeys()[i] + " = "+resultFeature.get(resultFeature.getKeys()[i])+"\n";
	    			        	}
	    			        	$('#data_result').html(featurehtml);
	    		    	 	}
    					}
    		    	},
    		    	
    		    	error: function(xhr, stat, err) {}
    		    });
        	}
        });
	})
	
	$(document).on("click","#onoff",function(){
		if($(this).is(":checked")){
			var wmslayer = vmap.addNamedLayer("도로명주소건물","LT_C_SPBD")
			var wmslayer2 = vmap.addNamedLayer("도로명주소도로","LT_L_SPRD")
			vmap.addLayer(wmslayer);
			vmap.addLayer(wmslayer2);
		}else{
			var layerName = vmap.getLayerByName("도로명주소도로") // name 값으로 레이어 선택
			vmap.removeLayer(layerName) //vmap.getLayerByName(레이어명)
			var layerName2 = vmap.getLayerByName("도로명주소건물") // name 값으로 레이어 선택
			vmap.removeLayer(layerName2) //vmap.getLayerByName(레이어명)
		}
	})


	//마커 이동 이미지 변화구현

	var move_change = function(){

		if(vmap.getLayerByName("마커레이어")==null){
			alert("마커가 없습니다. 검색먼저 실행해주세요");
			return;
		}
		var clickFeatures = vmap.getLayerByName("마커레이어").getSource().getFeatures()

		var imgSrc = "http://map.vworld.kr/images/ol3/marker_blue.png"
		if(clickFeatures[0].getStyle().getImage().getSrc().indexOf("blue")>-1){
			imgSrc= 'http://map.vworld.kr/images/ol3/marker.png'
		}
						
		var iconStyle = new ol.style.Style({
			image: new ol.style.Icon(/** @type {olx.style.IconOptions} */ ({
				anchor: [0.5, 46], //마커 이미지의 절대위치를 변경
				anchorXUnits: 'fraction',
				anchorYUnits: 'pixels',
				src: imgSrc
			}))
		});

		clickFeatures[0].setStyle(iconStyle) // 마커의 스타일(이미지)를 변경 

		//기존좌표
		var oldcoor =  clickFeatures[0].getGeometry().getCoordinates();
		//vmap.getLayerByName("마커레이어").getSource().getFeatures()[0].getGeometry().getCoordinates();

		var newcoor = [14128721.120936994, 4521345.062383187];
		clickFeatures[0].getGeometry().setCoordinates(newcoor); //좌표값을 변경
		move(newcoor[0],newcoor[1]);//해당위치로 이동
	}

	var move_select = function(value){ //선택한 식별자의 마커 이미지 변경
		if(vmap.getLayerByName("마커레이어")==null){
			alert("마커가 없습니다. 검색먼저 실행해주세요");
			return;
		}
		var clickFeatures = vmap.getLayerByName("마커레이어").getSource().getFeatures()
		// 마커 레이어를 가지고옴 


		clickFeatures.forEach(function(feature){

			if("ID_"+value == feature.get("식별자")){ // for 문을 돌리면서 해당 ID 값 객체를가지고옴
				var imgSrc = "http://map.vworld.kr/images/ol3/marker_blue.png"
				if(feature.getStyle().getImage().getSrc().indexOf("blue")>-1){
					imgSrc= 'http://map.vworld.kr/images/ol3/marker.png'
				}
				var iconStyle = new ol.style.Style({
					image: new ol.style.Icon(/** @type {olx.style.IconOptions} */ ({
						anchor: [0.5, 46], //마커 이미지의 절대위치를 변경
						anchorXUnits: 'fraction',
						anchorYUnits: 'pixels',
						src: imgSrc
					}))
				});

				feature.setStyle(iconStyle);
			}
		})
	}

</script>
</body>
</html>