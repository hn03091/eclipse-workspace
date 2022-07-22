package egovframework.example.sample.service;

public class PharmacyVO {
	private String NUM; 		//일련번호
	private String DUTYADDR;	//주소
	private String DUTYETC;		//비고
	private String DUTYMAPIMG;	//간이약도
	private String DUTYNAME;	//기관명
	private String DUTYTEL;		//대표전화
	
	private String DUTYTIME1C;	//약국닫는시간(월~
	private String DUTYTIME2C;	
	private String DUTYTIME3C;	
	private String DUTYTIME4C;	
	private String DUTYTIME5C;	//약국닫는시간 ~금)
	private String DUTYTIME6C;	// 토
	private String DUTYTIME7C;	// 일
	private String DUTYTIME8C;	//(공휴일)
	
	private String DUTYTIME1S;	//약국여는시간(월~
	private String DUTYTIME2S;	
	private String DUTYTIME3S;	
	private String DUTYTIME4S;	
	private String DUTYTIME5S;	//여는시간~금)
	private String DUTYTIME6S;	//토
	private String DUTYTIME7S;	//일
	private String DUTYTIME8S;	//여는시간(공휴일)
	
	private String HPID;		//기관id
	private String POSTCDN1;	//우편번호 1,2
	private String POSTCDN2;	//우편번호 1,2
	private String LON;			
	private String LAT;			
	private String X;
	private String Y;
	private String GEOM;		
	/* 21 30
	 * 
	 */
	private String DUTYWEEKENDAT;	//주말 여는지 
	
	
	@Override
	public String toString() {
		return "TEST[NUM=" + NUM +", 토요일 여는시간=" + DUTYTIME6S + ", 토요일 닫는시간=" + DUTYTIME6C + ", 일요일 여는시간=" + DUTYTIME7S +", 일요일 닫는시간=" + DUTYTIME7C + 
				", 공휴일 여는시간=" + DUTYTIME8S +", 공휴일 닫는시간="+ DUTYTIME8C +  ", 주말 오픈 여부" + DUTYWEEKENDAT + "]";
	}
	public String getX() {
		return X;
	}
	public void setX(String x) {
		X = x;
	}
	public String getY() {
		return Y;
	}
	public void setY(String y) {
		Y = y;
	}
	public String getNUM() {
		return NUM;
	}
	public void setNUM(String nUM) {
		NUM = nUM;
	}
	public String getDUTYADDR() {
		return DUTYADDR;
	}
	public void setDUTYADDR(String dUTYADDR) {
		DUTYADDR = dUTYADDR;
	}
	public String getDUTYETC() {
		return DUTYETC;
	}
	public void setDUTYETC(String dUTYETC) {
		DUTYETC = dUTYETC;
	}
	public String getDUTYMAPIMG() {
		return DUTYMAPIMG;
	}
	public void setDUTYMAPIMG(String dUTYMAPIMG) {
		DUTYMAPIMG = dUTYMAPIMG;
	}
	public String getDUTYNAME() {
		return DUTYNAME;
	}
	public void setDUTYNAME(String dUTYNAME) {
		DUTYNAME = dUTYNAME;
	}
	public String getDUTYTEL() {
		return DUTYTEL;
	}
	public void setDUTYTEL(String dUTYTEL) {
		DUTYTEL = dUTYTEL;
	}
	public String getDUTYTIME1C() {
		return DUTYTIME1C;
	}
	public void setDUTYTIME1C(String dUTYTIME1C) {
		DUTYTIME1C = dUTYTIME1C;
	}
	public String getDUTYTIME2C() {
		return DUTYTIME2C;
	}
	public void setDUTYTIME2C(String dUTYTIME2C) {
		DUTYTIME2C = dUTYTIME2C;
	}
	public String getDUTYTIME3C() {
		return DUTYTIME3C;
	}
	public void setDUTYTIME3C(String dUTYTIME3C) {
		DUTYTIME3C = dUTYTIME3C;
	}
	public String getDUTYTIME4C() {
		return DUTYTIME4C;
	}
	public void setDUTYTIME4C(String dUTYTIME4C) {
		DUTYTIME4C = dUTYTIME4C;
	}
	public String getDUTYTIME5C() {
		return DUTYTIME5C;
	}
	public void setDUTYTIME5C(String dUTYTIME5C) {
		DUTYTIME5C = dUTYTIME5C;
	}
	public String getDUTYTIME6C() {
		return DUTYTIME6C;
	}
	public void setDUTYTIME6C(String dUTYTIME6C) {
		DUTYTIME6C = dUTYTIME6C;
	}
	public String getDUTYTIME7C() {
		return DUTYTIME7C;
	}
	public void setDUTYTIME7C(String dUTYTIME7C) {
		DUTYTIME7C = dUTYTIME7C;
	}
	public String getDUTYTIME8C() {
		return DUTYTIME8C;
	}
	public void setDUTYTIME8C(String dUTYTIME8C) {
		DUTYTIME8C = dUTYTIME8C;
	}
	public String getDUTYTIME1S() {
		return DUTYTIME1S;
	}
	public void setDUTYTIME1S(String dUTYTIME1S) {
		DUTYTIME1S = dUTYTIME1S;
	}
	public String getDUTYTIME2S() {
		return DUTYTIME2S;
	}
	public void setDUTYTIME2S(String dUTYTIME2S) {
		DUTYTIME2S = dUTYTIME2S;
	}
	public String getDUTYTIME3S() {
		return DUTYTIME3S;
	}
	public void setDUTYTIME3S(String dUTYTIME3S) {
		DUTYTIME3S = dUTYTIME3S;
	}
	public String getDUTYTIME4S() {
		return DUTYTIME4S;
	}
	public void setDUTYTIME4S(String dUTYTIME4S) {
		DUTYTIME4S = dUTYTIME4S;
	}
	public String getDUTYTIME5S() {
		return DUTYTIME5S;
	}
	public void setDUTYTIME5S(String dUTYTIME5S) {
		DUTYTIME5S = dUTYTIME5S;
	}
	public String getDUTYTIME6S() {
		return DUTYTIME6S;
	}
	public void setDUTYTIME6S(String dUTYTIME6S) {
		DUTYTIME6S = dUTYTIME6S;
	}
	public String getDUTYTIME7S() {
		return DUTYTIME7S;
	}
	public void setDUTYTIME7S(String dUTYTIME7S) {
		DUTYTIME7S = dUTYTIME7S;
	}
	public String getDUTYTIME8S() {
		return DUTYTIME8S;
	}
	public void setDUTYTIME8S(String dUTYTIME8S) {
		DUTYTIME8S = dUTYTIME8S;
	}
	public String getHPID() {
		return HPID;
	}
	public void setHPID(String hPID) {
		HPID = hPID;
	}
	public String getPOSTCDN1() {
		return POSTCDN1;
	}
	public void setPOSTCDN1(String pOSTCDN1) {
		POSTCDN1 = pOSTCDN1;
	}
	public String getPOSTCDN2() {
		return POSTCDN2;
	}
	public void setPOSTCDN2(String pOSTCDN2) {
		POSTCDN2 = pOSTCDN2;
	}
	public String getLON() {
		return LON;
	}
	public void setLON(String lON) {
		LON = lON;
	}
	public String getLAT() {
		return LAT;
	}
	public void setLAT(String lAT) {
		LAT = lAT;
	}
	public String getGEOM() {
		return GEOM;
	}
	public void setGEOM(String gEOM) {
		GEOM = gEOM;
	}
	public String getDUTYWEEKENDAT() {
		return DUTYWEEKENDAT;
	}
	public void setDUTYWEEKENDAT(String dUTYWEEKENDAT) {
		DUTYWEEKENDAT = dUTYWEEKENDAT;
	}
	
	
}
