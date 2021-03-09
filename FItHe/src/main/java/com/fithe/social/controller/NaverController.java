package com.fithe.social.controller;

import java.io.IOException;
import java.util.UUID;

import javax.servlet.http.HttpSession;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.github.scribejava.core.builder.ServiceBuilder;
import com.github.scribejava.core.model.OAuth2AccessToken;
import com.github.scribejava.core.model.OAuthRequest;
import com.github.scribejava.core.model.Response;
import com.github.scribejava.core.model.Verb;
import com.github.scribejava.core.oauth.OAuth20Service;

@Controller
public class NaverController {
	
	private Logger logger = Logger.getLogger(NaverController.class);
	
	// https://thefif19wlsvy.tistory.com/33 참고
	// https://developers.naver.com/docs/login/bi/ 네이버 로그인 로고
	private final static String CLIENT_ID = "Oy7GSP_ga_SO__OGWLtY";
	private final static String CLIENT_SECRET = "sisgTorDDi";
	private final static String REDIRECT_URI = "http://localhost:8088/FItHe/naverLogin.do";
	private final static String SESSION_STATE = "oauth_state";
	
	// 프로필 조회 API URL
	private final static String PROFILE_API_URL = "https://openapi.naver.com/v1/nid/me";
	
	
	// 네아로 인증 URL 생성 Method
	public static String getAuthorizationUrl(HttpSession session) {
		
		// 세션 유효성 검증을 위하여 난수를 생성
		String state = generateRandomString();
		
		// 생성한 난수 값을 session에 저장
		setSession(session, state);
		
		// Scribe 에서 제공하는 인증 URL 생성 기능을 이용하여 네아로 인증 URL 생성
		OAuth20Service oauthService = new ServiceBuilder().apiKey(CLIENT_ID)
															.apiSecret(CLIENT_SECRET)
															.callback(REDIRECT_URI)
															.state(state)
															.build(NaverLoginApi.instance());
		
		return oauthService.getAuthorizationUrl();
	}
	
	// 네아로 Callback 처리 및 AccessToken 획득 Method 
	// 카카오 리다이렉트, 네아로 콜백
	public static OAuth2AccessToken getAccessToken(HttpSession session, String code, String state) throws IOException{
		
		// Callback으로 전달 받은 세션검증용 난수값과 세션에 저장되어있는 값이 일치하는지 확인한다.
		String sessionState = getSession(session);
		if(StringUtils.equals(sessionState, state)) {
			OAuth20Service oauthService = new ServiceBuilder().apiKey(CLIENT_ID)
															.apiSecret(CLIENT_SECRET)
															.callback(REDIRECT_URI)
															.state(state)
															.build(NaverLoginApi.instance());
			
			// Scribe에서 제공하는 AccessToken 획득 기능으로 네아로 Access Token 획득
			OAuth2AccessToken accessToken = oauthService.getAccessToken(code);
			return accessToken;
		}
		return null;
	}

	// 세션 유효성 검증을 위한 난수 생성기
	private static String generateRandomString() {
		
		return UUID.randomUUID().toString();
	}
	
	// http session에 데이터 저장
	private static void setSession(HttpSession session, String state) {
		session.setAttribute(SESSION_STATE, state);
	}
	
	// http session에서 데이터 가져오기
	private static String getSession(HttpSession session) {
		return (String) session.getAttribute(SESSION_STATE);
	}
	
	// Access Token을 이용하여 네이버 사용자 프로필 API 호출
	public static String getUserProfile(OAuth2AccessToken oauthToken) throws IOException {
		
		OAuth20Service oauthService = new ServiceBuilder().apiKey(CLIENT_ID)
														.apiSecret(CLIENT_SECRET)
														.callback(REDIRECT_URI)
														.build(NaverLoginApi.instance());
		
		OAuthRequest request = new OAuthRequest(Verb.GET, PROFILE_API_URL, oauthService);
		oauthService.signRequest(oauthToken, request);
		Response response = request.send();
				
		return response.getBody();
	}
	
	/*
	 * 시험용
	 * MemberController에서 loginForm에서 해주면 된다.
	 * 
	@RequestMapping(value="naverLoginForm.do", method=RequestMethod.GET)
	public String naverLoginForm(Model model, HttpSession session) {
		logger.info("naverLoginForm() 진입");
		
		String naverAuthUrl = getAuthorizationUrl(session); 
		logger.info("naverAuthUrl >>> : " + naverAuthUrl);
		
		model.addAttribute("naver_url", naverAuthUrl);
		
		return "member/naverLogin";
	}
	*/
	
	@RequestMapping(value="naverLogin", produces="application/json;charset=utf-8", method= {RequestMethod.GET, RequestMethod.POST})
	public ModelAndView naverLogin(@RequestParam String code, @RequestParam String state, HttpSession session) 
									throws IOException{
		
		logger.info("naverLogin() 진입");
		ModelAndView mav = new ModelAndView();
		
		OAuth2AccessToken oauthToken;
		oauthToken = getAccessToken(session, code, state);
		
		// 로그인한 사용자의 모든 정보가 JSON 타입으로 저장되어 있다.
		String apiResult = getUserProfile(oauthToken);
		
		// 내가 원하는 정보 (이름)만 JSON 타입에서 String 타입으로 바꿔 가져오기 위한 작업
		JSONParser parser = new JSONParser();
		
		Object obj = null;
		
		try {
			obj = parser.parse(apiResult);
		}catch(ParseException e) {
			e.printStackTrace();
		}
		
		JSONObject jsonobj = (JSONObject) obj;
		JSONObject response = (JSONObject) jsonobj.get("response");
		
		String nname = (String) response.get("name");
		logger.info("네이버 : nname >>> : " + nname);
		
		//session.setAttribute("mname", nname);
		
		String nemail = (String) response.get("email");
		logger.info("네이버 : nemail >>> : " + nemail);
		
		String nemail_a = nemail.split("@")[0];
		logger.info("네이버 : nemail_a >>> : " + nemail_a);
		
		session.setAttribute("mid", nemail_a.concat("(N)"));
		
		// 메인페이지로 이동시킬것
		mav.setViewName("mainpage/mainpage");
		
		return mav;
	}
}
