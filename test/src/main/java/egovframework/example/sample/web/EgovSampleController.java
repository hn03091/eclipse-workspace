/*
 * Copyright 2008-2009 the original author or authors.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
package egovframework.example.sample.web;

import java.awt.geom.Point2D;
import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.StringReader;
import java.math.BigDecimal;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import egovframework.example.sample.service.PopupService;
import egovframework.example.sample.service.PopupVO;
import egovframework.example.sample.service.AccidentService;
import egovframework.example.sample.service.AccidentVO;
import egovframework.example.sample.service.AedService;
import egovframework.example.sample.service.AedVO;
import egovframework.example.sample.service.EgovSampleService;
import egovframework.example.sample.service.PharmacyService;
import egovframework.example.sample.service.PharmacyVO;
import egovframework.example.sample.service.SampleDefaultVO;
import egovframework.example.sample.service.SampleVO;
import egovframework.example.sample.service.ShimtuService;
import egovframework.example.sample.service.ShimtuVO;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.xpath.XPath;
import javax.xml.xpath.XPathConstants;
import javax.xml.xpath.XPathExpression;
import javax.xml.xpath.XPathFactory;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.servlet.ModelAndView;
import org.springmodules.validation.commons.DefaultBeanValidator;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;
import org.xml.sax.InputSource;

import com.jhlabs.map.proj.Projection;
import com.jhlabs.map.proj.ProjectionFactory;



@Controller
public class EgovSampleController {

	@Resource(name = "popupService")
	private PopupService popupService;
	/**
	 * 졸음쉼터 서비스
	 */
	@Resource(name = "shimtuService")
	private ShimtuService shimtuService;
	/**
	 * 대형 차량 사고 서비스
	 */
	@Resource(name = "accidentService")
	private AccidentService accidentService;
	/**
	 * 자동 심장 충격기 서비스
	 */
	@Resource(name = "aedService")
	private AedService aedService;
	
	@Resource(name = "pharmacyService")
	private PharmacyService pmservice;
	/*
	// 1. URL
    //StringBuilder urlBuilder = new StringBuilder("http://apis.data.go.kr/B552657/AEDInfoInqireService/getAedFullDown"); 	/*URL
    String url = "http://apis.data.go.kr/B552657/AEDInfoInqireService/getAedFullDown";
    String key = "14NskrpuJyyWPdtoP%2BLa6YFYgQLDZLEdqC4ADaLCYfg7K%2Fy3l16lBKbl6nGszFUjbGAFCCqh8%2Ft1e1WEfMhR%2Bg%3D%3D";	// 2. 오픈 API의요청 규격에 맞는 파라미터 생성, 발급받은 인증키.
    int totalCount = 30463;	//총 데이터 갯수
    int nowpage = 1;	//불러올 페이지
    int pageSize= 3;	//불러올 데이터 결과 수
    int count= totalCount / pageSize +1;	// count+1 =데이터를 가져 올 횟수 
    
    //urlBuilder.append("?" + URLEncoder.encode("ServiceKey","UTF-8") + "="+key); /*Service Key
    //urlBuilder.append("&" + URLEncoder.encode("returnType","UTF-8") + "=" + URLEncoder.encode("JSON", "UTF-8")); /*XML 또는 JSON
    //urlBuilder.append("&" + URLEncoder.encode("numOfRows","UTF-8") + "=" + URLEncoder.encode("100", "UTF-8")); /*한 페이지 결과 수
    //urlBuilder.append("&" + URLEncoder.encode("pageNo","UTF-8") + "=" + URLEncoder.encode("1", "UTF-8")); /*페이지 번호
    //urlBuilder.append("&" + URLEncoder.encode("cond[country_nm::EQ]","UTF-8") + "=" + URLEncoder.encode("가나", "UTF-8")); /*한글 국가명
    //urlBuilder.append("&" + URLEncoder.encode("cond[country_iso_alp2::EQ]","UTF-8") + "=" + URLEncoder.encode("GH", "UTF-8")); /*ISO 2자리코드
    
    // 3. URL 객체 생성.
    //URL url = new URL(urlBuilder.toString());
    System.out.println("count :"+count);
    //while(nowpage <= count) {
    	String urlstr = url + "?ServiceKey=" + key + "&numOfRows=" + pageSize + "&pageNo=" + nowpage;
    	
        URL myurl = new URL(urlstr);
        // 4. 요청하고자 하는 URL과 통신하기 위한 Connection 객체 생성.
        HttpURLConnection conn = (HttpURLConnection) myurl.openConnection();
        // 5. 통신을 위한 메소드 SET.
        conn.setRequestMethod("GET");
        // 6. 통신을 위한 Content-type SET. 
        conn.setRequestProperty("Content-type", "application/json");
        // 7. 통신 응답 코드 확인.
        //System.out.println("Response code: " + conn.getResponseCode());
        // 8. 전달받은 데이터를 BufferedReader 객체로 저장.
        BufferedReader rd;
        if(conn.getResponseCode() >= 200 && conn.getResponseCode() <= 300) {
            rd = new BufferedReader(new InputStreamReader(conn.getInputStream()));
        } else {
            rd = new BufferedReader(new InputStreamReader(conn.getErrorStream()));
        }
        System.out.println("rd = "+rd);
        System.out.println("=============");
        
        
        // 9. 저장된 데이터를 라인별로 읽어 StringBuilder 객체로 저장.
        StringBuilder sb = new StringBuilder();
        String result ="";
        String line;
        while ((line = rd.readLine()) != null) {
        	result = result +line.trim();
            //sb.append(line);
        }
        // 10. 객체 해제.
        rd.close();
        conn.disconnect();
        System.out.println("result"+result);
        // 11. 전달받은 데이터 확인.
        //System.out.println(sb.toString());
        nowpage= nowpage+1;
    //}*/
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

		srcProject = new Point2D.Double(y, x); //x,y 경도를 잘못입력하면 dstproject 에서 값을 못받아옴. 오류 날시 x,y 위치를 바꾸어보기.
		
		dstProject = proj.transform(srcProject, new Point2D.Double());
		System.out.println(dstProject);
		
		return dstProject;
		
	}
	@RequestMapping(value="/testservice.do")
	public String testservice(PharmacyVO pharmacyVO) throws Exception{
		pmservice.insertPm(pharmacyVO);
		return "hjb/testservice";
	}
	/* 공공데이터 api XML파일을 파싱 하여 db로 insert
	 *	스케쥴러 이용하여 주기적으로 db업데이트를 함.
	 */
	@RequestMapping(value="/test.do")
	public String test(AedVO aedVO) throws Exception{
		aedService.deleteAed(aedVO);

        String url = "http://apis.data.go.kr/B552657/AEDInfoInqireService/getAedFullDown";
        String key = "14NskrpuJyyWPdtoP%2BLa6YFYgQLDZLEdqC4ADaLCYfg7K%2Fy3l16lBKbl6nGszFUjbGAFCCqh8%2Ft1e1WEfMhR%2Bg%3D%3D";	// 2. 오픈 API의요청 규격에 맞는 파라미터 생성, 발급받은 인증키.
        int totalCount = 1;	//총 데이터 갯수
        int nowpage = 1;	//불러올 페이지
        int pageSize= 100;	//불러올 데이터 결과 수
        int count= 3;	// count+1 =데이터를 가져 올 횟수 
        
        DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance(); //xml 문서에서 dom 오브젝트 트리를 생성하는 api
        factory.setNamespaceAware(true);	//xml 네임스페이스에 대한 지원을 제공하도록 지정하기
        DocumentBuilder builder;	//XML 에서 DOM 문서 인스턴스를 가져오는 API를 정의함 -> XML에서의 Document를 얻을 수 있음
        Document doc = null;	//xml에서 가져온 인스턴스를 저장하기 위함
        while(nowpage <= count) {
        	System.out.println("While nowpage= "+nowpage);
        	System.out.println("while Count= "+count);
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
		        String totalCount2 = node.getTextContent();
		        totalCount = Integer.parseInt(totalCount2);
		        System.out.println("totalCount = "+totalCount);
		        count = totalCount/pageSize+1;
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
	        		//System.out.println("For 2 : " + j);
	        		Node node = child.item(j);
	        		//System.out.println("현재 노드 이름 : " + node.getNodeName());			//vo type
	        		//System.out.println("현재 노드 타입 : " + node.getNodeType());			// ?
	        		//System.out.println("현재 노드 값 : " + node.getTextContent());			// vo content
	        		//System.out.println("현재 노드 네임스페이스 : " + node.getPrefix());		//
	        		//System.out.println("현재 노드의 다음 노드 : " + node.getNextSibling());	//
	        		
	        		String content = node.getTextContent();
	        		String type = node.getNodeName();
	        		//System.out.println("type= "+type);
	        		//System.out.println("content= "+content);
	        		
	        		xmlMap.put(type, content);
	        	
        			//if(type=="zipcode2") {
        			if(node.getNextSibling()==null) {	
        				aedVO.setBUILDADDRESS(xmlMap.getOrDefault("buildAddress","null"));
        				aedVO.setBUILDPLACE(xmlMap.getOrDefault("buildPlace","null"));
        				aedVO.setCLERKTEL(xmlMap.getOrDefault("clerkTel","null"));
        				aedVO.setGUGUN(xmlMap.getOrDefault("gugun","null"));
        				aedVO.setMANAGER(xmlMap.getOrDefault("manager","null"));
        				aedVO.setMANAGERTEL(xmlMap.getOrDefault("managerTel","null"));
        				aedVO.setMFG(xmlMap.getOrDefault("mfg","null"));
        				aedVO.setMODEL(xmlMap.getOrDefault("model","null"));
        				aedVO.setORG(xmlMap.getOrDefault("org","null"));
        				aedVO.setNUM(xmlMap.getOrDefault("rnum","null"));
        				aedVO.setSIDO(xmlMap.getOrDefault("sido","null"));
        				aedVO.setLON(xmlMap.getOrDefault("wgs84Lat","null"));
        				aedVO.setLAT(xmlMap.getOrDefault("wgs84Lon","null"));
        				aedVO.setZIPCODE1(xmlMap.getOrDefault("zipcode1","null"));
        				aedVO.setZIPCODE2(xmlMap.getOrDefault("zipcode2","null"));
        				String address = aedVO.getSIDO()+aedVO.getGUGUN()+aedVO.getBUILDADDRESS();
        				aedVO.setADDRES(address);
        				
        			
        				java.awt.geom.Point2D.Double inverseTransform = this.projTransform(aedVO.getLON(),aedVO.getLAT());	// 구글좌표계 > 경위도 변환    		
        				
        				String y = BigDecimal.valueOf(inverseTransform.getY()).toString();
        				String x = BigDecimal.valueOf(inverseTransform.getX()).toString();
                		aedVO.setX(x);
                		aedVO.setY(y);
        			
                		System.out.println(aedVO.toString());
                		aedService.insertAed(aedVO);
                		
	        		}	
		        }
	        }
	        nowpage= nowpage+1; //다음페이지 저장
        }
		return "hjb/test";
	}

	// 진행중인 지도 //
	@RequestMapping(value= "/newMap.do")
	public String newMap() throws Exception {
		
		return "hjb/newMap";
	}
	
	
	@RequestMapping(value= "/main.do")
	public String main() throws Exception {
		
		return "hjb/main";
	}
	// 과제의 지도 //
	@RequestMapping(value = "/map.do")
	public String map(ShimtuVO shimtuVO, AccidentVO accidentVO, ModelMap model)throws Exception{
		List<ShimtuVO> sList=shimtuService.shimtuList(shimtuVO);
		List<AccidentVO> aList=accidentService.accidentList(accidentVO);
		
		model.addAttribute("sList",sList);
		model.addAttribute("aList",aList);
		return "hjb/map";
	}
	
	
	
	//////////////////////////////////////////////////
	@RequestMapping(value = "/test/testjson.json")
	public @ResponseBody ModelAndView testList(ModelMap model, HttpServletRequest request, @ModelAttribute("shimtuVO") ShimtuVO shimtuVO) throws Exception {
		ModelAndView test = new ModelAndView("jsonView");
		List<ShimtuVO> testlist=shimtuService.shimtuList(shimtuVO);
		
		test.addObject("testlist", testlist);
		System.out.println(testlist);
		return test;
	}
	
	@RequestMapping(value="/hjb2.do")
	public String hjb2()throws Exception{
		
		return "hjb/hjbMap2";
	}
	@RequestMapping(value="/hjb.do")
	public String hjb()throws Exception{
		
		return "hjb/hjbMap";
	}
	
	@RequestMapping(value="/openlayer.do")
	public String openlayersTest()throws Exception{
		
		return "hjb/openlayer";
	}
	
	@RequestMapping(value="/testmain.do")
	public String testmain() throws Exception{
		
		return "hjb/testmain";
	}
	
	@RequestMapping(value ="/testmap.do")
	public String testmap(PopupVO popupVO,ModelMap model) throws Exception{
		//List<PopupVO> pList= popupService.popupList(popupVO);
		//popupService.popupInsert(popupVO);
		//model.addAttribute("list", pList);
		return "hjb/testmap";
	}
	
	@RequestMapping(value = "/map2.do")
	public String map2()throws Exception{
		
		return "hjb/map220623";
	}
	
///////////////////////////////////////////////////////////////////////////
	
	
	
	
	
	
	
	@Resource(name = "sampleService")
	private EgovSampleService sampleService;

	/** EgovPropertyService */
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;

	/** Validator */
	@Resource(name = "beanValidator")
	protected DefaultBeanValidator beanValidator;

	/**
	 * 글 목록을 조회한다. (pageing)
	 * @param searchVO - 조회할 정보가 담긴 SampleDefaultVO
	 * @param model
	 * @return "egovSampleList"
	 * @exception Exception
	 */
	@RequestMapping(value = "/egovSampleList.do")
	public String selectSampleList(@ModelAttribute("searchVO") SampleDefaultVO searchVO, ModelMap model) throws Exception {

		/** EgovPropertyService.sample */
		/*searchVO.setPageUnit(propertiesService.getInt("pageUnit"));
		searchVO.setPageSize(propertiesService.getInt("pageSize"));

		/* pageing setting */
		/*PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(searchVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(searchVO.getPageUnit());
		paginationInfo.setPageSize(searchVO.getPageSize());

		searchVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		searchVO.setLastIndex(paginationInfo.getLastRecordIndex());
		searchVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

		//List<?> sampleList = sampleService.selectSampleList(searchVO);
		//model.addAttribute("resultList", sampleList);

		int totCnt = sampleService.selectSampleListTotCnt(searchVO);
		paginationInfo.setTotalRecordCount(totCnt);
		model.addAttribute("paginationInfo", paginationInfo);*/

		return "sample/egovSampleList";
	}

	/**
	 * 글 등록 화면을 조회한다.
	 * @param searchVO - 목록 조회조건 정보가 담긴 VO
	 * @param model
	 * @return "egovSampleRegister"
	 * @exception Exception
	 */
	@RequestMapping(value = "/addSample.do", method = RequestMethod.GET)
	public String addSampleView(@ModelAttribute("searchVO") SampleDefaultVO searchVO, Model model) throws Exception {
		//model.addAttribute("sampleVO", new SampleVO());
		return "sample/egovSampleRegister";
	}

	/**
	 * 글을 등록한다.
	 * @param sampleVO - 등록할 정보가 담긴 VO
	 * @param searchVO - 목록 조회조건 정보가 담긴 VO
	 * @param status
	 * @return "forward:/egovSampleList.do"
	 * @exception Exception
	 */
	@RequestMapping(value = "/addSample.do", method = RequestMethod.POST)
	public String addSample(@ModelAttribute("searchVO") SampleDefaultVO searchVO, SampleVO sampleVO, BindingResult bindingResult, Model model, SessionStatus status)
			throws Exception {

		// Server-Side Validation
		beanValidator.validate(sampleVO, bindingResult);

		if (bindingResult.hasErrors()) {
			model.addAttribute("sampleVO", sampleVO);
			return "sample/egovSampleRegister";
		}

		//sampleService.insertSample(sampleVO);
		status.setComplete();
		return "forward:/egovSampleList.do";
	}

	/**
	 * 글 수정화면을 조회한다.
	 * @param id - 수정할 글 id
	 * @param searchVO - 목록 조회조건 정보가 담긴 VO
	 * @param model
	 * @return "egovSampleRegister"
	 * @exception Exception
	 */
	@RequestMapping("/updateSampleView.do")
	public String updateSampleView(@RequestParam("selectedId") String id, @ModelAttribute("searchVO") SampleDefaultVO searchVO, Model model) throws Exception {
		SampleVO sampleVO = new SampleVO();
		sampleVO.setId(id);
		// 변수명은 CoC 에 따라 sampleVO
		//model.addAttribute(selectSample(sampleVO, searchVO));
		return "sample/egovSampleRegister";
	}

	/**
	 * 글을 조회한다.
	 * @param sampleVO - 조회할 정보가 담긴 VO
	 * @param searchVO - 목록 조회조건 정보가 담긴 VO
	 * @param status
	 * @return @ModelAttribute("sampleVO") - 조회한 정보
	 * @exception Exception
	 */
	/*public SampleVO selectSample(SampleVO sampleVO, @ModelAttribute("searchVO") SampleDefaultVO searchVO) throws Exception {
		return sampleService.selectSample(sampleVO);
	}

	/**
	 * 글을 수정한다.
	 * @param sampleVO - 수정할 정보가 담긴 VO
	 * @param searchVO - 목록 조회조건 정보가 담긴 VO
	 * @param status
	 * @return "forward:/egovSampleList.do"
	 * @exception Exception
	 */
	@RequestMapping("/updateSample.do")
	public String updateSample(@ModelAttribute("searchVO") SampleDefaultVO searchVO, SampleVO sampleVO, BindingResult bindingResult, Model model, SessionStatus status)
			throws Exception {

		beanValidator.validate(sampleVO, bindingResult);

		if (bindingResult.hasErrors()) {
			model.addAttribute("sampleVO", sampleVO);
			return "sample/egovSampleRegister";
		}

		sampleService.updateSample(sampleVO);
		status.setComplete();
		return "forward:/egovSampleList.do";
	}

	/**
	 * 글을 삭제한다.
	 * @param sampleVO - 삭제할 정보가 담긴 VO
	 * @param searchVO - 목록 조회조건 정보가 담긴 VO
	 * @param status
	 * @return "forward:/egovSampleList.do"
	 * @exception Exception
	 */
	@RequestMapping("/deleteSample.do")
	public String deleteSample(SampleVO sampleVO, @ModelAttribute("searchVO") SampleDefaultVO searchVO, SessionStatus status) throws Exception {
		sampleService.deleteSample(sampleVO);
		status.setComplete();
		return "forward:/egovSampleList.do";
	}

}
