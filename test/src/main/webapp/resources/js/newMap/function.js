var VworldHybrid = new ol.source.XYZ({
    url: 'http://api.vworld.kr/req/wmts/1.0.0/10036FCE-3940-374C-B2ED-E6FBDF47CFA9/Hybrid/{z}/{y}/{x}.png'
}); //문자 타일 레이어

var VworldSatellite = new ol.source.XYZ({
    url: 'http://api.vworld.kr/req/wmts/1.0.0/10036FCE-3940-374C-B2ED-E6FBDF47CFA9/Satellite/{z}/{y}/{x}.jpeg'
    
}); //항공사진 레이어 타일

var VworldBase = new ol.source.XYZ({
    url: 'http://api.vworld.kr/req/wmts/1.0.0/10036FCE-3940-374C-B2ED-E6FBDF47CFA9/Base/{z}/{y}/{x}.png'

});


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
