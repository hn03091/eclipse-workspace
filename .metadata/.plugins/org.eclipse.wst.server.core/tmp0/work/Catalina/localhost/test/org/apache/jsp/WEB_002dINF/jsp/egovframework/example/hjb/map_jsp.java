/*
 * Generated by the Jasper component of Apache Tomcat
 * Version: Apache Tomcat/8.5.40
 * Generated at: 2022-06-09 00:40:53 UTC
 * Note: The last modified time of this file was set to
 *       the last modified time of the source file after
 *       generation to assist with modification tracking.
 */
package org.apache.jsp.WEB_002dINF.jsp.egovframework.example.hjb;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;

public final class map_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent,
                 org.apache.jasper.runtime.JspSourceImports {

  private static final javax.servlet.jsp.JspFactory _jspxFactory =
          javax.servlet.jsp.JspFactory.getDefaultFactory();

  private static java.util.Map<java.lang.String,java.lang.Long> _jspx_dependants;

  static {
    _jspx_dependants = new java.util.HashMap<java.lang.String,java.lang.Long>(2);
    _jspx_dependants.put("jar:file:/C:/Users/EGIS/eclipse-workspace/.metadata/.plugins/org.eclipse.wst.server.core/tmp0/wtpwebapps/test/WEB-INF/lib/jstl-1.2.jar!/META-INF/c.tld", Long.valueOf(1153352682000L));
    _jspx_dependants.put("/WEB-INF/lib/jstl-1.2.jar", Long.valueOf(1612850416000L));
  }

  private static final java.util.Set<java.lang.String> _jspx_imports_packages;

  private static final java.util.Set<java.lang.String> _jspx_imports_classes;

  static {
    _jspx_imports_packages = new java.util.HashSet<>();
    _jspx_imports_packages.add("javax.servlet");
    _jspx_imports_packages.add("javax.servlet.http");
    _jspx_imports_packages.add("javax.servlet.jsp");
    _jspx_imports_classes = null;
  }

  private volatile javax.el.ExpressionFactory _el_expressionfactory;
  private volatile org.apache.tomcat.InstanceManager _jsp_instancemanager;

  public java.util.Map<java.lang.String,java.lang.Long> getDependants() {
    return _jspx_dependants;
  }

  public java.util.Set<java.lang.String> getPackageImports() {
    return _jspx_imports_packages;
  }

  public java.util.Set<java.lang.String> getClassImports() {
    return _jspx_imports_classes;
  }

  public javax.el.ExpressionFactory _jsp_getExpressionFactory() {
    if (_el_expressionfactory == null) {
      synchronized (this) {
        if (_el_expressionfactory == null) {
          _el_expressionfactory = _jspxFactory.getJspApplicationContext(getServletConfig().getServletContext()).getExpressionFactory();
        }
      }
    }
    return _el_expressionfactory;
  }

  public org.apache.tomcat.InstanceManager _jsp_getInstanceManager() {
    if (_jsp_instancemanager == null) {
      synchronized (this) {
        if (_jsp_instancemanager == null) {
          _jsp_instancemanager = org.apache.jasper.runtime.InstanceManagerFactory.getInstanceManager(getServletConfig());
        }
      }
    }
    return _jsp_instancemanager;
  }

  public void _jspInit() {
  }

  public void _jspDestroy() {
  }

  public void _jspService(final javax.servlet.http.HttpServletRequest request, final javax.servlet.http.HttpServletResponse response)
      throws java.io.IOException, javax.servlet.ServletException {

    final java.lang.String _jspx_method = request.getMethod();
    if (!"GET".equals(_jspx_method) && !"POST".equals(_jspx_method) && !"HEAD".equals(_jspx_method) && !javax.servlet.DispatcherType.ERROR.equals(request.getDispatcherType())) {
      response.sendError(HttpServletResponse.SC_METHOD_NOT_ALLOWED, "JSPs only permit GET POST or HEAD");
      return;
    }

    final javax.servlet.jsp.PageContext pageContext;
    javax.servlet.http.HttpSession session = null;
    final javax.servlet.ServletContext application;
    final javax.servlet.ServletConfig config;
    javax.servlet.jsp.JspWriter out = null;
    final java.lang.Object page = this;
    javax.servlet.jsp.JspWriter _jspx_out = null;
    javax.servlet.jsp.PageContext _jspx_page_context = null;


    try {
      response.setContentType("text/html; charset=UTF-8");
      pageContext = _jspxFactory.getPageContext(this, request, response,
      			null, true, 8192, true);
      _jspx_page_context = pageContext;
      application = pageContext.getServletContext();
      config = pageContext.getServletConfig();
      session = pageContext.getSession();
      out = pageContext.getOut();
      _jspx_out = out;

      out.write("\r\n");
      out.write("\r\n");
      out.write("<!DOCTYPE html>\r\n");
      out.write("<html>\r\n");
      out.write("    <title>2D 지도생성 2.0</title>\r\n");
      out.write("<script type=\"text/javascript\" src=\"https://map.vworld.kr/js/vworldMapInit.js.do?version=2.0&apiKey=10036FCE-3940-374C-B2ED-E6FBDF47CFA9&domain=http://localhost:8080\"></script>\r\n");
      out.write("</head>\r\n");
      out.write("\r\n");
      out.write("<body>\r\n");
      out.write("\r\n");
      out.write("<div id=\"vmap\" style=\"width:100%;height:370px;left:0px;top:0px\"></div>\r\n");
      out.write("<div>\r\n");
      out.write("\t<!-- 검색 폼  -->\r\n");
      out.write("\t<form id=\"searchForm\" action=\"#\" class=\"form_data\" onsubmit=\"return false;search();\">\r\n");
      out.write("\t\t<input type=\"hidden\" name=\"page\" value=\"1\" />\r\n");
      out.write("\t\t<input type=\"hidden\" name=\"type\" value=\"address\" />\r\n");
      out.write("\t\t<input type=\"hidden\" name=\"request\" value=\"search\" />\r\n");
      out.write("\t\t<input type=\"hidden\" name=\"size\" value=\"100\" />\r\n");
      out.write("\t\t<input type=\"hidden\" name=\"apiKey\" value=\"10036FCE-3940-374C-B2ED-E6FBDF47CFA9\" />\r\n");
      out.write("\t\t<input type=\"hidden\" name=\"domain\" value=\"http://localhost:8080\" />\r\n");
      out.write("\t\t<input type=\"hidden\" name=\"crs\" value=\"EPSG:3857\" />\r\n");
      out.write("\t\t<div>\r\n");
      out.write("\t\t\t<input type=\"text\"  id=\"searchValue\" name=\"query\" value=\"서울시 은평구 진관1로 77-8\" style=\"width: 300px;\" /> <a href=\"javascript:search();\" >검색</a> \r\n");
      out.write("\t\t\t<input type=\"checkbox\" id=\"onoff\" />WMS ON/OFF\r\n");
      out.write("\t\t\t<select name=\"category\">\r\n");
      out.write("\t\t\t<option value=\"road\">도로명</option>\r\n");
      out.write("\t\t\t<option value=\"parcel\">지번</option>\r\n");
      out.write("\t\t</select>\r\n");
      out.write("\t\t</div>\r\n");
      out.write("\t\t\r\n");
      out.write("\t</form>\r\n");
      out.write("\t<!-- 데이터 API 폼  -->\r\n");
      out.write("\t<form id=\"dataForm\">\r\n");
      out.write("\t\t<input type=\"hidden\" name=\"key\" value=\"10036FCE-3940-374C-B2ED-E6FBDF47CFA9\">\r\n");
      out.write("\t\t<input type=\"hidden\" name=\"domain\" value=\"http://localhost:8080\">\r\n");
      out.write("\t\t<input type=\"hidden\" name=\"service\" value=\"data\">\r\n");
      out.write("\t\t<input type=\"hidden\" name=\"version\" value=\"2.0\">\r\n");
      out.write("\t\t<input type=\"hidden\" name=\"request\" value=\"getfeature\">\r\n");
      out.write("\t\t<input type=\"hidden\" name=\"format\" value=\"json\">\r\n");
      out.write("\t\t<input type=\"hidden\" name=\"size\" value=\"1000\">\r\n");
      out.write("\t\t<input type=\"hidden\" name=\"page\" value=\"1\">\r\n");
      out.write("\t\t<input type=\"hidden\" name=\"data\" value=\"LT_C_SPBD\">\r\n");
      out.write("\t\t<input type=\"hidden\" name=\"geometry\" value=\"true\">\r\n");
      out.write("\t\t<input type=\"hidden\" name=\"attribute\" value=\"true\">\r\n");
      out.write("\t\t<input type=\"hidden\" name=\"crs\" value=\"EPSG:900913\">\r\n");
      out.write("\t\t<!-- <input type=\"hidden\" name=\"geomfilter\" value=\"BOX(14028876.609587036,3912653.333809428,14151175.854843318,3974414.4526638505)\"> -->\r\n");
      out.write("\t\t<input type=\"hidden\" name=\"geomfilter\" value=\"POINT(14028876.609587036 3912653.333809428)\">\r\n");
      out.write("\t</form>\r\n");
      out.write("</div>\r\n");
      out.write("<div>\r\n");
      out.write("\t<ul id=\"result_ajax\">\r\n");
      out.write("\t\t<li></li>\r\n");
      out.write("\t</ul>\r\n");
      out.write("\t<p id=\"result_count\"></p>\r\n");
      out.write("\t<p id=\"result_pos\"></p>\r\n");
      out.write("</div>\r\n");
      out.write("<div id=\"data_result\"></div>\r\n");
      out.write("\r\n");
      out.write("<script type=\"text/javascript\">\r\n");
      out.write("\tvw.ol3.MapOptions = {\r\n");
      out.write("\t    basemapType: vw.ol3.BasemapType.GRAPHIC\r\n");
      out.write("\t  , controlDensity: vw.ol3.DensityType.EMPTY\r\n");
      out.write("\t  , interactionDensity: vw.ol3.DensityType.BASIC\r\n");
      out.write("\t  , controlsAutoArrange: true\r\n");
      out.write("\t  , homePosition: vw.ol3.CameraPosition\r\n");
      out.write("\t  , initPosition: vw.ol3.CameraPosition\r\n");
      out.write("\t}; \r\n");
      out.write("\tvmap = new vw.ol3.Map(\"vmap\",  vw.ol3.MapOptions); \r\n");
      out.write("\t\r\n");
      out.write("\tvar search = function(){\r\n");
      out.write("\t\t\r\n");
      out.write("\t\tvar markerLayer; // 마커를 담을 레이어 선언\r\n");
      out.write("\t\tif(markerLayer==null){\r\n");
      out.write("\t\t\tmarkerLayer = new vw.ol3.layer.Marker(vmap);\r\n");
      out.write("\t\t}\r\n");
      out.write("\t\tmarkerLayer.set(\"name\",\"마커레이어\"); //마커레이어에 이름을 적용하여 검색 결과 초기화\r\n");
      out.write("\t\t\r\n");
      out.write("\t\t$.ajax({\r\n");
      out.write("\t\t\ttype: \"get\",\r\n");
      out.write("\t\t\turl: \"https://api.vworld.kr/req/search\",\r\n");
      out.write("\t\t\tdata : $('#searchForm').serialize(),\r\n");
      out.write("\t\t\tdataType: 'jsonp',\r\n");
      out.write("\t\t\tasync: false,\r\n");
      out.write("\t\t\tsuccess: function(data) {\r\n");
      out.write("\t\t\t\tvar features = new Array();\r\n");
      out.write("\t\t\t\tif(data.response.status ==\"NOT_FOUND\"){\r\n");
      out.write("\t\t\t\t\talert(\"검색결과가 없습니다.\");\r\n");
      out.write("\t\t\t\t}else{\r\n");
      out.write("\t\t\t\t\t\r\n");
      out.write("\t\t\t\t\tvar result_html =\"\";\r\n");
      out.write("\t\t\t\t\t\r\n");
      out.write("\t\t\t\t\t\r\n");
      out.write("\t\t\t\t\tfor(var o in data.response.result.items){ \r\n");
      out.write("\t\t\t\t\t\tif(o==0){\r\n");
      out.write("\t\t\t\t\t\t\tmove(data.response.result.items[o].point.x*1,data.response.result.items[o].point.y*1);\r\n");
      out.write("\t\t\t\t\t\t}\r\n");
      out.write("\t\t\t\t\t\tvw.ol3.markerOption = {\r\n");
      out.write("\t\t\t\t\t\t\tx : data.response.result.items[o].point.x,\r\n");
      out.write("\t\t\t\t\t\t\ty : data.response.result.items[o].point.y,\r\n");
      out.write("\t\t\t\t\t\t\tepsg : \"EPSG:3857\",\r\n");
      out.write("\t\t\t\t\t\t\ttitle : data.response.result.items[o].address.bldnm,\r\n");
      out.write("\t\t\t\t\t\t\tcontents : data.response.result.items[o].address.road,\r\n");
      out.write("\t\t\t\t\t\t\ticonUrl : 'http://map.vworld.kr/images/ol3/marker_blue.png'\r\n");
      out.write("\t\t\t\t\t\t\t\r\n");
      out.write("\t\t\t\t\t\t}; //마커 옵션 설정\r\n");
      out.write("\t\t\t\t\t\t\r\n");
      out.write("\t\t\t\t\t\tresult_html += \"<li><p onclick='move(\"+data.response.result.items[o].point.x+\",\"+data.response.result.items[o].point.y+\")'> road: \"+ data.response.result.items[o].address.road +\" parcel: \"+ data.response.result.items[o].address.parcel +\" </p></li>\";\r\n");
      out.write("\t\t\t\t\t\t\r\n");
      out.write("\t\t\t\t\t\tmarkerLayer.addMarker(vw.ol3.markerOption);// 마커를 레이어에 등록\r\n");
      out.write("\t\t\t\t\t\tmarkerLayer.getSource().getFeatures()[o].set(\"식별자\",\"ID_\"+o);\r\n");
      out.write("\t\t\t\t\t}\r\n");
      out.write("\t\t\t\t\t\r\n");
      out.write("\t\t\t\t\t\r\n");
      out.write("\t\t\t\t\t$('#result_ajax').html(result_html);  //result_ajax 라는 id 값이 있는곳의 html을 수정한다 \r\n");
      out.write("\t\t\t\t\t$('#result_count').text(data.response.record.total+\"건이 검색되었습니다.\");\r\n");
      out.write("\t\t\t\t\t\r\n");
      out.write("\t\t\t\t}\r\n");
      out.write("\t\t\t\t\r\n");
      out.write("\t\t\t\t\r\n");
      out.write("\t\t\t},\r\n");
      out.write("\t\t\tcomplete:function(){\r\n");
      out.write("\t\t\t\t\r\n");
      out.write("\t\t\t},\r\n");
      out.write("\t\t\terror: function(xhr, stat, err) {}\r\n");
      out.write("\t\t});\r\n");
      out.write("\t\t\r\n");
      out.write("\t\t\r\n");
      out.write("\t\tvmap.removeLayer(vmap.getLayerByName(\"마커레이어\")) //vmap.getLayerByName(레이어명)\r\n");
      out.write("\t\tvmap.addLayer(markerLayer) //마커를 vmap에 등록\r\n");
      out.write("\t}\r\n");
      out.write("\r\n");
      out.write("\tvar move = function(x,y){\r\n");
      out.write("\t\tvmap.getView().setCenter([ x, y ]); // 지도 이동\r\n");
      out.write("\t\tvmap.getView().setZoom(17); // 줌레벨 설정\r\n");
      out.write("\t}\r\n");
      out.write("\t\r\n");
      out.write("\t\r\n");
      out.write("\t/* 폴리곤의 스타일 설정 */\r\n");
      out.write("\tvar vectorStyle = function(feature) {\r\n");
      out.write("\t    var style = new ol.style.Style({\r\n");
      out.write("\t\t    stroke: new ol.style.Stroke({\r\n");
      out.write("\t\t        color: [0, 256, 0, 1],\r\n");
      out.write("\t\t        width: 5\r\n");
      out.write("\t\t    }),\r\n");
      out.write("\t\t    fill: new ol.style.Fill({\r\n");
      out.write("\t\t        color: [256, 0, 0, .7]\r\n");
      out.write("\t\t    })\r\n");
      out.write("\t    });\r\n");
      out.write("\t    return [style];\r\n");
      out.write("\t}\r\n");
      out.write("\t\r\n");
      out.write("\tvmap.on('singleclick', function(evt) {\r\n");
      out.write("\t\tvar coordinate = evt.coordinate //좌표정보\r\n");
      out.write("\t\tvar pixel = evt.pixel // 픽셀정보\r\n");
      out.write("\t\t\r\n");
      out.write("\t\t\r\n");
      out.write("\t\t // 클릭한 지점이 feature나 layer 일 경우 이벤트를줌 \r\n");
      out.write("\t\tvmap.forEachFeatureAtPixel(pixel, function(feature, layer) {\r\n");
      out.write("        \tvar title = feature.get(\"title\");\r\n");
      out.write("        \tif(title.length>0){ // 도로명주소 건물 정보가 있으면 Data API 호출\r\n");
      out.write("        \t\tconsole.log(title);\r\n");
      out.write("        \t\t\r\n");
      out.write("        \t\tvar point = coordinate[0]+\" \"+coordinate[1];\r\n");
      out.write("     \t\t\t$('[name=geomfilter]').val('POINT('+point+')');\r\n");
      out.write("     \t\t\t\r\n");
      out.write("     \t\t\t$.ajax({\r\n");
      out.write("    \t\t    \ttype: \"get\",\r\n");
      out.write("    \t\t    \turl: \"http://api.vworld.kr/req/data\",\r\n");
      out.write("    \t\t    \tdata : $('#dataForm').serialize(),\r\n");
      out.write("    \t\t    \tdataType: 'jsonp',\r\n");
      out.write("    \t\t    \tasync: false,\r\n");
      out.write("    \t\t    \tsuccess: function(data) {\r\n");
      out.write("    \t\t    \t\tif(data.response.status ==\"NOT_FOUND\"){\r\n");
      out.write("    \t\t\t\t\t\tconsole.log(\" Data API 결과가 없습니다.\");\r\n");
      out.write("    \t\t\t\t\t}else{\r\n");
      out.write("\t    \t\t    \t    var vectorSource = new ol.source.Vector({features: (new ol.format.GeoJSON()).readFeatures(data.response.result.featureCollection)})\r\n");
      out.write("\t    \t\t    \t    \r\n");
      out.write("\t    \t\t    \t\tvmap.getLayers().forEach(function(layer){\r\n");
      out.write("\t    \t\t    \t\t\tif(layer.get(\"name\")==\"search_result\"){\r\n");
      out.write("\t    \t\t    \t\t\t\tvmap.removeLayer(layer);//기존결과 삭제\r\n");
      out.write("\t    \t\t    \t\t\t}\r\n");
      out.write("\t    \t\t    \t\t})\r\n");
      out.write("\t    \t\t    \t    var vector_layer = new ol.layer.Vector({\r\n");
      out.write("\t    \t\t    \t  \t  source: vectorSource,\r\n");
      out.write("\t    \t\t    \t  \t  style: vectorStyle\r\n");
      out.write("\t    \t\t    \t  \t})\r\n");
      out.write("\t    \t\t    \t    \r\n");
      out.write("\t    \t\t    \t    vector_layer.set(\"name\",\"search_result\");\r\n");
      out.write("\t    \t\t    \t \tvmap.addLayer(vector_layer);\r\n");
      out.write("\t    \t\t    \t \t\r\n");
      out.write("\t    \t\t    \t \tvar resultFeature = vectorSource.getFeatures()[0]\r\n");
      out.write("\t    \t\t    \t \tif(typeof resultFeature == \"object\"){\r\n");
      out.write("\t    \t\t\t        \tvar featurehtml=\"\";\r\n");
      out.write("\t    \t\t\t        \tfor(var i in resultFeature.getKeys()){ \r\n");
      out.write("\t    \t\t\t        \t\tfeaturehtml += resultFeature.getKeys()[i] + \" = \"+resultFeature.get(resultFeature.getKeys()[i])+\"\\n\";\r\n");
      out.write("\t    \t\t\t        \t}\r\n");
      out.write("\t    \t\t\t        \t$('#data_result').html(featurehtml);\r\n");
      out.write("\t    \t\t    \t \t}\r\n");
      out.write("    \t\t\t\t\t}\r\n");
      out.write("    \t\t    \t},\r\n");
      out.write("    \t\t    \t\r\n");
      out.write("    \t\t    \terror: function(xhr, stat, err) {}\r\n");
      out.write("    \t\t    });\r\n");
      out.write("        \t}\r\n");
      out.write("        });\r\n");
      out.write("\t})\r\n");
      out.write("\t\r\n");
      out.write("\t$(document).on(\"click\",\"#onoff\",function(){\r\n");
      out.write("\t\tif($(this).is(\":checked\")){\r\n");
      out.write("\t\t\tvar wmslayer = vmap.addNamedLayer(\"도로명주소건물\",\"LT_C_SPBD\")\r\n");
      out.write("\t\t\tvar wmslayer2 = vmap.addNamedLayer(\"도로명주소도로\",\"LT_L_SPRD\")\r\n");
      out.write("\t\t\tvmap.addLayer(wmslayer);\r\n");
      out.write("\t\t\tvmap.addLayer(wmslayer2);\r\n");
      out.write("\t\t}else{\r\n");
      out.write("\t\t\tvar layerName = vmap.getLayerByName(\"도로명주소도로\") // name 값으로 레이어 선택\r\n");
      out.write("\t\t\tvmap.removeLayer(layerName) //vmap.getLayerByName(레이어명)\r\n");
      out.write("\t\t\tvar layerName2 = vmap.getLayerByName(\"도로명주소건물\") // name 값으로 레이어 선택\r\n");
      out.write("\t\t\tvmap.removeLayer(layerName2) //vmap.getLayerByName(레이어명)\r\n");
      out.write("\t\t}\r\n");
      out.write("\t})\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\t//마커 이동 이미지 변화구현\r\n");
      out.write("\r\n");
      out.write("\tvar move_change = function(){\r\n");
      out.write("\r\n");
      out.write("\t\tif(vmap.getLayerByName(\"마커레이어\")==null){\r\n");
      out.write("\t\t\talert(\"마커가 없습니다. 검색먼저 실행해주세요\");\r\n");
      out.write("\t\t\treturn;\r\n");
      out.write("\t\t}\r\n");
      out.write("\t\tvar clickFeatures = vmap.getLayerByName(\"마커레이어\").getSource().getFeatures()\r\n");
      out.write("\r\n");
      out.write("\t\tvar imgSrc = \"http://map.vworld.kr/images/ol3/marker_blue.png\"\r\n");
      out.write("\t\tif(clickFeatures[0].getStyle().getImage().getSrc().indexOf(\"blue\")>-1){\r\n");
      out.write("\t\t\timgSrc= 'http://map.vworld.kr/images/ol3/marker.png'\r\n");
      out.write("\t\t}\r\n");
      out.write("\t\t\t\t\t\t\r\n");
      out.write("\t\tvar iconStyle = new ol.style.Style({\r\n");
      out.write("\t\t\timage: new ol.style.Icon(/** @type {olx.style.IconOptions} */ ({\r\n");
      out.write("\t\t\t\tanchor: [0.5, 46], //마커 이미지의 절대위치를 변경\r\n");
      out.write("\t\t\t\tanchorXUnits: 'fraction',\r\n");
      out.write("\t\t\t\tanchorYUnits: 'pixels',\r\n");
      out.write("\t\t\t\tsrc: imgSrc\r\n");
      out.write("\t\t\t}))\r\n");
      out.write("\t\t});\r\n");
      out.write("\r\n");
      out.write("\t\tclickFeatures[0].setStyle(iconStyle) // 마커의 스타일(이미지)를 변경 \r\n");
      out.write("\r\n");
      out.write("\t\t//기존좌표\r\n");
      out.write("\t\tvar oldcoor =  clickFeatures[0].getGeometry().getCoordinates();\r\n");
      out.write("\t\t//vmap.getLayerByName(\"마커레이어\").getSource().getFeatures()[0].getGeometry().getCoordinates();\r\n");
      out.write("\r\n");
      out.write("\t\tvar newcoor = [14128721.120936994, 4521345.062383187];\r\n");
      out.write("\t\tclickFeatures[0].getGeometry().setCoordinates(newcoor); //좌표값을 변경\r\n");
      out.write("\t\tmove(newcoor[0],newcoor[1]);//해당위치로 이동\r\n");
      out.write("\t}\r\n");
      out.write("\r\n");
      out.write("\tvar move_select = function(value){ //선택한 식별자의 마커 이미지 변경\r\n");
      out.write("\t\tif(vmap.getLayerByName(\"마커레이어\")==null){\r\n");
      out.write("\t\t\talert(\"마커가 없습니다. 검색먼저 실행해주세요\");\r\n");
      out.write("\t\t\treturn;\r\n");
      out.write("\t\t}\r\n");
      out.write("\t\tvar clickFeatures = vmap.getLayerByName(\"마커레이어\").getSource().getFeatures()\r\n");
      out.write("\t\t// 마커 레이어를 가지고옴 \r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\t\tclickFeatures.forEach(function(feature){\r\n");
      out.write("\r\n");
      out.write("\t\t\tif(\"ID_\"+value == feature.get(\"식별자\")){ // for 문을 돌리면서 해당 ID 값 객체를가지고옴\r\n");
      out.write("\t\t\t\tvar imgSrc = \"http://map.vworld.kr/images/ol3/marker_blue.png\"\r\n");
      out.write("\t\t\t\tif(feature.getStyle().getImage().getSrc().indexOf(\"blue\")>-1){\r\n");
      out.write("\t\t\t\t\timgSrc= 'http://map.vworld.kr/images/ol3/marker.png'\r\n");
      out.write("\t\t\t\t}\r\n");
      out.write("\t\t\t\tvar iconStyle = new ol.style.Style({\r\n");
      out.write("\t\t\t\t\timage: new ol.style.Icon(/** @type {olx.style.IconOptions} */ ({\r\n");
      out.write("\t\t\t\t\t\tanchor: [0.5, 46], //마커 이미지의 절대위치를 변경\r\n");
      out.write("\t\t\t\t\t\tanchorXUnits: 'fraction',\r\n");
      out.write("\t\t\t\t\t\tanchorYUnits: 'pixels',\r\n");
      out.write("\t\t\t\t\t\tsrc: imgSrc\r\n");
      out.write("\t\t\t\t\t}))\r\n");
      out.write("\t\t\t\t});\r\n");
      out.write("\r\n");
      out.write("\t\t\t\tfeature.setStyle(iconStyle);\r\n");
      out.write("\t\t\t}\r\n");
      out.write("\t\t})\r\n");
      out.write("\t}\r\n");
      out.write("\r\n");
      out.write("</script>\r\n");
      out.write("</body>\r\n");
      out.write("</html>");
    } catch (java.lang.Throwable t) {
      if (!(t instanceof javax.servlet.jsp.SkipPageException)){
        out = _jspx_out;
        if (out != null && out.getBufferSize() != 0)
          try {
            if (response.isCommitted()) {
              out.flush();
            } else {
              out.clearBuffer();
            }
          } catch (java.io.IOException e) {}
        if (_jspx_page_context != null) _jspx_page_context.handlePageException(t);
        else throw new ServletException(t);
      }
    } finally {
      _jspxFactory.releasePageContext(_jspx_page_context);
    }
  }
}
