package com.fithe.youtube.vo;

public class YoutubeVO {
	private String ylink;
	private String yid;
	private String ynum;
	
	public YoutubeVO() {
		
	}
	
	public YoutubeVO(String ylink, String yid, String ynum) {
		this.ylink = ylink;
		this.yid = yid;
		this.ynum = ynum;
	}

	public String getYlink() {
		return ylink;
	}

	public void setYlink(String ylink) {
		this.ylink = ylink;
	}

	public String getYid() {
		return yid;
	}

	public void setYid(String yid) {
		this.yid = yid;
	}

	public String getYnum() {
		return ynum;
	}

	public void setYnum(String ynum) {
		this.ynum = ynum;
	}
}
