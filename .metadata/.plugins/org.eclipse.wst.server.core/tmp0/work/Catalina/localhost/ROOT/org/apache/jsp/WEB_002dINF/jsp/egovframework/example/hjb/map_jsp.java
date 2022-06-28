/*
 * Generated by the Jasper component of Apache Tomcat
 * Version: Apache Tomcat/8.5.40
 * Generated at: 2022-06-28 05:49:45 UTC
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
      out.write("<!DOCTYPE html>\r\n");
      out.write("<html>\r\n");
      out.write("<head>\r\n");
      out.write("    <meta charset=\"UTF-8\">\r\n");
      out.write("    <title>과제</title>\r\n");
      out.write("    <link rel=\"stylesheet\" href=\"https://cdn.jsdelivr.net/gh/openlayers/openlayers.github.io@master/en/v6.14.1/css/ol.css\" >\r\n");
      out.write("    <link rel=\"stylesheet\" href=\"/resources/css/map.css\">\r\n");
      out.write("\r\n");
      out.write("    <script src=\"https://cdn.jsdelivr.net/gh/openlayers/openlayers.github.io@master/en/v6.14.1/build/ol.js\"></script>\r\n");
      out.write("    <script src=\"https://code.jquery.com/jquery-2.2.3.min.js\"></script>\r\n");
      out.write("    <script src=\"https://cdn.polyfill.io/v2/polyfill.min.js?features=requestAnimationFrame,Element.prototype.classList,URL\"></script>\r\n");
      out.write("\t<script type=\"text/javascript\" src=\"//dapi.kakao.com/v2/maps/sdk.js?appkey=2196f8832616f1028c78fef267e345ad\"></script>\r\n");
      out.write("</head>\r\n");
      out.write("<body>\r\n");
      out.write("    <div style=\"font-size:30px;\">\r\n");
      out.write("\t\t<input type=\"checkbox\" id=\"mapb\" >지도분할\r\n");
      out.write("\t\t<br>\r\n");
      out.write("\t\t<input type=\"checkbox\" id=\"map1b\" value=\"map1\" checked>지도1\r\n");
      out.write("        <label id=\"mapOn\"style=\"display: none; size:30px;\">\r\n");
      out.write("            <input type=\"checkbox\" id=\"map2b\" value=\"map2\">지도2\r\n");
      out.write("        </label>\r\n");
      out.write("    </div>\r\n");
      out.write("    \r\n");
      out.write("\t<form id=\"searchForm\" action=\"#\" class=\"form_data\"\r\n");
      out.write("\t\tonsubmit=\"return false;search();\">\r\n");
      out.write("\t\t<input type=\"hidden\" name=\"page\" value=\"1\" /> <input type=\"hidden\"\r\n");
      out.write("\t\t\tname=\"type\" value=\"address\" /> <input type=\"hidden\" name=\"request\"\r\n");
      out.write("\t\t\tvalue=\"search\" /> <input type=\"hidden\" name=\"size\" value=\"100\" /> <input\r\n");
      out.write("\t\t\ttype=\"hidden\" name=\"apiKey\"\r\n");
      out.write("\t\t\tvalue=\"10036FCE-3940-374C-B2ED-E6FBDF47CFA9\" /> <input type=\"hidden\"\r\n");
      out.write("\t\t\tname=\"domain\" value=\"http://localhost:8080\" /> <input type=\"hidden\"\r\n");
      out.write("\t\t\tname=\"crs\" value=\"EPSG:3857\" />\r\n");
      out.write("\t\t<div>\r\n");
      out.write("\t\t\t\r\n");
      out.write("\t\t\t\r\n");
      out.write("\t\t\t<input type=\"text\" id=\"searchValue\" name=\"query\"\r\n");
      out.write("\t\t\t\tvalue=\"서울시 은평구 진관1로 77-8\" style=\"width: 300px;\" /> <a\r\n");
      out.write("\t\t\t\thref=\"javascript:search();\">검색</a>\r\n");
      out.write("\t\t\t<!--input type=\"checkbox\" id=\"onoff\" />WMS ON/OFF-->\r\n");
      out.write("\t\t\t<select name=\"category\">\r\n");
      out.write("\t\t\t\t<option value=\"road\">도로명</option>\r\n");
      out.write("\t\t\t\t<option value=\"parcel\">지번</option>\r\n");
      out.write("\t\t\t</select><br>\r\n");
      out.write("\t\t\t<label><input type=\"radio\" name=\"searchMk\"id=\"mkImg\" value=\"http://map.vworld.kr/images/ol3/marker_blue.png\" checked=\"on\">\r\n");
      out.write("\t\t\t\t<img src=\"http://map.vworld.kr/images/ol3/marker_blue.png\" />\r\n");
      out.write("\r\n");
      out.write("\t\t\t\t<input type=\"radio\" name=\"searchMk\" id=\"mkImg\" value=\"http://map.vworld.kr/images/ol3/marker.png\"> \r\n");
      out.write("\t\t\t\t<img src=\"http://map.vworld.kr/images/ol3/marker.png\" /> \r\n");
      out.write("\r\n");
      out.write("\t\t\t\t<!--input type=\"radio\" name=\"searchMk\" id=\"mkImg\" value=\"https://openlayers.org/en/v3.20.1/examples/data/icon.png\">\r\n");
      out.write("\t\t\t\t<img src=\"https://openlayers.org/en/v3.20.1/examples/data/icon.png\" /-->\r\n");
      out.write("\r\n");
      out.write("\t\t\t\t<input type=\"radio\" name=\"searchMk\" id=\"mkImg\" value=\"https://developers.google.com/maps/documentation/javascript/examples/full/images/beachflag.png\">\r\n");
      out.write("\t\t\t\t<img src=\"https://developers.google.com/maps/documentation/javascript/examples/full/images/beachflag.png\" />\r\n");
      out.write("\t\t\t</label>\r\n");
      out.write("\t\t</div>\r\n");
      out.write("\t</form>\r\n");
      out.write("        <div id=\"option\"\r\n");
      out.write("\t\tstyle=\"border: solid 0.1px; width: 13%; height: 800px; float: left; overflow: auto;\">\r\n");
      out.write("\t\t\r\n");
      out.write("\t\t<div>\r\n");
      out.write("\t\t\t<p style=\"background-color: black; color: white;\">지도 타입변경\r\n");
      out.write("\t\t\t<p>\r\n");
      out.write("\t\t\t\t<input type=\"radio\" id=\"vworldTile\" name=\"tile\" value=\"Base\">기본지도\r\n");
      out.write("\t\t\t</p>\r\n");
      out.write("\t\t\t<p>\r\n");
      out.write("\t\t\t\t<input type=\"radio\" id=\"vworldTile\" name=\"tile\" value=\"Satelite\" checked>항공사진\r\n");
      out.write("\t\t\t</p>\r\n");
      out.write("\t\t\t<!--p><input type=\"checkbox\" id=\"vworldTile\" value=\"Hybrid\">문자 타일</p-->\r\n");
      out.write("\t\t\t<button type=\"button\" onclick=\"javascript:tileChange()\">지도옵션선택</button>\r\n");
      out.write("\t\t</div>\r\n");
      out.write("\t\t<hr>\r\n");
      out.write("\t\t\r\n");
      out.write("        \r\n");
      out.write("\t\t<div id=\"map1option\">\r\n");
      out.write("\t\t<div id=\"wms\">\r\n");
      out.write("\t\t\t<p style=\"background-color: gray; color: white;\">WMS\r\n");
      out.write("\t\t\t<p>\r\n");
      out.write("                <input type=\"checkbox\" id=\"sig\" value=\"sig\">지도 1 '시군구 주제도'\r\n");
      out.write("                <br>\r\n");
      out.write("                <input type=\"checkbox\" id=\"ctp\" value=\"ctp\">지도 1 '시도 주제도'\r\n");
      out.write("                <br>\r\n");
      out.write("                <input type=\"checkbox\" id=\"icon\" value=\"icon\">지도 1 '졸음쉼터 주제도'\r\n");
      out.write("\t\t\t\t<div id=\"wms2\" style=\"display:none;\">\r\n");
      out.write("\t\t\t\t\t<hr>\r\n");
      out.write("\t\t\t\t\t<input type=\"checkbox\" id=\"sig2\" value=\"sig\">지도 2 '시군구 주제도'\r\n");
      out.write("\t\t\t\t\t<br>\r\n");
      out.write("\t\t\t\t\t<input type=\"checkbox\" id=\"ctp2\" value=\"ctp\">지도 2 '시도 주제도'\r\n");
      out.write("\t\t\t\t\t<br>\r\n");
      out.write("\t\t\t\t\t<input type=\"checkbox\" id=\"icon2\" value=\"icon\">지도 2 '졸음쉼터 주제도'\r\n");
      out.write("\t\t\t\t</div>\r\n");
      out.write("\t\t\t\t\r\n");
      out.write("        </div>\r\n");
      out.write("\t\t\r\n");
      out.write("\t\t\t\r\n");
      out.write("\t\t<div id=\"selectOption\" style=\"\">   \r\n");
      out.write("\t\t\t<p style=\" background-color: black; color: white;\">1번지도 기능</p>\r\n");
      out.write("\t\t\t<label><input type=\"radio\" name=\"selcetType\" value=\"0\" checked>지도이동</label><br>\r\n");
      out.write("\t\t\t\t<label><input type=\"radio\" name=\"selcetType\" value=\"deleteMarker\">feature삭제</label><br>\r\n");
      out.write("\t\t\t\t<label><input type=\"radio\" name=\"selcetType\" value=\"roadviewOn\">로드뷰 보기</label><br>\r\n");
      out.write("\t\t\t\t<input type=\"radio\" name=\"selcetType\" value=\"MarkerOn\">마커 기능\r\n");
      out.write("\t\t\t\t\t\t\t<div id=\"selectMarker\" >\t\t\t\t\t\t\t\t\r\n");
      out.write("\t\t\t\t\t\t\t\t<br>\r\n");
      out.write("\t\t\t\t\t\t\t\t<input type=\"radio\" name=\"mkType\" value=\"http://map.vworld.kr/images/ol3/marker_blue.png\" checked>\t\t<img src=\"http://map.vworld.kr/images/ol3/marker_blue.png\" />\r\n");
      out.write("\t\t\t\t\t\t\t\t<input type=\"radio\" name=\"mkType\" value=\"http://map.vworld.kr/images/ol3/marker.png\">\t\t<img src=\"http://map.vworld.kr/images/ol3/marker.png\" />\r\n");
      out.write("\t\t\t\t\t\t\t\t<input type=\"radio\" name=\"mkType\" value=\"https://openlayers.org/en/v3.20.1/examples/data/icon.png\">\t<img src=\"https://openlayers.org/en/v3.20.1/examples/data/icon.png\" />\r\n");
      out.write("\t\t\t\t\t\t\t\t<input type=\"radio\" name=\"mkType\" value=\"https://developers.google.com/maps/documentation/javascript/examples/full/images/beachflag.png\">\t<img src=\"https://developers.google.com/maps/documentation/javascript/examples/full/images/beachflag.png\" />\r\n");
      out.write("\t\t\t\t\t\t\t\r\n");
      out.write("\t\t\t\t\t\t\t</div>\r\n");
      out.write("\t\t\t\t\t\t<hr>\r\n");
      out.write("\t\t\t</div>\r\n");
      out.write("\t\t\t<div id=\"marker\">\r\n");
      out.write("\t\t\t\t<p style=\"background-color: gray; color: white;\">1번지도 그리기 기능<br>\r\n");
      out.write("\t\t\t\t\t<span id=\"map1opWrap\"><input type=\"checkbox\" id=\"map1op\" value=\"\">'사용시체크'</span></p>\r\n");
      out.write("\t\t\t\t<form class=\"form-inline\">\r\n");
      out.write("\t\t\t\t\t<label>옵션 타입 &nbsp;</label> <select id=\"type\">\r\n");
      out.write("\t\t\t\t\t\t<option value=\"length\">길이</option>\r\n");
      out.write("\t\t\t\t\t\t<option value=\"area\" selected>면적</option>\r\n");
      out.write("\t\t\t\t\t\t\r\n");
      out.write("\t\t\t\t\t\t<!-- <option value=\"Circle\">Circle</option> -->\r\n");
      out.write("\t\t\t\t\t\t<option value=\"Select\" >선택</option>\r\n");
      out.write("\t\t\t\t\t</select>\r\n");
      out.write("\t\t\t\t</form>\r\n");
      out.write("\t\t\t\t\r\n");
      out.write("\t\t\t\t\r\n");
      out.write("\t\t\t\t<hr>\r\n");
      out.write("\t\t\t\t<button type=\"button\" onclick=\"javascript:map1_delete();\">MAP1\r\n");
      out.write("\t\t\t\t\t옵션 전체삭제</button><br>\r\n");
      out.write("\t\t\t</div>\r\n");
      out.write("\t\t\t<hr>\r\n");
      out.write("\t\t\t<p style=\"background-color: black; color: white;\">팝업 내용작성</p>\r\n");
      out.write("\t\t\t<label> 팝업제목 <input type=\"text\" id=\"subj\"\r\n");
      out.write("\t\t\t\tplaceholder=\"팝업 제목을 입력하세요\" />\r\n");
      out.write("\t\t\t</label> <br> <label> 팝업내용 <textarea id=\"cont\"\r\n");
      out.write("\t\t\t\t\tplaceholder=\"팝업 내용을 입력하세요\"></textarea>\r\n");
      out.write("\t\t\t</label>\r\n");
      out.write("\r\n");
      out.write("\t\t</div>\r\n");
      out.write("\t\t<div id=\"map2option\" style=\"display:none;\">\r\n");
      out.write("\t\t\t<p style=\"background-color: black; color: white;\">2번지도 그리기 기능<br></p>\r\n");
      out.write("\t\t\t\r\n");
      out.write("\t\t\t\t\r\n");
      out.write("\t\t\t\t\t\t<form class=\"form-inline\">\r\n");
      out.write("\t\t\t\t\t\t\t<label>옵션 타입 &nbsp;</label> <select id=\"type2\">\r\n");
      out.write("\t\t\t\t\t\t\t\t<option value=\"length\">길이</option>\r\n");
      out.write("\t\t\t\t\t\t\t\t<option value=\"area\" selected>면적</option>\r\n");
      out.write("\t\t\t\t\t\t\t\t\r\n");
      out.write("\t\t\t\t\t\t\t\t<!-- <option value=\"Circle\">Circle</option> -->\r\n");
      out.write("\t\t\t\t\t\t\t\t<option value=\"Select\">선택</option>\r\n");
      out.write("\t\t\t\t\t\t\t</select>\r\n");
      out.write("\t\t\t\t\t\t</form>\r\n");
      out.write("\t\t\t\t\t\t\t<hr>\r\n");
      out.write("\t\t\t\t\r\n");
      out.write("\t\t\t\t\t\t<br>\r\n");
      out.write("\t\t\t\t\t\t<button type=\"button\" onclick=\"javascript:map2_delete();\">MAP2\r\n");
      out.write("\t\t\t\t\t\t\t옵션 전체삭제</button><br>\r\n");
      out.write("\t\t</div>\r\n");
      out.write("\t\t\t\r\n");
      out.write("\t\t<div id=\"selectOption2\" style=\"display:none;\">   \r\n");
      out.write("\t\t<p style=\" background-color: black; color: white;\">2번지도 클릭 기능</p>\r\n");
      out.write("\t\t\t<label><input type=\"radio\" name=\"selcetType\" value=\"0\">지도이동</label><br>\r\n");
      out.write("\t\t\t<label><input type=\"radio\" name=\"selcetType\" value=\"deleteMarker\">feature삭제</label><br>\r\n");
      out.write("\t\t\t<input type=\"radio\" name=\"selcetType\" value=\"MarkerOn\">마커 기능\r\n");
      out.write("\t\t\t\t\t\t<div id=\"selectMarker\" >\r\n");
      out.write("\t\t\t\t\t\t\t\r\n");
      out.write("\t\t\t\t\t\t\t<br>\r\n");
      out.write("\t\t\t\t\t\t\t<input type=\"radio\" name=\"mkType\" value=\"http://map.vworld.kr/images/ol3/marker_blue.png\" checked>\t\t<img src=\"http://map.vworld.kr/images/ol3/marker_blue.png\" />\r\n");
      out.write("\t\t\t\t\t\t\t<input type=\"radio\" name=\"mkType\" value=\"http://map.vworld.kr/images/ol3/marker.png\">\t\t<img src=\"http://map.vworld.kr/images/ol3/marker.png\" />\r\n");
      out.write("\t\t\t\t\t\t\t<input type=\"radio\" name=\"mkType\" value=\"https://openlayers.org/en/v3.20.1/examples/data/icon.png\">\t<img src=\"https://openlayers.org/en/v3.20.1/examples/data/icon.png\" />\r\n");
      out.write("\t\t\t\t\t\t\t<input type=\"radio\" name=\"mkType\" value=\"https://developers.google.com/maps/documentation/javascript/examples/full/images/beachflag.png\">\t<img src=\"https://developers.google.com/maps/documentation/javascript/examples/full/images/beachflag.png\" />\r\n");
      out.write("\t\t\t\t\t\t\r\n");
      out.write("\t\t\t\t\t\t</div>\r\n");
      out.write("\t\t\t\t\t<hr>\r\n");
      out.write("\t\t</div>\r\n");
      out.write("\r\n");
      out.write("\t\t<div id=\"allOption\">\r\n");
      out.write("\t\t<p style=\"background-color: black; color: white;\">Delete기능</p>\r\n");
      out.write("\t\t\t<button type=\"button\" onclick=\"javascript:all_delete();\">전체MAP 옵션 전체삭제</button>\r\n");
      out.write("\t\t</div>\r\n");
      out.write("\r\n");
      out.write("</div>\r\n");
      out.write("\r\n");
      out.write("<div id=\"popupTest\" style=\"width: 300px; display: none;\"></div>\r\n");
      out.write("\r\n");
      out.write("    <div id=\"wrap\">\r\n");
      out.write("        <div id=\"map1\" class=\"map\"></div>\r\n");
      out.write("\t\t<div id=\"road\" style=\"display:none;\"></div>\r\n");
      out.write("\t\t<div id=\"map2\" class=\"map\"></div>\r\n");
      out.write("    </div>\r\n");
      out.write("\r\n");
      out.write("\t<div>\r\n");
      out.write("\t\t<!-- 검색 폼  -->\r\n");
      out.write("\t\t<!-- 데이터 API 폼  -->\r\n");
      out.write("\t\t<form id=\"dataForm\">\r\n");
      out.write("\t\t\t<input type=\"hidden\" name=\"key\"\r\n");
      out.write("\t\t\t\tvalue=\"CEB52025-E065-364C-9DBA-44880E3B02B8\"> <input\r\n");
      out.write("\t\t\t\ttype=\"hidden\" name=\"domain\" value=\"http://localhost:8080\"> <input\r\n");
      out.write("\t\t\t\ttype=\"hidden\" name=\"service\" value=\"data\"> <input\r\n");
      out.write("\t\t\t\ttype=\"hidden\" name=\"version\" value=\"2.0\"> <input\r\n");
      out.write("\t\t\t\ttype=\"hidden\" name=\"request\" value=\"getfeature\"> <input\r\n");
      out.write("\t\t\t\ttype=\"hidden\" name=\"format\" value=\"json\"> <input\r\n");
      out.write("\t\t\t\ttype=\"hidden\" name=\"size\" value=\"1000\"> <input type=\"hidden\"\r\n");
      out.write("\t\t\t\tname=\"page\" value=\"1\"> <input type=\"hidden\" name=\"data\"\r\n");
      out.write("\t\t\t\tvalue=\"LT_C_SPBD\"> <input type=\"hidden\" name=\"geometry\"\r\n");
      out.write("\t\t\t\tvalue=\"true\"> <input type=\"hidden\" name=\"attribute\"\r\n");
      out.write("\t\t\t\tvalue=\"true\"> <input type=\"hidden\" name=\"crs\"\r\n");
      out.write("\t\t\t\tvalue=\"EPSG:900913\">\r\n");
      out.write("\t\t\t<!-- <input type=\"hidden\" name=\"geomfilter\" value=\"BOX(14028876.609587036,3912653.333809428,14151175.854843318,3974414.4526638505)\"> -->\r\n");
      out.write("\t\t\t<input type=\"hidden\" name=\"geomfilter\"\r\n");
      out.write("\t\t\t\tvalue=\"POINT(14028876.609587036 3912653.333809428)\">\r\n");
      out.write("\t\t</form>\r\n");
      out.write("\t</div>\r\n");
      out.write("\t<div id=\"info\" style=\"top: 80%; left: 30%;\"></div>\r\n");
      out.write("\t<div id=\"result\"\r\n");
      out.write("\t\tstyle=\"overflow: scroll; width: 1500px; height: 500px; \">\r\n");
      out.write("\t\t<!-- P class=\"noticePrev\">검색결과 -->\r\n");
      out.write("\r\n");
      out.write("\t\t<p class=\"notice\" style=\"display: none; color: red;\">주소를 클릭 할 시 해당 좌표로\r\n");
      out.write("\t\t\t이동합니다<br>\r\n");
      out.write("\t\t\t<input type=\"checkbox\" id=\"searchMarker\" value=\"on\"> 체크시 이동 장소를 제외한 마커 숨김\r\n");
      out.write("\t\t</p>\r\n");
      out.write("\t\t<hr>\r\n");
      out.write("\t\t\r\n");
      out.write("\r\n");
      out.write("\t\t<p id=\"result_count\" style=\"text-align: center;\"></p>\r\n");
      out.write("\r\n");
      out.write("\t\t<ul id=\"result_ajax\">\r\n");
      out.write("\t\t\t<!--검색결과 ajax 장소, count 개수-->\r\n");
      out.write("\t\t\t<li></li>\r\n");
      out.write("\t\t</ul>\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\t\t<p id=\"result_pos\"></p>\r\n");
      out.write("\t\r\n");
      out.write("    <script src=\"/resources/js/function.js\"></script>\r\n");
      out.write("    <script src=\"/resources/js/map.js\"></script>\r\n");
      out.write("</body>\r\n");
      out.write("</html>\r\n");
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
