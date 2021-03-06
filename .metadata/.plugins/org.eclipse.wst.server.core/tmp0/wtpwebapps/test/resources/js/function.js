
/**
*	list[?]
*	0=졸음쉼터명, 1=도로노선명, 2=도로노선방향, 3= 화장실 유무, 4= 관리기관명,
*	5= 관리기관 전화번호, 6=쉼터주소, 7=도로명 주소, 8=x좌표, 9=y좌표
*
*/
var shLayer;
function shimtuOn(){
	var index2 = 1;
	var shStyle = new ol.style.Style({
                image: new ol.style.Icon({
                    anchor: [0.5, 0.5],
                    scale:0.2,
                    src: "/images/egovframework/example/poi21.png"
                }),
                zindex: 1001
            });
    var shFeature;
	var shSource = new ol.source.Vector();
	shSource.set("name","마커레이어");
	
	var SHLTR_NM;	//졸음쉼터명
	var ROAD_NM;	//도로노선명
	var ROAD_DRC;	//도로노선방향
	var TOILET_YN;	//화장실 유무
	var MNG_NM;		//관리 기관명
	var MNG_TEL;	//관리기관 전화번호
	var ADRES;		//쉼터주소
	var RN_ADRES;	//도로명 주소
	var xlon;		//x
	var ylat;		//y
	
	while(index2 !=247){	//246번까지 반복문 index2값이 247이 되면 멈추도록 조건
		if(index2 !=7){		//obj값이 7번이 없음.
			var list = new Array();	//배열로 졸음쉼터 hidden값  저장
			$("input[name='"+index2+"']").each(function(index, item){	//obj값이 246번될떄 까지 배열속에 값을 넣어서 원하는 값 가져오기
				   list.push($(item).val());
			});	
			SHLTR_NM= list[0]		//졸음쉼터명
			ROAD_NM= list[1]		//도로노선명
			ROAD_DRC= list[2]		//도로노선방향
			TOILET_YN= list[3]		//화장실 유무
			MNG_NM= list[4]			//관리 기관명
			MNG_TEL= list[5]		//관리기관 전화번호
			ADRES= list[6]			//쉼터주소
			RN_ADRES= list[7]		//도로명 주소
			xlon= list[8]			//x축
			ylat= list[9]			//y축
			shFeature = new ol.Feature({
			                geometry: new ol.geom.Point([xlon,ylat])     //마커를 생성할 좌표 x,y 
			            });
			var marker_html="";
            marker_html+="<span>졸음쉼터 명 :"+SHLTR_NM+"<br> 도로노선 명 : "+ROAD_NM+"<br>도로노선 방향 : "+ROAD_DRC+"<br>화장실 유무 : "+TOILET_YN+"<br>관리 기관명 : "+MNG_NM+"<br>관리기관 전화번호 : "+MNG_TEL+"<br>쉼터주소 : "+ADRES+"<br>도로명 주소 : "+RN_ADRES+"<span>";
            cont ="123";
            shFeature.set("subj",marker_html);  //html로 팝업내용 저장
            shFeature.set("cont",cont); 
			shSource.addFeature(shFeature);
			
			index2= index2+1;
		}else if(index2 ==7){	//7번 없음
			index2=index2+1;
		}
	}
	shLayer = new ol.layer.Vector({
                            source: shSource, //마커 feacture들
                            style: shStyle //마커 스타일
                        });
	map1s.addLayer(shLayer);
}
function shimtuOff(){
	map1s.removeLayer(shLayer);
}


var VworldHybrid = new ol.source.XYZ({
    url: 'http://api.vworld.kr/req/wmts/1.0.0/10036FCE-3940-374C-B2ED-E6FBDF47CFA9/Hybrid/{z}/{y}/{x}.png'
}); //문자 타일 레이어

var VworldSatellite = new ol.source.XYZ({
    url: 'http://api.vworld.kr/req/wmts/1.0.0/10036FCE-3940-374C-B2ED-E6FBDF47CFA9/Satellite/{z}/{y}/{x}.jpeg'
    
}); //항공사진 레이어 타일

var VworldBase = new ol.source.XYZ({
    url: 'http://api.vworld.kr/req/wmts/1.0.0/10036FCE-3940-374C-B2ED-E6FBDF47CFA9/Base/{z}/{y}/{x}.png'

});

//지도를 불러오기 위함.
var map1s;
var map2s;

/**
 * 지도를 생성 해주는 함수
 * @param {object} option 지도 생성시에 필요한 옵션 값
 * @returns Map
 */
function createMap(option) {
    var map = new ol.Map({
        controls: ol.control.defaults().extend([
            option.mouseControlCoordinate
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
        ],
        target: option.selecter,
        view: new ol.View({
            center: ol.proj.transform([14324890.296973, 4277891.7105477], 'EPSG:3857', 'EPSG:900913'),
            zoom: 16,
            minZoom: 0,
            maxZoom: 21
        })
    });

    return map;
}


//마커를 찍기위한 함수
function mapMakrerCreate(map) {
    map.on('click', function(evt) {
        var coordinate = evt.coordinate;
        var x = coordinate[0];  // 지도에 클릭된 x,y 좌표
        var y = coordinate[1];
        
        var markerOn = $('input:radio[name="selcetType"]:checked').val(); //마커 기능 체크 확인
        var iconSrc = $('input:radio[name="mkType"]:checked').val(); //이미지 밸류값 가져오기
        
        if (markerOn == 'MarkerOn') {  //마커 기능을 체크했을 때

            var subj = document.getElementById('subj').value//작성한 팝업제목 값
            var cont = document.getElementById('cont').value//작성한 팝업내용 값
            var marker_html="";
            marker_html+= "<span>작업 제목 :"+subj+"<hr>작업 내용 :"+cont+"<span>"; //html로 변형
            
            
            var markerFeature = new ol.Feature({
                geometry: new ol.geom.Point([x, y])     //마커를 생성할 좌표 x,y 
            }); 
            
            var markerStyle = new ol.style.Style({
                image: new ol.style.Icon({
                    anchor: [0.5, 0.5],
                    src: iconSrc
                })
            });
            setId =  Math.random();                 //마커에 랜덤으로 저장할 아이디 생성
            markerFeature.setStyle(markerStyle);    //스타일 저장
            markerFeature.setId(setId);             //아이디 저장
            markerFeature.set("subj",marker_html);  //html로 팝업내용 저장
            markerFeature.set("cont",cont);         //팝업의 내용이 있고 없음을 cont로 구분하기 때문에 cont 에도 값을 저장함.
                                                    //cont에 내용이 없을 경우 선택할시 팝업 내용이 나타나지않음.

            var markerSource = new ol.source.Vector({
                features: [markerFeature]
            });

            var markerLayer = new ol.layer.Vector({
                source: markerSource,
            });
            
            map.addLayer(markerLayer);
        }
        
    });
}


// 배경지도 함수

function tileChange(){

    var tileValue = $('input:radio[name="tile"]:checked').val();
                    
    //var tileLength = $('input:checkbox[id="vworldTile"]:checked').length;
    //var tileValue = $('input:checkbox[id="vworldTile"]:checked').val();
    map1b = $('input:checkbox[id="map1b"]:checked').val();
    map2b = $('input:checkbox[id="map2b"]:checked').val();
    
    
       if(tileValue=="Satelite"){
            if(map1b != null){
                map1s.getLayers().forEach(function (layer) {
                    if (layer.get("name") == "vworld") {
                        layer.setSource(VworldSatellite)
                    }
                })
            }
            if(map2b != null){
                map2s.getLayers().forEach(function(layer){
                    if(layer.get("name") =="vworld"){
                        layer.setSource(VworldSatellite)
                    }
                })
            }
        }else if(tileValue=="Base"){
            if(map1b != null){
                map1s.getLayers().forEach(function (layer) {
                    if (layer.get("name") == "vworld") {
                        layer.setSource(VworldBase)
                    }
                })
            }
            if(map2b != null){
                map2s.getLayers().forEach(function(layer){
                    if(layer.get("name") =="vworld"){
                        layer.setSource(VworldBase)
                    }
                })
            }
        }

    }

    //-------------마우스핸들러------------------//


function mapControl1(map){

    function pointerMoveHandler(event){
        var features = map.getFeaturesAtPixel(event.pixel);
        if (!features) {
                // 마우스 위치에 어떠한 Feature도 없음
            return;
            }
            // 마우스 포인터 위치에 존재하는 Feature 중 첫번째(features[0])
        var properties = features[0].getProperties();  
            // properties 객체가 object 타입의 Feature에 대한 속성값임
            
            
        }
        
        // 그리기 옵션 및 마우스 오버레이 //
        var sketch;                                             //draw를 시작할때 sketch에 타입 선택값을 저장. 오버레이 제어 및 그리기 옵션 제어
        var helpTooltipElement;                                 //지도를 이동할때 커서 오버레이 제어
        var helpTooltip;                                        //마우스 이동시 오버레이
        var measureTooltipElement;                              //면적 길이 오버레이
        var measureTooltip;                                     //면적 길이 오버레이
        var continuePolygonMsg = 'polygon을 그리는 중입니다.';   //폴리곤을 시작할때 
        var continueLineMsg = '선 을 그리는 중입니다.';          //길이를 측정할때
        

            
        var pointerMoveHandler = function (evt) {
            if (evt.dragging) {
                return;
                }
                  
            var helpMsg ='지도를 이동하세요.';
            

            if (sketch) {
                var geom = (sketch.getGeometry());
                
                if (geom instanceof ol.geom.Polygon) {  //sketch에 저장된 draw이벤트가 polygon 일 경우
                    helpMsg = continuePolygonMsg;
                    }else if (geom instanceof ol.geom.LineString) { //sketch에 저장된 draw이벤트가 line 일 경우
                        helpMsg = continueLineMsg;
                    }
            }
            helpTooltipElement.innerHTML = helpMsg;
            helpTooltip.setPosition(evt.coordinate);

            helpTooltipElement.classList.remove('hidden');

                
            };
    var typeSelect = document.getElementById('type');   //draw 옵션 값 찾아오기
    //var mkSelect = document.getElementById('mkType');
        
        
        


    var draw; // 선과 넓이를 그리기위함


    var formatLength = function (line) {    //선 길이구하기
        
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


    var formatArea = function (polygon) {   //넓이 구하기
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


            
    helpTooltip = new ol.Overlay({  //마우스 커서 오버레이
            element: helpTooltipElement,
            offset: [15, 0],
            positioning: 'center-left'
        });

          
    //포인트 무브
    map.on('pointermove', pointerMoveHandler);
    map.getViewport().addEventListener('mouseout', function () {
        helpTooltipElement.classList.add('hidden');
    });

    

    function addInteraction() {
        var type = '';  //그리기 옵션값을 확인 면적인지 길이인지 선택인지
        if (typeSelect.value == 'area') {
            type = 'Polygon';
            $("#selectOption").hide();
            
            $("input:radio[name='selcetType']:radio[value='0']").prop('checked', true); // 선택기능이 아닐시 선택기능의 지도이동 버튼 체크 
            
        } else if (typeSelect.value == 'length') {
            type = 'LineString';
            $("#selectOption").hide();
            
            $("input:radio[name='selcetType']:radio[value='0']").prop('checked', true); // 선택기능이 아닐시 선택기능의 지도이동 버튼 체크 
                

        } else if (typeSelect.value == 'Circle') {
            type = 'Circle';
        /* }else if (typeSelect.value == 'Point') {
            type = 'Point';
         */   
        } else if (typeSelect.value == 'Select') {
            $("#selectOption").show();
            var select; 
            
            select = new ol.interaction.Select({
                condition: ol.events.condition.click
            })
            select.set("이벤트", "선택");
            select.on("select", function (evt) {
            
                var length = evt.target.getFeatures().getLength();              //마우스가 선택한곳에 feature 여부 확인
                if (length > 0) {                                               //feature 있을경우
                    var popup_Test ="";
                    subj = evt.target.getFeatures().getArray()[0].get("subj");  //feature에 저장된 subj값 가져오기
                    cont = evt.target.getFeatures().getArray()[0].get("cont");  //팝업 내용이 있는지 없는지 확인하기 위해 저장해둔 cont값 불러오기.
                    
                    var features = evt.target.getFeatures().getArray();         //features에 선택된 feature 저장
                    var feature = features[0]                                   //1개 밖에없겠지만 2개이상일경우 첫번째값을 feature에 저장
                    var getLayer = select.getLayer(feature); //마커 옵션중 마커를 변경하기위해선 레이어를 계속 추가해야함으로 선택된 feature의 레이어를 찾아야함.
                    
                    var deleteMk = $('input:radio[name="selcetType"]:checked').val();   //선택기능중 feature 삭제 기능 체크하기위함
                    
                    if(deleteMk =='deleteMarker'){
                        var ftId=feature.getId();	//생성된 feautre 아이디를 구함
                        
                        if(ftId !=null){	
                            var olId=map.getOverlayById(ftId);	//면적넓이와 길이 오버레이를 feature id로 찾아냄
                            map.getOverlays().getArray().slice(0).forEach(function(measureTooltip) {
                                map.removeOverlay(olId); //해당 feature의 오버레이를 삭제
                            });
                        }

                        getLayer.getSource().removeFeature(feature);//선택된 feautre의 레이어 중 선택된 feature을 삭제

                        
                    }
                    if(deleteMk!='deleteMarker'){   //마커를 삭제할경우 팝업내용은 보이지않음.
                        if(cont != ''){
                            $('#popupTest').show();    //저장된 팝업내용보이기
                            $("#popupTest").css("left", "14%"); //첫번째 지도임으로 왼쪽으로 css변경
                        }else if(cont ==''){
                            $('#popupTest').hide(); //팝업내용이 없을경우 cont는 널값임. 있을경우는 임의의 값이 cont에 저장되어있음
                        }
                    }
                    
                    popup_Test += '<p style="float:right;"><a href="#" onclick="javascript:popup_delete();">닫기</a><p>'+subj;  //팝업내용 닫기 html subj=팝업제목과 내용을 넣은 html
                        $('#popupTest').html(popup_Test);   //팝업div에 html 저장
                        
                    
                }
            })
                map.addInteraction(select);
                return;
        
        }
        //면적과 길이를 작성하기 위한 vector 소스와 vector
        newSource = new ol.source.Vector({
                id: "sourceId"
                });
                newSource.set("name", "sourceName");

        newVector = new ol.layer.Vector({
                id: "vectorId",
                source: newSource,
                style: new ol.style.Style({
                    
                    fill: new ol.style.Fill({
                        color: 'rgba(52, 0, 0, 0.35)'
                    }),
                    stroke: new ol.style.Stroke({
                        color: '#000',
                        width: 2
                    })
                    /*,
                    image: new ol.style.Icon(({
                    anchor: [0.5, 10],
                    anchorXUnits: 'fraction',
                    anchorYUnits: 'pixels',
                    src: imgsrc
                    }))*/
                })
            });
            

        newVector.set("name", "vectorName");
        newVector.setZIndex(1000);
            
        //면적과 길이의 스타일 및 옵션
        draw = new ol.interaction.Draw({
            source: newSource,
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
        map.addLayer(newVector);    //그리기 옵션의 레이어를 지도에 추가
        map.addInteraction(draw);   //실행함수 호출
    
        

        createMeasureTooltip();     //길이와 면적의 오버레이.
        createHelpTooltip();        //마우스 커서 아래의 오버레이 (지도를 이동해주세요, 폴리곤을 그리는 중 입니다, 라인을 그리는 중입니다.)

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
                var subj = document.getElementById('subj').value    //작성된 팝업제목을 subj에 저장
                var cont = document.getElementById('cont').value    //작성된 팝업내용을 cont에 저장

                var marker_html="";
                marker_html+= "<span>작업 제목 :"+subj+"<hr>작업 내용 :"+cont+"<span>"; //html로 팝업을 저장
                
                feature.setId(setId);   // 선택시 삭제를 제어하기위하여 난수를 id로 저장

                feature.set("subj",marker_html);    //subj 에 팝업 html을 저장
                feature.set("cont",cont);           //팝업 제어를 위하여 cont를 저장 -> 팝업내용이없을경우 cont==null 임으로 선택시 나오지않음. 
                $("#subj").val("");                 //팝업 제목과 내용을 입력하는 textarea 값을 초기화
                $("#cont").val("");
                measureTooltipElement.className = 'tooltip tooltip-static';
                measureTooltip.setOffset([0, -7]);
                
                sketch = null;
                
                measureTooltipElement = null;
                createMeasureTooltip();     //면적오버레이를 넣기 위해 실행
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
        
            map.addOverlay(helpTooltip); //커서에 달린 도움말

        
    }

    var setId;


    function createMeasureTooltip() {
        if (measureTooltipElement) {
            measureTooltipElement.parentNode.removeChild(measureTooltipElement);
        }
        measureTooltipElement = document.createElement('div');
        measureTooltipElement.className = 'tooltip tooltip-measure';
        setId =  Math.random(); //삭제를 제어하기위함 :draw하기전에 제일먼저 실행이 됨으로 이곳에서 setId에 저장함 
                                //이후 feature에 setId 값을 그대로들고 가서 feature와 면적길이의 오버레이가 같은 id로 저장됨.
        measureTooltip = new ol.Overlay({
            id:setId,
            element: measureTooltipElement, //넓이와 길이
            offset: [0, -15],
            positioning: 'bottom-center'
        });
        
            map.addOverlay(measureTooltip); //넓이와 길이 오버레이 추가
        

    }
    
    typeSelect.onchange = function () { //그리기 타입의 선택한 기능을 확인
        map.removeInteraction(draw);    //이전 사용중이던 draw 기능 삭제
        map.getInteractions().getArray().forEach(function (i) {
            if (i.get("이벤트") == "선택") {
                map.removeInteraction(i);   //선택 기능일 경우 draw기능 모두삭제
                    
                
            }
        })
        addInteraction();   //컨트롤러를 다시실행함.
    };

    addInteraction();
}
// -----------지도2번 마우스핸들러---------------//
function mapControl2(map){
    function pointerMoveHandler(event){        
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
            }else if (geom instanceof ol.geom.LineString) {
                helpMsg = continueLineMsg;
                }
            }
            helpTooltipElement.innerHTML = helpMsg;
            helpTooltip.setPosition(evt.coordinate);

            helpTooltipElement.classList.remove('hidden');

                
            };
    var typeSelect = document.getElementById('type2');
    
        
        


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


            
    helpTooltip = new ol.Overlay({
            element: helpTooltipElement,
            offset: [15, 0],
            positioning: 'center-left'
        });

          
    //포인트 무브
    map.on('pointermove', pointerMoveHandler);
    map.getViewport().addEventListener('mouseout', function () {
        helpTooltipElement.classList.add('hidden');
    });

    

    function addInteraction() {
        var type = '';
        if (typeSelect.value == 'area') {
            type = 'Polygon';
            $("#selectOption2").hide();
            //$("input:radio[name='selcetType']:radio[value='0']").prop('checked', true); // 선택하기  
        } else if (typeSelect.value == 'length') {
            type = 'LineString';
            $("#selectOption2").hide();
            //$("input:radio[name='selcetType']:radio[value='0']").prop('checked', true); // 선택하기  
        } else if (typeSelect.value == 'Circle') {
            type = 'Circle';
        /* }else if (typeSelect.value == 'Point') {
            type = 'Point';
         */   
        } else if (typeSelect.value == 'Select') {
            $("#selectOption2").show();
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
                    var getLayer = select.getLayer(feature); //마커 옵션중 마커를 변경하기위해선 레이어를 계속 추가해야함으로 선택된 feature의 레이어를 찾아야함.
                    
                    
                    var deleteMk = $('input:radio[name="selcetType"]:checked').val();
                    
                    
                    if(deleteMk =='deleteMarker'){
                        var ftId=feature.getId();	//생성된 feautre 아이디를 구함
                        
                        if(ftId !=null){	//search 해서 생성된 마커에는 오버레이가 존재할수 없기때문에 id가 없음
                            var olId=map.getOverlayById(ftId);	//면적넓이와 길이 오버레이를 feautre id로 찾아냄
                            map.getOverlays().getArray().slice(0).forEach(function(measureTooltip) {
                                map.removeOverlay(olId); //해당 feature의 오버레이를 삭제
                            });
                        }

                        getLayer.getSource().removeFeature(feature);//선택된 feautre의 레이어 중 선택된 feature을 삭제

                        
                    }
                    if(deleteMk !='deleteMarker'){
                        if(cont != ''){
                            $('#popupTest').show();
                            $("#popupTest").css("left", "75%");
                        }else if(cont ==''){
                            $('#popupTest').hide();
                        }    
                    }
                    
                    
                    popup_Test += '<p style="float:right;"><a href="#" onclick="javascript:popup_delete();">닫기</a><p>'+subj;
                        $('#popupTest').html(popup_Test);
                        
                    
                }
            })
                map.addInteraction(select);
                return;
        
        }
        
        newSource = new ol.source.Vector({
                id: "sourceId"
                });
                newSource.set("name", "sourceName");

        newVector = new ol.layer.Vector({
                id: "vectorId",
                source: newSource,
                style: new ol.style.Style({
                    
                    fill: new ol.style.Fill({
                    color: 'rgba(52, 0, 0, 0.35)'
                    }),
                    stroke: new ol.style.Stroke({
                    color: '#000',
                    width: 2
                    })
                    /*,image: new ol.style.Icon(({
                    anchor: [0.5, 10],
                    anchorXUnits: 'fraction',
                    anchorYUnits: 'pixels',
                    src: imgsrc
                    }))*/
                })
            });
            

        newVector.set("name", "vectorName");
        newVector.setZIndex(1000);
    
        draw = new ol.interaction.Draw({
            source: newSource,
            type: type,
            style: new ol.style.Style({
                fill: new ol.style.Fill({
                    color: 'rgba(255, 255, 255, 0.2)'
                }),
                stroke: new ol.style.Stroke({
                    color: 'rgba(0, 0, 0, 0.5)',
                    lineDash: [10, 10],
                    width: 5
                })
                /*,image: new ol.style.Circle({
                    radius: 5,
                    stroke: new ol.style.Stroke({
                        color: 'rgba(0, 0, 0, 0.7)'
                    }),
                    fill: new ol.style.Fill({
                        color: 'rgba(255, 255, 255, 0.2)'
                    })
                })*/
            })
        });
        map.addLayer(newVector);
        map.addInteraction(draw);
        

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
                
                feature.setId(setId);

                feature.set("subj",marker_html);
                feature.set("cont",cont);
                $("#subj").val("");
                $("#cont").val("");
                
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
        
            map.addOverlay(helpTooltip); //커서에 달린 도움말

        
    }
    var setId;

    function createMeasureTooltip() {
        if (measureTooltipElement) {
            measureTooltipElement.parentNode.removeChild(measureTooltipElement);
        }
        measureTooltipElement = document.createElement('div');
        measureTooltipElement.className = 'tooltip tooltip-measure';
        setId =  Math.random();
        measureTooltip = new ol.Overlay({
            id:setId,
            element: measureTooltipElement,
            offset: [0, -15],
            positioning: 'bottom-center'
        });
        
            map.addOverlay(measureTooltip); //넓이와 길이
        

    }
    /*mkSelect.onchange = function(){
        console.log(mkSelect.value);
        var showmarker='';
        mksrc=mkSelect.value
        showmarker += "<img src="+mksrc+" />";
        $('#showmarker').html(showmarker);


        map.removeInteraction(draw);
        map.getInteractions().getArray().forEach(function (i) {
            if (i.get("이벤트") == "선택") {
                map.removeInteraction(i);
                    
                
            }
        })
        addInteraction();
    }*/
    typeSelect.onchange = function () {
        console.log(typeSelect.value);
        map.removeInteraction(draw);
        map.getInteractions().getArray().forEach(function (i) {
            if (i.get("이벤트") == "선택") {
                map.removeInteraction(i);
                    
                
            }
        })
        addInteraction();
    };

    addInteraction();
}




//---------------로드뷰-1번지도만 가능함(분할로 나오기때문에 2번까지하면 화면에 자리가없음. 할 필요성이 없음.--------------//
function roadview(map){ 
    // roadviewindex = $('input:checkbox[id="roadview"]:checked').val();
    // $("#type").val("Select").prop("selected", true); //값이 1인 option 선택
    // $("#type2").val("Select").prop("selected", true); //값이 1인 option 선택
    
    //     map.on('click', function(evt) {
    //             var coordinate = evt.coordinate;
            
    //             lon= coordinate[0];
    //             lat= coordinate[1];
    //             "<span>작업 제목 :"+subj+"<hr>작업 내용 :"+cont+"<span>";
                
    //             var tansform = ol.proj.transform([lon,lat], 'EPSG:3857', 'EPSG:4326')// 브이월드 좌표계에서 다음 지도 좌표계로 변환 EPSG:3857=>EPSG:4326
    //             if(roadviewindex !=null){
    //                 var roadview="https://map.kakao.com/link/roadview/"+tansform[1]+","+tansform[0];   // 로드뷰 불러오기
    //                 window.open(roadview, '로드뷰팝업', 'width=500, height=700, scrollbars=yes, resizable=no')
    //                 var roadhtml="";
    //                 roadhtml += "<iframe src=\""+roadview+"\" width=800px height=800px></iframe>";
    //                 console.log(roadhtml);
    //                 $('#road').html(roadhtml);
                    
    //             }
    //         });


    var rvContainer = document.getElementById('road'); //로드뷰를 표시할 div
    var rv = new kakao.maps.Roadview(rvContainer); //로드뷰 객체
    var rvClient = new kakao.maps.RoadviewClient(); //좌표로부터 로드뷰 파노ID를 가져올 로드뷰 helper객체
    
    var roadviewb;  //로드뷰 보기 기능을 제어하기 위함
    map.on('click', function(evt) {
        roadviewb = $('input:radio[name="selcetType"]:checked').val();  //로드뷰 보기 체크값
        var mapb = $('input:checkbox[id="mapb"]:checked').length;       //지도분할일시 아닐시를 체크
        if(roadviewb =='roadviewOn'){                  //로드뷰 보기가 체크되어있을경우
            $("#map1").css("width", "49%");            //지도 1번과 로드뷰가 표시될 div css 변경
            $("#road").css("width","49%");
            $('#road').show();                         //로드뷰 div show
            map1s.updateSize();                        //지도를 감싼 div가 커질경우 updatesize 함수를 사용하지않으면 깨짐.
            var coordinate = evt.coordinate;           //마우스 클릭시 evt.좌표를 구함 coordinate
            var lon = coordinate[0];                    //x
            var lat = coordinate[1];                    //y
            var transform = ol.proj.transform([lon, lat], 'EPSG:3857', 'EPSG:4326') //브이월드와 카카오로드뷰의 좌표를 3857에서 4326으로 변경
            var position = new kakao.maps.LatLng(transform[1], transform[0]);       //카카오 로드맵은 y,x 로 값을받나?..

            rvClient.getNearestPanoId(position, 50, function(panoId) {      //공부해야함.
                if (panoId != null) {
                    rv.setPanoId(panoId, position); //panoId와 중심좌표를 통해 로드뷰 실행
                }
            });
        }else{
            $("#map1").css("width", "90%");
            $("#road").css("width","0%");
            $('#road').hide();
            if(mapb != 0){
                $("#map1").css("width", "48%");
                $("#map2").css("width", "48%");
            }
            map1s.updateSize();
            
        }
    })
    
    
    var roadmarkerSource;   //로드뷰 이용시 지도에 생성될 마커 소스와 레이어
    var roadmarkerLayer;
    kakao.maps.event.addListener(rv, 'position_changed', function () {
        roadviewb = $('input:radio[name="selcetType"]:checked').val();
        if(roadviewb =='roadviewOn'){
            var position = rv.getPosition();
            
            var transform = ol.proj.transform([position.getLng(), position.getLat()], 'EPSG:4326', 'EPSG:3857'); //카카오 로드뷰의 좌표를 지도의 좌표로 변형
            map1s.getView().setCenter([transform[0],transform[1]]);         //x축 y축 넣어서 지도 위치 이동 및 확대
            map1s.getView().setZoom(17);
            //오픈레이어스 지도 위치 이동
            
            if(roadmarkerSource !=null){ //로드뷰 이동시 이전에 생성된 마커의 존재를 확인하고 마커를 삭제함.
                roadmarkerLayer.getSource().clear();
            }
            var roadMarker = new ol.Feature({
                geometry: new ol.geom.Point([transform[0], [transform[1]]])
            });
            
            var markerStyle = new ol.style.Style({
                image: new ol.style.Icon({
                    anchor: [0.5, 0.5],
                    scale: 0.3,
                    src: "/images/egovframework/example/car1.png"
                    //'https://developers.google.com/maps/documentation/javascript/examples/full/images/beachflag.png'
                })
            });
            
            setId =  Math.random(); //굳이 필요하진 않은거같은데 혹시 삭제할수도있으니 저장
            roadMarker.setStyle(markerStyle);
            roadMarker.setId(setId);
            roadMarker.set("cont",'');
        
            roadmarkerSource = new ol.source.Vector({
                features: [roadMarker]
            });
        
            roadmarkerLayer = new ol.layer.Vector({
                source: roadmarkerSource,
            });
            
            map1s.addLayer(roadmarkerLayer);
        }
    });
}

/*function roadview(){
    roadviewindex = $('input:checkbox[id="roadview"]:checked').val();
    console.log(roadviewindex);
    
        map1s.on('click', function(evt) {
                var coordinate = evt.coordinate;
            
                lon= coordinate[0];
                lat= coordinate[1];
                
                var tansform = ol.proj.transform([lon,lat], 'EPSG:3857', 'EPSG:4326')// 브이월드 좌표계에서 다음 지도 좌표계로 변환 EPSG:3857=>EPSG:4326
                if(roadviewindex !=null){
                    var roadview="https://map.kakao.com/link/roadview/"+tansform[1]+","+tansform[0];   // 로드뷰 불러오기
                    window.open(roadview, '로드뷰팝업', 'width=500, height=700, scrollbars=yes, resizable=no')
                }
            });
        map2s.on('click', function(evt2) {
                var coordinate = evt2.coordinate;
            
                lon2= coordinate[0];
                lat2= coordinate[1];
                
                var tansform2 = ol.proj.transform([lon2,lat2], 'EPSG:3857', 'EPSG:4326')// 브이월드 좌표계에서 다음 지도 좌표계로 변환 EPSG:3857=>EPSG:4326
                if(roadviewindex !=null){
                    var roadview2="https://map.kakao.com/link/roadview/"+tansform2[1]+","+tansform2[0];   // 로드뷰 불러오기
                    window.open(roadview2, '로드뷰팝업', 'width=500, height=700, scrollbars=yes, resizable=no')
                }
            });
    
}*/

    
    

//search 함수

var markerSource;
var markerSource_2;
var markerLayer
var markerLayer_2

//버튼 체크를 확인하기위함.
var map1b;
var map2b;

function searchIndex(map1){ //지도 값 가져오기
    map1s=map1;
}
function searchIndex2(map2){
    map2s=map2;
}

var search = function(){
    map2b = $('input:checkbox[id="map2b"]:checked').val(); //2번지도에 검색을할지
    map1b = $('input:checkbox[id="map1b"]:checked').val(); //1번지도에 검색을할지 선택
    
    var imgsrc = $('input:radio[name="searchMk"]:checked').val();   //마커 선택
    if(map1b!=null){        //1번지도가 체크되어있을경우에
        if(markerSource==null){	        // 첫 검색시 마커 소스 생성
                markerSource = new ol.source.Vector();
            }else if(markerSource !=null){ //  두번째 검색시 이전 검색의 소스와 마커 스타일 초기화
                markerLayer.getSource().clear();
                markerLayer.setStyle();
            }
        if(markerSource2 != null){	//이전 검색시 이동하여 생성한 마커삭제]
            markerLayer2.getSource().clear();
                    
        }
    }
    if(map2b !=null){   //2번지도 나머지기능은 위와 동일
        if(markerSource_2==null){    
            markerSource_2 = new ol.source.Vector();
            }else if(markerSource_2 !=null){
                markerLayer_2.getSource().clear();
                markerLayer_2.setStyle();
            }
        
        if(markerSource2_2 != null){
            markerLayer2_2.getSource().clear();
            }
        }
            
            
    if(map1b !=null){
        markerSource.set("name","마커레이어");
        }
    if(map2b !=null){
        markerSource_2.set("name","마커레이어");
        }
    
        //style을 활용해서, point의 style을 변경한다.
    var markerStyle = new ol.style.Style({
            image: new ol.style.Icon({ //마커 이미지
                opacity: 1, //투명도 1=100% 
                scale: 1, //크기 1=100%
                src: imgsrc //marker 이미지, 해당 point를 marker로 변경한다.
                }),
            zindex: 1001
        });
        
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
                    if(o==0){   //검색결과가 있다면 o값에 0번째 값을 가져옴
                        
                        if(map1b !=null){   //검색시 지도의 위치 이동
                            map1s.getView().setCenter([data.response.result.items[o].point.x*1, data.response.result.items[o].point.y*1 ]); 
                            map1s.getView().setZoom(17); 
                        }
                        if(map2b !=null){
                            map2s.getView().setCenter([data.response.result.items[o].point.x*1, data.response.result.items[o].point.y*1 ]); // 지도 이동
                            map2s.getView().setZoom(17); // 줌레벨 설정
                        }
                    }
                
                    
                    var x = data.response.result.items[o].point.x*1;   //브이월드에서 검색결과가져옴 data.response.result.items[o] x축 y축 값 저장
                    var y = data.response.result.items[o].point.y*1
                    var point_feature = new ol.Feature({
                        geometry: new ol.geom.Point([x, y]).transform('EPSG:900913', 'EPSG:3857')   //브이월드 좌표계 변경 3857로
                    });
                    
                    var title = data.response.result.items[o].address.bldnm     //팝업에 생성하기위해 주소명을 저장
                    var cont = "2";  //cont값을 임의로 저장하여 팝업제어를 함.
                    var contents = data.response.result.items[o].address.road   //팝업의 도로명 저장
                    marker_html += "<span> 장소 :"+title+"<hr>도로명 :"+ contents+"</span>";    //html로 팝업내용을 작성함
                    point_feature.set("subj",marker_html);  //생성된 마커에 주소와 도로명을 팝업에 저장함.
                    point_feature.set("cont",cont);         //팝업 제어를위함.

                    if(map1b !=null){
                        markerSource.addFeature(point_feature);
                    // 마커 레이어 생성
                        markerLayer = new ol.layer.Vector({
                            source: markerSource, //마커 feacture들
                            style: markerStyle //마커 스타일
                        });
                    }
                    if(map2b !=null){
                        markerSource_2.addFeature(point_feature);
                        // 마커 레이어 생성
                        markerLayer_2 = new ol.layer.Vector({
                            source: markerSource_2, //마커 feacture들
                            style: markerStyle //마커 스타일
                        });
                    }
                        
                        
                    var roadText=escape(data.response.result.items[o].address.road);
                    var bldnmText=escape(data.response.result.items[o].address.bldnm);
                    
                    result_html += "<hr><li><p onclick='move("+data.response.result.items[o].point.x+","+
                            data.response.result.items[o].point.y+
                            ","+"\""+roadText+"\","+"\""+bldnmText+"\""+
                    ")'> 도로명: "+ data.response.result.items[o].address.road +
                    " 지번: "+ data.response.result.items[o].address.parcel +"  </p></li>";
                        
                }
                
                if(map1b !=null){
                    map1s.addLayer(markerLayer);
                }
                if(map2b !=null){
                    map2s.addLayer(markerLayer_2);
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



var markerSource2; //검색시 생성되는 마커
var markerSource2_2; //이동시 생성되는 마커
var searchMarker; //검색시 생성되는 마커 제어(move 함수 실행시 검색시 생성된 마커를 제어.)

var move = function(x,y,roadText,bldnmText){
    map2b = $('input:checkbox[id="map2b"]:checked').val();  //어느지도인지 체크박스 확인
    map1b = $('input:checkbox[id="map1b"]:checked').val(); 
    searchMarker = $('input:checkbox[id="searchMarker"]:checked').val(); //검색시 마커를 이동할때 숨길지 안숨길지 제어   
 
    var road=unescape(roadText);    //도로명을 문자열로 변형
    var bldnm=unescape(bldnmText);  //주소명 문자열 변형
 
    var markerStyle2 = new ol.style.Style({     //이동시 생성되는 마커           
        image: new ol.style.Icon({              //마커 이미지
            opacity: 1,                         //투명도 1=100% 
            scale: 1,                           //크기 1=100%
            src: 'https://openlayers.org/en/v3.20.1/examples/data/icon.png'                        
            }),
            
            zindex: 1001
        });
    var point_feature2 = new ol.Feature({
        geometry: new ol.geom.Point([x, y]).transform('EPSG:900913', 'EPSG:3857')   //브이월드 검색시 가져온 좌표를 3857로 변형
    });
    var marker_html="";
    marker_html += "<span> 장소 :"+bldnm+"<hr>도로명 :"+ road+"</span>";    //이동시 생성되는 마커는 새로운 레이어임으로 팝업내용을 다시 저장함
    var cont = "2";  //내용이없을경우 팝업 제외하기위하여 추가 검색시 생성되는 마커는 모두 내용이 있음으로 cont 내용을 추가함
        
    point_feature2.set("subj",marker_html); //팝업내용 저장
    point_feature2.set("cont",cont);    
        
    if(map1b !=null){
        
        map1s.getView().setCenter([ x, y ]); // 지도 이동
        map1s.getView().setZoom(17); // 줌레벨 설정
        
        if(markerSource==null){
            markerSource = new ol.source.Vector();

        }else if(markerSource !=null){
            if(searchMarker != null){   //검색결과시 생성된 마커 숨김, 이동시 마커는 생성
                //markerLayer.getSource().clear();
                markerLayer.setVisible(false);
            }else if(searchMarker == null){
                markerLayer.setVisible(true);
            }
            
        }
        if(markerSource2==null){
            markerSource2 = new ol.source.Vector();
            
        }else if(markerSource2 != null){
            markerLayer2.getSource().clear();
        }
        markerSource2.set("name","마커레이어");
        

        //markerSource에 등록한 point를 담는다. addFeature를 이용해서, 여러개의 point를 source에 담는다.
        markerSource2.addFeature(point_feature2);
                
        // 마커 레이어 생성
        markerLayer2 = new ol.layer.Vector({
            source: markerSource2, //마커 feacture들
            style: markerStyle2 //마커 스타일
            });
            
        map1s.addLayer(markerLayer2);

    }
    if(map2b !=null){
        map2s.getView().setCenter([ x, y ]); // 지도 이동
        map2s.getView().setZoom(17); // 줌레벨 설정
        
        if(markerSource_2==null){
            markerSource = new ol.source.Vector();
            
        }else if(markerSource_2 !=null){
            //markerLayer_2.getSource().clear(); //검색결과시 생성된 마커삭제
            if(searchMarker != null){   //검색결과시 생성된 마커 숨김, 이동시 마커는 생성
                //markerLayer.getSource().clear();
                markerLayer_2.setVisible(false);
            }else if(searchMarker == null){
                markerLayer_2.setVisible(true);
            }
        }
        if(markerSource2_2==null){
            markerSource2_2 = new ol.source.Vector(); //이동하는 곳에 마커 생성
            }else if(markerSource2_2 != null){
                markerLayer2_2.getSource().clear();   //이동했던 곳에 마커 삭제
                }

        markerSource2_2.set("name","마커레이어");
    
        //markerSource에 등록한 point를 담는다. addFeature를 이용해서, 여러개의 point를 source에 담는다.
        markerSource2_2.addFeature(point_feature2);
                
        // 마커 레이어 생성
        markerLayer2_2 = new ol.layer.Vector({
            source: markerSource2_2, //마커 feacture들
            style: markerStyle2 //마커 스타일
            });
            
        map2s.addLayer(markerLayer2_2);
    }
    
}
//생성된 팝업 닫기
function popup_delete(){
    $('#popupTest').hide();
    }
/*
function map1optionShow(){
    $('#map1option').show();
    }
function map2optionShow(){
    $('#map2option').show();
    }
function map1optionHide(){
    $('#map1option').hide();
    }
function map2optionHide(){
    $('#map2option').hide();
    }*/
        
//지도 기능 전체 삭제
function map1_delete(){
    map1s.getLayers().forEach(layer => layer.getSource().refresh());
    map1s.getOverlays().getArray().slice(0).forEach(function(MeasureTooltip) {
        map1s.removeOverlay(MeasureTooltip);
        });
    }
function map2_delete(){
    map2s.getLayers().forEach(layer => layer.getSource().refresh());
    map2s.getOverlays().getArray().slice(0).forEach(function(MeasureTooltip) {
        map2s.removeOverlay(MeasureTooltip);
        });
    }
function all_delete(){
    map1s.getLayers().forEach(layer => layer.getSource().refresh());
    map1s.getOverlays().getArray().slice(0).forEach(function(MeasureTooltip) {
        map1s.removeOverlay(MeasureTooltip);
        });
    
    map2s.getLayers().forEach(layer => layer.getSource().refresh());
    map2s.getOverlays().getArray().slice(0).forEach(function(MeasureTooltip) {
        map2s.removeOverlay(MeasureTooltip);
        });
    }   