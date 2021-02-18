package com.fithe.common.page;

public class Util {

	public static int nvl(String text) {
		
		return nvl(text,0);
	}
	/*
	 * nvl() 메소드는 문자열을 숫자로 변환하는 메소드
	 * @param(숫자로 변환할 문자열, 초기값으로 사용할 값(대체값))
	 * 참고 : 예외 처리는 체크예외와 비체크 예외로 구분.
	 * 체크 예외는 파일입출력 / 네트워크 입출력 / 데이터베이스 입출력
	 * 나머지는 비체크 예외로 인식
	 * */
	
	public static int nvl(String text, int def) {

		// Paging파일을 보면 getPage()가 text, def=1이다.
		// int ret = def; 는 초기값을 1로 정하자는 의미이다.
		int ret = def;
		
		try {
			// getPage() 타입이 String이므로 인트형으로 형변환해준다.
			ret = Integer.parseInt(text);
			
		}catch(Exception e) {
			ret = def;
		}
		
		// PagingVO에서 얻어온 getPage()가 인트형으로 형 변환하여 리턴한다.
		return ret;
	}
	
	public static String nvl(Object text, String def) {
		
		if(text==null || "".equals(text.toString().trim())) {
			return def;
		}else {
			return text.toString();
		}
	}
	
}
