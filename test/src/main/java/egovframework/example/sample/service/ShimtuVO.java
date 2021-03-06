package egovframework.example.sample.service;

public class ShimtuVO {
	private int OBJT_ID;		//키
	private String SHLTR_NM;	//졸음쉼터명
	private String ROAD_NM;		//도로노선명
	private String ROAD_DRC;	//도로노선방향
	private String TOILET_YN;	//화장실 유무
	private String MNG_NM;		//관리기관명
	private String MNG_TEL;	//관리기관 전화번호
	private String ADRES;		//쉼터 주소
	private String RN_ADRES;	//도로명 주소
	private int xlon;				// X좌표
	private int ylat;				// Y좌표	
	
	public int getOBJT_ID() {
		return OBJT_ID;
	}
	public void setOBJT_ID(int oBJT_ID) {
		OBJT_ID = oBJT_ID;
	}
	public String getSHLTR_NM() {
		return SHLTR_NM;
	}
	public void setSHLTR_NM(String sHLTR_NM) {
		SHLTR_NM = sHLTR_NM;
	}
	public String getROAD_NM() {
		return ROAD_NM;
	}
	public void setROAD_NM(String rOAD_NM) {
		ROAD_NM = rOAD_NM;
	}
	public String getROAD_DRC() {
		return ROAD_DRC;
	}
	public void setROAD_DRC(String rOAD_DRC) {
		ROAD_DRC = rOAD_DRC;
	}
	public String getTOILET_YN() {
		return TOILET_YN;
	}
	public void setTOILET_YN(String tOILET_YN) {
		TOILET_YN = tOILET_YN;
	}
	public String getMNG_NM() {
		return MNG_NM;
	}
	public void setMNG_NM(String mNG_NM) {
		MNG_NM = mNG_NM;
	}
	public String getMNG_TEL() {
		return MNG_TEL;
	}
	public void setMNG_TEL(String mNG_TEL) {
		MNG_TEL = mNG_TEL;
	}
	public String getADRES() {
		return ADRES;
	}
	public void setADRES(String aDRES) {
		ADRES = aDRES;
	}
	public String getRN_ADRES() {
		return RN_ADRES;
	}
	public void setRN_ADRES(String rN_ADRES) {
		RN_ADRES = rN_ADRES;
	}
	public int getXlon() {
		return xlon;
	}
	public void setXlon(int xlon) {
		this.xlon = xlon;
	}
	public int getYlat() {
		return ylat;
	}
	public void setYlat(int ylat) {
		this.ylat = ylat;
	}	
	
}
