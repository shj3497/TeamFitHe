package com.fithe.member.vo;

public class MemberVO {

    private String mnum;			// 회원 채번 Myyyy0001, yyyy:년도
    private String mid;				// 아이디
    private String mpw;	   			// 패스워드 
    private String mname;  			// 이름 홍길동
    private String mgender; 		// 성별 'M','F'
    private String mbir;			// 생년월일 주민등록번호 앞 6자리
    private String mzonecode;   	// 우편번호
    private String maddress;	// 도로명주소
    private String maddress_detail; // 상세주소 
    private String mph;				// 핸드폰번호
    private String memail;			// 이메일
    private String minsertdate;		// 입력일
    private String mupdatedate;		// 수정일
    private String mdelyn;			// 삭제여부
    private String mauth;		    // 권한 'A', 'M' >> : 'A' : 관리자, 'M' : 회원
    
    public MemberVO() {}
    
    public MemberVO(String mnum,
    				String mid,
    				String mpw,
    				String mname,
    				String mgender,
    				String mbir,
    				String mzonecode,
    				String maddress_road,
    				String maddress_detail,
    				String mph,
    				String memail,
    				String minsertdate,
    				String mupdatedate,
    				String mdelyn,
    				String mauth) {
    	this.mnum = mnum;
    	this.mid = mid;
    	this.mpw = mpw;
    	this.mname = mname;
    	this.mgender = mgender;
    	this.mbir = mbir;
    	this.mzonecode = mzonecode;
    	this.maddress = maddress;
    	this.maddress_detail = maddress_detail;
    	this.mph = mph;
    	this.memail = memail;
    	this.minsertdate = minsertdate;
    	this.mupdatedate = mupdatedate;
    	this.mdelyn = mdelyn;
    	this.mauth = mauth;
    }

	public String getMnum() {
		return mnum;
	}

	public void setMnum(String mnum) {
		this.mnum = mnum;
	}

	public String getMid() {
		return mid;
	}

	public void setMid(String mid) {
		this.mid = mid;
	}

	public String getMpw() {
		return mpw;
	}

	public void setMpw(String mpw) {
		this.mpw = mpw;
	}

	public String getMname() {
		return mname;
	}

	public void setMname(String mname) {
		this.mname = mname;
	}

	public String getMgender() {
		return mgender;
	}

	public void setMgender(String mgender) {
		this.mgender = mgender;
	}

	public String getMbir() {
		return mbir;
	}

	public void setMbir(String mbir) {
		this.mbir = mbir;
	}

	public String getMzonecode() {
		return mzonecode;
	}

	public void setMzonecode(String mzonecode) {
		this.mzonecode = mzonecode;
	}

	public String getMaddress() {
		return maddress;
	}

	public void setMaddress_Road(String maddress) {
		this.maddress = maddress;
	}

	public String getMaddress_detail() {
		return maddress_detail;
	}

	public void setMaddress_detail(String maddress_detail) {
		this.maddress_detail = maddress_detail;
	}

	public String getMph() {
		return mph;
	}

	public void setMph(String mph) {
		this.mph = mph;
	}

	public String getMemail() {
		return memail;
	}

	public void setMemail(String memail) {
		this.memail = memail;
	}

	public String getMinsertdate() {
		return minsertdate;
	}

	public void setMinsertdate(String minsertdate) {
		this.minsertdate = minsertdate;
	}

	public String getMupdatedate() {
		return mupdatedate;
	}

	public void setMupdatedate(String mupdatedate) {
		this.mupdatedate = mupdatedate;
	}

	public String getMdelyn() {
		return mdelyn;
	}

	public void setMdelyn(String mdelyn) {
		this.mdelyn = mdelyn;
	}

	public String getMauth() {
		return mauth;
	}

	public void setMauth(String mauth) {
		this.mauth = mauth;
	}
    
    
}
