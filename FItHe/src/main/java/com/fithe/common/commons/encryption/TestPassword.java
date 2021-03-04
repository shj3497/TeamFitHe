package com.fithe.common.commons.encryption;

public class TestPassword {
	
	public static void main(String args[]) {
		PasswordEncoding passwordEncoding = new PasswordEncoding();
		
		String password1 = "12345678";
		String password2 = "12345678";
		
		// 암호화된 패스워드
		// 1. 같은 문자열을 입력 받았더라도 다른 암호화 문자열이 반환된다.
		String cryptpass1 = PasswordEncoding.encode(password1);
		String cryptpass2 = PasswordEncoding.encode(password2);
		
		System.out.println("newPassword1 : " + cryptpass1);
		System.out.println("newPassword2 : " + cryptpass2);
		
		// 암호화된 문자열을 비교할 때는 boolean으로 하면 안된다.
		System.out.println("boolean : " + cryptpass1==cryptpass2);
		// 암호화된 문자열을 비교할 때는 match라는 함수를 사용하여 비교한다.
		// matches(입력받은 패스워드, 암호화된 패스워드)
		// 2. 암호화된 패스워드가 다르더라도 처음 입력받은 pw가 같으면 matches() 함수로 true를 반환한다.
		System.out.println("matches : " + passwordEncoding.matches(password2, cryptpass2));
		
		// 프로젝트시 진행할 예정사항
		// .jsp 입력받은 pw -> vo에 저장 -> 컨트롤러에서 vo에 저장된 pw를 얻어와서 암호화 -> db저장
		// 로그인시 쿼리문 -> id로만 검색해서 모든 정보를 가지고 나온다.
		// -> db에서 암호화된 패스워드를 vo에 저장 -> vo에 있는 암호화된 패스워드를 matches() 함수를 이용하여
		// .jsp에서 입력받은 pw와 db에서 가지고 나온 pw를 비교
		// 일치하면 로그인 성공
	}
}
