package com.fithe.social.controller;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.http.HttpResponse;
import org.apache.http.NameValuePair;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.HttpClient;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.impl.client.HttpClientBuilder;
import org.apache.http.message.BasicNameValuePair;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;

@Controller
public class KakaoController {
	
		// https://thefif19wlsvy.tistory.com/62 참고
		// 이미지 다운로드 https://developers.kakao.com/tool/resource/login
		private Logger logger = Logger.getLogger(KakaoController.class);
		
		private final static String K_CLIENT_ID = "a8696ed73671985ffe695c01ef5ac010";
		private final static String K_REDIRECT_URI = "http://localhost:8088/FitHe/kakaoLogin.do";
		
		public static String getAuthorizationUrl(HttpSession session) {
			String kakaoUrl = "https://kauth.kakao.com/oauth/authorize?" + 
							  "client_id=" + K_CLIENT_ID + 
							  "&redirect_uri=" + K_REDIRECT_URI + 
							  "&response_type=code";

			return kakaoUrl;
		}
		
		public static JsonNode getAccessToken(String authorize_code) {
			
			final String RequestUrl = "https://kauth.kakao.com/oauth/token"; 
			final List<NameValuePair> postParams = new ArrayList<NameValuePair>();
			
			postParams.add(new BasicNameValuePair("grant_type","authorization_code"));
			postParams.add(new BasicNameValuePair("client_id","a8696ed73671985ffe695c01ef5ac010"));
			postParams.add(new BasicNameValuePair("redirect_uri","http://localhost:8088/FitHe/kakaoLogin.do"));
			postParams.add(new BasicNameValuePair("code", authorize_code));
			
			final HttpClient client = HttpClientBuilder.create().build(); 
			final HttpPost post = new HttpPost(RequestUrl);

			JsonNode returnNode = null;
			try {
				post.setEntity(new UrlEncodedFormEntity(postParams));
				final HttpResponse response = client.execute(post);
				
				// JSON 형태 반환값 처리
				ObjectMapper mapper = new ObjectMapper();
				returnNode = mapper.readTree(response.getEntity().getContent());
				
			}catch(UnsupportedEncodingException e) {
				e.printStackTrace(); 
			} catch (ClientProtocolException e) { 
				e.printStackTrace(); 
			} catch (IOException e) { 
				e.printStackTrace(); 
			} finally { 
				// clear resources
			}
			
			return returnNode;
		}
		
		public static JsonNode getKakaoUserInfo(JsonNode accessToken) {
			
			final String RequestUrl = "https://kapi.kakao.com/v2/user/me";
			final HttpClient client = HttpClientBuilder.create().build();
			final HttpPost post = new HttpPost(RequestUrl);
			
			// add Header
			post.addHeader("Authorization", "Bearer " + accessToken);
			JsonNode returnNode = null;
			
			try {
				
				final HttpResponse response = client.execute(post);
				// JSON 형태 반환처리
				ObjectMapper mapper = new ObjectMapper();
				returnNode = mapper.readTree(response.getEntity().getContent());
				
			}catch(ClientProtocolException e) {
				e.printStackTrace();
			}catch(IOException e) {
				e.printStackTrace();
			}finally {
				// clear resources
			}
			return returnNode;
		}
		
		@RequestMapping(value="kakaoLoginForm", method=RequestMethod.GET)
		public String kakaoLoginForm(Model model, HttpSession session) {
			
			String kakaoUrl = KakaoController.getAuthorizationUrl(session);
			logger.info("kakaoUrl >>> : " + kakaoUrl);
			
			model.addAttribute("kakao_url", kakaoUrl);
			
			return "member/kakaoLogin";
		}
		
		
		
		@RequestMapping(value="kakaoLogin", produces="application/json", method= {RequestMethod.GET, RequestMethod.POST})
		public ModelAndView kakaoLogin(@RequestParam("code") String code, 
										HttpServletRequest request, 
										HttpServletResponse response, 
										HttpSession session) throws Exception {
			ModelAndView mav = new ModelAndView();
			
			logger.info("code >>> : " + code);
			// 결과값을 node에 담아준다.
			JsonNode node = KakaoController.getAccessToken(code);
			logger.info("node >>> : " + node);
			
			// accessToken 에 사용자의 로그인한 모든 정보가 들어있다.
			JsonNode accessToken = node.get("access_token");
			logger.info("accessToken >>> : " + accessToken);
					
			// 사용자의 정보
			JsonNode userInfo = KakaoController.getKakaoUserInfo(accessToken);
			logger.info("userInfo >>> : " + userInfo);
			
			String kemail = null;
			String kname = null;
			String kgender = null;
			String kbirthday = null;
			String kage = null;
			String kimage = null;
			
			// 유저정보 카카오에서 가져오기 Get properties
			JsonNode properties = userInfo.path("properties");
			JsonNode kakao_account = userInfo.path("kakao_account");
			kemail = kakao_account.path("email").asText();
			
			logger.info("kemail >>> : " + kemail);

			String kemail_a = kemail.split("@")[0];
			logger.info("kemail_a >>> : " + kemail_a);
			
			session.setAttribute("mid", kemail_a.concat("(K)"));
			
			
			// 메인페이지로 이동시키면 된다.
			mav.setViewName("member/loginsuccess");
			
			return mav;
		}
}
