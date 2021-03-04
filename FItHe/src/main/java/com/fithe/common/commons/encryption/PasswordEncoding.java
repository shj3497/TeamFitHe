package com.fithe.common.commons.encryption;

import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional
public class PasswordEncoding {

	public static PasswordEncoder passwordEncoder;
	
	public PasswordEncoding() {
		PasswordEncoding.passwordEncoder = new BCryptPasswordEncoder();
	}
	
	public PasswordEncoding(PasswordEncoder passwordEncoder) {
		PasswordEncoding.passwordEncoder = passwordEncoder;
	}
	
	// 암호화 함수
	public static String encode(CharSequence rawPassword) {
		return passwordEncoder.encode(rawPassword);
	}
	
	// 패스워드 비교함수
	// rawPassword : 암호화 전 pw
	// encodedPassword : 암호화 후 pw
	// CharSequence : 마크업 문자를 사용하여 변형과 가공이 가능한 문자열이란 의미로 스타일 문자 또는 연속되는 문자
	// <-> String : 마크업 문자를 입력하여 사용할 수 없는 문자열이란 의미로 변경금지 문자
	public static boolean matches(CharSequence rawPassword, String encodedPassword) {
	    return passwordEncoder.matches(rawPassword, encodedPassword);
	}

}
