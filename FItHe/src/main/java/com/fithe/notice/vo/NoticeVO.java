package com.fithe.notice.vo;

public class NoticeVO {
	private String nstatusyn; // 공지게시글을 공지(Y), 일반 속성(N)
	private String nnum;
	private String mid;
	private String nsubject;
	private String ncontent;
	private String nfile; // 파일 이름
	private String ninsertdate;
	private String nupdatedate;
	private String ndelyn;
	
	// 조회수 처리 속성
	private int nhit;
	
	// 일반페이지, 관리자페이지 구분
	private String boardtype;
	
	public NoticeVO() {
		
	}
	
	public NoticeVO(String nstatusyn, String nnum, String mid, String nsubject, String ncontent, String nfile,
			String ninsertdate, String nupdatedate, String ndelyn, int nhit, String boardtype) {
		this.nstatusyn = nstatusyn;
		this.nnum = nnum;
		this.mid = mid;
		this.nsubject = nsubject;
		this.ncontent = ncontent;
		this.nfile = nfile;
		this.ninsertdate = ninsertdate;
		this.nupdatedate = nupdatedate;
		this.ndelyn = ndelyn;
		this.nhit = nhit;
		this.boardtype = boardtype;
	}

	public String getNstatusyn() {
		return nstatusyn;
	}

	public String getNnum() {
		return nnum;
	}

	public String getMid() {
		return mid;
	}

	public String getNsubject() {
		return nsubject;
	}

	public String getNcontent() {
		return ncontent;
	}

	public String getNfile() {
		return nfile;
	}

	public String getNinsertdate() {
		return ninsertdate;
	}

	public String getNupdatedate() {
		return nupdatedate;
	}

	public String getNdelyn() {
		return ndelyn;
	}

	public int getNhit() {
		return nhit;
	}

	public String getBoardtype() {
		return boardtype;
	}

	public void setNstatusyn(String nstatusyn) {
		this.nstatusyn = nstatusyn;
	}

	public void setNnum(String nnum) {
		this.nnum = nnum;
	}

	public void setMid(String mid) {
		this.mid = mid;
	}

	public void setNsubject(String nsubject) {
		this.nsubject = nsubject;
	}

	public void setNcontent(String ncontent) {
		this.ncontent = ncontent;
	}

	public void setNfile(String nfile) {
		this.nfile = nfile;
	}

	public void setNinsertdate(String ninsertdate) {
		this.ninsertdate = ninsertdate;
	}

	public void setNupdatedate(String nupdatedate) {
		this.nupdatedate = nupdatedate;
	}

	public void setNdelyn(String ndelyn) {
		this.ndelyn = ndelyn;
	}

	public void setNhit(int nhit) {
		this.nhit = nhit;
	}

	public void setBoardtype(String boardtype) {
		this.boardtype = boardtype;
	}
	
}
