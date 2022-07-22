<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>국가인터넷지도 | 지도 오픈API 샘플</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/gh/openlayers/openlayers.github.io@master/en/v6.4.3/css/ol.css" >
<script src="https://code.jquery.com/jquery-2.2.3.min.js"></script>
<script src="https://cdn.jsdelivr.net/gh/openlayers/openlayers.github.io@master/en/v6.4.3/build/ol.js"></script>
<script src="https://cdn.polyfill.io/v2/polyfill.min.js?features=requestAnimationFrame,Element.prototype.classList,URL"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/proj4js/2.4.4/proj4.js"></script>
<script type="text/javascript" src="http://localhost:8080/newMap.do/openapi/wmts_ngiiMap_v6.4.3.js?apikey=A7EC92E2BF6E49D7E3EDD4307A381D74"></script>


<script>
var map1;
window.onload = function(){
map1 = new ngii_wmts.map("map1", {zoom : 2});
};
</script>
</head>
<body>
<div id="map1" style="width:700px;height:700px;"></div>
</body>
</html>