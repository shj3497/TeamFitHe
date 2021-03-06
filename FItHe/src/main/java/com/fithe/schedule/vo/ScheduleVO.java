package com.fithe.schedule.vo;

public class ScheduleVO {
	private String sdate;
	private String situp;
	private String bend;
	private String jump;
	private String around;
	private String race;
	private String mid;
	
	public ScheduleVO() {
		
	}
	
	public ScheduleVO(String sdate, String situp, String bend, String jump, String around, String race, String mid) {
		this.sdate = sdate;
		this.situp = situp;
		this.bend = bend;
		this.jump = jump;
		this.around = around;
		this.race = race;
		this.mid = mid;
	}

	public String getSdate() {
		return sdate;
	}

	public void setSdate(String sdate) {
		this.sdate = sdate;
	}

	public String getSitup() {
		return situp;
	}

	public void setSitup(String situp) {
		this.situp = situp;
	}

	public String getBend() {
		return bend;
	}

	public void setBend(String bend) {
		this.bend = bend;
	}

	public String getJump() {
		return jump;
	}

	public void setJump(String jump) {
		this.jump = jump;
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

	public String getMid() {
		return mid;
	}

	public void setMid(String mid) {
		this.mid = mid;
	}
	
	
	
}