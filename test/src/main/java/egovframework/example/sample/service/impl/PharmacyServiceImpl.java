package egovframework.example.sample.service.impl;

import java.awt.geom.Point2D;
import java.io.BufferedReader;
import java.io.DataOutputStream;
import java.io.InputStreamReader;
import java.io.StringReader;
import java.math.BigDecimal;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.xpath.XPath;
import javax.xml.xpath.XPathConstants;
import javax.xml.xpath.XPathExpression;
import javax.xml.xpath.XPathFactory;

import org.postgresql.core.Parser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.w3c.dom.Document;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;
import org.xml.sax.InputSource;

import com.jhlabs.map.proj.Projection;
import com.jhlabs.map.proj.ProjectionFactory;

import egovframework.example.sample.service.PharmacyService;
import egovframework.example.sample.service.PharmacyVO;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

@Service("pharmacyService")
public class PharmacyServiceImpl extends EgovAbstractServiceImpl implements PharmacyService {
	
	@Autowired PharmacyMapper pmMapper;
	
	/**
	 * geocoder api 2.0
	 * 주소 -> 구글 좌표계 x,y
	 * changeAdr = 공공데이터 xml 의 주소지
	 * 반환 타입 JSON,XML / 좌표계 설정 가능
	 * @return 주소를 3857 좌표계로 변환 하여 리턴
	 * @return xyList
	 */
	public List<String> geocoder(String changeAdr) {
		String apiurl="http://api.vworld.kr/req/address";
		DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance(); //xml 문서에서 dom 오브젝트 트리를 생성하는 api
        factory.setNamespaceAware(true);	//xml 네임스페이스에 대한 지원을 제공하도록 지정하기
        DocumentBuilder builder;	//XML 에서 DOM 문서 인스턴스를 가져오는 API를 정의함 -> XML에서의 Document를 얻을 수 있음
        Document doc = null;	//xml에서 가져온 인스턴스를 저장하기 위함
        List<String> xyList = new ArrayList<>();
        try {
			int responseCode=0;
			URL url = new URL(apiurl);
			HttpURLConnection con =(HttpURLConnection)url.openConnection();
			
			String text_content = URLEncoder.encode(changeAdr.toString(), "utf-8");
			String postParams ="service=address";
				postParams +="&request=getcoord";
				postParams +="&version=2.0";
				postParams +="&crs=EPSG:3857";
				postParams +="&address="+text_content;
				postParams +="&arefine=true";
				postParams +="&simple=false";
				postParams +="&format=xml";
				postParams +="&type=road";
				postParams +="&errorFormat=xml";
				postParams +="&key=10036FCE-3940-374C-B2ED-E6FBDF47CFA9";
			
			con.setDoOutput(true);
			DataOutputStream wr= new DataOutputStream(con.getOutputStream());
			wr.writeBytes(postParams);
			wr.flush();
			wr.close();
			responseCode= con.getResponseCode();
			BufferedReader br;
			if(responseCode ==200) {
				br = new BufferedReader(new InputStreamReader(con.getInputStream()));
			}else {
				br = new BufferedReader(new InputStreamReader(con.getErrorStream()));
			}
			String inputLine;
			
			String result="";
			
			while((inputLine = br.readLine()) != null) {
				result = result + inputLine.trim();
			}
			InputSource is = new InputSource(new StringReader(result));
	        builder = factory.newDocumentBuilder();
	        doc = builder.parse(is);
	        XPathFactory xpathFactory = XPathFactory.newInstance();
	        XPath xpath = xpathFactory.newXPath();
	        XPathExpression expr = xpath.compile("//point");
	        NodeList nodeList = (NodeList) expr.evaluate(doc, XPathConstants.NODESET);
	        NodeList child = nodeList.item(0).getChildNodes();
	        Node node = child.item(0);
	        Node node2 = child.item(1);
	        String X= node.getTextContent();
	        String Y= node2.getTextContent();
	        
	        xyList.add(0,X);
	        xyList.add(1,Y);
	        System.out.println(xyList);
			br.close();
			con.disconnect();
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		return xyList;
	}
	
	/**
	 * 좌표변환 - 경위도 -> 구글좌표계 
	 * proj 사용 시 y 좌표 안나올시 x,y 위치 바꾸어 볼 것.
	 * @param strX
	 * @param strY
	 * @return
	 */
	public Point2D.Double projTransform(String strX, String strY) {
		
		double x = 0.;
		double y = 0.;
		
		if(strX != null && !"".equals(strX)) {
			x = Double.parseDouble(strX);
		}
		if(strY != null && !"".equals(strY)) {
			y = Double.parseDouble(strY);
		}
		
		String[] proj4_w=new String[]{
				"+proj=merc", 
				"+a=6378137", 
				"+b=6378137",
				"+lat_ts=0.0", 
				"+lon_0=0.0", 
				"+x_0=0.0",
				"+y_0=0",
				"+k=1.0",
				"+units=m",
				"+nadgrids=@null",
				"+no_defs"
		};

		Point2D.Double srcProject = null;
		Point2D.Double dstProject = null;
		Projection proj = ProjectionFactory.fromPROJ4Specification(proj4_w);

		srcProject = new Point2D.Double(x, y); //x,y 경도를 잘못입력하면 dstproject 에서 값을 못받아옴. 오류 날시 x,y 위치를 바꾸어보기.
		
		dstProject = proj.transform(srcProject, new Point2D.Double());
		//System.out.println(dstProject);
		
		return dstProject;
		
	}
	/**
	 *  공공api XML 파싱 하여 DB INSERT
	 *  String url, vo set,get 수정 시 다른 data도 이용가능
	 */
	@Override
	public void insertPm(PharmacyVO pharmacyVO) throws Exception{ //getParmacyFullDown
		String url = "http://apis.data.go.kr/B552657/ErmctInsttInfoInqireService/getParmacyFullDown";
        String key = "14NskrpuJyyWPdtoP%2BLa6YFYgQLDZLEdqC4ADaLCYfg7K%2Fy3l16lBKbl6nGszFUjbGAFCCqh8%2Ft1e1WEfMhR%2Bg%3D%3D";	// 2. 오픈 API의요청 규격에 맞는 파라미터 생성, 발급받은 인증키.
		

        int totalCount = 1;	//총 데이터 개수 => 첫 while 문에서 xml파싱하여 totalCount 최신으로 업데이트.
        int nowpage = 1;	//불러올 페이지
        int pageSize= 100;	//불러올 데이터 결과 수
        int count= 3;	// 데이터를 가져 올 횟수  => 첫 while 문에서 totalcount 이용하여 최신으로 업데이트.
        
        DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance(); //xml 문서에서 dom 오브젝트 트리를 생성하는 api
        factory.setNamespaceAware(true);	//xml 네임스페이스에 대한 지원을 제공하도록 지정하기
        DocumentBuilder builder;	//XML 에서 DOM 문서 인스턴스를 가져오는 API를 정의함 -> XML에서의 Document를 얻을 수 있음
        Document doc = null;	//xml에서 가져온 인스턴스를 저장하기 위함
        while(nowpage <= count) {
        	//공공데이터의 xml 값
        	String urlstr = url + "?ServiceKey=" + key + "&numOfRows=" + pageSize + "&pageNo=" + nowpage;
	    	
	        URL myurl = new URL(urlstr);
	        //  요청하고자 하는 URL과 통신하기 위한 Connection 객체 생성.
	        HttpURLConnection conn = (HttpURLConnection) myurl.openConnection();
	        //  통신을 위한 메소드 설정.
	        conn.setRequestMethod("GET");
	        //  통신을 위한 Content-type 설정. 
	        conn.setRequestProperty("Content-type", "application/json");
	        // 8. 전달받은 데이터를 BufferedReader 객체로 저장.
	        BufferedReader rd;
	        if(conn.getResponseCode() >= 200 && conn.getResponseCode() <= 300) {
	            rd = new BufferedReader(new InputStreamReader(conn.getInputStream()));
	        } else {
	            rd = new BufferedReader(new InputStreamReader(conn.getErrorStream()));
	        }
	        String result="";
	        String line;
	        while ((line = rd.readLine()) != null) {
	            result = result + line.trim();	//trim() => 공백제거
	        }
	        if(totalCount<2) {
	        	InputSource is = new InputSource(new StringReader(result));
		        builder = factory.newDocumentBuilder();
		        doc = builder.parse(is);
		        XPathFactory xpathFactory = XPathFactory.newInstance();
		        XPath xpath = xpathFactory.newXPath();
		        XPathExpression expr = xpath.compile("//totalCount");
		        NodeList nodeList = (NodeList) expr.evaluate(doc, XPathConstants.NODESET);
		        NodeList child = nodeList.item(0).getChildNodes();
		        Node node = child.item(0);
		        String totalCount2 = node.getTextContent();			//XML의 최신 totalCount => 주기적으로 바뀜
		        totalCount = Integer.parseInt(totalCount2);			//비교를 위하여 string에서 int로 변환
		        System.out.println("totalCount = "+totalCount);
		        count = totalCount/pageSize+1;						//데이터를 가져올 횟 수 =>COUNT 값 업데이트
		        System.out.println("Count = "+count);
	        }
	        //xml 파싱
	        
	        InputSource is = new InputSource(new StringReader(result));
	        builder = factory.newDocumentBuilder();
	        doc = builder.parse(is);
	        XPathFactory xpathFactory = XPathFactory.newInstance();
	        XPath xpath = xpathFactory.newXPath();
	        XPathExpression expr = xpath.compile("//items/item");
	        NodeList nodeList = (NodeList) expr.evaluate(doc, XPathConstants.NODESET);
	        for(int i = 0; i< nodeList.getLength(); i++) {
	        	//System.out.println("For 1 : " + i);
	        	NodeList child = nodeList.item(i).getChildNodes();
	        	HashMap<String, String>xmlMap = new HashMap<String, String>();
	        	//System.out.println("child.getLength() : " + child.getLength());
	        	for(int j=0; j<child.getLength(); j++) {
	        		Node node = child.item(j);
	        		
	        		String content = node.getTextContent();
	        		String type = node.getNodeName();
	        		
	        		xmlMap.put(type, content);
	        	
        			if(node.getNextSibling()==null) {	
        				pharmacyVO.setNUM(xmlMap.getOrDefault("rnum","null"));
        				pharmacyVO.setDUTYADDR(xmlMap.getOrDefault("dutyAddr","null"));
        				pharmacyVO.setDUTYETC(xmlMap.getOrDefault("dutyEtc","null"));
        				pharmacyVO.setDUTYMAPIMG(xmlMap.getOrDefault("dutyMapimg","null"));
        				pharmacyVO.setDUTYNAME(xmlMap.getOrDefault("dutyName","null"));
        				pharmacyVO.setDUTYTEL(xmlMap.getOrDefault("dutyTel1","null"));
        				
        				pharmacyVO.setDUTYTIME1C(xmlMap.getOrDefault("dutyTime1c","null"));
        				pharmacyVO.setDUTYTIME1S(xmlMap.getOrDefault("dutyTime1s","null"));
        				pharmacyVO.setDUTYTIME2C(xmlMap.getOrDefault("dutyTime2c","null"));
        				pharmacyVO.setDUTYTIME2S(xmlMap.getOrDefault("dutyTime2s","null"));
        				pharmacyVO.setDUTYTIME3C(xmlMap.getOrDefault("dutyTime3c","null"));
        				pharmacyVO.setDUTYTIME3S(xmlMap.getOrDefault("dutyTime3s","null"));
        				pharmacyVO.setDUTYTIME4C(xmlMap.getOrDefault("dutyTime4c","null"));
        				pharmacyVO.setDUTYTIME4S(xmlMap.getOrDefault("dutyTime4s","null"));
        				pharmacyVO.setDUTYTIME5C(xmlMap.getOrDefault("dutyTime5c","null"));
        				pharmacyVO.setDUTYTIME5S(xmlMap.getOrDefault("dutyTime5s","null"));
        				pharmacyVO.setDUTYTIME6C(xmlMap.getOrDefault("dutyTime6c","null"));
        				pharmacyVO.setDUTYTIME6S(xmlMap.getOrDefault("dutyTime6s","null"));
        				pharmacyVO.setDUTYTIME7C(xmlMap.getOrDefault("dutyTime7c","null"));
        				pharmacyVO.setDUTYTIME7S(xmlMap.getOrDefault("dutyTime7s","null"));
        				pharmacyVO.setDUTYTIME8C(xmlMap.getOrDefault("dutyTime8c","null"));
        				pharmacyVO.setDUTYTIME8S(xmlMap.getOrDefault("dutyTime8s","null"));
        				
        				pharmacyVO.setHPID(xmlMap.getOrDefault("hpid","null"));
        				pharmacyVO.setPOSTCDN1(xmlMap.getOrDefault("postCdn1","null"));
        				pharmacyVO.setPOSTCDN2(xmlMap.getOrDefault("postCdn2","null"));
        				pharmacyVO.setLON(xmlMap.getOrDefault("wgs84Lon","null"));
        				pharmacyVO.setLAT(xmlMap.getOrDefault("wgs84Lat","null"));
        				if(pharmacyVO.getDUTYTIME7S() != "null") { //일요일 오픈시간이 null값이 아니라면
        					pharmacyVO.setDUTYWEEKENDAT("Y");
        				}else {
        					pharmacyVO.setDUTYWEEKENDAT("N");
        				}
        				//vworld 주소로 좌표가져오기 어플있음, lon lat 없는 주소지도 있음 
        				// geocoder api
        				if(pharmacyVO.getLON() !="null" && pharmacyVO.getLAT() != "null") {
        					java.awt.geom.Point2D.Double inverseTransform = this.projTransform(pharmacyVO.getLON(),pharmacyVO.getLAT());	// 구글좌표계 > 경위도 변환    		
            				
            				String y = BigDecimal.valueOf(inverseTransform.getY()).toString();
            				String x = BigDecimal.valueOf(inverseTransform.getX()).toString();
            				/*System.out.println("================");
            				System.out.println("x= "+x);
            				System.out.println("y= "+y);
            				System.out.println("================");
                    		*/pharmacyVO.setX(x);
                    		pharmacyVO.setY(y);
        				}else {	//lon,lat 값이 없을때 geocoder 이용하여 주소를 좌표로 변환
        					String addr=pharmacyVO.getDUTYADDR();
        					//String vworld_apikey="10036FCE-3940-374C-B2ED-E6FBDF47CFA9";
        					List<String> returnXy = new ArrayList<>();
        					returnXy =geocoder(addr);
        					/*
        					String X = returnXy.get(0);
        					String Y = returnXy.get(1);
        					System.out.println("================");
        					System.out.println("return X"+X);
        					System.out.println("================");
        					System.out.println("return Y"+Y);
        					System.out.println("================!");
        					*/
        					if(returnXy != null) {	//주소지로 좌표 반환을 성공 했을 때
        						pharmacyVO.setX(returnXy.get(0));
            					pharmacyVO.setY(returnXy.get(1));
            					//System.out.println(pharmacyVO.toString());
        					}
        					
        				}
        				
                		System.out.println(pharmacyVO.toString());
                		System.out.println("=============");
        				
                		//pmMapper.insertPm(pharmacyVO);
                		
	        		}	
		        }
	        }
	        nowpage= nowpage+1; //다음페이지 저장
        }
	}
}
