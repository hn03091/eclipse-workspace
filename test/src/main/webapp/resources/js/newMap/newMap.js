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
	
})