package com.fithe.reply.vo;

public class ReplyVO {
	
	private String rnum;		// 댓글 채번
	private String cnum;		// 게시판 채번
	private String mid;			// 작성자 아이디(회원아이디)
	private String rcontent;	// 내용
	private String rinsertdate;	// 입력일
	private String rdelyn;		// 삭제여부
	
	public ReplyVO() {
		// TODO Auto-generated constructor stub
	}
	
	
	public ReplyVO(String rnum, String cnum, String mid, String rcontent, String rinsertdate, String rdelyn) {
		this.rnum = rnum;
		this.cnum = cnum;
		this.mid = mid;
		this.rcontent = rcontent;
		this.rinsertdate = rinsertdate;
		this.rdelyn = rdelyn;
	}


	public String getRnum() {
		return rnum;
	}


	public void setRnum(String rnum) {
		this.rnum = rnum;
	}


	public String getCnum() {
		return cnum;
	}


	public void setCnum(String cnum) {
		this.cnum = cnum;
	}


	public String getMid() {
		return mid;
	}


	public void setMid(String mid) {
		this.mid = mid;
	}


	public String getRcontent() {
		return rcontent;
	}


	public void setRcontent(String rcontent) {
		this.rcontent = rcontent;
	}


	public String getRinsertdate() {
		return rinsertdate;
	}


	public void setRinsertdate(String rinsertdate) {
		this.rinsertdate = rinsertdate;
	}


	public String getRdelyn() {
		return rdelyn;
	}


	public void setRdelyn(String rdelyn) {
		this.rdelyn = rdelyn;
	}

}
