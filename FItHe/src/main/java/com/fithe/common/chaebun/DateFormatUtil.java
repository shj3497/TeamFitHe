package com.fithe.common.chaebun;

import java.text.SimpleDateFormat;
import java.util.Date;

public abstract class DateFormatUtil {

	// 채번로직 적용시 필요한 공통함수
	public static String ymdFormats(String t) {
		
		String sd = "";
		Date d = new Date();
		
		// 연월일 출력
		if("D".equals(t.toUpperCase())) {
			sd = new SimpleDateFormat("yyyymmdd").format(d);
		}
		// 연월 출력
		if("M".equals(t.toUpperCase())) {
			sd = new SimpleDateFormat("yyyymm").format(d);
		}
		// 연 출력
		if("Y".equals(t.toUpperCase())) {
			sd = new SimpleDateFormat("yyyy").format(d);
		}
		// 출력x
		if("N".equals(t.toUpperCase())) {
			sd = "";
		}
		
		return sd;
	}
}
