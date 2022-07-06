package egovframework.example.sample.service;

public class AccidentVO {
	private int OBJT_ID;
	private String VIOLT_CN;
	private int xlon;
	private int ylat;
	
	
	public int getOBJT_ID() {
		return OBJT_ID;
	}
	public void setOBJT_ID(int oBJT_ID) {
		OBJT_ID = oBJT_ID;
	}
	public String getVIOLT_CN() {
		return VIOLT_CN;
	}
	public void setVIOLT_CN(String vIOLT_CN) {
		VIOLT_CN = vIOLT_CN;
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
