package com.fithe.common.commons;

import java.util.UUID;

public abstract class AuthcodeUtil {
	
	// 인증번호 생성 클래스
	public static String authcode(int len) {
		
		String u = UUID.randomUUID().toString();
		System.out.println("u >>> : " + u);
		u = u.replace("-", "").substring(0, len);
		System.out.println("u >>> : " + u);
		
		return u;
	}
	
	public static void main(String args[]) {
		System.out.println("main : " + AuthcodeUtil.authcode(6));
	}
}

