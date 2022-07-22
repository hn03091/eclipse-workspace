$(document).ready(function(){
	
	var mouseControlCoordinate = new ol.control.MousePosition({
        coordinateFormat : new ol.coordinate.createStringXY(4),
        projection : 'EPSG:3857',//좌표계 설정
        className : 'mposition', //css 클래스 이름
        target : document.getElementById('mouseCoordinate'),//좌표를 뿌릴 element
    });
    
    var option= {
        selecter: 'map',
        mouseControlCoordinate: mouseControlCoordinate
    }
    var map = createMap(option);
	var AedWms = new ol.layer.Tile({
        opacity:1,
        scale:10,
        source : new ol.source.TileWMS({
            url : 'http://localhost:8090/geoserver/cite/wms?service=WMS', // 1. 레이어 URL
            params : {
                'VERSION' : '1.1.0', // 2. 버전
                'LAYERS' : 'cite:Aed_point', // 3. 작업공간:레이어 명                
                'SRS' : 'EPSG:3857', // SRID
                'FORMAT' : 'image/png' // 포맷
            },
            
            serverType : 'geoserver',
        })
    });
    var AccidentWms = new ol.layer.Tile({
    	opacity:1,
    	scale:10,
    	source:new ol.source.TileWMS({
    		url : 'http://localhost:8090/geoserver/cite/wms?service=WMS',
    		params :{
    			'VERSION' : '1.1.0',
    			'LAYERS'  : 'cite:accident',
    			'SRS'	: 'ESPG:3857',
    			'FORMAT' : 'image/png'
    		},
    		serverType :'geoserver',
    	})
    });
    var pmWms = new ol.layer.Tile({
    	opacity:1,
    	scale:10,
    	source:new ol.source.TileWMS({
    		url : 'http://localhost:8090/geoserver/cite/wms?service=WMS',
    		params :{
    			'VERSION' : '1.1.0',
    			'LAYERS'  : 'cite:pharmacy',
    			'SRS'	: 'ESPG:3857',
    			'FORMAT' : 'image/png'
    		},
    		serverType :'geoserver',
    	})
    });
    
    $("#Pharmacy").change(function(){
        if($("#Pharmacy").is(":checked")){
            console.log('Pharmacy check On');
            map.addLayer(pmWms);
            $('#info').show();
            var view = map.getView();
            map.on('singleclick', function (evt) {
                document.getElementById('info').innerHTML = '';
                var viewResolution = (view.getResolution());
                var source = pmWms.getSource();
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
        }else{
            console.log('Pharmacy check Off');
        	map.removeLayer(pmWms);
        
        }
    });
    
    
	$("#Aed").change(function(){
        if($("#Aed").is(":checked")){
            console.log('AED check On');
            map.addLayer(AedWms);
            $('#info').show();
            var view = map.getView();
            map.on('singleclick', function (evt) {
                document.getElementById('info').innerHTML = '';
                var viewResolution = (view.getResolution());
                var source = AedWms.getSource();
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
        }else{
            console.log('AED check Off');
        	map.removeLayer(AedWms);
        }
    });
    var normal  = new ol.source.XYZ({
		url: 'https://map.ngii.go.kr/openapi/Gettile.do?service=WMTS&request=GetTile&version=1.0.0&layer=korean_map&style=korean&format=image/png&tilematrixset=korean&tilematrix=L{z}&tilerow={y}&tilecol={x}&apikey=A7EC92E2BF6E49D7E3EDD4307A381D74'
	});

    $("#Accident").change(function(){
    	if($("#Accident").is(":checked")){
    		console.log("accident check On");
    		map.addLayer(AccidentWms);
    		$('#info').show();
            var view = map.getView();
            map.on('singleclick', function (evt) {
                document.getElementById('info').innerHTML = '';
                var viewResolution = (view.getResolution());
                var source = AccidentWms.getSource();
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
    	}else{
    		console.log("accident check Off");
    		map.removeLayer(AccidentWms);
    	}
    });
    
	
})