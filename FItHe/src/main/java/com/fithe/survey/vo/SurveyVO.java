package com.fithe.survey.vo;

public class SurveyVO {
	
	private String snum;	// 채번
	private String mid;		// 회원 아이디
	private String sinsertdate; // 입력 날짜
	private String sdelyn;		// 삭제 여부
	
	// 회원 특징
	private String sgender;	// 성별
	private String sage;	// 나이
	private String sheight;	// 키
	private String sweight;	// 몸무게
	private String swaist;	// 허리둘레
	
	// 운동 측정
	private String situp;	// 윗몸 일으키기
	private String jump;	// 제자리 멀리뛰기
	private String bend;	// 윗몸 앞으로 굽히기
	private String around;	// 왕복 달리기
	private String race;	// 오래 달리기
	
	public SurveyVO() {}

	public SurveyVO(String snum, String mid, String sinsertdate, String sdelyn, String sgender, String sage,
			String sheight, String sweight, String swaist, String situp, String jump, String bend, String around,
			String race) {
		super();
		this.snum = snum;
		this.mid = mid;
		this.sinsertdate = sinsertdate;
		this.sdelyn = sdelyn;
		this.sgender = sgender;
		this.sage = sage;
		this.sheight = sheight;
		this.sweight = sweight;
		this.swaist = swaist;
		this.situp = situp;
		this.jump = jump;
		this.bend = bend;
		this.around = around;
		this.race = race;
	}

	public String getSnum() {
		return snum;
	}

	public void setSnum(String snum) {
		this.snum = snum;
	}

	public String getMid() {
		return mid;
	}

	public void setMid(String mid) {
		this.mid = mid;
	}

	public String getSinsertdate() {
		return sinsertdate;
	}

	public void setSinsertdate(String sinsertdate) {
		this.sinsertdate = sinsertdate;
	}

	public String getSdelyn() {
		return sdelyn;
	}

	public void setSdelyn(String sdelyn) {
		this.sdelyn = sdelyn;
	}

	public String getSgender() {
		return sgender;
	}

	public void setSgender(String sgender) {
		this.sgender = sgender;
	}

	public String getSage() {
		return sage;
	}

	public void setSage(String sage) {
		this.sage = sage;
	}

	public String getSheight() {
		return sheight;
	}

	public void setSheight(String sheight) {
		this.sheight = sheight;
	}

	public String getSweight() {
		return sweight;
	}

	public void setSweight(String sweight) {
		this.sweight = sweight;
	}

	public String getSwaist() {
		return swaist;
	}

	public void setSwaist(String swaist) {
		this.swaist = swaist;
	}

	public String getSitup() {
		return situp;
	}

	public void setSitup(String situp) {
		this.situp = situp;
	}

	public String getJump() {
		return jump;
	}

	public void setJump(String jump) {
		this.jump = jump;
	}

	public String getBend() {
		return bend;
	}

	public void setBend(String bend) {
		this.bend = bend;
	}

	public String getAround() {
		return around;
	}

	public void setAround(String around) {
		this.around = around;
	}

	public String getRace() {
		return race;
	}

	public void setRace(String race) {
		this.race = race;
	}


	
}
