package com.fithe.common.commons.mail;

import java.io.UnsupportedEncodingException;
import java.util.Date;
import java.util.Properties;

import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import com.fithe.common.CommonUtils;
import com.fithe.member.vo.MemberVO;

public class MailSend {

	public void mailSend(MemberVO mvo) {
		
		Properties prop = System.getProperties();
		/*
		 * Properties 클래스는 시스템 속성을 객체로 생성하는 클래스
		 * HashTable을 상속받는 클래스로 속성과 값은 1:1 로 저장
		 * */
		
		// Mail 처리환경
		
		// 로그인시 TLS를 사용할 것인지 설정
		prop.put("mail.smtp.starttls.enable", "true");
		
		// 이메일 발송을 처리해줄 SMTP 서버
		prop.put("mail.smtp.host", "smtp.gmail.com");
		
		// SMTP 서버의 인증을 사용한다는 의미
		prop.put("mail.smtp.auth", "true");
		
		// TLS 포트 587, SSL 포트 : 465;
		prop.put("mail.smtp.port", "587");
		
		Authenticator auth = new MailAuth();
		Session session = Session.getDefaultInstance(prop, auth);
		/*
		 * MailAuth.java 에서 Authenticator을 상속받아 생성한
		 * MailAuth 클래스를 받아서 세션을 생성한다.
		 * getDefaultInstance의 첫번째 파라미터는 23~32 Line에서 정의한 값
		 * */
		
		MimeMessage msg = new MimeMessage(session);
		// MimeMessage는 Message(추상)클래스를 상속받은 인터넷 메일을 위한 클래스
		// session을 담아 msg객체를 생성한다.
		
		try {
			// 보내는 날짜 지정
			msg.setSentDate(new Date());
			// 보내는 사람 무조건 gmail
			msg.setFrom(new InternetAddress(CommonUtils.MAIL_ID, "FitHe Admin"));
			// Message 클래스의 setFrom() 메소드를 사용하여 발송자를 지정
			// 발송자의 메일, 발송지명 InternetAddress클래스는 이메일 주소를 나타낼때 사용하는 클래스
						
			// 수신자의 메일 생성
			// 받는이 어디서든지 가능 google, naver, daum
			// getAemail() : 입력받은 이메일로 인증번호를 보낸다.
			// 입력받은 이메일과 실제로 가입된 이메일의 비교는 나중일이다.
			InternetAddress to = new InternetAddress(mvo.getAemail());
						
			msg.setRecipient(Message.RecipientType.TO, to);
			/*
			 * Message클래스의 setRecipient() 메소드를 사용하여 수신자를 설정한다.
			 * setRecipient() 메소드로 수신자, 참조, 숨은 참조설정이 가능하다.
			 * Message.RecipientType.TO : 받는사람
			 * Message.RecipientType.CC : 참조
			 * Message.RecipientType.BCC : 숨은 참조 
			 */
						
			// 메일의 제목 지정 인코딩 타입 설정
			msg.setSubject("FitHe Auth Number", "UTF-8");
			
			// 메일의 내용 입력, 인코딩 타입설정
			msg.setText("Auth Number : " + mvo.getAuthnum(), "UTF-8");
			
			// Transport는 메일을 최종적으로 보내는 클래스 >>> 메일을 보내는 부분
			Transport.send(msg);
		}catch(AddressException ae) {  
            System.out.println("AddressException : " + ae.getMessage());           
        } catch(MessagingException me) {
        	// 메일 계정인증 관련 예외처리
            System.out.println("MessagingException : " + me.getMessage());
        } catch(UnsupportedEncodingException e) {
        	// 지원되지 않은 인코딩을 사용할 경우 예외 처리
            System.out.println("UnsupportedEncodingException : " + e.getMessage());			
        }
		
	}
}
