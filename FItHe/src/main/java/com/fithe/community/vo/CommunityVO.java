package com.fithe.community.vo;

public class CommunityVO {
	private String cnum;
	private String mid;
	private String csubject;
	private String ccontent;
	private String cfile;
	private String cinsertdate;
	private String cupdatedate;
	private String cdelyn;
	
	// 조회수 처리 속성
	private int chit;
	
	// 일반페이지, 관리자페이지 구분
	private String boardtype;
	
	public CommunityVO() {
		
	}
	
	public CommunityVO(String cnum, String mid, String csubject, String ccontent, String cfile, String cinsertdate,
			String cupdatedate, String cdelyn, int chit, String boardtype) {
		this.cnum = cnum;
		this.mid = mid;
		this.csubject = csubject;
		this.ccontent = ccontent;
		this.cfile = cfile;
		this.cinsertdate = cinsertdate;
		this.cupdatedate = cupdatedate;
		this.cdelyn = cdelyn;
		this.chit = chit;
		this.boardtype = boardtype;
	}

	public String getCnum() {
		return cnum;
	}

	public String getMid() {
		return mid;
	}

	public String getCsubject() {
		return csubject;
	}

	public String getCcontent() {
		return ccontent;
	}

	public String getCfile() {
		return cfile;
	}

	public String getCinsertdate() {
		return cinsertdate;
	}

	public String getCupdatedate() {
		return cupdatedate;
	}

	public String getCdelyn() {
		return cdelyn;
	}

	public int getChit() {
		return chit;
	}

	public String getBoardtype() {
		return boardtype;
	}

	public void setCnum(String cnum) {
		this.cnum = cnum;
	}

	public void setMid(String mid) {
		this.mid = mid;
	}

	public void setCsubject(String csubject) {
		this.csubject = csubject;
	}

	public void setCcontent(String ccontent) {
		this.ccontent = ccontent;
	}

	public void setCfile(String cfile) {
		this.cfile = cfile;
	}

	public void setCinsertdate(String cinsertdate) {
		this.cinsertdate = cinsertdate;
	}

	public void setCupdatedate(String cupdatedate) {
		this.cupdatedate = cupdatedate;
	}

	public void setCdelyn(String cdelyn) {
		this.cdelyn = cdelyn;
	}

	public void setChit(int chit) {
		this.chit = chit;
	}

	public void setBoardtype(String boardtype) {
		this.boardtype = boardtype;
	}
	
}
