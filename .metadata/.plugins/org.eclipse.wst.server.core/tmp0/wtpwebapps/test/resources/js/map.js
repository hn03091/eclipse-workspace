
$(document).ready(function(){
    //
    var map2V; 
    var map1V;
    var checkroadview;
    
    //////////geoserver wms////////////////
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
    //checkbox on.off 체크박스값 가져오기.//
    
    //----------2번 지도 WMS----------//
    $("#sig").change(function(){
        if($("#sig").is(":checked")){
        
            map1.addLayer(sigWms);
            
        }else{
            map1.removeLayer(sigWms);
        }
    });
    $("#ctp").change(function(){
        if($("#ctp").is(":checked")){
            map1.addLayer(ctpWms);
            
        }else{
            map1.removeLayer(ctpWms);
           
        }
    });
    $("#icon").change(function(){
        if($("#icon").is(":checked")){
            console.log('쉼터on');
            shimtuOn();            
        }else{
            console.log('쉼터off');
            shimtuOff();         
              
        }
    });
    $("#accident").change(function(){
        if($("#accident").is(":checked")){
            console.log('On');
            accidentOn(map1);
        }else{
        	console.log('Off');
            accidentOff(map1);     
        }
    });
    /*
    $("#icon").change(function(){
        if($("#icon").is(":checked")){
            map1.addLayer(iconWms);
            $('#info').show();
            var view = map1.getView();
            map1.on('singleclick', function (evt) {
                document.getElementById('info').innerHTML = '';
                var viewResolution = (view.getResolution());
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
        }else{
            map1.removeLayer(iconWms);
            $('#info').hide();
            
        }
    });*/
    //----------2번 지도 WMS----------//
    $("#sig2").change(function(){
        if($("#sig2").is(":checked")){
            map2.addLayer(sigWms);
            
        }else{
            map2.removeLayer(sigWms);
            
        }
    });
    $("#ctp2").change(function(){
        if($("#ctp2").is(":checked")){
            map2.addLayer(ctpWms);
            
            
        }else{
            map2.removeLayer(ctpWms);
           
        }
    });
    
    $("#icon2").change(function(){
        if($("#icon2").is(":checked")){
            map2.addLayer(iconWms);
            $('#info').show();
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
            
        }else{
            map2.removeLayer(iconWms);
            $('#info').hide();
        }
    });
    $("#map1op").change(function(){
        if($("#map1op").is(":checked")){
            mapControl1(map1);
            $("#map1opWrap").hide();
            
        }
    });
    

    
    //------------지도 분할 ------------//
    $("#mapb").change(function(){
        if($('#mapb').is(":checked")){
            
            $('#mapOn').show();
            $('#map2option').show();
            $('#map2op').show();
            $('#wms2').show();
            
            $("#map1").css("width", "49%");
            $("#map2").css("width","49%");
            
            map1.updateSize();
            map2.updateSize();
        }else{
            $('#mapOn').hide();
            $('#map2op').hide();
            $('#map2option').hide();
            $('#wms2').hide();
            $('#selectOption2').hide();
            $("#map1").css("width","100%");
            $("#map2").css("width","0%");

            
            map1.updateSize();
            map2.updateSize();
        }
    })
    $("#map1b").change(function(){
        if($("#map1b").is(":checked")){
        /*    $("#map2").css("width","0%");
            $("#map2").css("display:none");
            $("#map1").css("width", "100%");
            map1.updateSize();
        */
        }else{
        /*    $("#map2").css("width","48%");
            $("#map2").css("display:block");
            $("#map1").css("width", "48%");
        */
        }
        map = $('input:checkbox[id="map1b"]:checked').val();
        
    })
    $("#map2b").change(function(){
        if($("#map2b").is(":checked")){
        /*    $("#map1").css("width","0%");
            $("#map1").css("display:none");
            $("#map2").css("width", "98%");
            map2.updateSize();
        */
        }else{
        /*    $("#map1").css("width","48%");
            $("#map1").css("display:block");
            $("#map2").css("width", "48%");
        */
        }

        map = $('input:checkbox[id="map2b"]:checked').val();
        
    })
    /*
    $("#roadview").change(function(){
        var checked = $("#roadview").is(":checked");
        console.log('checked : ', checked);
        if (checked) {
            checkroadview='on';
            roadview(map1);
            //roadview(map2);
        } else {
            checkroadview='off';
        }
    });*/
    
    /////////////////////


    

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


    var option1 = {
        selecter: 'map1',
        mouseControlCoordinate: mouseControlCoordinate
    }

    var option2 = {
        selecter: 'map2',
        mouseControlCoordinate: mouseControlCoordinate2
    }
//지도 생성
    var map1 = createMap(option1);
    var map2 = createMap(option2);

    roadview(map1);
	
    searchIndex(map1);
    searchIndex2(map2);

    mapMakrerCreate(map1);
    mapMakrerCreate(map2);
    
    //마우스 핸들러
    //mapControl1(map1);
    mapControl2(map2);
        
    
    //mapControl2();
    //map2Control(map2);
    
    

    


    
    

});