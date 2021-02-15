package com.fithe.common.chaebun;

public abstract class ChaebunUtil {

	public static final String BIZ_GUBUN_M = "M"; // Member
	public static final String BIZ_GUBUN_B = "B"; // Board
	public static final String BIZ_GUBUN_R = "R"; // Reply
	
	// t : type >> DateFormatUtil에서의 구분문자이다.
	// c : ChaebunDAOImpl에서 해당 테이블에서 가져온 채번번호의 숫자이다.
	public static String numpad(String t, String c) {
		
		for(int i=c.length(); i<4; i++) {
			c = "0" + c;
		}
		String ymd = DateFormatUtil.ymdFormats(t);
		
		return ymd.concat(c);
	}
	
	// Member Table 채번 적용 >> ex) M20210001
	public static String getMemberChaebun(String type, String chaebun) {
		return BIZ_GUBUN_M.concat(ChaebunUtil.numpad(type, chaebun));
	}
			
}
